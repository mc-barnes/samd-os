# 42 CFR Part 2 — Substance Use Disorder Confidentiality

## Purpose

42 CFR Part 2 provides federal protections for records of patients receiving treatment for substance use disorders (SUD). These protections are **more restrictive than HIPAA** and apply to all SUD treatment records regardless of state law.

This is critical for Eleanor Health because SUD treatment is a core service. Any AI system that touches member records must comply with both HIPAA and 42 CFR Part 2.

## Key Provisions

### What Part 2 Protects (§ 2.12)
- Records of the identity, diagnosis, prognosis, or treatment of any patient maintained in connection with a Part 2 program
- Applies to any information that would identify a person as having or having had a SUD
- Includes: clinical notes, lab results, treatment plans, attendance records, billing records that reveal SUD treatment

### Who It Applies To (§ 2.11)
- **Part 2 programs**: Any federally assisted program that holds itself out as providing SUD diagnosis, treatment, or referral
- "Federally assisted" includes: receiving federal funding, tax-exempt status, Medicare/Medicaid enrollment, DEA registration
- Practically: most SUD treatment providers qualify, including Eleanor Health

### Consent Requirements (§ 2.31)
Part 2 consent must include ALL of the following:
1. Name of the patient
2. Name of the program making the disclosure
3. Name of the entity receiving the disclosure
4. Purpose of the disclosure
5. How much and what kind of information will be disclosed
6. Patient's right to revoke consent (and exceptions)
7. Expiration date or condition
8. Signature of the patient (or authorized representative)
9. Date of signature

**Key difference from HIPAA**: HIPAA allows disclosure for Treatment, Payment, and Health Care Operations (TPO) without patient authorization. Part 2 generally requires **written patient consent** for most disclosures.

### Exceptions to Consent (§ 2.51-2.53)
Limited disclosures permitted without consent:
- Medical emergencies (§ 2.51) — immediate threat to health
- Audit and evaluation (§ 2.53) — by authorized auditors only
- Court orders (§ 2.64-2.67) — with specific "good cause" requirements
- Reporting of child abuse/neglect — as required by state law
- Qualified Service Organization Agreements (QSOA) — see below

### Qualified Service Organization Agreement (QSOA) (§ 2.12(c)(4))
- A QSOA allows Part 2 programs to share records with service organizations that provide services to the program (e.g., labs, billing services, IT vendors)
- The QSOA must specify what services are provided and that the organization will comply with Part 2
- **AI vendors processing SUD records may need a QSOA** in addition to a HIPAA BAA

### Re-disclosure Prohibition (§ 2.32)
- Any recipient of Part 2 information is prohibited from re-disclosing it
- Must include a notice: "This record is protected by federal confidentiality rules (42 CFR Part 2). The federal rules prohibit any use of this record to criminally investigate or prosecute any alcohol or drug abuse patient."
- **AI implication**: AI systems must not surface SUD information in contexts where it could be re-disclosed (e.g., shared dashboards, cross-team reports)

## 2024 Rule Changes (Final Rule — February 2024)

The 2024 final rule **partially aligned Part 2 with HIPAA**:

### What Changed
- **TPO Consent**: Single consent can now cover all future treatment, payment, and healthcare operations disclosures (previously required purpose-specific consent each time)
- **HIPAA Breach Notification**: Part 2 records are now subject to HIPAA breach notification requirements (45 CFR Parts 160, 164)
- **Patient Rights**: Part 2 patients now have HIPAA-style rights (access, amendment, accounting of disclosures)
- **Antidiscrimination**: Prohibits use of Part 2 records in legal proceedings against the patient (strengthened)

### What Did NOT Change
- Part 2 records still cannot be used for criminal investigation or prosecution of the patient
- Re-disclosure prohibition remains in effect
- Written consent is still required for most disclosures (TPO consent is broader but still requires initial consent)
- Part 2 still applies as an overlay on top of HIPAA — both must be satisfied

## AI-Specific Implications

### For AI Voice/SMS Agents
- AI agents must not ask members about SUD treatment details in outbound calls/texts (could create a Part 2 record)
- If a member voluntarily discloses SUD information to an AI agent, the transcript becomes a Part 2 record
- Transcripts containing SUD information must be stored with Part 2 protections (separate from general PHI if needed)

### For Internal AI (Claude Enterprise)
- Employees using Claude Enterprise must not input SUD treatment records without proper consent
- AI-generated summaries of SUD records are themselves Part 2 protected
- Prompts containing member SUD information are Part 2 records

### For AI Analytics
- De-identification of SUD data must follow Part 2 standards (not just HIPAA Safe Harbor)
- Aggregate data that could identify an individual as having SUD is protected
- AI models trained on SUD data could potentially reveal SUD status through inference

## References

- 42 CFR Part 2 (full text): https://www.ecfr.gov/current/title-42/chapter-I/subchapter-A/part-2
- SAMHSA Fact Sheet on 2024 Final Rule
- HHS Final Rule (89 FR 12472, February 2024)
- SAMHSA FAQs on Confidentiality of SUD Patient Records
