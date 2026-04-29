# Scope of Practice Boundaries — AI in Behavioral Health

## Purpose

Defines what AI agents can and cannot do when interacting with members in a behavioral health / SUD treatment context. These boundaries apply to all AI modalities: voice, SMS, chat.

## What AI Agents CAN Do

### Administrative Tasks
- Schedule, reschedule, or cancel appointments
- Provide clinic hours, locations, and contact information
- Confirm insurance eligibility (read-only lookups)
- Send appointment reminders and follow-up messages
- Collect intake information (demographics, contact info)
- Process medication refill requests (routing to pharmacy/provider)

### Information Sharing (Pre-Approved Content Only)
- Explain program structure and what to expect
- Share general wellness information (sleep hygiene, stress management)
- Provide crisis hotline numbers and community resources
- Describe available services and treatment modalities
- Answer FAQs from an approved knowledge base

### Engagement & Outreach
- Conduct outbound calls/SMS for lead conversion (with disclosure)
- Pre-visit data collection (allergies, current medications, symptoms)
- Post-visit follow-up surveys
- Appointment no-show follow-up

## What AI Agents CANNOT Do

### Clinical Activities (Requires Licensed Human)
- Diagnose any condition (mental health, SUD, medical)
- Recommend, adjust, or comment on medications
- Provide therapy, counseling, or clinical advice
- Interpret lab results, drug screening results, or clinical assessments
- Make treatment recommendations or suggest treatment changes
- Assess fitness for discharge or level-of-care changes

### Clinical Judgment Calls
- Determine whether symptoms are "serious" or "not serious"
- Advise whether a member should go to the ER
- Triage clinical urgency (this must follow crisis escalation protocols with human handoff)
- Provide reassurance about clinical symptoms ("that sounds normal")

### Prohibited Responses
- "You should..." followed by any clinical recommendation
- "That's probably just..." (minimizing symptoms)
- "Don't worry about..." (dismissing concerns)
- "In my experience..." (AI has no clinical experience)
- Any statement that could be interpreted as a clinical opinion

## Multi-State Considerations

Eleanor Health operates across multiple states. AI agents must account for:

### State Licensing Variations
- Scope of practice for peer support specialists varies by state
- Telehealth consent requirements differ (some states require verbal consent, others written)
- Mandatory reporting obligations vary (child abuse, elder abuse, duty to warn)
- Some states have additional AI disclosure requirements beyond FTC guidance

### Key Regulatory Bodies
- Each state's behavioral health licensing board
- State Medicaid programs (if applicable)
- DEA registration requirements for controlled substance prescribing (human-only)

### SAMHSA Guidance
- SAMHSA TIP 63: Medications for Opioid Use Disorder — defines evidence-based treatment standards
- SAMHSA National Practice Guidelines — scope of practice for SUD treatment
- 42 CFR Part 2 applies to all SUD treatment records regardless of state (federal preemption)

## Boundary Enforcement in AI Systems

### Design Requirements
1. AI must have a hard-coded list of prohibited response patterns
2. Clinical keyword detection must trigger scope-check before responding
3. When a member asks a clinical question, AI must respond: "That's an important question for your care team. Would you like me to connect you with [provider/nurse]?"
4. All AI responses must be auditable against scope boundaries
5. Quarterly review of AI transcripts for scope violations

### Monitoring
- Sample 5% of AI interactions weekly for scope compliance review
- Track "near-miss" events where AI almost exceeded scope
- Report scope violations to compliance team within 24 hours
- Retrain/update AI guardrails based on findings
