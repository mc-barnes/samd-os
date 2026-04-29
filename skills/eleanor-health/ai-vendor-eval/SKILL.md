---
name: ai-vendor-eval
description: >
  Generate AI vendor evaluation scorecards as XLSX. Covers weighted criteria
  scoring, clinical safety assessment, HIPAA compliance checklist, tech stack
  integration assessment, pilot design, and contract requirements. Use when
  evaluating AI vendors for healthcare deployments.
  Triggers: "vendor eval", "AI vendor", "scorecard", "pilot design",
  "vendor assessment", "vendor go/no-go".
---

# AI Vendor Evaluation Skill

## When to Use
- Evaluating AI vendors for clinical or operational healthcare deployments
- Scoring vendors against weighted criteria (clinical safety, compliance, integration, cost)
- Assessing HIPAA compliance posture for a prospective AI vendor
- Designing a structured pilot to validate vendor claims before full deployment
- Documenting contract requirements and SLA expectations for AI vendor agreements
- Preparing a GO/NO-GO recommendation for leadership or procurement

## When NOT to Use
- Clinical safety requirements for AI agents (use `clinical-safety` instead)
- HIPAA/PHI governance frameworks (use `hipaa-governance` instead)
- EHR integration architecture (use `ehr-integration` instead)
- AI rollout planning and adoption strategy (use `ai-deployment-playbook` instead)
- General software vendor selection with no AI/ML component -- use standard procurement
- Evaluating internal AI models you are building yourself (this is for *third-party* vendors)
- Non-healthcare contexts where HIPAA and clinical safety do not apply

## Quick Start

```bash
# Generate Eleanor Health example with all 7 sheets
python scripts/generate_vendor_eval.py --example eleanor

# Generate scorecard for a specific vendor and category
python scripts/generate_vendor_eval.py --vendor "Vendor Name" --category "voice-agent"
```

Output lands in `output/vendor-eval-{vendor-slug}.xlsx`.

## XLSX Structure -- 7 Sheets

### 1. Evaluation_Summary
| Column | Description |
|--------|-------------|
| Vendor Name | Name of the AI vendor being evaluated |
| Category | Product category (e.g., voice-agent, clinical-NLP, ambient-scribe) |
| Overall Score | Weighted average across all criteria (1.0-5.0 scale) |
| Recommendation | Formula-driven: Proceed / Conditional / Reject |
| Decision Date | Date the evaluation decision was made |
| Owner | Person responsible for the evaluation |

### 2. Criteria_Scoring
| Column | Description |
|--------|-------------|
| Criterion | Specific evaluation criterion |
| Category | Scoring domain (Clinical Efficacy, Safety, Compliance, Integration, Cost, Support) |
| Weight (%) | Percentage weight (all weights must sum to 100%) |
| Score (1-5) | Raw score on 1-5 scale |
| Weighted Score | Formula: =Weight * Score |
| Evidence/Notes | Supporting evidence or notes for the score |

### 3. Clinical_Safety
| Column | Description |
|--------|-------------|
| Requirement ID | CS-001, CS-002, ... |
| Requirement | Specific clinical safety requirement |
| Priority | Critical / High / Medium / Low |
| Met? | Yes / No / Partial / N/A |
| Evidence | Documentation or attestation provided by vendor |
| Gap Notes | Details on any gaps identified |

### 4. HIPAA_Compliance
| Column | Description |
|--------|-------------|
| Requirement ID | HC-001, HC-002, ... |
| Requirement | Specific HIPAA or compliance requirement |
| Status | Compliant / Partially Compliant / Non-Compliant / Not Assessed |
| Evidence | Documentation or attestation provided by vendor |
| Risk if Unmet | Consequence of non-compliance |

### 5. Integration_Assessment
| Column | Description |
|--------|-------------|
| System | System component (e.g., athenahealth, Salesforce, data warehouse) |
| Integration Type | API, FHIR, HL7v2, flat file, manual, etc. |
| Feasibility | High / Medium / Low |
| Effort Estimate | Estimated integration effort |
| Dependencies | Systems or teams this integration depends on |
| Notes | Additional context or concerns |

### 6. Pilot_Design
| Column | Description |
|--------|-------------|
| Metric | KPI to track during pilot |
| Baseline | Current baseline value |
| Target | Target value for success |
| Measurement Method | How the metric will be measured |
| Duration | Planned measurement duration |
| Success Threshold | Minimum acceptable result |
| Owner | Responsible party |

### 7. Contract_Requirements
| Column | Description |
|--------|-------------|
| Term | Contract domain (SLA, Data Rights, Termination, Liability, Support) |
| Requirement | Specific contract term or clause |
| Vendor Response | Vendor's position on this term |
| Acceptable? | Yes / No / Negotiate |
| Negotiation Notes | Fallback positions or context |

## Decision Thresholds

| Overall Score | Recommendation | Action |
|---------------|---------------|--------|
| >= 4.0 | Proceed | Advance to pilot or contracting |
| 3.0 - 3.9 | Conditional | Proceed only if identified gaps are resolved with documented mitigations |
| < 3.0 | Reject | Do not proceed; document rationale and re-evaluate if vendor remediates |

## Reference Files
- `references/evaluation-framework.md` -- Weighted criteria definitions, scoring rubrics, category benchmarks
- `references/hipaa-vendor-checklist.md` -- HIPAA Security Rule requirements mapped to vendor assessment questions
- `references/integration-patterns.md` -- Common EHR/data integration patterns, API standards, interoperability requirements

## Verification Checklist

Before submitting a vendor evaluation scorecard, verify:

- [ ] Every criterion has a unique ID (CS-nnn, SAF-nnn, HIP-nnn, INT-nnn, PIL-nnn, CON-nnn)
- [ ] Criteria weights in Criteria_Scoring sum to exactly 100%
- [ ] Weighted Score is calculated via formula (=Weight * Score), not hardcoded
- [ ] Overall Score in Evaluation_Summary is formula-driven from Criteria_Scoring weighted scores
- [ ] Recommendation is formula-driven from decision thresholds, not manually entered
- [ ] Every Clinical_Safety item with Severity "Critical" has a vendor mitigation documented
- [ ] Every HIPAA requirement has a Status value (no blank statuses)
- [ ] Every Integration_Assessment gap with Risk Level "High" has a corresponding Pilot_Design phase to validate
- [ ] Pilot_Design includes measurable success criteria and rollback triggers for each phase
- [ ] Contract_Requirements includes at least one Must-Have item for SLA, Data Rights, and Termination categories
