---
name: roadmap-planning
description: >
  Time-based product roadmap organized by outcomes, not features. Now/Next/Later with decreasing specificity.
  Triggers: "plan a roadmap", "product roadmap", "quarterly plan",
  "what should we build this quarter".
---

# Roadmap Planning

## Purpose
Create a time-based product roadmap organized by outcomes, not features. Covers 1-3 quarters with decreasing specificity.

## When to Use
- Quarterly planning — deciding what to commit to
- Communicating product direction to leadership or the team
- Aligning engineering, design, and business on priorities
- Stakeholders ask "what's the roadmap?"

## When NOT to Use
- Scoring and ranking individual features → use `feature-prioritization`
- Planning an AI tool rollout specifically → use `ai-deployment-playbook`
- Defining metrics for a feature → use `metrics-definition`
- Writing detailed requirements for a feature → use `prd-writer`

## Quick Start
Say `"plan a roadmap for [product] this quarter"` in Claude Code.

## Instructions

Ask for:
1. **Product** — what product or team is this for?
2. **Time horizon** — how far out? (default: 3 quarters)
3. **Strategic context** — what's the company/team trying to achieve?

Push back if "Now" has too many items. If the PM lists 15 items in "Now," that's a wish list, not a roadmap. Ask: *"If you could only ship 3 things this quarter, which 3?"*

"What We're NOT Doing" is mandatory. Roadmaps are about what you cut as much as what you build. If the PM resists, ask: *"What request will you say 'no' to this quarter?"*

Do NOT fabricate timelines or dependencies. Use `[TBD — need input]` for unknowns.

## Template

```markdown
# Roadmap: [Product Name]
**Period**: [Q_ 20__ — Q_ 20__]
**Author**: [Name]
**Last updated**: [Date]

---

## 1. Vision
[One sentence: where are we going and why?]

## 2. Strategic Pillars
| Pillar | Description |
|--------|-------------|
| [Pillar 1] | [What this theme is about — 1 sentence] |
| [Pillar 2] | [What this theme is about — 1 sentence] |
| [Pillar 3] | [What this theme is about — 1 sentence] |
[2-4 themes that group roadmap items. These are the "why" behind the work.]

## 3. Now (This Quarter) — Committed
| Initiative | Pillar | Expected Outcome | Success Metric | Owner |
|-----------|--------|------------------|----------------|-------|
| [Initiative] | [Pillar] | [What changes] | [How measured] | [Name] |
| [Initiative] | [Pillar] | [What changes] | [How measured] | [Name] |
| [Initiative] | [Pillar] | [What changes] | [How measured] | [Name] |
[Maximum 5 items. These are commitments — team is staffed and ready.]

## 4. Next (Next Quarter) — Planned
| Theme | Bet | Why Now |
|-------|-----|---------|
| [Theme] | [What we're exploring] | [Why this quarter] |
| [Theme] | [What we're exploring] | [Why this quarter] |
[Themes and bets — not detailed specs. Specificity decreases.]

## 5. Later (2+ Quarters) — Exploratory
| Opportunity | Depends On | Open Question |
|-------------|-----------|---------------|
| [Opportunity] | [What needs to happen first] | [What we don't know yet] |
| [Opportunity] | [What needs to happen first] | [What we don't know yet] |
[Explicitly exploratory. No commitments. Depends on Now/Next outcomes.]

## 6. What We're NOT Doing
| Request | Why Not | Revisit When |
|---------|---------|-------------|
| [Request/idea] | [Rationale for deprioritizing] | [Condition to reconsider] |
| [Request/idea] | [Rationale for deprioritizing] | [Condition to reconsider] |
[Mandatory. Every roadmap must say what it's cutting.]

## 7. Dependencies & Risks
| Dependency/Risk | Impact | Mitigation | Owner |
|----------------|--------|------------|-------|
| [Cross-team dependency] | [What slips if this breaks] | [Plan B] | [Name] |
| [Hiring dependency] | [What slips if unfilled] | [Plan B] | [Name] |
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these to the roadmap:
- **Regulatory milestones**: Submission deadlines, audit dates, standards compliance targets
- **Clinical validation timeline**: Study design, enrollment, data collection, analysis
- **Compliance dependencies**: What regulatory approvals gate which features?

## Verification Checklist
- [ ] Vision is one sentence (not a paragraph)
- [ ] "Now" has ≤5 committed items
- [ ] "Next" is themes, not detailed specs
- [ ] "Later" is explicitly exploratory
- [ ] "What We're NOT Doing" exists and has rationale
- [ ] Each "Now" item has an owner and success metric
