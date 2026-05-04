---
type: gap-report
status: draft
owner: @pm-user
skill: aiml-readiness-assessor
version: "1.0"
generated-on: 2026-05-04
device: "CardioPredict Arrhythmia AI"
scan-sources:
  design-controls: present
  risk-management: present
  soup-register: absent
coverage: partial
related: []
---

# AI/ML SaMD Readiness Assessment: CardioPredict Arrhythmia AI

## 1. Device Context

| Field | Value |
|-------|-------|
| Device | CardioPredict Arrhythmia AI |
| Intended use | AI-driven real-time arrhythmia detection and clinical alert generation, replacing manual rhythm interpretation in continuous monitoring |
| AI/ML role | detection |
| Decision autonomy | output-clinical-replace (IMDRF) |
| Learning type | continuous |
| Regulatory status | pre-submission |

## Scenario Assumptions

This example uses synthetic artifacts. The following keyword presence/absence drives the heuristic results.

**design-controls-cardiopredict.xlsx — Design_Inputs.Requirement column contains:**
`training data`, `dataset`, `retraining criteria`, `model version`, `rollback`, `monitoring plan`

**Design_Inputs.Requirement column does NOT contain:**
`pipeline validation`, `automated validation`, `CI/CD`, `drift`, `distribution shift`, `notif`, `user communication`, `change log`, `release note`, `update notice`

**Verification sheet:** Test Data Source column is populated (all 6 rows have data provenance entries).

**Verification + Validation sheets contain:**
`data quality`, `subgroup`, `bias`, `sample size`

**Verification + Validation sheets do NOT contain:**
`representativeness`, `data representativeness`, `population distribution`, `re-validation`, `revalidation`, `re-test`, `retest`, `periodic validation`

**risk-analysis-cardiopredict.xlsx — FMEA sheet does NOT contain:**
`drift`, `distribution shift`, `concept drift`, `data drift`, `covariate shift`

**SOUP register:** Not provided.

## 2. Scan Summary

**Artifacts analyzed:** 2
**Coverage:** partial

| Source | Status | Heuristics applied |
|--------|--------|--------------------|
| Design controls | scanned | 15 |
| Risk management | scanned | 1 |
| SOUP register | not provided | 0 |

**Coverage note:** SOUP register not provided. 1 heuristic (DM-MIN-001: Dataset version not pinned) could not be assessed. SOUP-dependent findings are excluded from scoring. Provide a SOUP register for complete coverage.

## 3. Findings

### Critical (0)

No critical findings.

### Major (4)

#### F-DM-MAJ-001-001: No representativeness analysis
- **Severity:** Major
- **Axis:** Data Management | Cross-ref: Performance Evaluation
- **Citation:** FDA PCCP Guidance §VII.B.1 — "Representativeness of data"
- **Explanation:** Design inputs reference training data ("training data", "dataset" found in Design_Inputs.Requirement), but Verification and Validation sheets contain no mention of "representativeness", "demographic", "population distribution", or "data representativeness". Training data is documented but its representativeness against the target cardiac monitoring population is not verified.
- **Evidence:** design-controls-cardiopredict.xlsx → Design_Inputs (source: "training data" found) → Verification + Validation (target: 0 matches for representativeness keywords across 12 rows)
- **Remediation:** Document representativeness analysis: target population demographics, training data demographics, gap analysis, and mitigation strategy.

#### F-UM-MAJ-002-001: No drift detection mechanism
- **Severity:** Major
- **Axis:** Update & Monitoring | Cross-ref: Performance Evaluation
- **Citation:** FDA PCCP Guidance §VII.B.4 — "Update procedures... monitoring for performance degradation"
- **Explanation:** Searched Design_Inputs requirements and FMEA failure modes for drift-related keywords. No mentions of "drift", "distribution shift", "concept drift", "data drift", or "covariate shift" found in either artifact. For a continuously learning model, absence of drift detection is a significant gap — input distributions will shift over time as patient populations and monitoring equipment evolve.
- **Evidence:** design-controls-cardiopredict.xlsx → Design_Inputs sheet → Requirement column (col C) — 6 rows, 0 matches; risk-analysis-cardiopredict.xlsx → FMEA sheet → Failure Mode (col B), Effect (col C), Cause (col D) — 5 rows, 0 matches
- **Remediation:** Define drift detection approach: statistical tests on input distributions, performance metric monitoring with alert thresholds, or periodic re-validation triggers.

#### F-UM-MAJ-003-001: Monitoring defined but no re-validation trigger linked
- **Severity:** Major
- **Axis:** Update & Monitoring | Cross-ref: Performance Evaluation
- **Citation:** FDA PCCP Guidance §VII.B.4 — "Triggers for re-evaluation"
- **Explanation:** Design inputs contain "monitoring plan" (source match), but Verification and Validation sheets contain no mention of "re-validation", "revalidation", "re-test", "retest", or "periodic validation". Monitoring exists but has no defined link to re-validation — degradation detection without a response protocol is incomplete.
- **Evidence:** design-controls-cardiopredict.xlsx → Design_Inputs (source: "monitoring plan" found) → Verification + Validation (target: 0 matches for re-validation keywords across 12 rows)
- **Remediation:** Link monitoring thresholds to re-validation triggers: define which metric breaches initiate re-validation, specify the re-validation protocol, and document acceptance criteria.

#### F-UM-MIN-001-001: No user notification protocol for model updates
- **Severity:** Major (promoted from minor due to decision autonomy level)
- **Axis:** Update & Monitoring
- **Citation:** FDA PCCP Guidance §VII.B.4 — "Update procedures, including user notification"
- **Explanation:** Searched Design_Inputs requirements for notification patterns (regex: `notif|user communication|change\s+log|release\s+note|update\s+notice`). No matches found. At decision autonomy level `output-clinical-replace`, the model **replaces** manual clinical interpretation — undisclosed model changes directly alter clinical decision-making without clinician awareness. Severity promoted from minor to major per severity_promotion rules.
- **Evidence:** design-controls-cardiopredict.xlsx → Design_Inputs sheet → Requirement column (col C) — 6 rows, 0 pattern matches
- **Remediation:** Define user notification protocol: notification trigger, communication channel, content template, and timing requirements for model updates.
- **Promotion note:** Base severity `minor` promoted to `major` because `decision_autonomy = output-clinical-replace` and `severity_promotion = { eligible: true, ceiling: "major" }`. At this autonomy level, clinicians rely entirely on model output — notification gaps have direct patient safety implications.

### Minor (1)

#### F-RT-MIN-001-001: No automated pipeline validation
- **Severity:** Minor
- **Axis:** Retraining
- **Citation:** FDA PCCP Guidance §VII.B.2 — "Automated procedures for re-training"
- **Explanation:** Searched Design_Inputs requirements for automated pipeline validation keywords. No mentions of "pipeline validation", "automated validation", "CI/CD", "pipeline testing", or "automated test" found. The continuous model has defined retraining triggers, versioning, and rollback, but no automated validation of the retraining pipeline itself. For a continuously learning model, manual pipeline validation creates a bottleneck and increases risk of undetected training errors.
- **Evidence:** design-controls-cardiopredict.xlsx → Design_Inputs sheet → Requirement column (col C) — 6 rows, 0 keyword matches
- **Remediation:** Document automated pipeline validation: data ingestion checks, training reproducibility, output comparison against acceptance criteria.

### Not assessed (1)

- **DM-MIN-001** (Dataset version not pinned in SOUP register): SOUP register not provided. Cannot assess ML framework/dataset version pinning.

## 4. Maturity Profile

| Axis | Level | Description |
|------|-------|-------------|
| Data Management | 3 | Basic governance in place |
| Retraining | 4 | Versioned with rollback |
| Performance Evaluation | 5 | Full PCCP compliance |
| Update & Monitoring | 2 | Basic logging only |

**Overall readiness:** Level 2 (limited by Update & Monitoring)

**Calibration basis:** Based on FDA PCCP Guidance §VII.B.1-4 (no published example PCCP submissions available as of 2026-05-04).

**SOUP coverage note:** Data Management axis score may understate actual gaps — 1 of 4 heuristics (DM-MIN-001) could not execute due to missing SOUP register. Provide SOUP register for complete assessment.

**Severity promotion note:** F-UM-MIN-001-001 was promoted from minor to major because `decision_autonomy = output-clinical-replace`. This promotion changed the UM axis finding count from (0c, 2M, 1m) → (0c, 3M, 0m), which does not change the axis level (both map to Level 2 via Rule 7) but does affect the remediation priority ordering. This is the only heuristic in the v1 set where severity promotion produces an observable effect.

### Score derivation trace

| Axis | Critical | Major | Minor | Rule | Level |
|------|----------|-------|-------|------|-------|
| Data Management | 0 | 1 | 0 | Rule 6 (major≤1, minor≤3) | 3 |
| Retraining | 0 | 0 | 1 | Rule 5 (major=0, minor≤2) | 4 |
| Performance Evaluation | 0 | 0 | 0 | Rule 4 (major=0, minor=0) | 5 |
| Update & Monitoring | 0 | 3 | 0 | Rule 7 (catch-all: major>1; includes 1 promoted) | 2 |

## 5. Regulatory Pathway Recommendation

Significant gaps. Run `roadmap-planning` skill with remediation tasks as input.

Consider Type C pre-submission meeting to discuss AI/ML approach with FDA.

## 6. Remediation Roadmap

Priority-ordered tasks derived from findings. Format compatible with `roadmap-planning` skill input.

| # | Task | Axis | Severity | Effort | Dependency |
|---|------|------|----------|--------|------------|
| 1 | Define drift detection approach (statistical tests, alert thresholds, re-validation triggers) | Update & Monitoring | Major | M | none |
| 2 | Link monitoring thresholds to re-validation triggers with defined protocol | Update & Monitoring | Major | M | 1 |
| 3 | Define user notification protocol for model updates (trigger, channel, content, timing) | Update & Monitoring | Major (promoted) | S | none |
| 4 | Document representativeness analysis for cardiac monitoring target population | Data Management | Major | L | none |
| 5 | Document automated pipeline validation for continuous retraining (ingestion checks, reproducibility) | Retraining | Minor | M | none |
| 6 | Provide SOUP register for ML framework/dataset version assessment | Data Management | n/a | S | none |

---

*Generated by `aiml-readiness-assessor` v1.0 on 2026-05-04. Validate findings with RA/QA before accepting into DHF.*
