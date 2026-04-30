---
name: research-synthesis
description: >
  Turn raw user research into actionable product decisions — patterns, not summaries.
  Triggers: "synthesize research", "research synthesis", "summarize interviews",
  "user research summary", "interview findings".
---

# Research Synthesis

## Purpose
Turn raw user research (interviews, surveys, feedback) into actionable product decisions — patterns, not summaries.

## When to Use
- You have interview transcripts or notes and need to extract insights
- Consolidating feedback from multiple user conversations
- Turning survey data into product actions
- Preparing research readouts for stakeholders

## When NOT to Use
- Analyzing competitors or market landscape → use `competitive-analysis`
- Defining what metrics to track → use `metrics-definition`
- Writing a product spec from scratch → use `prd-writer`

## Quick Start
Say `"synthesize research from these interviews: [paste notes]"` in Claude Code.

## Instructions

Ask the PM to paste or describe their raw research (interview notes, survey responses, feedback threads). The more raw data, the better. Remind the PM to anonymize participant data before pasting — use participant IDs (P1, P2) instead of real names, and remove any PII or PHI.

**Critical rules**:
- Never invent quotes or findings. Extract verbatim quotes from what's provided.
- Flag confidence level explicitly: how many sources support this finding?
- The Surprises section is mandatory — even if the answer is "None identified."
- Implications must be specific product actions, not vague themes like "improve onboarding."

Use `[TBD — need raw data]` for sections where the PM hasn't provided enough input.

## Template

```markdown
# Research Synthesis: [Research Topic]
**Method**: [Interviews / Survey / Usability test / Feedback analysis]
**Sample**: [N participants]
**Period**: [Date range]
**Research questions**: [What were we trying to learn?]

---

## 1. Key Findings

### Finding 1: [Insight statement]
- **Evidence**: "[Verbatim quote]" — Participant [ID/role]
- **Supporting data**: [Additional quotes or data points]
- **Confidence**: High / Medium / Low — [N of M participants]

### Finding 2: [Insight statement]
- **Evidence**: "[Verbatim quote]" — Participant [ID/role]
- **Supporting data**: [Additional quotes or data points]
- **Confidence**: High / Medium / Low — [N of M participants]

### Finding 3: [Insight statement]
- **Evidence**: "[Verbatim quote]" — Participant [ID/role]
- **Supporting data**: [Additional quotes or data points]
- **Confidence**: High / Medium / Low — [N of M participants]
[3-5 findings. Each must have evidence.]

## 2. Patterns
| Theme | Frequency | Representative Quote |
|-------|-----------|---------------------|
| [Theme] | [N of M participants] | "[Quote]" |
| [Theme] | [N of M participants] | "[Quote]" |
[Themes that appeared across multiple sources.]

## 3. Surprises
[Findings that contradicted assumptions or expectations.]
- [Surprise 1 — what was expected vs. what was found]
- [Surprise 2]
[If none: "No findings contradicted pre-research assumptions."]

## 4. Implications
What to do based on these findings:
- **Build**: [Feature/capability to create]
- **Change**: [Existing behavior to modify]
- **Kill**: [Thing to stop doing or remove]
- **Investigate further**: [Questions that need more research]

## 5. Raw Data Summary
| Participant | Segment | Key Quote | Notable Behavior |
|------------|---------|-----------|-----------------|
| [ID/Role] | [Segment] | "[Quote]" | [Observation] |
| [ID/Role] | [Segment] | "[Quote]" | [Observation] |
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these considerations to the Implications section:
- **Patient safety implications**: Do any findings suggest safety risks?
- **Health equity considerations**: Are certain populations underserved or impacted differently?
- **Clinical workflow impact**: How do findings affect clinical staff workflows?

## Verification Checklist
- [ ] Every finding has supporting evidence (quotes or data)
- [ ] Confidence levels assigned (high/medium/low)
- [ ] Patterns cite frequency ("4 of 6 participants")
- [ ] Surprises section exists (even if empty — state "none")
- [ ] Implications are specific product actions, not vague themes
- [ ] No fabricated quotes or data
