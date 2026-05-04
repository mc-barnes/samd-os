---
name: aiml-readiness-assessor
version: 1.0.0
description: >
  Scan existing regulatory artifacts for AI/ML-specific compliance gaps against
  FDA PCCP guidance. Produces a structured gap report with computed maturity scores
  and a regulatory pathway recommendation. Triggers: "AI/ML readiness",
  "PCCP readiness", "AI compliance gaps", "ML regulatory assessment",
  "AI/ML gap analysis", "PCCP gap report".
---

# AI/ML SaMD Readiness Assessor

## When to Use

- Scanning existing design controls, risk management, and SOUP register artifacts for AI/ML-specific gaps
- Assessing readiness for a Predetermined Change Control Plan (PCCP) submission
- Determining whether a PCCP is needed based on model learning type
- Prioritizing AI/ML regulatory remediation work
- Pre-submission readiness check before FDA meeting

## When NOT to Use

- **Initial design controls creation** — use `design-controls` skill instead
- **Risk management from scratch** — use `risk-management` skill instead
- **SOUP register generation** — use `code-to-soup-register` skill instead
- **EU AI Act compliance** — out of scope for v1
- **Startup/greenfield teams with no artifacts** — this skill requires existing artifacts to scan
- **PCCP document drafting** — this skill identifies gaps, it does not write the PCCP itself

> **Note on directory structure:** This skill uses `heuristics/`, `scoring/`, `router/`, and `examples/` subdirectories rather than the conventional `scripts/` and `references/` pattern used by `design-controls` and `risk-management`. This is intentional — there is no generator script; the skill operates by Claude reading and applying YAML heuristic definitions directly.

---

## Structured Intake

Collect these fields from the user before scanning. Fields 1-6 are required. Field 7 defaults to `false`. Field 8 must resolve to at least one scannable artifact.

| # | Field | Type | Values / Format | Used by |
|---|-------|------|-----------------|---------|
| 1 | `device_name` | string | Free text | Report header |
| 2 | `intended_use` | string | 1-3 sentences | Context for heuristic applicability |
| 3 | `aiml_role` | enum | `diagnostic`, `monitoring`, `therapeutic-decision`, `triage`, `screening` | Heuristic gating, pathway router |
| 4 | `decision_autonomy` | enum | IMDRF levels: `no-automation`, `output-non-clinical`, `output-clinical-inform`, `output-clinical-drive`, `output-clinical-replace` | Severity scaling, pathway router |
| 5 | `learning_type` | enum | `locked`, `batch-retrained`, `continuous` | Heuristic gating, pathway router |
| 6 | `regulatory_status` | enum | `pre-submission`, `post-510k`, `post-de-novo`, `post-pma` | Pathway router, finding severity context |
| 7 | `modification_pending` | boolean | Default: `false` | Pathway router modifier |
| 8 | `artifact_paths` | list[path] | Relative paths to XLSX/MD artifacts | Scanner input |

### Intake validation rules

- If any of fields 1-6 is missing, **exit with error** — do not produce a gap report.
- If `artifact_paths` is empty or no paths resolve to scannable files, **exit with error**: "No artifacts to scan. Provide at least one design-controls XLSX, risk-management XLSX, or SOUP register (XLSX/MD)."
- `decision_autonomy` at `output-clinical-drive` or `output-clinical-replace` activates severity promotion for eligible heuristics (see promotion rules below).

---

## Scan Procedure

Follow these steps in order.

### Step 1: Validate intake

Verify all required fields are present and values are from allowed enums. Exit with error on any precondition failure.

### Step 2: Resolve artifact paths and identify types

For each path in `artifact_paths`:

1. **Attempt to open the file.** If unreadable (corrupted, wrong format, password-protected), mark entire artifact source as `not_assessed` with reason "file could not be read: {error}". Continue with remaining artifacts.
2. **Identify artifact type** by examining sheet names:
   - Contains `Design_Inputs` sheet → **design-controls** XLSX
   - Contains `Hazard_Identification` sheet → **risk-management** XLSX
   - Contains `SOUP_Register` sheet → **soup-register** XLSX
   - `.md` file → **soup-register** MD (text-based scan only)
3. Record which artifact types are present in `scan_sources`.

If no artifacts of any recognized type are found, exit with error.

### Step 3: Read artifact content by column header

Read and parse each YAML file in `heuristics/` to load all heuristic definitions.

For each identified artifact, read the relevant sheets and columns **by header name** (not column position):

**Design controls XLSX:**

| Search Scope | Sheet | Columns to Read |
|---|---|---|
| `design_inputs_requirements` | `Design_Inputs` | `Requirement` (col C) |
| `verification_test_protocol` | `Verification` | `Test Protocol` (col C), `Pass Criteria` (col D) |
| `validation_method` | `Validation` | `Validation Method` (col C), `Acceptance Criteria` (col D) |
| `verification_validation_combined` | `Verification` + `Validation` | Union of the two scopes above |

- If the `Verification` sheet has a `Test Data Source` column (col F), also read it for `column_absence` checks.
- **Missing sheet:** If an expected sheet is absent, mark all heuristics scoped to that sheet as `not_assessed` with reason "sheet '{name}' not found in {filename}". Continue.
- **Missing/renamed columns:** If column headers don't match, mark affected heuristics as `not_assessed` with reason "expected column '{header}' not found in {sheet}". Continue.

**Risk management XLSX:**

| Search Scope | Sheet | Columns to Read |
|---|---|---|
| `hazard_identification` | `Hazard_Identification` | `Hazard` (col B), `Hazardous Situation` (col C), `Harm` (col D), `Sequence of Events` (col E) |
| `risk_controls` | `Risk_Controls` | `Control Measure` (col C) |
| `fmea_failure_modes` | `FMEA` | `Failure Mode` (col B), `Effect` (col C), `Cause` (col D) |

**SOUP register:**

| Search Scope | Format | Columns to Read |
|---|---|---|
| `soup_register` (XLSX) | `SOUP_Register` sheet | All text columns; `Version` (col C) and `Known Anomalies Reviewed` (col J) for `version_unpin` |
| `soup_register` (MD) | Full text | Text-based scan only; `version_unpin` heuristics marked `not_assessed` (no structured columns) |

### Step 4: Evaluate each heuristic

For each heuristic loaded from `heuristics/*.yaml`:

1. **Check intake conditions.** If `intake_conditions` is non-empty and any condition does not match intake, **skip** (not evaluated, not counted).
2. **Check false positive guards.** If any guard condition matches intake, **suppress** (not emitted, not counted as `not_assessed`).
3. **Check artifact availability.** If no artifacts matching the heuristic's `artifact_types` are present, mark `not_assessed`.
4. **Execute match logic:**

   - **`keyword_absence`**: Search the specified `search_scope` text for any of `required_keywords` (case-insensitive). If **none** found → finding triggers.
   - **`cross_reference_missing`**: Search `source` scope for `source.keywords`. If source keywords are found, search `target` scope for `target.keywords`. If target keywords are **not** found → finding triggers. If source keywords are not found either, the heuristic does not trigger (nothing to cross-reference).
   - **`column_absence`**: Check specified columns in the sheet. If `condition: all_empty` and all specified columns have no data in any row → finding triggers.
   - **`version_unpin`**: For SOUP register entries matching `ml_keywords`, check that `fields` (version, known_anomalies) are populated. If any ML-related entry is missing version or known anomaly assessment → finding triggers.
   - **`pattern_absence`**: Apply regex `pattern` to the specified `search_scope` text. If no match → finding triggers.

5. **Multi-artifact match logic (array):** When `match_logic` is an array, evaluate each rule against its declared artifact. Finding triggers if **any** rule fires (OR semantics). Rules for absent artifacts are skipped.

6. **Apply severity promotion** if the heuristic has `severity_promotion.eligible: true` and `decision_autonomy` is `output-clinical-drive` or `output-clinical-replace`:
   - Promote `base_severity` one level (minor → major, major → critical)
   - Promoted severity **cannot exceed** `severity_promotion.ceiling`
   - Record `promoted: true` on the finding

7. **Emit finding** with all required fields (see `heuristics/_schema.md` for Finding object structure).

### Step 5: Compute maturity scores

For each of the 4 axes, apply the finding-density decision tree from `scoring/thresholds.md`:

```
1. If no artifacts scanned for this axis           → Level 1
2. If ≤1 applicable heuristic could run for axis   → Level 1
3. If critical ≥ 1                                 → Level 2 (hard-cap)
4. If major = 0 AND minor = 0                      → Level 5
5. If major = 0 AND minor ≤ 2                      → Level 4
6. If major ≤ 1 AND minor ≤ 3                      → Level 3
7. Otherwise                                       → Level 2
```

**Axis-specific calibration:** If an axis has ≤4 applicable heuristics, tighten thresholds — Level 4 minor threshold becomes ≤1 (default ≤2), Level 3 minor threshold becomes ≤2 (default ≤3). See `scoring/thresholds.md` §Axis-Specific Calibration for the full adjustment table.

Use rubric descriptions from `scoring/rubric.md` for the one-line level summary in the output.

**Coverage adjustment:** `not_assessed` heuristics do not count toward finding thresholds. Append `coverage_note` when applicable.

### Step 6: Run pathway router

Apply the decision tree from `router/pathways.md` using:
- `min_level` = minimum across all 4 axis levels
- `max_level` = maximum across all 4 axis levels
- `has_critical_cap` = any axis at Level 2 due to ≥1 critical finding
- `learning_type` from intake
- `regulatory_status` from intake
- `modification_pending` from intake

Append any applicable modifiers.

### Step 7: Generate output

Produce the gap report markdown using the output template below.

---

## Output Template

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

### Body

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
- **Evidence:** {evidence — artifact, sheet, column, what was searched}
- **Remediation:** {remediation task}

### Major ({count})

{same structure per finding}

### Minor ({count})

{same structure per finding}

### Not assessed ({count})

{If ≤3: list inline with heuristic ID, name, and reason.}
{If >3: summary line + details in Appendix A.}

## 4. Maturity Profile

| Axis | Level | Description |
|------|-------|-------------|
| Data Management | {1-5} | {one-line rubric text from scoring/rubric.md} |
| Retraining | {1-5} | {one-line rubric text} |
| Performance Evaluation | {1-5} | {one-line rubric text} |
| Update & Monitoring | {1-5} | {one-line rubric text} |

**Overall readiness:** {minimum axis level}

**Calibration basis:** Based on FDA PCCP Guidance §VII.B.1-4 (no published example PCCP submissions available as of {date}).

{per-axis coverage notes if partial}

## 5. Regulatory Pathway Recommendation

{Router output from router/pathways.md — 2-3 sentences}

{Modifier text if applicable — each as separate paragraph}

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

## Boundaries

### Always

- Cite the specific standard clause or guidance section for every finding
- Include evidence (artifact location: file, sheet, column) for every finding — never generate findings without scannable proof
- Apply the primary-axis tagging convention consistently (tag the *activity whose absence was detected*, not the subject domain — see `heuristics/_schema.md`)
- Respect intake gating — suppress heuristics where false-positive guards match
- Note calibration source for each axis score
- Apply malformed-input handling: missing sheets/columns → `not_assessed`, unreadable files → `not_assessed` with error, empty data → scan normally

### Ask first

- Before adding new heuristics beyond the defined set — validate axis tagging against convention
- Before adjusting finding-density thresholds — verify against rubric descriptions
- Before extending to new artifact types — confirm parser contract compliance

### Never

- Emit findings without artifact evidence (no speculation, no inference from intake alone)
- Double-count cross-axis findings in scoring (finding scores against `primary_axis` only)
- Self-assess or use questionnaire inputs as scoring evidence
- Hard-code artifact paths — always use `artifact_paths` from intake
- Override severity promotion ceiling — a heuristic with `ceiling: "major"` must never produce a critical finding via promotion
- Assign `ceiling: "critical"` to more than 2 heuristics without explicit patient-harm justification

### Invariants (from spec — do not re-litigate)

1. **No self-assessment.** Scores derive from artifact evidence, never questionnaires.
2. **No fifth Org Readiness axis.** Organizational context is intake metadata, not scored.
3. **No startup path in v1.** Requires existing artifacts.
4. **One output template in v1.** RA/QA-facing, citation-dense.

---

## Reference Files

| File | Purpose |
|------|---------|
| `heuristics/_schema.md` | Heuristic object schema, match logic types, search scope enum, severity promotion rules, primary-axis tagging convention |
| `heuristics/data-management.yaml` | Data Management axis heuristics (4) |
| `heuristics/retraining.yaml` | Retraining axis heuristics (4) |
| `heuristics/performance-evaluation.yaml` | Performance Evaluation axis heuristics (4) |
| `heuristics/update-monitoring.yaml` | Update & Monitoring axis heuristics (4) |
| `scoring/rubric.md` | Level 1-5 definitions per axis with one-line summaries |
| `scoring/thresholds.md` | Finding-density decision tree and coverage adjustment rules |
| `router/pathways.md` | Pathway decision tree, modifiers, worked examples |
| `examples/example-output.md` | Complete example gap report |

## Source Documents

| Source | Edition | Sections Used |
|--------|---------|---------------|
| FDA PCCP Guidance | Aug 2025 | §VI (Description of Modifications), §VII (Modification Protocol — all 4 components), §VIII (Impact Assessment) |
| FDA AI/ML SaMD Action Plan | Jan 2021 | 5 pillars: PCCP, GMLP, transparency, bias/robustness, RWP |
| IMDRF N67 | May 2022 | Key terms, change taxonomy, locked vs continuous learning |
| ISO 14971:2019 | 2019 | Risk-specific gap detection, hazard identification for AI/ML failure modes |
| IEC 62304:2006+A1:2015 | 2015 | SOUP identification (§5.3.3), software lifecycle considerations |
