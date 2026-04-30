---
name: decision-doc
description: >
  Record a product or technical decision with context, options, trade-offs, and recommendation.
  Triggers: "decision doc", "write a decision document", "document this decision",
  "RFC", "design decision", "ADR".
---

# Decision Document

## Purpose
Record a product or technical decision — context, options, trade-offs, recommendation — readable 6 months later by someone who wasn't in the room.

## When to Use
- Choosing between two or more approaches and need to document why
- Making a decision that will be hard or expensive to reverse
- Stakeholders need to understand the trade-offs you accepted
- Building an institutional record of decisions for future teams

## When NOT to Use
- Comparing and ranking features → use `feature-prioritization`
- Sequencing work into a timeline → use `roadmap-planning`
- Writing full product requirements → use `prd-writer`

## Quick Start
Say `"write a decision doc for [decision you're making]"` in Claude Code.

## Instructions

Ask for:
1. **Decision context** — what needs to be decided and why now?
2. **Options** — what are the choices on the table?

If the PM has only one option, push: *"What's the alternative you rejected?"* Every good decision doc needs at least 2 real options — not strawmen.

The "What We're Giving Up" section is mandatory. If the PM says "nothing significant," push harder: every decision has a trade-off.

Do NOT fabricate effort estimates. Use `[TBD — need engineering input]` for unknowns.

## Template

```markdown
# Decision: [One-sentence decision statement]
**Date**: [Date]
**Decision maker**: [Name]
**Status**: Proposed / Decided / Superseded

---

## 1. Context
[Why this decision is needed now. What changed? What's the cost of not deciding?]

## 2. Options Considered

### Option A: [Name]
- **Description**: [What this option entails]
- **Pros**: [Benefits]
- **Cons**: [Drawbacks]
- **Estimated effort**: [T-shirt size or hours]

### Option B: [Name]
- **Description**: [What this option entails]
- **Pros**: [Benefits]
- **Cons**: [Drawbacks]
- **Estimated effort**: [T-shirt size or hours]

[At least 2 options. Add Option C/D if relevant. Each must be a real alternative.]

## 3. Recommendation
**Chosen option**: [Option name]
**Why**: [1-2 sentences — the deciding factor]
**Trade-offs accepted**: [What you're knowingly giving up]

## 4. What We're Giving Up
[Be specific. What becomes harder, slower, or impossible with this choice?]
- [Consequence 1]
- [Consequence 2]

## 5. Reversibility
**Type**: One-way door / Two-way door
**Cost to reverse**: [What it takes to undo this — migration effort, data loss, contracts]
**Time horizon**: [How long before this becomes irreversible?]

## 6. Next Steps
| Action | Owner | Due Date |
|--------|-------|----------|
| [Action item] | [Name] | [Date] |
| [Action item] | [Name] | [Date] |
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these sections:
- **Regulatory impact**: Does this decision affect the regulatory pathway or submission timeline?
- **Patient safety considerations**: Could this decision impact patient outcomes?
- **Compliance review required**: Yes/No — if yes, who needs to review?

## Verification Checklist
- [ ] Decision stated in one sentence at the top
- [ ] At least 2 real options considered (not strawmen)
- [ ] Each option has both pros and cons
- [ ] "What We're Giving Up" is specific (not "nothing significant")
- [ ] Reversibility is assessed
- [ ] Next steps have owners and dates
