---
name: status-update
description: >
  Generate a structured status update that leads with the headline for stakeholder communication.
  Triggers: "write a status update", "weekly update", "stakeholder update",
  "exec summary", "project status".
---

# Status Update

## Purpose
Generate a structured status update that leads with the headline, not the details. For upward communication to leadership or cross-functional stakeholders.

## When to Use
- Weekly or biweekly project status reporting
- Escalating a risk or blocker to leadership
- Communicating progress to cross-functional stakeholders
- Preparing for a standup, steering committee, or exec review

## When NOT to Use
- Requesting a decision between options → use `decision-doc`
- Defining what metrics to track → use `metrics-definition`
- Writing a full project spec → use `prd-writer`

## Quick Start
Say `"write a status update for [project name] this week"` in Claude Code.

## Instructions

Ask for:
1. **Project name** — what project is this update about?
2. **Time period** — what week/sprint does this cover?

Push the PM to state the status color and one-sentence summary first. Don't let them bury the lead — the executive reading this will spend 10 seconds on it.

If "Decisions Needed" is empty, say so explicitly: "No decisions needed this week." Don't leave it blank.

Do NOT fabricate progress or metrics. Use `[TBD — need data]` for numbers not provided.

## Template

```markdown
# Status Update: [Project Name]
**Period**: [Week of MM/DD or Sprint N]
**Author**: [Name]

---

## Status: [GREEN / YELLOW / RED] — [One-sentence summary]

## Key Updates
- **Shipped**: [What was completed this period]
- **In progress**: [What's actively being worked on]
- **Blocked**: [What's stuck and why — or "None"]

## Decisions Needed
| Decision | Options | Recommendation | Needed By |
|----------|---------|----------------|-----------|
| [Decision] | [A vs B] | [Your pick + why] | [Date] |
[If none: "No decisions needed this period."]

## Risks
| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| [Risk] | [High/Med/Low] | [High/Med/Low] | [What you're doing about it] |
[Risks have mitigations — not just risk statements.]

## Next Week
1. [Priority 1]
2. [Priority 2]
3. [Priority 3]
[Maximum 3 items. If you have 10, you don't have priorities.]
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these rows/sections:
- **Compliance milestones**: Submission deadlines, audit dates, regulatory review status
- **Clinical validation status**: Study enrollment, data collection progress
- **Audit readiness**: Open CAPAs, documentation gaps, inspection prep

## Verification Checklist
- [ ] Status color is stated in first line
- [ ] One-sentence summary captures the headline
- [ ] "Decisions Needed" has options with a recommendation (not open-ended asks)
- [ ] Risks have mitigations (not just risk statements)
- [ ] Next week priorities are ≤3 items
- [ ] Entire update fits on one page
