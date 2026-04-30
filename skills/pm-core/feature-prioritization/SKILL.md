---
name: feature-prioritization
description: >
  Turn a messy backlog into a scored, ranked, defensible build order using RICE or similar frameworks.
  Triggers: "prioritize features", "feature prioritization", "what should we build next",
  "backlog prioritization", "RICE scoring".
---

# Feature Prioritization

## Purpose
Turn a messy backlog into a scored, ranked, defensible build order.

## When to Use
- Backlog has 10+ items and no clear priority
- Stakeholders disagree on what to build next
- Need a data-informed way to say "no" to low-impact requests
- Quarterly planning and need to rank features

## When NOT to Use
- Sequencing work across quarters → use `roadmap-planning`
- Prioritizing AI use cases for deployment → use `ai-deployment-playbook`
- Comparing competitor features → use `competitive-analysis`
- Defining what success looks like → use `metrics-definition`

## Quick Start
Say `"prioritize these features: [list your features]"` in Claude Code.

## Instructions

Ask for:
1. **Feature list** — what's on the table? (a brain-dump is fine)
2. **Framework preference** — RICE, Impact/Effort, ICE, or "you pick" (default: RICE)

**RICE scoring**:
- **Reach**: How many users/accounts affected per quarter?
- **Impact**: How much does this move the needle? (3=massive, 2=high, 1=medium, 0.5=low, 0.25=minimal)
- **Confidence**: How sure are we? (100%=high, 80%=medium, 50%=low)
- **Effort**: Person-months to build

Push back on inflated scores. Ask: *"What's your evidence for this Impact score?"* If every feature scores as "massive impact," the framework is useless.

At least one feature MUST land in "Don't Build." If the PM pushes back, ask: *"Which of these would you cut if you lost a developer?"*

Do NOT fabricate reach numbers or effort estimates. Use `[TBD — need data]` for unknowns.

## Template

```markdown
# Feature Prioritization: [Product/Area]
**Framework**: RICE / Impact-Effort / ICE
**Date**: [Date]
**Author**: [Name]

---

## 1. Framework
**Using**: [RICE / Impact-Effort / ICE]
**Why**: [One sentence — why this framework fits this situation]

## 2. Feature Scoring

| # | Feature | Reach | Impact | Confidence | Effort | Score | Rank |
|---|---------|-------|--------|------------|--------|-------|------|
| 1 | [Feature] | [N/qtr] | [0.25-3] | [50-100%] | [PM] | [Calc] | [#] |
| 2 | [Feature] | [N/qtr] | [0.25-3] | [50-100%] | [PM] | [Calc] | [#] |
| 3 | [Feature] | [N/qtr] | [0.25-3] | [50-100%] | [PM] | [Calc] | [#] |

**RICE formula**: (Reach x Impact x Confidence) / Effort

### Score Rationale
- **[Feature 1]**: [Why it scored this way — evidence]
- **[Feature 2]**: [Why it scored this way — evidence]

## 3. Tier Summary

### Build Now (This Quarter)
- [Feature] — [One-line reason]

### Build Next (Next Quarter)
- [Feature] — [One-line reason]

### Build Later (Backlog)
- [Feature] — [One-line reason]

### Don't Build
- [Feature] — [Why not: low impact, high effort, doesn't align with strategy]
[At least one feature here. Every prioritization exercise should cut something.]

## 4. Dependencies
| Feature | Depends On | Unlocks |
|---------|-----------|---------|
| [Feature] | [Prerequisite] | [What it enables] |
[Which features unlock others or need prerequisites.]

## 5. Recommendation
**Top 3 to build first**:
1. [Feature] — [Reasoning]
2. [Feature] — [Reasoning]
3. [Feature] — [Reasoning]
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these columns to the scoring table:
- **Safety risk**: Does this feature touch patient safety? (High/Medium/Low/None)
- **Regulatory dependency**: Does this need FDA review, clinical validation, or compliance sign-off?
- **Clinical validation**: What evidence is needed before launch?

## Verification Checklist
- [ ] Framework choice is justified
- [ ] Scores have rationale (not just numbers)
- [ ] At least one feature is in "Don't Build" tier
- [ ] Dependencies are documented
- [ ] Top 3 recommendation has clear reasoning
- [ ] Scoring is honest — not everything is high-impact
