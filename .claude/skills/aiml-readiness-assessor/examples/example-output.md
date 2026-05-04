---
type: gap-report
status: draft
owner: @pm-user
skill: aiml-readiness-assessor
version: "1.0"
generated-on: 2026-05-04
device: "NeoTriage SpO2 AI"
scan-sources:
  design-controls: present
  risk-management: present
  soup-register: absent
coverage: partial
related: []
---

# AI/ML SaMD Readiness Assessment: NeoTriage SpO2 AI

## 1. Device Context

| Field | Value |
|-------|-------|
| Device | NeoTriage SpO2 AI |
| Intended use | AI-assisted triage of neonatal SpO2 patterns into urgency tiers for clinical prioritization |
| AI/ML role | triage |
| Decision autonomy | output-clinical-drive (IMDRF) |
| Learning type | batch-retrained |
| Regulatory status | pre-submission |

## Scenario Assumptions

This example uses synthetic artifacts. The following keyword presence/absence drives the heuristic results.

**design-controls-neotriage-spo2.xlsx — Design_Inputs.Requirement column contains:**
`training data`, `retraining criteria`, `model version`, `rollback`, `monitoring plan`

**Design_Inputs.Requirement column does NOT contain:**
`pipeline validation`, `automated validation`, `CI/CD`, `drift`, `distribution shift`, `notif`, `user communication`, `change log`, `release note`, `update notice`

**Verification sheet:** Test Data Source column is empty (all 5 rows).

**Verification + Validation sheets contain:**
`representativeness`, `data quality`, `re-validation`

**Verification + Validation sheets do NOT contain:**
`subgroup`, `stratified`, `demographic`, `bias`, `fairness`, `sample size`, `statistical plan`, `analysis plan`

**risk-analysis-neotriage-spo2.xlsx — FMEA sheet does NOT contain:**
`drift`, `distribution shift`, `concept drift`

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

### Critical (1)

#### F-PE-CRIT-001-001: No ML-specific validation methodology
- **Severity:** Critical
- **Axis:** Performance Evaluation
- **Citation:** FDA PCCP Guidance §VII.B.3 — "Performance evaluation methodology"
- **Explanation:** Verification sheet exists but the Test Data Source column (col F) is entirely empty across all 5 verification records. No test data provenance is documented, making validation results unverifiable for clinical decision-making. Without documented data sources, there is no way to assess dataset independence, size adequacy, or collection methodology.
- **Evidence:** design-controls-neotriage-spo2.xlsx → Verification sheet → Test Data Source column (col F) — 5 rows scanned, all empty
- **Remediation:** Populate Test Data Source column for all verification records: describe data origin, size, collection methodology, and independence from training data.

### Major (4)

#### F-PE-MAJ-001-001: No subgroup performance analysis
- **Severity:** Major
- **Axis:** Performance Evaluation | Cross-ref: Data Management
- **Citation:** FDA PCCP Guidance §VII.B.3 — "Performance evaluation... across relevant subgroups"
- **Explanation:** Searched Verification (Test Protocol, Pass Criteria) and Validation (Validation Method, Acceptance Criteria) sheets for subgroup analysis indicators. No mentions of "subgroup", "stratified", "demographic", "subpopulation", or "disaggregated" found. Overall performance metrics are present but no stratified analysis across clinically relevant subgroups (e.g., gestational age categories, birth weight).
- **Evidence:** design-controls-neotriage-spo2.xlsx → Verification sheet (cols C-D) + Validation sheet (cols C-D) — 10 rows scanned, 0 keyword matches
- **Remediation:** Add stratified performance analysis across clinically relevant subgroups (age, sex, ethnicity, disease severity, comorbidities as applicable to intended use).

#### F-PE-MAJ-002-001: Bias testing methodology absent
- **Severity:** Major
- **Axis:** Performance Evaluation | Cross-ref: Data Management
- **Citation:** FDA AI/ML Action Plan — Pillar 4: "Bias and robustness"
- **Explanation:** Searched Verification and Validation sheets for bias/fairness testing patterns (regex: `bias|fairness|equitab|disparate\s+impact|discrimination\s+test`). No matches found. No bias testing methodology is documented, leaving potential disparate performance across demographic groups undetected.
- **Evidence:** design-controls-neotriage-spo2.xlsx → Verification sheet (cols C-D) + Validation sheet (cols C-D) — 10 rows scanned, 0 pattern matches
- **Remediation:** Document bias testing methodology: protected attributes, fairness metrics, acceptance thresholds, and mitigation strategy.

#### F-UM-MAJ-002-001: No drift detection mechanism
- **Severity:** Major
- **Axis:** Update & Monitoring | Cross-ref: Performance Evaluation
- **Citation:** FDA PCCP Guidance §VII.B.4 — "Update procedures... monitoring for performance degradation"
- **Explanation:** Searched Design_Inputs requirements and FMEA failure modes for drift-related keywords. No mentions of "drift", "distribution shift", "concept drift", "data drift", or "covariate shift" found in either artifact. No mechanism exists to detect input distribution changes or concept drift in the deployed model.
- **Evidence:** design-controls-neotriage-spo2.xlsx → Design_Inputs sheet → Requirement column (col C) — 5 rows, 0 matches; risk-analysis-neotriage-spo2.xlsx → FMEA sheet → Failure Mode (col B), Effect (col C), Cause (col D) — 5 rows, 0 matches
- **Remediation:** Define drift detection approach: statistical tests on input distributions, performance metric monitoring with alert thresholds, or periodic re-validation triggers.

#### F-UM-MIN-001-001: No user notification protocol for model updates
- **Severity:** Major (promoted from minor due to decision autonomy level)
- **Axis:** Update & Monitoring
- **Citation:** FDA PCCP Guidance §VII.B.4 — "Update procedures, including user notification"
- **Explanation:** Searched Design_Inputs requirements for notification patterns (regex: `notif|user communication|change\s+log|release\s+note|update\s+notice`). No matches found. At decision autonomy level `output-clinical-drive`, clinicians rely on model outputs for clinical decisions — undisclosed model changes directly affect clinical workflow without user awareness.
- **Evidence:** design-controls-neotriage-spo2.xlsx → Design_Inputs sheet → Requirement column (col C) — 5 rows, 0 pattern matches
- **Remediation:** Define user notification protocol: notification trigger, communication channel, content template, and timing requirements for model updates.

### Minor (2)

#### F-RT-MIN-001-001: No automated pipeline validation
- **Severity:** Minor
- **Axis:** Retraining
- **Citation:** FDA PCCP Guidance §VII.B.2 — "Automated procedures for re-training"
- **Explanation:** Searched Design_Inputs requirements for automated pipeline validation keywords. No mentions of "pipeline validation", "automated validation", "CI/CD", "pipeline testing", or "automated test" found. The batch-retrained model has defined retraining triggers and a rollback procedure, but no automated validation of the retraining pipeline itself.
- **Evidence:** design-controls-neotriage-spo2.xlsx → Design_Inputs sheet → Requirement column (col C) — 5 rows, 0 keyword matches
- **Remediation:** Document automated pipeline validation: data ingestion checks, training reproducibility, output comparison against acceptance criteria.

#### F-PE-MIN-002-001: No statistical analysis plan pre-specified
- **Severity:** Minor
- **Axis:** Performance Evaluation
- **Citation:** FDA PCCP Guidance §VII.B.3 — "Pre-specified performance evaluation methodology"
- **Explanation:** Searched Verification and Validation sheets for statistical analysis plan indicators. No mentions of "sample size", "statistical plan", "analysis plan", "power analysis", or "success criteria" found. Validation methodology exists but no pre-specified statistical analysis plan documents endpoints, sample size justification, or success criteria before evaluation.
- **Evidence:** design-controls-neotriage-spo2.xlsx → Verification sheet (cols C-D) + Validation sheet (cols C-D) — 10 rows scanned, 0 keyword matches
- **Remediation:** Pre-specify statistical analysis plan: define primary endpoints, sample size justification, success/failure criteria, and statistical tests before conducting validation.

### Not assessed (1)

- **DM-MIN-001** (Dataset version not pinned in SOUP register): SOUP register not provided. Cannot assess ML framework/dataset version pinning.

## 4. Maturity Profile

| Axis | Level | Description |
|------|-------|-------------|
| Data Management | 5 | Full PCCP compliance |
| Retraining | 4 | Versioned with rollback |
| Performance Evaluation | 2 | Basic metrics only (hard-capped: 1 critical finding) |
| Update & Monitoring | 2 | Basic logging only |

**Overall readiness:** Level 2 (limited by Performance Evaluation and Update & Monitoring)

**Calibration basis:** Based on FDA PCCP Guidance §VII.B.1-4 (no published example PCCP submissions available as of 2026-05-04).

**Performance Evaluation coverage note:** Axis hard-capped at Level 2 due to critical finding F-PE-CRIT-001-001. Resolve the critical finding before re-assessing.

**SOUP coverage note:** Data Management axis score may understate actual gaps — 1 of 4 heuristics (DM-MIN-001) could not execute due to missing SOUP register. Provide SOUP register for complete assessment.

### Score derivation trace

| Axis | Critical | Major | Minor | Rule | Level |
|------|----------|-------|-------|------|-------|
| Data Management | 0 | 0 | 0 | Rule 4 (major=0, minor=0) | 5 |
| Retraining | 0 | 0 | 1 | Rule 5 (major=0, minor≤2) | 4 |
| Performance Evaluation | 1 | 2 | 1 | Rule 3 (critical≥1, hard-cap) | 2 |
| Update & Monitoring | 0 | 2 | 0 | Rule 7 (catch-all: major>1) | 2 |

## 5. Regulatory Pathway Recommendation

Critical gaps blocking submission. Address critical findings first, then re-assess.

Consider Type C pre-submission meeting to discuss AI/ML approach with FDA.

## 6. Remediation Roadmap

Priority-ordered tasks derived from findings. Format compatible with `roadmap-planning` skill input.

| # | Task | Axis | Severity | Effort | Dependency |
|---|------|------|----------|--------|------------|
| 1 | Populate Test Data Source for all verification records (data origin, size, independence from training data) | Performance Evaluation | Critical | M | none |
| 2 | Add stratified performance analysis across clinically relevant subgroups (GA categories, birth weight) | Performance Evaluation | Major | L | 1 |
| 3 | Document bias testing methodology with protected attributes and fairness metrics | Performance Evaluation | Major | L | 1 |
| 4 | Define drift detection approach (statistical tests, alert thresholds, re-validation triggers) | Update & Monitoring | Major | M | none |
| 5 | Define user notification protocol for model updates (trigger, channel, content, timing) | Update & Monitoring | Major | S | none |
| 6 | Document automated pipeline validation for retraining (ingestion checks, reproducibility) | Retraining | Minor | M | none |
| 7 | Pre-specify statistical analysis plan (endpoints, sample size, success criteria) | Performance Evaluation | Minor | S | 1 |
| 8 | Provide SOUP register for ML framework/dataset version assessment | Data Management | n/a | S | none |

---

*Generated by `aiml-readiness-assessor` v1.0 on 2026-05-04. Validate findings with RA/QA before accepting into DHF.*
