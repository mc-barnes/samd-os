---
name: clinical-safety
description: >
  Generate behavioral health clinical safety requirements for AI deployments
  interacting with members. Covers crisis escalation, scope of practice,
  de-escalation, consent, content guardrails, and monitoring/QA. Use when
  deploying AI voice agents, SMS agents, or chatbots in a behavioral health
  or SUD treatment context.
  Triggers: "clinical safety", "crisis protocol", "crisis escalation",
  "de-escalation", "scope of practice".
---

# Behavioral Health Clinical Safety Skill

## When to Use
- Any AI deployment that interacts with members (voice, SMS, chat)
- Any AI system that processes clinical content (transcripts, call recordings, clinical notes)
- Designing safety requirements for new AI agent deployments
- Reviewing existing AI agents for clinical safety compliance
- Building crisis escalation workflows into AI products
- Defining scope of practice boundaries for AI in behavioral health

## When NOT to Use
- General product requirements without member-facing AI (use `prd-writer-samd` instead)
- HIPAA/PHI governance questions (use `hipaa-governance` instead)
- Vendor evaluation (use `ai-vendor-eval` instead)
- EHR integration architecture (use `ehr-integration` instead)
- Non-clinical AI deployments (internal productivity tools, analytics dashboards)

## Safety Requirements Framework

When generating clinical safety requirements for an AI deployment, cover all 6 sections:

### 1. Crisis Detection & Escalation
Define how the AI detects and responds to crisis situations:
- **Tier 1 (Immediate Danger)**: Suicidal ideation, active self-harm, overdose, homicidal ideation → warm handoff to human within 60 seconds
- **Tier 2 (Elevated Risk)**: Passive SI, relapse, withdrawal symptoms, severe distress → escalate within 15 minutes
- **Tier 3 (Routine)**: Standard administrative interactions → normal workflow

For each tier, specify:
- Detection keywords and behavioral patterns
- AI response script
- Handoff target (crisis team, care team, 988 Lifeline)
- Maximum time-to-human
- Documentation requirements

See `references/crisis-escalation-protocols.md` for full tier definitions.

### 2. Scope of Practice Boundaries
Define what the AI can and cannot do:
- **Allowed**: Administrative tasks, pre-approved information sharing, scheduling, outreach
- **Prohibited**: Diagnosis, medication advice, clinical recommendations, symptom interpretation, treatment suggestions
- **Boundary phrases**: Hard-coded responses when members ask clinical questions ("That's an important question for your care team. Would you like me to connect you?")

See `references/scope-of-practice-boundaries.md` for detailed boundary lists and multi-state considerations.

### 3. De-escalation Protocols
Define how the AI communicates with distressed members:
- **Tone**: Calm, empathetic, validating — never dismissive, rushed, or clinical
- **Pacing**: Slow down response speed for distressed callers (voice); shorter messages with pauses (SMS)
- **Validation language**: "I hear you", "That sounds really difficult", "Thank you for sharing that"
- **Prohibited language**: "Calm down", "It's not that bad", "You need to relax", "Don't worry"
- **Escalation trigger**: If de-escalation fails after 2 attempts, escalate to Tier 2

### 4. Consent & Transparency
Define disclosure and opt-out requirements:
- AI must identify itself as AI at the start of every interaction (no exceptions)
- Member must be able to opt out and reach a human at any time
- Disclosure language must be plain, clear, and compliant with state laws
- Consent must be documented and logged

See `references/ai-transparency-requirements.md` for FTC guidance, state laws, and recommended disclosure scripts.

### 5. Clinical Content Guardrails
Define content controls for AI-generated responses:
- **Approved content sources**: Curated FAQ knowledge base, program descriptions, resource lists
- **Prohibited topics**: AI must not discuss specific treatment protocols, medications, dosing, or clinical outcomes
- **Escalation triggers**: Any mention of substances, self-harm, weapons, domestic violence, child abuse
- **Response templates**: Pre-approved response templates for common clinical-adjacent questions
- **Content review cadence**: Clinical team reviews AI response templates quarterly

### 6. Monitoring & QA
Define ongoing safety monitoring:
- **Transcript review**: Sample 5% of AI interactions weekly for safety compliance
- **Adverse event tracking**: Log and investigate any interaction where a member reported harm or a crisis was missed
- **False negative analysis**: Track cases where a crisis was detected by a human but missed by AI
- **Metrics**: Time-to-escalation, escalation accuracy rate, member satisfaction post-escalation, opt-out rate
- **Reporting**: Monthly safety report to clinical leadership; immediate reporting for adverse events

## Output Format

Generate safety requirements as a structured markdown document:

```markdown
# Clinical Safety Requirements — [AI Product Name]

## Product Overview
- Modality: [Voice / SMS / Chat]
- Member population: [Description]
- Use cases: [List]

## 1. Crisis Detection & Escalation
[Tier definitions, keywords, response scripts, handoff targets]

## 2. Scope of Practice
[Allowed/prohibited actions, boundary phrases]

## 3. De-escalation Protocols
[Tone guidelines, pacing, validation language, prohibited language]

## 4. Consent & Transparency
[Disclosure script, opt-out mechanism, documentation requirements]

## 5. Content Guardrails
[Approved sources, prohibited topics, escalation triggers]

## 6. Monitoring & QA
[Review cadence, metrics, reporting, adverse event process]

## Verification Checklist
[Pre-launch safety checklist]
```

## Reference Files
- `references/crisis-escalation-protocols.md` — Tier definitions, indicators, warm handoff requirements
- `references/scope-of-practice-boundaries.md` — AI boundaries, multi-state considerations, SAMHSA guidance
- `references/ai-transparency-requirements.md` — FTC guidance, state laws, disclosure scripts

## Verification Checklist

Before approving an AI deployment for member interaction, verify:

- [ ] Crisis escalation covers all Tier 1 indicators (SI, self-harm, overdose, homicidal ideation)
- [ ] Warm handoff path tested end-to-end with fallback to 988/911
- [ ] Scope of practice boundaries are hard-coded (not just guidelines)
- [ ] AI identifies itself as AI at the start of every interaction
- [ ] Member can reach a human at any point (voice: transfer; SMS: HUMAN keyword)
- [ ] De-escalation language reviewed and approved by clinical team
- [ ] Content guardrails prevent AI from making clinical statements
- [ ] Monitoring plan includes transcript sampling and adverse event tracking
- [ ] Multi-state compliance reviewed (most restrictive state as baseline)
- [ ] Clinical leadership has signed off on safety requirements

## Disclaimer

This skill provides informational frameworks for clinical safety planning. It does not constitute medical or legal advice. Crisis protocols, scope of practice boundaries, and transparency requirements vary by state and are subject to change. Consult qualified clinical leadership, legal counsel, and your organization's compliance team before deploying member-facing AI systems.
