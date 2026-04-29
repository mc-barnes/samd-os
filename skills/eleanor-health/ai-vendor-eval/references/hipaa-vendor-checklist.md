# HIPAA Vendor Compliance Checklist

## Purpose

Checklist for scoring a vendor's HIPAA compliance posture. This is the applied assessment tool — it evaluates whether a specific vendor meets the requirements defined in the `hipaa-governance` skill's normative standards.

Use this checklist during vendor evaluation (Phase 2 of the evaluation framework) to systematically assess each compliance requirement.

## BAA Requirements

| # | Requirement | Status | Evidence | Notes |
|---|------------|--------|----------|-------|
| 1 | Vendor willing to sign BAA | | | Non-negotiable. No BAA = no deal. |
| 2 | BAA covers all services that touch PHI | | | Including AI processing, storage, support access |
| 3 | BAA specifies permitted uses/disclosures | | | Must explicitly prohibit model training on PHI |
| 4 | BAA includes breach notification timeline | | | Must meet HIPAA requirement (without unreasonable delay, ≤60 days) |
| 5 | BAA addresses subprocessors | | | Vendor must ensure downstream BAAs with subprocessors |
| 6 | BAA includes data return/destruction on termination | | | Must be able to delete all PHI on contract end |
| 7 | BAA grants audit rights | | | Right to audit vendor's PHI handling practices |

## PHI Handling

| # | Requirement | Status | Evidence | Notes |
|---|------------|--------|----------|-------|
| 8 | PHI encrypted in transit (TLS 1.2+) | | | Verify certificate and protocol version |
| 9 | PHI encrypted at rest (AES-256 or equivalent) | | | Verify encryption standard and key management |
| 10 | Access controls (RBAC) for PHI | | | Who at the vendor can access PHI? Role-based? |
| 11 | PHI not used for model training/improvement | | | Must be contractual, not just policy |
| 12 | PHI not retained beyond session/task completion | | | Or: retention period defined and acceptable |
| 13 | PHI data residency confirmed (US-only) | | | Verify processing AND storage locations |
| 14 | PHI de-identification capabilities | | | Can vendor de-identify data for analytics? |
| 15 | Context window/session data cleared after use | | | For LLM-based services: no cross-session leakage |

## Audit & Monitoring

| # | Requirement | Status | Evidence | Notes |
|---|------------|--------|----------|-------|
| 16 | Audit logging of all PHI access | | | Timestamp, user, action, data accessed |
| 17 | Logs tamper-proof and retained ≥6 years | | | HIPAA retention requirement |
| 18 | Real-time monitoring for unauthorized access | | | Alerting on anomalous PHI access patterns |
| 19 | Regular vulnerability scanning | | | Frequency and scope of scans |
| 20 | Penetration testing (annual minimum) | | | Third-party pen test results available? |

## Incident Response

| # | Requirement | Status | Evidence | Notes |
|---|------------|--------|----------|-------|
| 21 | Documented incident response plan | | | Specific to PHI/data breaches |
| 22 | Breach notification within contractual timeline | | | Must align with HIPAA and BAA terms |
| 23 | Root cause analysis process | | | Post-incident RCA with corrective actions |
| 24 | Customer notification process | | | How and when are customers notified? |
| 25 | Insurance/liability coverage | | | Cyber liability insurance in place? |

## Certifications & Attestations

| # | Requirement | Status | Evidence | Notes |
|---|------------|--------|----------|-------|
| 26 | SOC 2 Type II (current) | | | Covers security, availability, confidentiality |
| 27 | HITRUST CSF certification | | | Gold standard for healthcare; preferred but not required |
| 28 | HIPAA compliance attestation | | | Self-attestation at minimum |
| 29 | Third-party security audit (annual) | | | Independent assessment of security controls |

## 42 CFR Part 2 (SUD-Specific)

| # | Requirement | Status | Evidence | Notes |
|---|------------|--------|----------|-------|
| 30 | Vendor understands Part 2 obligations | | | Not just HIPAA — Part 2 is stricter |
| 31 | QSOA available (if needed) | | | Qualified Service Organization Agreement |
| 32 | Re-disclosure controls in place | | | Vendor cannot re-disclose SUD records |
| 33 | Consent management supported | | | Can track/enforce Part 2 consent requirements |
| 34 | SUD data segregation capability | | | Can separate SUD records from general PHI if needed |

## Scoring Guide

| Score | Criteria Met | Interpretation |
|-------|-------------|----------------|
| 5 (Exceeds) | All items in section + proactive measures beyond requirements | Vendor is a compliance leader |
| 4 (Meets) | All required items met, evidence documented | Vendor is fully compliant |
| 3 (Partial) | Most items met, 1-2 gaps with remediation plans | Acceptable with conditions |
| 2 (Gaps) | Multiple gaps, remediation timeline unclear | Significant risk |
| 1 (Fails) | Critical items missing (BAA, encryption, breach notification) | Disqualifying |

## Red Flags

Stop the evaluation if any of these are true:
- Vendor refuses to sign a BAA
- PHI is processed outside the US with no option to change
- Vendor uses PHI for model training and cannot opt out
- No encryption at rest or in transit
- No audit logging capability
- Vendor has had an unreported breach
