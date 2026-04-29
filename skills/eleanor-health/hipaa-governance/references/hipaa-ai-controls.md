# HIPAA Safeguards for AI/LLM Deployments

## Purpose

Defines PHI protection requirements specific to AI and large language model (LLM) deployments in healthcare. Standard HIPAA controls apply, but AI systems introduce unique risks that require additional safeguards.

## AI-Specific Risks to PHI

### 1. Model Training Data Leakage
- **Risk**: If PHI is used to train or fine-tune an AI model, that data could be memorized and surfaced to other users
- **Control**: Ensure all AI vendor contracts include explicit model training opt-out clauses. Verify that PHI is never used for model training, fine-tuning, or evaluation by the vendor.
- **HIPAA basis**: 45 CFR § 164.502(a) — minimum necessary standard; 45 CFR § 164.504(e) — BAA requirements

### 2. Prompt Injection / Jailbreaking
- **Risk**: A malicious or accidental prompt could cause the AI to reveal PHI from its context window
- **Control**: Input sanitization, prompt guardrails, and output filtering. AI systems should never include raw PHI in system prompts unless absolutely necessary.
- **HIPAA basis**: 45 CFR § 164.312(a)(1) — access controls; 45 CFR § 164.312(e)(1) — transmission security

### 3. Context Window Exposure
- **Risk**: PHI loaded into an AI's context window (e.g., patient records for summarization) exists in memory during processing
- **Control**: Minimize PHI in context. Use de-identified data when possible. Ensure context is cleared after each session. Verify vendor does not retain context data.
- **HIPAA basis**: 45 CFR § 164.312(a)(2)(iv) — encryption and decryption; minimum necessary principle

### 4. Re-identification Risk
- **Risk**: AI can correlate de-identified data points to re-identify individuals, especially with small populations
- **Control**: Follow Safe Harbor or Expert Determination methods per 45 CFR § 164.514(b). Be especially cautious with behavioral health data where populations may be small.
- **HIPAA basis**: 45 CFR § 164.514 — de-identification standards

### 5. Audit Trail Gaps
- **Risk**: AI interactions with PHI may not be logged, making breach investigation impossible
- **Control**: All AI access to PHI must be logged with: timestamp, user identity, data accessed, purpose, AI model used. Logs must be tamper-proof and retained per HIPAA requirements (minimum 6 years).
- **HIPAA basis**: 45 CFR § 164.312(b) — audit controls; 45 CFR § 164.530(j) — retention

### 6. Data Residency
- **Risk**: PHI processed by cloud AI services may be transmitted to or stored in jurisdictions with different privacy protections
- **Control**: Verify data processing location. Require US-only data processing for PHI. Confirm in BAA.
- **HIPAA basis**: 45 CFR § 164.312(e)(1) — transmission security

## Required Controls by HIPAA Category

### Administrative Safeguards (45 CFR § 164.308)
- [ ] AI system included in security risk assessment (§ 164.308(a)(1))
- [ ] Workforce training on AI and PHI handling (§ 164.308(a)(5))
- [ ] AI vendor included in business associate management (§ 164.308(b))
- [ ] Incident response plan updated to include AI-related breaches (§ 164.308(a)(6))
- [ ] Access authorization for AI systems documented (§ 164.308(a)(4))

### Physical Safeguards (45 CFR § 164.310)
- [ ] AI infrastructure access controls documented (cloud or on-premises)
- [ ] Data center security verified for AI processing (via vendor SOC 2 / HITRUST)

### Technical Safeguards (45 CFR § 164.312)
- [ ] Unique user identification for AI system access (§ 164.312(a)(2)(i))
- [ ] Automatic logoff for AI sessions with PHI (§ 164.312(a)(2)(iii))
- [ ] Encryption of PHI at rest and in transit (§ 164.312(a)(2)(iv), (e)(2)(ii))
- [ ] Audit logging of all AI interactions with PHI (§ 164.312(b))
- [ ] Integrity controls on PHI processed by AI (§ 164.312(c))
- [ ] Transmission security for PHI sent to/from AI services (§ 164.312(e))

## AI Vendor Security Assessment Checklist

When evaluating an AI vendor for PHI handling:

1. **BAA execution**: Has the vendor signed a BAA? (Non-negotiable)
2. **Model training opt-out**: Does the vendor guarantee PHI is not used for training?
3. **Data retention**: What is the vendor's data retention policy? Can data be deleted on request?
4. **Encryption**: Is PHI encrypted in transit (TLS 1.2+) and at rest (AES-256)?
5. **Access controls**: Who at the vendor can access PHI? Role-based access?
6. **Audit logging**: Does the vendor provide audit logs for PHI access?
7. **Incident response**: What is the vendor's breach notification timeline?
8. **Subprocessors**: Does the vendor use subprocessors? Are they covered by the BAA?
9. **SOC 2 / HITRUST**: Does the vendor hold current security certifications?
10. **Data residency**: Where is PHI processed and stored? US-only?
