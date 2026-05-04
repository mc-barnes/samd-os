# AI/ML SaMD Readiness Scoring Rubric

## Overview

Four axes, five maturity levels each. Axes map directly to FDA Predetermined Change Control Plan (PCCP) Guidance §VII.B subsections.

**Calibration source disclosure:** Based on FDA PCCP Guidance §VII.B.1-4 (no published example PCCP submissions available as of 2026-05-04). Level definitions are derived from the guidance language and adapted into a progressive maturity model. As real-world PCCP submissions become public, recalibrate level boundaries against accepted practice.

---

## Axis 1 — Data Management (§VII.B.1)

Training data governance, sequestration, representativeness, quality, bias analysis.

| Level | Summary | Description |
|:-----:|---------|-------------|
| 1 | **No governance** | No evidence of data governance. Training data sources unspecified or absent from design controls. |
| 2 | **Sources identified only** | Training data sources identified but no sequestration, representativeness criteria, or quality standards documented. |
| 3 | **Basic governance in place** | Sources, sequestration, and basic quality criteria present. No bias or representativeness analysis. |
| 4 | **Bias-aware governance** | Above plus documented representativeness analysis and bias detection methods. No deployment-phase data drift monitoring. |
| 5 | **Full PCCP compliance** | All Level 4 elements plus deployment-phase data drift monitoring with defined triggers. Addresses all PCCP §VII.B.1 requirements. |

### Key heuristic targets

- Data source registry with provenance metadata
- Train/validation/test sequestration with documented split rationale
- Data quality acceptance criteria (completeness, label accuracy, class balance)
- Representativeness analysis against intended patient population
- Bias detection methodology (demographic subgroups, site variation)
- Deployment-phase data drift monitoring with trigger thresholds

---

## Axis 2 — Retraining (§VII.B.2)

Re-training protocols, trigger criteria, data pipeline integrity, model versioning.

| Level | Summary | Description |
|:-----:|---------|-------------|
| 1 | **No protocol** | No retraining protocol exists. Model is treated as static software with no lifecycle consideration. |
| 2 | **Acknowledged, undefined** | Retraining acknowledged as future need but no trigger criteria, data pipeline, or versioning defined. |
| 3 | **Triggers and pipeline defined** | Trigger criteria and retraining cadence defined. Data pipeline documented. No model versioning or rollback protocol. |
| 4 | **Versioned with rollback** | Above plus model versioning, comparison testing against prior version, and rollback protocol. No automated pipeline validation. |
| 5 | **Full PCCP compliance** | All Level 4 elements plus automated pipeline validation, reproducibility guarantees, and PCCP §VII.B.2 full compliance. |

### Key heuristic targets

- Retraining trigger criteria (performance degradation, data drift, calendar cadence)
- Data pipeline documentation (ingestion, transformation, labeling)
- Model version control with unique identifiers
- Comparison testing protocol (new version vs. prior version)
- Rollback procedure with defined activation criteria
- Automated pipeline validation (data integrity checks, reproducibility tests)

---

## Axis 3 — Performance Evaluation (§VII.B.3)

Validation methodology, bias testing, statistical rigor, dataset independence.

| Level | Summary | Description |
|:-----:|---------|-------------|
| 1 | **No ML-specific V&V** | No ML-specific validation methodology. Model treated as deterministic software for V&V purposes. |
| 2 | **Basic metrics only** | Basic accuracy metrics defined but no statistical methodology, dataset independence, or bias testing. |
| 3 | **Statistical methodology present** | Statistical methodology present. Independent test dataset documented. No subgroup analysis or bias testing. |
| 4 | **Subgroup-aware evaluation** | Above plus subgroup performance analysis and documented bias testing methodology. No prospective monitoring plan. |
| 5 | **Full PCCP compliance** | All Level 4 elements plus prospective performance monitoring, pre-specified statistical analysis plan, and PCCP §VII.B.3 full compliance. |

### Key heuristic targets

- Performance metrics appropriate to clinical task (sensitivity, specificity, AUC, PPV, NPV)
- Statistical methodology (confidence intervals, hypothesis tests, sample size justification)
- Independent test dataset with documented provenance
- Subgroup performance analysis (age, sex, race/ethnicity, disease severity, site)
- Bias testing methodology with acceptance criteria
- Prospective performance monitoring plan with pre-specified statistical analysis plan (SAP)

---

## Axis 4 — Update & Monitoring (§VII.B.4)

Deployment monitoring, drift detection, update procedures, rollback, user notification.

| Level | Summary | Description |
|:-----:|---------|-------------|
| 1 | **No monitoring** | No post-deployment monitoring plan. Model outputs not tracked after release. |
| 2 | **Basic logging only** | Basic logging exists but no performance degradation detection, drift monitoring, or update procedures. |
| 3 | **Alerting defined** | Performance monitoring defined with alert thresholds. No formal update procedure or user notification protocol. |
| 4 | **Formal update process** | Above plus formal update procedure, rollback plan, and user notification protocol. No continuous drift detection. |
| 5 | **Full PCCP compliance** | All Level 4 elements plus continuous drift detection with automated alerts, defined re-validation triggers, and PCCP §VII.B.4 full compliance. |

### Key heuristic targets

- Post-deployment performance logging (predictions, confidence scores, outcomes when available)
- Performance degradation detection with defined thresholds
- Data and concept drift monitoring
- Formal update procedure (change control integration)
- Rollback plan with activation criteria and maximum rollback time
- User notification protocol for model updates
- Continuous drift detection with automated alerting
- Re-validation triggers linked to PCCP change boundaries

---

## Composite Score

The overall readiness level is the **minimum** across all four axes. Rationale: a PCCP submission must address all four subsections — strength in one area does not compensate for gaps in another.

| Overall Level | Interpretation |
|:-------------:|----------------|
| 1 | Not started — no ML lifecycle awareness in design controls |
| 2 | Early — significant gaps remain before PCCP viability |
| 3 | Developing — foundations present but bias, monitoring, or versioning gaps |
| 4 | Mature — near-complete but missing continuous/automated elements |
| 5 | PCCP-ready — all four axes satisfy guidance requirements |

---

## Maintenance

- Review rubric when FDA issues updated PCCP guidance or publishes example submissions
- Recalibrate level boundaries against accepted PCCP submissions once available
- Track inter-rater reliability if multiple assessors use the rubric independently
