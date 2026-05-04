---
type: spec
status: draft
owner: @Sterdb
skill: aiml-readiness-assessor
related:
  - .claude/skills/change-impact/SKILL.md
  - .claude/skills/design-controls/SKILL.md
  - .claude/skills/risk-management/SKILL.md
  - .claude/skills/code-to-soup-register/SKILL.md
---

# AI/ML SaMD Readiness Assessor — Specification

## Invariants

These decisions are load-bearing and must not be re-litigated during the build:

1. **No self-assessment.** Maturity scores are computed from finding density against scanned artifacts. Never from questionnaires or self-reported inputs. This is a SaMD-OS pattern invariant — every scoring skill derives scores from artifact evidence.
2. **No fifth Org Readiness axis.** Organizational context is captured via structured intake (`regulatory_status`), not scored. Adding an axis without scannable artifacts produces opinion, not assessment.
3. **No startup path in v1.** The startup user depends on `code-to-*` skill stability and a pedagogical output template, neither of which exist yet. Compounding unvalidated outputs is worse than shipping nothing.
4. **One output template in v1.** RA/QA-facing, citation-dense. The pedagogical template ships with the startup path in v2.

---

## 1. Objective

Build a SaMD-OS skill that scans existing regulatory artifacts, detects AI/ML-specific compliance gaps against FDA PCCP guidance, and produces a structured gap report with computed maturity scores and a regulatory pathway recommendation.

### Target user

PM on an existing SaMD team with regulatory artifacts already in progress. The PM generates the report; RA/QA validates findings and accepts the report into the DHF.

### Workflow

```
PM invokes skill → structured intake → artifact scan → findings + scores → gap-report.md
    ↓
RA/QA reviews → validates/adjusts → approved doc → DHF
```

---

## 2. Structured Intake

The intake is a scanner precondition, not a supplement. These fields gate heuristic applicability and pathway routing.

| # | Field | Type | Values / Format | Used by |
|---|-------|------|-----------------|---------|
| 1 | `device_name` | string | Free text | Report header |
| 2 | `intended_use` | string | 1-3 sentences | Context for heuristic applicability |
| 3 | `aiml_role` | enum | `diagnostic`, `monitoring`, `therapeutic-decision`, `triage`, `screening` | Heuristic gating, pathway router |
| 4 | `decision_autonomy` | enum | IMDRF levels: `no-automation`, `output-non-clinical`, `output-clinical-inform`, `output-clinical-drive`, `output-clinical-replace` | Severity scaling, pathway router |
| 5 | `learning_type` | enum | `locked`, `batch-retrained`, `continuous` | Heuristic gating (continuous-only heuristics), pathway router |
| 6 | `regulatory_status` | enum | `pre-submission`, `post-510k`, `post-de-novo`, `post-pma` | Pathway router, finding severity context |
| 7 | `modification_pending` | boolean | `true` if a software change is in progress that may require a new submission | Pathway router modifier |
| 8 | `artifact_paths` | list[path] | Relative paths to XLSX/MD artifacts | Scanner input |

### Intake validation rules

- Fields 1-6 are required. Field 7 (`modification_pending`) defaults to `false` if omitted. Skill exits with error if any required field is missing.
- `artifact_paths` must resolve to at least one scannable artifact. If empty, skill exits with "no artifacts to scan" (not a gap report — a precondition failure).
- `decision_autonomy` scales severity: findings at `output-clinical-drive` or `output-clinical-replace` are promoted one severity level for eligible heuristics, subject to promotion ceiling rules (see §4, Severity Promotion).

---

## 3. Artifact Source Contract

### v1 sources

| Source | Format | What's scanned |
|--------|--------|----------------|
| Design controls | XLSX (skill output format) | DI/DO columns for AI/ML-specific requirements, V&V records for ML validation |
| Risk management | XLSX (skill output format) | Hazard descriptions, risk controls, FMEA for AI/ML failure modes |
| SOUP register | MD or XLSX | ML framework entries, version pinning, known anomalies |

Each individual source is optional, but at least one must be present. The skill scans whatever is provided and reports coverage accordingly.

### Scan-what's-present semantics

- The scanner processes whatever artifacts are provided via `artifact_paths`.
- `scan_sources` metadata in the output reflects which artifact types were present and scanned.
- A team with design-controls and risk-management but no SOUP register gets a partial-coverage report with a `coverage: partial` flag and an informational note — not a failure state.
- Minimum viable scan: at least one of the three artifact types must be present (individual sources are optional; the collection is not).

### Malformed-input handling

Real users will provide XLSX files from older generator versions, hand-edited workbooks, or adapted formats. The scanner degrades gracefully rather than failing:

- **Missing sheet:** If an expected sheet (e.g., `FMEA`) is absent from an otherwise valid XLSX, all heuristics scoped to that sheet are marked `not_assessed` with reason "sheet not found in {filename}". A `coverage_note` is appended. The scan continues with remaining sheets.
- **Missing or renamed columns:** If column headers don't match expected names (header-based lookup), affected heuristics are marked `not_assessed` with reason "expected column '{header}' not found in {sheet}". The scan continues with remaining columns.
- **Unreadable file:** If the XLSX cannot be opened (corrupted, wrong format, password-protected), the entire artifact source is marked `not_assessed` with reason "file could not be read: {error}". This is not a scan failure — other artifacts are still scanned.
- **Empty sheets/columns:** Sheets or columns that exist but contain no data rows are scanned normally — empty data is a valid scan result (and likely triggers keyword_absence findings).

The principle: every degradation produces a visible `not_assessed` annotation in the output, never a silent miss. The user sees exactly what was and wasn't scanned.

### Extension contract

Artifact sources are plugins. Each source type implements:

```
interface ArtifactSource {
  type: string;              // e.g., "design-controls", "risk-management", "soup-register"
  format: "xlsx" | "md";
  parse(path: string): ParsedArtifact;
  applicable_heuristics(): HeuristicID[];
}
```

The scoring engine accepts findings from any source that conforms to this contract. Adding a new source in v2 (intended-use letters, pre-submission packages) requires only a new parser — no scoring engine changes.

---

## 4. Heuristic Pattern Structure

### Heuristic schema

Each heuristic is a self-contained detection rule:

```typescript
interface Heuristic {
  id: string;                    // e.g., "DM-CRIT-001"
  name: string;                  // Human-readable, e.g., "Training data sources unspecified"
  description: string;           // What absence this detects

  // Classification
  primary_axis: Axis;            // "data-management" | "retraining" | "performance-evaluation" | "update-monitoring"
  cross_ref_axes: Axis[];        // Noted in findings, not double-counted
  base_severity: Severity;       // "critical" | "major" | "minor"

  // Matching
  artifact_types: ArtifactType[];            // Which sources this heuristic applies to
  match_logic: MatchLogic | MatchLogic[];    // Single rule, or one per artifact_type for multi-artifact heuristics
  false_positive_guards: FalsePositiveGuard[];  // Conditions that suppress the finding

  // Gating
  intake_conditions: IntakeCondition[];      // When this heuristic is applicable (e.g., only for continuous learning)
  severity_promotion: SeverityPromotion;     // Whether and how decision_autonomy promotes severity

  // Citation
  primary_citation: Citation;    // FDA PCCP §, IMDRF N67 §, ISO 14971 clause
  secondary_citations: Citation[];
}
```

### Match logic types

> **Representation note:** The schema is documented here in TypeScript-style interfaces for precision. Heuristics are authored as YAML files conforming to this schema (see §10 project structure). The build phase should include a YAML schema validator.

```typescript
type MatchLogic =
  | { type: "column_absence"; artifact: ArtifactType; sheet: string; columns: string[]; condition: "all_empty" | "any_empty" }
  | { type: "keyword_absence"; artifact: ArtifactType; search_scope: SearchScope; required_keywords: string[] }
  | { type: "pattern_absence"; artifact: ArtifactType; search_scope: SearchScope; pattern: RegExp }
  | { type: "cross_reference_missing"; source: CrossRefScope; target: CrossRefScope; link_description: string }
  | { type: "version_unpin"; artifact: "soup-register"; fields: string[]; ml_keywords?: string[] }

// Cross-reference scope: identifies where to search and what to match
interface CrossRefScope {
  artifact: ArtifactType;
  search_scope: SearchScope;
  keywords: string[];           // Terms to match in the specified scope
}
```

### Search scope enum

`search_scope` and `scope` are closed enums, not free-form strings. Each value maps to specific XLSX sheets and columns. The YAML validator must reject any scope value not in this list.

```typescript
type SearchScope =
  | "design_inputs_requirements"       // Design_Inputs sheet → col C (Requirement)
  | "verification_test_protocol"       // Verification sheet → cols C-D (Test Protocol, Pass Criteria)
  | "validation_method"                // Validation sheet → cols C-D (Validation Method, Acceptance Criteria)
  | "verification_validation_combined" // Union of verification_test_protocol + validation_method
  | "hazard_identification"            // Hazard_Identification sheet → cols B-E (Hazard, Hazardous Situation, Harm, Sequence of Events)
  | "risk_controls"                    // Risk_Controls sheet → col C (Control Measure)
  | "fmea_failure_modes"               // FMEA sheet → cols B-D (Failure Mode, Effect, Cause)
  | "soup_register"                    // SOUP_Register sheet → all text columns
```

**Column binding rationale:** Each scope binds to column headers (not positions) as the primary reference, with column letters noted for the current generator version. If a generator update reorders columns, header-based lookup still works. If headers change, the YAML validator will flag mismatches at build time rather than producing silent scan misses.

**Multi-artifact match logic:** When a heuristic declares multiple `artifact_types`, `match_logic` becomes an array with one entry per artifact type. The heuristic triggers if **any** match rule fires (OR semantics — finding the gap in any scanned artifact is sufficient). If no artifacts matching a given rule are present, that rule is skipped (not failed). See UM-MAJ-002 in §8 for an example.

**Match type coverage in starter set:** The starter heuristics (§8) exercise `keyword_absence`, `version_unpin`, and `pattern_absence`. The `version_unpin` type supports an optional `ml_keywords` field that filters SOUP register entries to ML-related dependencies only (e.g., `["tensorflow", "pytorch", "scikit"]`), preventing false positives on non-ML utility libraries. The remaining types are reserved for build-phase heuristics:
- `column_absence` — for XLSX-specific structural checks. The `sheet` field disambiguates which sheet within a multi-sheet XLSX to scan (e.g., `sheet: "Verification"` targets the Verification sheet within a design-controls XLSX). Requires knowledge of the specific XLSX column schema produced by the `design-controls` skill.
- `cross_reference_missing` — the higher-fidelity alternative to `keyword_absence` for detecting "mentioned but not validated" gaps. Uses nested `source` and `target` scopes, each with `artifact`, `search_scope`, and `keywords`. The heuristic fires when source keywords are found but target keywords are not — detecting gaps where a concept is mentioned without corresponding evidence. `link_description` provides a human-readable explanation of the expected cross-reference. See build-phase quality note in §8.

### False positive guards

```typescript
interface FalsePositiveGuard {
  condition: IntakeCondition;  // e.g., { field: "learning_type", value: "locked" }
  rationale: string;           // Why this suppresses the finding
}
```

If a guard condition matches the intake, the heuristic is suppressed (finding not emitted).

### Severity promotion

```typescript
type SeverityPromotion =
  | { eligible: false }                              // Never promoted
  | { eligible: true; ceiling: "major" }             // minor→major only; never crosses into critical
  | { eligible: true; ceiling: "critical" }          // minor→major or major→critical (rare, reserved for patient-harm heuristics)
```

**Promotion rules:**

1. Promotion activates only when `decision_autonomy` ∈ {`output-clinical-drive`, `output-clinical-replace`}.
2. A promoted finding's severity cannot exceed its `ceiling`. Most heuristics use `ceiling: "major"` — promotion escalates minor→major but never major→critical.
3. `ceiling: "critical"` is reserved for major-base heuristics where the gap directly enables patient harm at high autonomy (e.g., a model making unsupervised clinical decisions with no validation methodology). This should apply to ≤2 major-base heuristics in the full set. Critical-base heuristics cannot consume ceiling:"critical" budget slots because the ceiling has no effect on them.
5. **Schema validation rule:** If `base_severity` is `"critical"`, then `severity_promotion` must be `{ eligible: false }`. A critical-base finding cannot be promoted higher, so `eligible: true` is unrepresentable. The YAML validator must enforce this.
4. A single promoted-to-critical finding still triggers the hard-cap rule (axis capped at Level 2). This is intentional for the narrow cases where it applies — but because `ceiling: "critical"` is rare, the cascade problem is contained.

**Design rationale:** The previous binary `severity_promotion: true` allowed most major findings to promote to critical at high autonomy, which mechanically hard-capped axes at Level 2 from single findings across the board. The ceiling constraint ensures that only explicitly designated patient-harm heuristics can trigger the critical hard-cap via promotion. The common case (major finding on high-autonomy device) stays at major severity.

**Build constraint — observable promotion:** The heuristic set must include at least one minor-base heuristic with `eligible: true` so that the promotion mechanism is observable in test scenarios. An unobservable mechanism is functionally equivalent to no mechanism — the five rounds of ceiling-system design are only validated when promotion actually fires in practice. Future modifications to v1 heuristics must not reduce the eligible-promotion count below 1 without an explicit invariant revision. In v1, UM-MIN-001 serves this role (see §8 for clinical rationale).

### Finding object (output of a triggered heuristic)

```typescript
interface Finding {
  id: string;                    // Auto-generated: "F-{heuristic_id}-{seq}"
  heuristic_id: string;
  name: string;                  // From heuristic
  severity: Severity;            // Base or promoted
  primary_axis: Axis;
  cross_ref_axes: Axis[];
  explanation: string;           // What was expected, what was found (or not found)
  evidence: string;              // Specific artifact location (sheet, row, column)
  citation: Citation;            // Primary citation from heuristic
  remediation: string;           // Actionable task description
  promoted: boolean;             // True if severity was promoted by decision_autonomy
}
```

---

## 5. Primary-Axis Tagging Convention

**Rule:** A finding scores against the axis that describes the *activity whose absence was detected*, not the domain of the subject matter.

**Application:**
- "No bias testing methodology documented" → **Performance Evaluation** (absence of *testing*, not absence of data analysis), cross-ref Data Management
- "Training data sources not specified" → **Data Management** (absence of *data governance*)
- "No retraining trigger criteria defined" → **Retraining** (absence of *retraining protocol*)
- "No post-deployment performance monitoring" → **Update & Monitoring** (absence of *monitoring*)
- "Bias in training data not assessed for representativeness" → **Data Management** (absence of *data analysis*), cross-ref Performance Evaluation

**Conflict resolution:** When reasonable people disagree, default to the axis whose PCCP Modification Protocol section the heuristic's primary citation falls under:
- §VII.B.1 (Data Management) → data-management
- §VII.B.2 (Re-training) → retraining
- §VII.B.3 (Performance Evaluation) → performance-evaluation
- §VII.B.4 (Update Procedures) → update-monitoring

This convention must be applied at heuristic authoring time. All heuristics share this rule; no per-heuristic overrides.

---

## 6. Scoring Algorithm

### Maturity axes

| Axis | PCCP Section | Scope |
|------|-------------|-------|
| Data Management | §VII.B.1 | Training data governance, sequestration, representativeness, quality, bias analysis |
| Retraining | §VII.B.2 | Re-training protocols, trigger criteria, data pipeline integrity, model versioning |
| Performance Evaluation | §VII.B.3 | Validation methodology, bias testing, statistical rigor, dataset independence |
| Update & Monitoring | §VII.B.4 | Deployment monitoring, drift detection, update procedures, rollback, user notification |

### Rubric definitions

#### Data Management

| Level | Description |
|-------|-------------|
| 1 | No evidence of data governance. Training data sources unspecified or absent from design controls. |
| 2 | Training data sources identified but no sequestration, representativeness criteria, or quality standards documented. |
| 3 | Sources, sequestration, and basic quality criteria present. No bias or representativeness analysis. |
| 4 | Above plus documented representativeness analysis and bias detection methods. No deployment-phase data drift monitoring. |
| 5 | All Level 4 elements plus deployment-phase data drift monitoring with defined triggers. Addresses all PCCP §VII.B.1 requirements. |

#### Retraining

| Level | Description |
|-------|-------------|
| 1 | No retraining protocol exists. Model is treated as static software with no lifecycle consideration. |
| 2 | Retraining acknowledged as future need but no trigger criteria, data pipeline, or versioning defined. |
| 3 | Trigger criteria and retraining cadence defined. Data pipeline documented. No model versioning or rollback protocol. |
| 4 | Above plus model versioning, comparison testing against prior version, and rollback protocol. No automated pipeline validation. |
| 5 | All Level 4 elements plus automated pipeline validation, reproducibility guarantees, and PCCP §VII.B.2 full compliance. |

#### Performance Evaluation

| Level | Description |
|-------|-------------|
| 1 | No ML-specific validation methodology. Model treated as deterministic software for V&V purposes. |
| 2 | Basic accuracy metrics defined but no statistical methodology, dataset independence, or bias testing. |
| 3 | Statistical methodology present. Independent test dataset documented. No subgroup analysis or bias testing. |
| 4 | Above plus subgroup performance analysis and documented bias testing methodology. No prospective monitoring plan. |
| 5 | All Level 4 elements plus prospective performance monitoring, pre-specified statistical analysis plan, and PCCP §VII.B.3 full compliance. |

#### Update & Monitoring

| Level | Description |
|-------|-------------|
| 1 | No post-deployment monitoring plan. Model outputs not tracked after release. |
| 2 | Basic logging exists but no performance degradation detection, drift monitoring, or update procedures. |
| 3 | Performance monitoring defined with alert thresholds. No formal update procedure or user notification protocol. |
| 4 | Above plus formal update procedure, rollback plan, and user notification protocol. No continuous drift detection. |
| 5 | All Level 4 elements plus continuous drift detection with automated alerts, defined re-validation triggers, and PCCP §VII.B.4 full compliance. |

### Scoring computation

**Hard-cap rule:** Any axis with ≥1 critical finding is capped at Level 2, regardless of other evidence.

**Finding-density thresholds — evaluated as a decision tree (first match wins):**

```
1. If no artifacts scanned for this axis → Level 1
2. If ≤1 applicable heuristic could run for this axis → Level 1
3. If critical ≥ 1 → Level 2 (hard-cap)
4. If major = 0, minor = 0 → Level 5
5. If major = 0, minor ≤ 2 → Level 4
6. If major ≤ 1, minor ≤ 3 → Level 3
7. Otherwise → Level 2 (catch-all: anything that didn't qualify for Level 3+)
```

**Exhaustiveness proof:** Steps 1-2 handle edge cases. Step 3 handles all critical>0. Steps 4-7 cover the remaining space (critical=0) exhaustively: step 4 catches (0,0), step 5 catches (0, 1-2), step 6 catches (0-1 major, 0-3 minor combinations not already caught), step 7 catches everything else (≥2 majors, or 1 major with >3 minors, or 0 majors with >3 minors). Note: (0 majors, 3 minors) is caught by step 6 (major≤1 AND minor≤3), not step 7.

**Examples of step 7 catch-all triggering:**
- 0 critical, 1 major, 5 minors → Level 2 (minor>3 disqualifies Level 3)
- 0 critical, 3 majors, 0 minors → Level 2 (major>1 disqualifies Level 3)
- 0 critical, 2 majors, 1 minor → Level 2 (major>1 disqualifies Level 3)

**Axis-specific calibration notes:**
- Thresholds assume unequal heuristic counts per axis. If an axis has only 3-4 applicable heuristics, the minor threshold for Level 4 may need adjustment (≤1 instead of ≤2). The build phase should calibrate against the final heuristic set.
- Level 5 calibration source: FDA PCCP guidance text (§VII.B.1-4). Where published FDA example PCCP submissions exist, calibrate against those. Where they don't (likely for most axes given guidance recency), calibrate against guidance language. The output should note calibration source per axis.

### Coverage adjustment

When `scan_sources` shows partial coverage (e.g., no SOUP register), the scorer applies:
- Heuristics gated to missing artifact types are marked `not_assessed` (not failed, not passed)
- `not_assessed` heuristics don't count toward level thresholds
- A `coverage_note` is appended to the axis score explaining what couldn't be assessed

---

## 7. Pathway Router

The router is a total function over `(level_vector: [Axis → Level], intake: Intake) → Recommendation`. Evaluated as a decision tree — first match wins.

**Inputs:**
- `min_level` = minimum level across all 4 axes
- `max_level` = maximum level across all 4 axes
- `has_critical_cap` = any axis is Level 2 due to hard-cap rule (≥1 critical finding)
- `learning_type` from intake
- `regulatory_status` from intake

**Decision tree:**

```
1. If min_level = 1:
   → "Foundation work needed. Run `design-controls` skill to establish baseline, then re-assess."

2. If has_critical_cap = true:
   → "Critical gaps blocking submission. Address critical findings first, then re-assess."

3. If min_level = 2 (no critical cap — reached via catch-all):
   → "Significant gaps. Run `roadmap-planning` skill with remediation tasks as input."

4. If min_level = 3:
   → "Near-ready. Targeted remediation needed (see roadmap). Estimate 4-8 weeks to PCCP readiness."

5. If min_level ≥ 4 AND learning_type ∈ {"batch-retrained", "continuous"}:
   → "Ready for PCCP submission. Recommend pre-submission (Q-Sub) to validate approach with FDA."

6. If min_level ≥ 4 AND learning_type = "locked":
   → "Standard submission pathway. No PCCP needed — model is locked post-deployment."

7. Default (should never reach — included for defensive completeness):
   → "Unable to determine pathway. Review maturity profile and intake fields manually."
```

**Totality guarantee:** Steps 1-3 cover all cases where any axis is ≤2. Step 4 covers min_level=3. Steps 5-6 cover min_level≥4 partitioned by learning_type. Step 7 is unreachable given the learning_type enum is exhaustive over {locked, batch-retrained, continuous}, but guards against future enum extension.

**Modifiers (appended to the primary recommendation):**

| Condition | Appended text |
|-----------|---------------|
| `modification_pending` = true AND `regulatory_status` ∈ {`post-510k`, `post-de-novo`} | "Evaluate whether modifications trigger new 510(k) per `change-impact` skill before PCCP path." |
| `modification_pending` = true AND `regulatory_status` = `post-pma` | "PMA supplement pathway may apply. Consult RA for supplement type determination." |
| `regulatory_status` = `pre-submission` | "Consider Type C pre-submission meeting to discuss AI/ML approach with FDA." |

---

## 8. Starter Heuristics (7 fully-worked examples)

> **Build-phase quality note:** The starter set leans on `keyword_absence` matching for spec completeness. During the build, at least 2-3 of the remaining heuristics should use `cross_reference_missing` to catch "mentioned but not validated" gaps — e.g., "design input references training data AND a corresponding V&V record validates data quality." The starter set establishes the schema template; the build phase should raise the scanner reliability bar by diversifying match types. `keyword_absence` alone is vulnerable to both false positives (different terminology) and false negatives (keyword mentioned without underlying work — "drift detection deferred to v2" would pass a keyword check for "drift").
>
> **Known-deferred upgrade:** UM-MAJ-002 (drift detection) is a `cross_reference_missing` upgrade candidate deferred from v1 because its definition was locked as a starter heuristic. v2 should evaluate upgrading to cross-reference between design inputs (drift keywords) and FMEA failure modes (drift-specific risk controls).

### DM-CRIT-001: Training data sources unspecified

```yaml
id: DM-CRIT-001
name: Training data sources unspecified
description: No design input specifies the source, scope, or characteristics of training data used by the AI/ML model.
primary_axis: data-management
cross_ref_axes: []
base_severity: critical
artifact_types: [design-controls]
match_logic:
  type: keyword_absence
  artifact: design-controls
  search_scope: design_inputs_requirements
  required_keywords: ["training data", "dataset", "data source", "training set"]
false_positive_guards:
  - condition: { field: "decision_autonomy", value: "output-non-clinical" }
    rationale: "Non-clinical output may use pre-trained models without team-specific training data"
intake_conditions: []  # Always applicable
severity_promotion: { eligible: false }
primary_citation: "FDA PCCP Guidance §VII.B.1 — 'Description of data management practices, including... data collection'"
secondary_citations: ["IMDRF N67 §6.1 — Data management for MLMD"]
remediation: "Add design input specifying: training data source(s), inclusion/exclusion criteria, dataset size, collection timeframe, and annotation methodology."
```

### RT-CRIT-002: No retraining trigger criteria

```yaml
id: RT-CRIT-002
name: No retraining trigger criteria defined
description: For a model declared as batch-retrained or continuous, no criteria exist that define when retraining is initiated.
primary_axis: retraining
cross_ref_axes: [update-monitoring]
base_severity: critical
artifact_types: [design-controls]
match_logic:
  type: keyword_absence
  artifact: design-controls
  search_scope: design_inputs_requirements
  required_keywords: ["retrain", "re-train", "update trigger", "retraining criteria", "model update"]
false_positive_guards:
  - condition: { field: "learning_type", value: "locked" }
    rationale: "Locked models do not retrain; trigger criteria are not applicable"
intake_conditions:
  - { field: "learning_type", operator: "in", values: ["batch-retrained", "continuous"] }
severity_promotion: { eligible: false }
primary_citation: "FDA PCCP Guidance §VII.B.2 — 'Re-training... including triggers for re-training'"
secondary_citations: ["IMDRF N67 §5.3 — Change triggers"]
remediation: "Define retraining trigger criteria: performance degradation thresholds, data drift metrics, temporal cadence, or clinical event triggers that initiate a retraining cycle."
```

### PE-MAJ-001: No subgroup performance analysis

```yaml
id: PE-MAJ-001
name: No subgroup performance analysis
description: Validation records show overall performance metrics but no stratified analysis across clinically relevant subgroups.
primary_axis: performance-evaluation
cross_ref_axes: [data-management]
base_severity: major
artifact_types: [design-controls]
match_logic:
  type: keyword_absence
  artifact: design-controls
  search_scope: verification_validation_combined
  required_keywords: ["subgroup", "stratified", "demographic", "subpopulation", "disaggregated"]
false_positive_guards: []
intake_conditions: []  # Always applicable for clinical AI
severity_promotion: { eligible: true, ceiling: "major" }
primary_citation: "FDA PCCP Guidance §VII.B.3 — 'Performance evaluation... across relevant subgroups'"
secondary_citations: ["FDA AI/ML Action Plan — Pillar 4: Bias and robustness"]
remediation: "Add stratified performance analysis across clinically relevant subgroups (age, sex, ethnicity, disease severity, comorbidities as applicable to intended use)."
```

### UM-MAJ-002: No drift detection mechanism

```yaml
id: UM-MAJ-002
name: No drift detection mechanism
description: No design control or risk control addresses detection of data or concept drift in the deployed model.
primary_axis: update-monitoring
cross_ref_axes: [performance-evaluation]
base_severity: major
artifact_types: [design-controls, risk-management]
match_logic:
  - type: keyword_absence
    artifact: design-controls
    search_scope: design_inputs_requirements
    required_keywords: ["drift", "distribution shift", "concept drift", "data drift", "covariate shift"]
  - type: keyword_absence
    artifact: risk-management
    search_scope: fmea_failure_modes
    required_keywords: ["drift", "distribution shift", "concept drift", "data drift", "covariate shift"]
false_positive_guards:
  - condition: { field: "learning_type", value: "locked" }
    rationale: "Locked models with no update path may legitimately defer drift to periodic manual review, though this is a minor gap"
intake_conditions: []
severity_promotion: { eligible: true, ceiling: "major" }
primary_citation: "FDA PCCP Guidance §VII.B.4 — 'Update procedures... monitoring for performance degradation'"
secondary_citations: ["IMDRF N67 §6.4 — Monitoring"]
remediation: "Define drift detection approach: statistical tests on input distributions, performance metric monitoring with alert thresholds, or periodic re-validation triggers."
```

### DM-MIN-001: Dataset version not pinned in SOUP register

```yaml
id: DM-MIN-001
name: Dataset version not pinned in SOUP register
description: ML framework or dataset dependency listed in SOUP register without version pinning or known anomaly assessment.
primary_axis: data-management
cross_ref_axes: []
base_severity: minor
artifact_types: [soup-register]
match_logic:
  type: version_unpin
  artifact: soup-register
  fields: ["version", "known_anomalies"]
false_positive_guards: []
intake_conditions: []
severity_promotion: { eligible: false }
primary_citation: "IEC 62304:2006+A1:2015 §5.3.3 — SOUP identification and version"
secondary_citations: []
remediation: "Pin dataset/framework version in SOUP register and document known anomalies assessment per IEC 62304 §5.3.3."
```

### PE-MIN-002: No statistical analysis plan pre-specified

```yaml
id: PE-MIN-002
name: No statistical analysis plan pre-specified
description: Validation methodology exists but no pre-specified statistical analysis plan (endpoints, sample size justification, success criteria defined before evaluation).
primary_axis: performance-evaluation
cross_ref_axes: []
base_severity: minor
artifact_types: [design-controls]
match_logic:
  type: keyword_absence
  artifact: design-controls
  search_scope: verification_validation_combined
  required_keywords: ["sample size", "statistical plan", "analysis plan", "power analysis", "success criteria"]
false_positive_guards: []
intake_conditions: []
severity_promotion: { eligible: false }
primary_citation: "FDA PCCP Guidance §VII.B.3 — 'Pre-specified performance evaluation methodology'"
secondary_citations: ["FDA Guidance: Statistical Guidance on Reporting Results (2007)"]
remediation: "Pre-specify statistical analysis plan: define primary endpoints, sample size justification, success/failure criteria, and statistical tests before conducting validation."
```

### UM-MIN-001: No user notification protocol for model updates

> **Promotion rationale:** This is the sole minor-base heuristic with `eligible: true` in v1, satisfying the observable-promotion build constraint (§4). The clinical justification: at high decision autonomy (`output-clinical-drive` or `output-clinical-replace`), clinicians rely on model outputs for clinical decisions. Undisclosed model changes have a different harm profile at high vs. low autonomy — the clinician's ability to compensate for unknown behavioral changes is degraded when the model drives rather than informs decisions. The promotion from minor→major reflects a real escalation of clinical risk, not an arbitrary designation.

```yaml
id: UM-MIN-001
name: No user notification protocol for model updates
description: No versioned notification or communication pattern for informing users of model updates, leaving clinicians unaware of changes to decision-support behavior.
primary_axis: update-monitoring
cross_ref_axes: []
base_severity: minor
artifact_types: [design-controls]
match_logic:
  type: pattern_absence
  artifact: design-controls
  search_scope: design_inputs_requirements
  pattern: "notif|user communication|change\\s+log|release\\s+note|update\\s+notice"
false_positive_guards: []
intake_conditions: []
severity_promotion: { eligible: true, ceiling: "major" }
primary_citation: "FDA PCCP Guidance §VII.B.4 — 'Update procedures, including user notification'"
secondary_citations: []
remediation: "Define user notification protocol: notification trigger, communication channel, content template, and timing requirements for model updates."
```

---

## 9. Output Template

### Frontmatter

```yaml
---
type: gap-report
status: draft
owner: @{invoking_user}
skill: aiml-readiness-assessor
version: "1.0"
generated-on: YYYY-MM-DD
device: "{device_name}"
scan-sources:
  design-controls: {present|absent}
  risk-management: {present|absent}
  soup-register: {present|absent}
coverage: {full|partial}
related: []
---
```

### Body structure

```markdown
# AI/ML SaMD Readiness Assessment: {device_name}

## 1. Device Context

| Field | Value |
|-------|-------|
| Device | {device_name} |
| Intended use | {intended_use} |
| AI/ML role | {aiml_role} |
| Decision autonomy | {decision_autonomy} (IMDRF) |
| Learning type | {learning_type} |
| Regulatory status | {regulatory_status} |

## 2. Scan Summary

**Artifacts analyzed:** {count}
**Coverage:** {full|partial}

| Source | Status | Heuristics applied |
|--------|--------|--------------------|
| Design controls | {scanned|not provided} | {n} |
| Risk management | {scanned|not provided} | {n} |
| SOUP register | {scanned|not provided} | {n} |

{if partial: "**Coverage note:** {explanation of what couldn't be assessed}"}

## 3. Findings

### Critical ({count})

#### F-{id}: {name}
- **Severity:** Critical {if promoted: "(promoted from major due to decision autonomy level)"}
- **Axis:** {primary_axis} {if cross_ref: "| Cross-ref: {axes}"}
- **Citation:** {primary_citation}
- **Explanation:** {explanation}
- **Evidence:** {evidence — artifact, location}
- **Remediation:** {remediation task}

### Major ({count})

{same structure}

### Minor ({count})

{same structure}

### Not assessed ({count})

{If ≤3: list inline with heuristic ID, name, and suppression reason.}
{If >3: single summary line ("8 heuristics not assessed due to intake gating or missing artifacts") with details collapsed into Appendix A at end of report.}

## 4. Maturity Profile

| Axis | Level | Description |
|------|-------|-------------|
| Data Management | {1-5} | {one-line rubric text} |
| Retraining | {1-5} | {one-line rubric text} |
| Performance Evaluation | {1-5} | {one-line rubric text} |
| Update & Monitoring | {1-5} | {one-line rubric text} |

**Overall readiness:** {lowest axis level determines ceiling}

**Calibration basis:** {If all axes share the same source, emit a single line: "Based on FDA PCCP Guidance §VII.B.1-4 (no published example PCCP submissions available as of {date})." If any axis has a different source (e.g., a published PCCP example becomes available), break out per-axis calibration notes below the table.}

{per-axis coverage notes if partial}

## 5. Regulatory Pathway Recommendation

{Router output — 2-3 sentences with specific next-action recommendation}

{Modifier text if applicable}

## 6. Remediation Roadmap

Priority-ordered tasks derived from findings. Format compatible with `roadmap-planning` skill input.

| # | Task | Axis | Severity | Effort | Dependency |
|---|------|------|----------|--------|------------|
| 1 | {remediation text} | {axis} | {severity} | {S/M/L} | {task # or "none"} |
| 2 | ... | | | | |

---

*Generated by `aiml-readiness-assessor` v1.0 on {date}. Validate findings with RA/QA before accepting into DHF.*
```

---

## 10. Project Structure

```
.claude/skills/aiml-readiness-assessor/
├── SKILL.md              # Skill definition (triggers, instructions, output format)
├── heuristics/
│   ├── _schema.md        # Heuristic schema reference (from §4 above)
│   ├── data-management.yaml
│   ├── retraining.yaml
│   ├── performance-evaluation.yaml
│   └── update-monitoring.yaml
├── scoring/
│   ├── rubric.md         # Level definitions per axis (from §6 above)
│   └── thresholds.md     # Finding-density computation rules
├── router/
│   └── pathways.md       # Pathway conditions and recommendations
└── examples/
    └── example-output.md # Complete example gap report
```

---

## 11. Testing Strategy

### Validation approach

1. **Fixture-based testing:** Create synthetic XLSX artifacts with known gaps, run skill, verify findings match expected output.
2. **False-positive testing:** Create artifacts that are compliant; verify zero findings emitted.
3. **Severity promotion testing:** Run same artifacts with different `decision_autonomy` levels; verify promotion logic.
4. **Partial coverage testing:** Run with subset of artifacts; verify `not_assessed` findings and coverage notes.
5. **Pathway router testing:** Run combinations of maturity levels + intake values; verify correct pathway recommendation.

### Test fixtures needed

| Fixture | Purpose |
|---------|---------|
| `compliant-full.xlsx` | Design controls with full AI/ML coverage → expect zero critical/major findings; level depends on whether minor count meets Level 5 threshold |
| `minimal-gaps.xlsx` | 2-3 minor gaps → expect Level 4 |
| `critical-gap-data.xlsx` | Missing training data sources → expect DM capped at Level 2 |
| `locked-model.xlsx` | Locked model with good coverage → verify retraining heuristics suppressed |
| `promotion-ceiling.xlsx` | Single major finding (PE-MAJ-001) with `decision_autonomy: output-clinical-replace` → verify finding promotes to major (not critical), axis NOT hard-capped at Level 2 |
| `no-soup.xlsx` | Only design-controls present → verify partial coverage handling |

---

## 12. Boundaries

### Always
- Cite the specific standard clause or guidance section for every finding
- Include evidence (artifact location) for every finding — never generate findings without scannable proof
- Apply the primary-axis tagging convention from §5 consistently
- Respect intake gating — suppress heuristics where false-positive guards match
- Note calibration source (guidance text vs published example) for each axis score

### Ask first
- Before adding new heuristics beyond the starter set — validate axis tagging against §5 convention
- Before adjusting finding-density thresholds — verify against rubric descriptions
- Before extending to new artifact types — confirm parser contract compliance

### Never
- Emit findings without artifact evidence (no speculation, no inference from intake alone)
- Double-count cross-axis findings in scoring
- Self-assess or use questionnaire inputs as scoring evidence
- Hard-code artifact paths — always use `artifact_paths` from intake
- Override severity promotion ceiling — a heuristic with `ceiling: "major"` must never produce a critical finding via promotion
- Assign `ceiling: "critical"` to more than 2 heuristics without explicit justification linking to direct patient harm

---

## 13. Regulatory Sources

| Source | Edition | Sections used |
|--------|---------|---------------|
| FDA PCCP Guidance | Aug 2025 | §VI (Description of Modifications), §VII (Modification Protocol — all 4 components), §VIII (Impact Assessment) |
| FDA AI/ML SaMD Action Plan | Jan 2021 | 5 pillars: PCCP, GMLP, transparency, bias/robustness, RWP |
| IMDRF N67 | May 2022 | Key terms, change taxonomy (cause/effect/trigger/domain/effectuation), locked vs continuous learning |
| ISO 14971:2019 | 2019 | Risk-specific gap detection, hazard identification for AI/ML failure modes |
| IEC 62304:2006+A1:2015 | 2015 | SOUP identification (§5.3.3), software lifecycle considerations |

---

## 14. Out of Scope (v1)

- Self-assessment questionnaires
- Fifth "Org Readiness" axis
- Startup/greenfield user path
- Pedagogical output template
- PCCP document drafting (separate skill)
- EU AI Act compliance checks
- Auto-generation of remediation artifacts (outputs tasks, not artifacts)
- Scanning of PRDs, intended-use docs, or engineering RFCs
