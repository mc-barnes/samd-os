# Internal AI Usage Policy — Template

## Purpose

Template for an organization-wide policy governing employee use of AI tools (Claude Enterprise, other LLMs) with protected health information. Customize for your organization's specific tools, roles, and workflows.

---

## [Organization Name] — AI Usage Policy

### 1. Scope

This policy applies to all employees, contractors, and vendors who use AI tools in the course of their work at [Organization Name]. This includes but is not limited to:
- Claude Enterprise (Anthropic)
- Any LLM-based tool (ChatGPT, Gemini, Copilot, etc.)
- AI-powered features within existing software (EHR AI assistants, CRM AI features)
- Custom AI tools built or deployed by the organization

### 2. Approved AI Tools

| Tool | Approved Use | PHI Permitted? | BAA in Place? |
|------|-------------|----------------|---------------|
| Claude Enterprise | Internal productivity, document drafting, analysis | Yes (with controls below) | Yes |
| [Tool 2] | [Use case] | [Yes/No] | [Yes/No] |
| [Tool 3] | [Use case] | [Yes/No] | [Yes/No] |

**Unapproved tools**: Any AI tool not listed above is prohibited for use with PHI or SUD treatment records. Using an unapproved tool with PHI is a policy violation and potential HIPAA breach.

### 3. What You CAN Do with AI

#### With PHI (Approved Tools Only)
- Summarize clinical notes for handoff preparation
- Draft communications to members (reviewed by human before sending)
- Analyze operational data for workflow improvements
- Generate templates for clinical documentation
- Research clinical guidelines and best practices

#### Without PHI (Any Approved Tool)
- Draft internal communications, reports, presentations
- Research topics, brainstorm ideas, outline documents
- Generate code, scripts, or technical documentation
- Analyze de-identified or aggregate data
- Prepare training materials

### 4. What You CANNOT Do with AI

#### Prohibited Actions (All Tools)
- Input raw member records (names, DOBs, SSNs, medical record numbers) into any AI tool
- Upload documents containing PHI to AI tools without de-identification
- Use AI to make clinical decisions without licensed human review
- Share AI-generated clinical content with members without clinical approval
- Use personal AI accounts (free ChatGPT, personal Claude) for any work-related PHI
- Input SUD treatment records into AI without verifying Part 2 consent
- Use AI outputs as the sole basis for treatment, billing, or compliance decisions

#### De-identification Before AI Input
When using AI to analyze member data, de-identify first:
- Remove: names, dates (except year), phone numbers, addresses, SSN, MRN, email
- Replace with: [MEMBER], [DATE], [PHONE], [ADDRESS], [ID]
- Follow HIPAA Safe Harbor method (18 identifiers — 45 CFR § 164.514(b)(2))
- SUD records require additional care — even de-identified SUD data may be Part 2 protected if re-identification is possible

### 5. SUD Treatment Records — Additional Rules

42 CFR Part 2 records require stricter handling than general PHI:
- **Do NOT** input SUD-specific information into any AI tool without Part 2 compliant consent
- SUD information includes: substance names, treatment attendance, drug screen results, SUD diagnoses, MAT medication details
- If unsure whether data is Part 2 protected, treat it as protected
- AI-generated outputs containing SUD information are themselves Part 2 records

### 6. Roles and Responsibilities

| Role | Responsibility |
|------|---------------|
| All employees | Follow this policy; report violations; complete AI training |
| Managers | Ensure team compliance; approve new AI use cases |
| IT / Security | Manage approved tool list; monitor for unauthorized tool use |
| Compliance | Audit AI usage; investigate violations; update policy |
| Clinical Leadership | Approve clinical AI use cases; review AI-generated clinical content |
| Privacy Officer | Assess AI tools for HIPAA/Part 2 compliance; manage BAAs |

### 7. Incident Reporting

If you believe PHI or SUD records were improperly used with an AI tool:
1. **Immediately** stop using the tool for that purpose
2. **Report** to [Privacy Officer / Compliance Team] within 24 hours
3. **Document** what data was input, which tool was used, and when
4. **Do not** attempt to delete or modify the AI conversation history (preserve for investigation)

### 8. Training Requirements

- All employees must complete AI usage training before accessing approved AI tools
- Training covers: this policy, PHI identification, de-identification methods, Part 2 basics, approved use cases
- Annual refresher training required
- New tool onboarding training required when new AI tools are approved

### 9. Policy Review

- This policy is reviewed and updated quarterly
- Updates triggered by: new AI tool approvals, regulatory changes, incident findings, new use cases
- Policy owner: [Privacy Officer / Chief Compliance Officer]

---

## Acknowledgment

I have read and understand the AI Usage Policy. I agree to comply with all requirements.

| Field | Value |
|-------|-------|
| Employee Name | _________________ |
| Department | _________________ |
| Date | _________________ |
| Signature | _________________ |
