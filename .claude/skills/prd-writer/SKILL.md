---
name: prd-writer
description: >
  Generate a structured Product Requirements Document for any product or feature.
  Triggers: "general PRD", "product spec", "feature requirements", "feature spec",
  "PRD for [product]". For medical device PRDs, use prd-writer-samd instead.
---

# PRD Writer (General)

## Purpose
Generate a product requirements document that is compelling, evidence-backed, and honest about gaps. A great PRD excites the team to build — it doesn't just outline what to build.

## When to Use
- Starting a new product or feature and need requirements documented
- Aligning stakeholders on what you're building and why
- Creating a portfolio piece to demonstrate product thinking
- Translating a vague idea into structured requirements

## When NOT to Use
- Medical device or FDA-regulated product → use `prd-writer-samd`
- Recording a decision between options → use `decision-doc`
- Defining success metrics in depth → use `metrics-definition`

## Quick Start
Say `"write a general PRD for [your product name]"` in Claude Code.

## Instructions

When asked to write a PRD, ask for these things before generating:
1. **Product/feature name** — what are we calling this?
2. **Target user** — who is this for?
3. **Core problem** — what pain point does this solve?
4. **Evidence** — any customer data, complaints, quotes, research, or metrics that prove this is a real problem? (If none, we'll mark it [TBD].)

### Content Quality Rules

**Never do these:**
- Fill sections with generic filler ("ensure alignment with standards", "improve user experience")
- Use tautologies — if a section restates the heading, it's empty
- Claim the doc is "comprehensive" when sections are incomplete — use `[WIP]` in the title
- Delegate all design thinking — the PM should describe edge cases, user states, and entry points

**Always do these:**
- Use `[TBD — need input]` for anything the PM hasn't provided
- Ground the problem in real evidence: user quotes, support tickets, usage data, public complaints
- Address the downside — every feature has trade-offs; name them
- Make it compelling — the reader should feel the user's pain and want to fix it
- If the PM mentions medical device, FDA, or regulatory context, redirect to `prd-writer-samd`

## Template

```markdown
# PRD: [Product/Feature Name]
**Author**: [Name]
**Date**: [Date]
**Status**: Draft / In Review / Approved / [WIP]

### Stakeholders
| Name | Role | Sign-off |
|------|------|----------|
| [Name] | PM / Owner | [ ] |
| [Name] | Engineering Lead | [ ] |
| [Name] | Design Lead | [ ] |
| [Name] | [Other — Legal, Data, etc.] | [ ] |

---

## 1. Overview
- **Problem**: [One sentence — what specific problem exists?]
- **Solution**: [One sentence — how does this product solve it?]
- **Target user**: [One sentence — who benefits?]

## 2. Customer Evidence
[Ground the problem in reality. Include any of the following:]
- User research findings (quotes, interview themes, survey data)
- Support ticket volume or complaint patterns
- Usage analytics showing the gap
- Public signals (social media, app reviews, forum posts)
- Internal escalations or sales feedback

[If no evidence exists yet, write: `[TBD — need user research before proceeding]` and flag this as a risk in section 8.]

## 3. Competitive Landscape
| Competitor | How they handle this | Strength | Weakness |
|------------|---------------------|----------|----------|
| [Competitor 1] | [Approach] | [What works] | [What doesn't] |
| [Competitor 2] | [Approach] | [What works] | [What doesn't] |

[What can we learn? Where is the opportunity to differentiate?]

## 4. User Stories
- As a [user type], I want [action], so that [outcome]
- As a [user type], I want [action], so that [outcome]
- As a [user type], I want [action], so that [outcome]
[3-5 user stories. Use [TBD — need user research] if PM hasn't provided context.]

## 5. Requirements

### Functional
1. The system shall [requirement]
2. The system shall [requirement]
3. The system shall [requirement]

### Non-Functional
- **Performance**: [Specific latency/throughput targets]
- **Security**: [Authentication, authorization, data handling]
- **Accessibility**: [WCAG level, screen reader support]

## 6. User Flow & Design Direction
1. User [action]
2. System [response]
3. User [action]
4. System [response]
[Step-by-step primary journey. One flow — not every edge case.]

**Key edge cases & user states the PM has identified:**
- [Edge case 1 — e.g., "What happens if the user has no payment method?"]
- [Edge case 2 — e.g., "How does this display for users with 20+ items?"]
- [Entry point — e.g., "User can reach this from search, deep link, and home feed"]

**Mockup / sketch**: [Include a rough wireframe, ASCII sketch, or link to Figma. The PM should think through layout — don't fully delegate to design.]

## 7. Success Metrics
| Metric | Current | Target | Measurement |
|--------|---------|--------|-------------|
| [Metric 1] | [Baseline] | [Goal] | [How measured] |
| [Metric 2] | [Baseline] | [Goal] | [How measured] |
| [Metric 3] | [Baseline] | [Goal] | [How measured] |
[3-5 measurable outcomes. Include current baseline where known. If baseline is unknown, write `[TBD — need analytics]`.]

**Anti-metrics** (metrics we do NOT want to regress):
- [e.g., "Conversion rate should not drop more than X%"]
- [e.g., "Page load time should not increase beyond Xms"]

## 8. Trade-offs & Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1 — e.g., "Showing total price may reduce click-through"] | [High/Med/Low] | [How we address it] |
| [Risk 2 — e.g., "Legal review pending in 3 markets"] | [High/Med/Low] | [How we address it] |
| [Risk 3 — e.g., "No user research yet — building on assumption"] | [High/Med/Low] | [How we address it] |

[Be honest. Every feature has downsides. Name them and explain how you'll manage them.]

## 9. Scope
**In scope**:
- [Feature/capability 1]
- [Feature/capability 2]

**Out of scope**:
- [Explicitly excluded item 1]
- [Explicitly excluded item 2]

## 10. Open Questions
- [ ] [Question needing stakeholder input]
- [ ] [Question needing engineering input]
- [ ] [Question needing user research]
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these sections after Open Questions:
- **Regulatory pathway**: FDA classification, submission type, predicate device
- **Clinical requirements**: Validation study design, performance targets (sensitivity/specificity)
- **HIPAA considerations**: PHI handling, BAA requirements, data retention

## Verification Checklist
- [ ] Problem statement is specific (not "improve user experience")
- [ ] Customer evidence section has real data, quotes, or signals (not just stated assumptions)
- [ ] Competitive landscape surveyed — at least 2 alternatives analyzed
- [ ] User stories reference real user types (not generic "user")
- [ ] Requirements are testable (not "fast" — specify latency)
- [ ] PM has identified key edge cases and entry points (not fully delegated to design)
- [ ] Success metrics have numeric targets with baselines where available
- [ ] Anti-metrics defined — what must NOT regress
- [ ] Trade-offs section is honest — at least one real downside acknowledged
- [ ] Stakeholder table has names and sign-off status
- [ ] Out of scope list exists and is explicit
- [ ] No sections filled with generic filler — every sentence adds information
- [ ] If sections are incomplete, title includes `[WIP]` and gaps use `[TBD — need X]`
