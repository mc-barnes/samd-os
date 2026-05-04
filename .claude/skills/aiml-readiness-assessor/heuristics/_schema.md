# Heuristic Schema Reference

This document defines the schema for all heuristic YAML files in this directory. Every heuristic must conform to this structure.

## Heuristic Object

```yaml
id: "DM-CRIT-001"                    # {Axis prefix}-{Severity prefix}-{sequence}
                                      # Axis: DM | RT | PE | UM
                                      # Severity: CRIT | MAJ | MIN
name: "Training data sources unspecified"
description: "What absence this heuristic detects — one sentence."

# Classification
primary_axis: data-management         # One of: data-management, retraining,
                                      #         performance-evaluation, update-monitoring
cross_ref_axes: []                    # Noted in findings for context, NOT double-counted in scoring
base_severity: critical               # One of: critical, major, minor

# Matching
artifact_types:                       # Which source artifacts this heuristic applies to
  - design-controls                   # One or more of: design-controls, risk-management, soup-register
match_logic:                          # Single rule OR array (one per artifact_type, OR semantics)
  type: keyword_absence
  artifact: design-controls
  search_scope: design_inputs_requirements
  required_keywords:
    - "training data"
    - "dataset"

# False positive guards
false_positive_guards:
  - condition:
      field: decision_autonomy
      value: output-non-clinical
    rationale: "Non-clinical output may use pre-trained models without team-specific training data"

# Gating
intake_conditions: []                 # When empty, always applicable
severity_promotion:
  eligible: true
  ceiling: major                      # minor->major only; never crosses into critical

# Citations
primary_citation: "FDA PCCP Guidance §VII.B.1 — 'Description of data management practices'"
secondary_citations:
  - "IMDRF N67 §6.1 — Data management for MLMD"

# Remediation
remediation: "Add design input specifying: training data source(s), inclusion/exclusion criteria."
```

## Match Logic Types

Five types are available. The heuristic set must exercise all five, with `keyword_absence` comprising ≤50% of total heuristics.

### 1. keyword_absence

Checks whether required keywords appear in scanned text. Finding triggers if **none** of the keywords are found.

```yaml
match_logic:
  type: keyword_absence
  artifact: design-controls
  search_scope: design_inputs_requirements
  required_keywords:
    - "training data"
    - "dataset"
    - "data source"
    - "training set"
```

### 2. cross_reference_missing

Checks that a concept mentioned in one artifact is also addressed in another (or in a different scope of the same artifact). Finding triggers if the source artifact mentions the concept but the target has no corresponding entry.

```yaml
match_logic:
  type: cross_reference_missing
  source:
    artifact: design-controls
    search_scope: design_inputs_requirements
    keywords:
      - "training data"
      - "dataset"
  target:
    artifact: design-controls
    search_scope: verification_validation_combined
    keywords:
      - "data quality"
      - "data validation"
      - "dataset verification"
  link_description: "Training data referenced in design inputs but no V&V record validates data quality"
```

### 3. column_absence

Checks XLSX column content for structural emptiness. Finding triggers if the specified columns are empty across all data rows.

```yaml
match_logic:
  type: column_absence
  artifact: design-controls
  sheet: Verification
  columns:
    - "Test Data Source"
  condition: all_empty               # all_empty | any_empty
```

### 4. version_unpin

Checks SOUP register entries for missing version pins or known-anomaly assessments. Finding triggers if any ML-related entry lacks version or known-anomaly documentation.

```yaml
match_logic:
  type: version_unpin
  artifact: soup-register
  fields:
    - "version"
    - "known_anomalies"
  ml_keywords:                       # Filter to ML-related SOUP entries
    - "tensorflow"
    - "pytorch"
    - "scikit"
    - "model"
    - "dataset"
```

### 5. pattern_absence

Regex-based detection where keyword lists are too blunt. Finding triggers if no match for the pattern is found in the specified scope.

```yaml
match_logic:
  type: pattern_absence
  artifact: design-controls
  search_scope: design_inputs_requirements
  pattern: "v\\d+\\.\\d+|version\\s+\\d"
  description: "No versioned model reference found (e.g., 'v1.2', 'version 3')"
```

## Search Scope Enum

Closed enum — the YAML validator must reject any value not in this list. Each value maps to specific XLSX sheets and column headers.

| Scope Value | Artifact | Sheet | Columns (by header) |
|---|---|---|---|
| `design_inputs_requirements` | design-controls | Design_Inputs | col C: `Requirement` |
| `verification_test_protocol` | design-controls | Verification | col C: `Test Protocol`, col D: `Pass Criteria` |
| `validation_method` | design-controls | Validation | col C: `Validation Method`, col D: `Acceptance Criteria` |
| `verification_validation_combined` | design-controls | Verification + Validation | Union of `verification_test_protocol` + `validation_method` |
| `hazard_identification` | risk-management | Hazard_Identification | col B: `Hazard`, col C: `Hazardous Situation`, col D: `Harm`, col E: `Sequence of Events` |
| `risk_controls` | risk-management | Risk_Controls | col C: `Control Measure` |
| `fmea_failure_modes` | risk-management | FMEA | col B: `Failure Mode`, col C: `Effect`, col D: `Cause` |
| `soup_register` | soup-register | SOUP_Register (XLSX) or full text (MD) | All text columns; specifically col C: `Version`, col J: `Known Anomalies Reviewed` for version_unpin |

**Column binding note:** Lookups use column headers as primary reference. Column letters are documented for the current generator version. If generators reorder columns, header-based lookup still works.

## Multi-Artifact Match Logic

When a heuristic declares multiple `artifact_types`, `match_logic` becomes an array — one entry per artifact type. **OR semantics:** the heuristic triggers if any single rule fires.

```yaml
artifact_types:
  - design-controls
  - risk-management
match_logic:
  - type: keyword_absence
    artifact: design-controls
    search_scope: design_inputs_requirements
    required_keywords: ["drift", "distribution shift"]
  - type: keyword_absence
    artifact: risk-management
    search_scope: fmea_failure_modes
    required_keywords: ["drift", "distribution shift"]
```

If no artifact matching a given rule is present in `artifact_paths`, that rule is skipped (not failed). The heuristic is marked `not_assessed` only if **no** artifacts for any of its declared types are present.

## Intake Conditions

Gate heuristic applicability based on structured intake fields.

```yaml
# Single value match
intake_conditions:
  - field: learning_type
    operator: in
    values: ["batch-retrained", "continuous"]

# Always applicable (empty list)
intake_conditions: []
```

When `intake_conditions` is non-empty, the heuristic is only evaluated if **all** conditions match.

## False Positive Guards

Suppress a finding when a condition matches intake. Checked **after** intake conditions pass but **before** match logic executes.

```yaml
false_positive_guards:
  - condition:
      field: learning_type
      value: locked
    rationale: "Locked models do not retrain; trigger criteria are not applicable"
```

If **any** guard condition matches, the heuristic is suppressed (finding not emitted, not counted as `not_assessed`).

## Severity Promotion

Controls whether `decision_autonomy` at high levels promotes finding severity.

```yaml
# Most heuristics: promote minor->major, never to critical
severity_promotion:
  eligible: true
  ceiling: major

# Rare (≤2 major-base heuristics): can promote to critical — patient-harm justification required
severity_promotion:
  eligible: true
  ceiling: critical

# Never promoted (required for critical-base heuristics)
severity_promotion:
  eligible: false
```

**Rules:**
1. Promotion activates only when `decision_autonomy` is `output-clinical-drive` or `output-clinical-replace`.
2. Promoted severity cannot exceed `ceiling`.
3. `ceiling: critical` reserved for ≤2 major-base heuristics where gap directly enables patient harm at high autonomy. Critical-base heuristics cannot consume this budget.
4. **Validation rule:** If `base_severity` is `critical`, then `severity_promotion.eligible` must be `false`. A critical-base finding cannot be promoted higher.

## Finding Object

Output of a triggered heuristic:

```yaml
id: "F-DM-CRIT-001-001"             # Auto: F-{heuristic_id}-{seq}
heuristic_id: "DM-CRIT-001"
name: "Training data sources unspecified"
severity: critical                    # Base or promoted
primary_axis: data-management
cross_ref_axes: []
explanation: "No design input specifies training data sources. Searched Design_Inputs.Requirement column for: 'training data', 'dataset', 'data source', 'training set'. No matches found."
evidence: "design-controls-spo2.xlsx → Design_Inputs sheet → Requirement column (col C) — 5 rows scanned, 0 keyword matches"
citation: "FDA PCCP Guidance §VII.B.1 — 'Description of data management practices'"
remediation: "Add design input specifying: training data source(s), inclusion/exclusion criteria."
promoted: false                       # True if severity was promoted
```

## Primary-Axis Tagging Convention

From spec §5 — applies at heuristic authoring time:

**Rule:** Tag against the axis describing the *activity whose absence was detected*, not the domain of the subject matter.

| Finding | Primary Axis | Reason |
|---|---|---|
| "No bias testing methodology" | performance-evaluation | Absence of *testing* |
| "Training data sources not specified" | data-management | Absence of *data governance* |
| "No retraining trigger criteria" | retraining | Absence of *retraining protocol* |
| "No post-deployment monitoring" | update-monitoring | Absence of *monitoring* |

**Conflict resolution:** Default to the PCCP section the primary citation falls under:
- §VII.B.1 → data-management
- §VII.B.2 → retraining
- §VII.B.3 → performance-evaluation
- §VII.B.4 → update-monitoring

## Malformed-Input Handling

Per spec §3, the scanner degrades gracefully:
- **Missing sheet** → heuristics scoped to that sheet are `not_assessed` with reason
- **Missing/renamed columns** → affected heuristics are `not_assessed` with reason
- **Unreadable file** → entire artifact source is `not_assessed`
- **Empty sheets/columns** → scanned normally (likely triggers keyword_absence findings)

Every degradation produces a visible `not_assessed` annotation — never a silent miss.
