# AI Transparency Requirements

## Purpose

Defines disclosure and transparency requirements for AI agents interacting with members. Covers federal guidance, emerging state laws, and recommended implementation for voice and SMS modalities.

## Federal Guidance

### FTC Act (Section 5 — Unfair or Deceptive Practices)
- AI systems must not mislead consumers about the nature of the interaction
- Failing to disclose that a consumer is interacting with AI (not a human) may constitute a deceptive practice
- FTC has signaled increased enforcement on AI transparency (2023-2024 policy statements)

### FTC Recommendations for AI Disclosure
- Disclose AI nature at the start of every interaction
- Use clear, plain language ("I'm an AI assistant" not "I'm a virtual agent")
- Repeat disclosure if the member appears confused about who they're speaking with
- Do not design AI to mimic a specific human or imply human identity

### CMS / HHS Considerations
- No specific federal mandate for AI disclosure in healthcare (as of 2024)
- CMS conditions of participation require informed consent for treatment — AI-mediated interactions should be disclosed as part of this process
- HHS Office for Civil Rights: AI use with PHI must comply with HIPAA, but no separate AI transparency rule yet

## State AI Transparency Laws

### States with AI Disclosure Requirements (as of 2024)
- **California** (SB 1001, effective 2025): Requires bots to disclose non-human identity when communicating with consumers for sales or customer service
- **New York**: Proposed legislation requiring AI disclosure in healthcare settings (pending)
- **Colorado** (AI Act, effective 2026): Requires developers of high-risk AI systems to provide transparency documentation; healthcare is explicitly included
- **Illinois**: Biometric Information Privacy Act (BIPA) may apply if AI voice systems collect voiceprints

### Multi-State Operations
- Apply the most restrictive state's requirements across all states as baseline
- Track emerging legislation quarterly — AI transparency laws are evolving rapidly
- Consult legal counsel for state-specific compliance obligations

## Recommended Disclosure Language

### Voice Agent — Opening Disclosure
```
"Hello, this is [Name], an AI assistant calling from Eleanor Health.
I'm not a human — I'm an automated system here to help with
[scheduling/follow-up/information]. You can ask to speak with
a person at any time. Is it okay to continue?"
```

### Voice Agent — Mid-Call Reminder (if member seems confused)
```
"Just to clarify, I'm an AI assistant, not a human staff member.
Would you like me to transfer you to a person?"
```

### SMS Agent — Opening Disclosure
```
"Hi [Name], this is an automated message from Eleanor Health.
I'm an AI assistant, not a human. I can help with [purpose].
Reply HUMAN at any time to reach a person, or STOP to opt out."
```

### SMS Agent — Opt-Out Compliance
- Must support STOP keyword for opt-out (TCPA compliance)
- Must support HUMAN keyword for human escalation
- Must confirm opt-out: "You've been unsubscribed. You won't receive further automated messages."

## Implementation Requirements

### Technical Controls
1. Disclosure message must be the first utterance/message in every AI interaction
2. Disclosure cannot be skipped, even for returning members
3. Member must acknowledge or implicitly consent (continuing the conversation) before AI proceeds
4. AI must respond to "are you a robot?" / "am I talking to a person?" with honest disclosure
5. Call recordings must capture the disclosure for compliance auditing

### Consent Documentation
- Log that disclosure was provided (timestamp, channel, member ID)
- Log member response (continued, opted out, requested human)
- Retain logs per HIPAA record retention requirements (minimum 6 years)
- Make logs available for compliance audits

### Monitoring & Compliance
- Audit 10% of AI interactions monthly for disclosure compliance
- Track opt-out rates as a signal of member discomfort with AI
- Review member complaints related to AI transparency
- Update disclosure language based on new state laws (quarterly review cycle)

## References

- FTC Policy Statement on Deceptive AI (2023)
- California SB 1001 — Bot Disclosure Act
- Colorado AI Act (SB 24-205)
- TCPA (Telephone Consumer Protection Act) — SMS/call consent requirements
- HIPAA Privacy Rule — record retention (45 CFR § 164.530(j))
