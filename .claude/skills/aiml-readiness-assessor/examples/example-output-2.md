---
type: gap-report
status: draft
owner: @pm-user
skill: aiml-readiness-assessor
version: "1.0"
generated-on: 2026-05-04
device: "DermAssist AI Lesion Classifier"
scan-sources:
  design-controls: present
  risk-management: present
  soup-register: present
coverage: full
related: []
---

# AI/ML SaMD Readiness Assessment: DermAssist AI Lesion Classifier

## 1. Device Context

| Field | Value |
|-------|-------|
| Device | DermAssist AI Lesion Classifier |
| Intended use | AI-assisted classification of dermatological lesion images into benign/suspicious categories for clinician review |
| AI/ML role | classification |
| Decision autonomy | output-clinical-inform (IMDRF) |
| Learning type | locked |
| Regulatory status | post-510k |

## Scenario Assumptions

This example uses synthetic artifacts. The following keyword presence/absence drives the heuristic results.

**design-controls-dermassist.xlsx — Design_Inputs.Requirement column contains:**
`training data`, `dataset`, `post-deployment`, `monitoring plan`

**Design_Inputs.Requirement column does NOT contain:**
`retrain`, `re-train`, `model update`, `pipeline validation`, `drift`, `notif`, `user communication`, `change log`, `release note`, `update notice`

**Verification sheet:** Test Data Source column is populated (all 8 rows have data provenance entries).

**Verification + Validation sheets contain:**
`representativeness`, `data quality`, `subgroup`, `bias`, `success criteria`, `re-validation`

**risk-analysis-dermassist.xlsx — FMEA sheet contains:**
`drift` (listed as failure mode)

**soup-register-dermassist.xlsx — SOUP_Register sheet contains:**
Entry for "pytorch" with version column empty, known_anomalies column empty.

## 2. Scan Summary

**Artifacts analyzed:** 3
**Coverage:** full

| Source | Status | Heuristics applied |
|--------|--------|--------------------|
| Design controls | scanned | 11 |
| Risk management | scanned | 1 |
| SOUP register | scanned | 1 |

## 3. Findings

### Critical (0)

No critical findings.

### Major (0)

No major findings.

### Minor (2)

#### F-DM-MIN-001-001: Dataset version not pinned in SOUP register
- **Severity:** Minor
- **Axis:** Data Management
- **Citation:** IEC 62304:2006+A1:2015 §5.3.3 — SOUP identification and version
- **Explanation:** SOUP register contains an ML-related entry matching keyword "pytorch" but the version field is empty and known_anomalies field is empty. Without version pinning, reproducibility of model training and inference is not guaranteed.
- **Evidence:** soup-register-dermassist.xlsx → SOUP_Register sheet → "pytorch" entry — version column empty, known_anomalies column empty
- **Remediation:** Pin dataset/framework version in SOUP register and document known anomalies assessment per IEC 62304 §5.3.3.

#### F-UM-MIN-001-001: No user notification protocol for model updates
- **Severity:** Minor
- **Axis:** Update & Monitoring
- **Citation:** FDA PCCP Guidance §VII.B.4 — "Update procedures, including user notification"
- **Explanation:** Searched Design_Inputs requirements for notification patterns (regex: `notif|user communication|change\s+log|release\s+note|update\s+notice`). No matches found. Although the model is locked, the notification protocol documents communication procedures for any future software updates affecting clinical workflow.
- **Evidence:** design-controls-dermassist.xlsx → Design_Inputs sheet → Requirement column (col C) — 8 rows, 0 pattern matches
- **Remediation:** Define user notification protocol: notification trigger, communication channel, content template, and timing requirements for model updates.

### Suppressed (1)

- **UM-MAJ-002** (No drift detection mechanism): Suppressed by false positive guard — locked models with no update path may legitimately defer drift to periodic manual review.

### Intake-gated (4)

- **RT-CRIT-002** (No retraining trigger criteria): Skipped — intake_conditions require `learning_type ∈ {batch-retrained, continuous}`; device is locked.
- **RT-MAJ-001** (No model versioning protocol): Skipped — same gate.
- **RT-MAJ-002** (Retraining defined but no rollback procedure): Skipped — same gate.
- **RT-MIN-001** (No automated pipeline validation): Skipped — same gate.

## 4. Maturity Profile

| Axis | Level | Description |
|------|-------|-------------|
| Data Management | 4 | Bias-aware governance |
| Retraining | 5 | Full PCCP compliance (all heuristics intake-gated for locked model — no retraining gaps by design) |
| Performance Evaluation | 5 | Full PCCP compliance |
| Update & Monitoring | 4 | Formal update process |

**Overall readiness:** Level 4 (limited by Data Management and Update & Monitoring)

**Calibration basis:** Based on FDA PCCP Guidance §VII.B.1-4 (no published example PCCP submissions available as of 2026-05-04).

**Retraining axis note:** All 4 RT heuristics are gated by `intake_conditions` (require `learning_type ∈ {batch-retrained, continuous}`). For a locked model, the retraining axis has no applicable gaps — the Level 5 score reflects this. The axis is not "untested" (artifacts are present and heuristics were evaluated), but no retraining-related deficiencies can exist for a model that does not retrain.

### Score derivation trace

| Axis | Critical | Major | Minor | Rule | Level |
|------|----------|-------|-------|------|-------|
| Data Management | 0 | 0 | 1 | Rule 5 (major=0, minor≤2) | 4 |
| Retraining | 0 | 0 | 0 | Rule 4 (major=0, minor=0; all heuristics intake-gated) | 5 |
| Performance Evaluation | 0 | 0 | 0 | Rule 4 (major=0, minor=0) | 5 |
| Update & Monitoring | 0 | 0 | 1 | Rule 5 (major=0, minor≤2) | 4 |

## 5. Regulatory Pathway Recommendation

Standard submission pathway. No PCCP needed — model is locked post-deployment.

## 6. Remediation Roadmap

Priority-ordered tasks derived from findings. Format compatible with `roadmap-planning` skill input.

| # | Task | Axis | Severity | Effort | Dependency |
|---|------|------|----------|--------|------------|
| 1 | Pin PyTorch version in SOUP register and document known anomalies assessment | Data Management | Minor | S | none |
| 2 | Define user notification protocol for software updates (trigger, channel, content, timing) | Update & Monitoring | Minor | S | none |

---

*Generated by `aiml-readiness-assessor` v1.0 on 2026-05-04. Validate findings with RA/QA before accepting into DHF.*
