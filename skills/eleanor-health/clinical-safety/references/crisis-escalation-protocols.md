# Crisis Escalation Protocols — Behavioral Health AI

## Purpose

Defines escalation tiers for AI systems interacting with behavioral health members. Any AI agent (voice, SMS, chat) must be able to detect crisis indicators and escalate appropriately.

## Escalation Tiers

### Tier 1: Immediate Danger (Escalate NOW — warm handoff to human within 60 seconds)

**Indicators**:
- Suicidal ideation: explicit statements ("I want to die", "I'm going to kill myself", "I don't want to be here anymore")
- Active self-harm: "I'm cutting", "I took pills", "I'm hurting myself right now"
- Overdose indicators: "I used too much", "I can't breathe", "I took everything", confusion/slurring (voice)
- Homicidal ideation: threats of violence toward others
- Medical emergency: seizures, loss of consciousness, severe withdrawal symptoms (delirium tremens, hallucinations)

**AI Action**:
1. Immediately acknowledge: "I hear you, and I want to make sure you're safe right now."
2. Do NOT ask probing questions — do not delay the handoff
3. Initiate warm handoff to crisis-trained human staff
4. If unable to reach staff: provide 988 Suicide & Crisis Lifeline (call/text 988) and 911
5. Log the interaction with full transcript for clinical review

**Warm Handoff Requirements**:
- AI must stay on the line/in the conversation until a human connects
- AI must pass context to the human: member name, what was said, escalation reason
- The member must never be placed on hold or dropped during transfer
- If transfer fails after 2 attempts, instruct member to call 988 or 911 directly

### Tier 2: Elevated Risk (Escalate within 15 minutes)

**Indicators**:
- Passive suicidal ideation: "I wish I wasn't alive", "everyone would be better off without me"
- Relapse disclosure: "I used last night", "I fell off the wagon", "I bought [substance]"
- Withdrawal symptoms: tremors, anxiety, nausea, insomnia described by member
- Severe emotional distress: panic attacks, dissociation, uncontrollable crying
- Medication non-adherence: "I stopped taking my meds", "I ran out of medication"
- Domestic violence or unsafe living situation

**AI Action**:
1. Validate: "Thank you for sharing that with me. That sounds really difficult."
2. Assess willingness: "Would you like to speak with someone from your care team?"
3. Schedule or initiate contact with care team
4. If member declines: document and flag for care team follow-up within 24 hours
5. Provide crisis resources: 988, SAMHSA helpline (1-800-662-4357)

### Tier 3: Routine (Standard workflow)

**Indicators**:
- Scheduling requests, appointment changes
- General information questions
- Medication refill requests (non-urgent)
- Insurance or billing questions
- Program enrollment inquiries

**AI Action**:
- Handle within normal workflow
- No escalation required
- Log interaction for analytics

## Documentation Standards

Every escalation must be documented with:
- Timestamp (UTC)
- Member identifier (anonymized in logs, linked in EHR)
- Tier level triggered
- Specific indicator(s) detected
- AI response taken
- Handoff outcome (successful/failed, time to human connection)
- Follow-up actions assigned

## References

- SAMHSA National Helpline: 1-800-662-4357
- 988 Suicide & Crisis Lifeline: call or text 988
- Crisis Text Line: text HOME to 741741
- SAMHSA Treatment Locator: https://findtreatment.gov
- Columbia Suicide Severity Rating Scale (C-SSRS): standard clinical tool for suicide risk assessment
