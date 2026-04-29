---
name: hipaa-governance
description: >
  Generate HIPAA and PHI governance frameworks for AI deployments in
  healthcare. Covers data classification, AI-specific PHI controls, BAA
  requirements, 42 CFR Part 2 overlay for SUD records, internal AI usage
  policies, and incident response. Use when deploying AI tools that handle
  PHI or establishing organizational AI governance.
  Triggers: "HIPAA", "PHI", "BAA", "data governance",
  "42 CFR Part 2", "SUD confidentiality".
---

# HIPAA & PHI Governance Skill

## When to Use
- Any AI deployment that will access, process, or store PHI
- Evaluating a vendor's HIPAA compliance posture (pair with `ai-vendor-eval` for the full scorecard)
- Establishing internal AI usage policies (Claude Enterprise, other LLMs)
- Assessing 42 CFR Part 2 implications for SUD treatment data
- Building data governance frameworks for AI-powered workflows
- Responding to compliance questions about AI and PHI

## When NOT to Use
- General product questions without PHI implications
- Clinical safety requirements for member-facing AI (use `clinical-safety` instead)
- Technical EHR integration architecture (use `ehr-integration` instead)
- Scoring a specific vendor's compliance (use `ai-vendor-eval` instead — this skill defines the standards, vendor eval scores against them)
- Non-healthcare AI deployments where HIPAA does not apply

## Governance Framework Template

When generating a governance framework, cover all 6 sections:

### 1. Data Classification
Classify the data the AI system will handle:

| Classification | Description | Examples | Protection Level |
|---------------|-------------|----------|-----------------|
| PHI | Individually identifiable health information | Member names + diagnoses, treatment records, billing records | HIPAA + BAA required |
| SUD Records | Substance use disorder treatment records | SUD diagnoses, drug screens, MAT medications, treatment attendance | HIPAA + 42 CFR Part 2 + consent required |
| De-identified | Data with all 18 HIPAA identifiers removed | Aggregate outcomes, population statistics | Standard data security |
| Non-PHI | Operational data not linked to individuals | Workflow metrics, scheduling patterns (no member data) | Standard data security |

### 2. AI-Specific PHI Controls
Address risks unique to AI/LLM systems:
- **Model training exclusion**: Verify vendor does not use PHI for model training or improvement
- **Context window management**: Minimize PHI loaded into AI context; clear after each session
- **Prompt injection protection**: Input sanitization to prevent PHI leakage via adversarial prompts
- **Output filtering**: Scan AI outputs for PHI before displaying to unauthorized users
- **Audit logging**: Log all AI interactions involving PHI (timestamp, user, data accessed, purpose)
- **Data residency**: Confirm PHI is processed in US-only data centers

See `references/hipaa-ai-controls.md` for detailed control requirements by HIPAA category.

### 3. BAA Requirements
Every AI vendor processing PHI must have a signed BAA. The BAA must include:
- Permitted uses and disclosures of PHI
- Obligation to safeguard PHI (administrative, physical, technical safeguards)
- Obligation to report breaches within required timeframes
- Requirement to return or destroy PHI upon termination
- Prohibition on using PHI for vendor's own purposes (including model training)
- Subcontractor obligations (downstream BAAs required)
- Audit and access rights

### 4. 42 CFR Part 2 Overlay
For any AI system touching SUD treatment records, additional requirements apply:
- Written patient consent required before disclosure (even for treatment/payment/operations — despite 2024 rule changes, consent is still required)
- Re-disclosure prohibition: recipients cannot re-disclose Part 2 information
- Re-disclosure notice must accompany any shared Part 2 records
- QSOA may be needed for AI vendors in addition to BAA
- AI-generated outputs containing SUD information are themselves Part 2 records
- Criminal use prohibition: Part 2 records cannot be used to investigate or prosecute the patient

See `references/42cfr-part2-summary.md` for full Part 2 provisions and 2024 rule changes.

### 5. Internal AI Use Policy
Define rules for employee use of AI tools with PHI:
- Approved vs. unapproved tools list
- What employees can and cannot input to AI tools
- De-identification requirements before AI input
- SUD record handling rules (stricter than general PHI)
- Incident reporting procedures
- Training requirements

See `references/internal-ai-policy-template.md` for a complete policy template.

### 6. Incident Response
Define the response process for AI-related PHI breaches:
- **Detection**: How AI-related breaches are identified (audit log review, employee reports, vendor notification)
- **Assessment**: Determine scope — what PHI was exposed, how many members affected, was SUD data involved
- **Notification**: HIPAA breach notification timelines (individual notice without unreasonable delay, no later than 60 days; HHS notification; media notification if >500 individuals)
- **Remediation**: Vendor remediation, policy updates, additional controls
- **Documentation**: Breach log maintained for minimum 6 years

## Output Format

```markdown
# PHI Governance Framework — [AI System/Initiative Name]

## 1. Data Classification
[Table of data types, classifications, protection levels]

## 2. AI-Specific PHI Controls
[Controls mapped to HIPAA safeguard categories]

## 3. BAA Requirements
[BAA status, key terms, gaps]

## 4. 42 CFR Part 2 Assessment
[Applicability, consent status, re-disclosure controls]

## 5. Internal AI Usage Policy
[Summary of employee rules, approved tools, training status]

## 6. Incident Response Plan
[Detection, assessment, notification, remediation procedures]

## Compliance Status
[Overall readiness assessment with open items]
```

## Reference Files
- `references/hipaa-ai-controls.md` — PHI safeguards specific to AI/LLM deployments
- `references/42cfr-part2-summary.md` — 42 CFR Part 2 key provisions and 2024 rule changes
- `references/internal-ai-policy-template.md` — Employee AI usage policy template

## Verification Checklist

Before approving an AI system for PHI access, verify:

- [ ] BAA signed with AI vendor (non-negotiable)
- [ ] Model training opt-out confirmed in writing
- [ ] Data residency confirmed (US-only for PHI)
- [ ] Audit logging enabled for all AI-PHI interactions
- [ ] 42 CFR Part 2 applicability assessed (if SUD data involved)
- [ ] Patient consent documented (if Part 2 applies)
- [ ] Internal AI usage policy published and employees trained
- [ ] Incident response plan updated to include AI-related breaches
- [ ] De-identification procedures documented for AI input
- [ ] Vendor SOC 2 or HITRUST certification verified

## Disclaimer

This skill provides informational frameworks for HIPAA and 42 CFR Part 2 compliance planning. It does not constitute legal advice. Regulatory requirements are complex, jurisdiction-dependent, and subject to change. Consult qualified legal counsel and your organization's compliance team before making compliance determinations or deploying AI systems with PHI.
