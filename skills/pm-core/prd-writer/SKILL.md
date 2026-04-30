---
name: prd-writer
description: >
  Generate a structured Product Requirements Document for any product or feature.
  Triggers: "general PRD", "product spec", "feature requirements", "feature spec",
  "PRD for [product]". For medical device PRDs, use prd-writer-samd instead.
---

# PRD Writer (General)

## Purpose
Generate a 1-2 page product requirements document for any product or feature.

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

When asked to write a PRD, ask for these three things before generating:
1. **Product/feature name** — what are we calling this?
2. **Target user** — who is this for?
3. **Core problem** — what pain point does this solve?

Do NOT fill sections with generic content. Use `[TBD — need input]` for anything the PM hasn't provided. If the PM mentions medical device, FDA, or regulatory context, redirect to `prd-writer-samd`.

## Template

```markdown
# PRD: [Product/Feature Name]
**Author**: [Name]
**Date**: [Date]
**Status**: Draft / In Review / Approved

---

## 1. Overview
- **Problem**: [One sentence — what specific problem exists?]
- **Solution**: [One sentence — how does this product solve it?]
- **Target user**: [One sentence — who benefits?]

## 2. User Stories
- As a [user type], I want [action], so that [outcome]
- As a [user type], I want [action], so that [outcome]
- As a [user type], I want [action], so that [outcome]
[3-5 user stories. Use [TBD — need user research] if PM hasn't provided context.]

## 3. Requirements

### Functional
1. The system shall [requirement]
2. The system shall [requirement]
3. The system shall [requirement]

### Non-Functional
- **Performance**: [Specific latency/throughput targets]
- **Security**: [Authentication, authorization, data handling]
- **Accessibility**: [WCAG level, screen reader support]

## 4. User Flow
1. User [action]
2. System [response]
3. User [action]
4. System [response]
[Step-by-step primary journey. One flow — not every edge case.]

## 5. Success Metrics
| Metric | Target | Measurement |
|--------|--------|-------------|
| [Metric 1] | [Number] | [How measured] |
| [Metric 2] | [Number] | [How measured] |
| [Metric 3] | [Number] | [How measured] |
[3-5 measurable outcomes with numeric targets.]

## 6. Scope
**In scope**:
- [Feature/capability 1]
- [Feature/capability 2]

**Out of scope**:
- [Explicitly excluded item 1]
- [Explicitly excluded item 2]

## 7. Open Questions
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
- [ ] User stories reference real user types (not generic "user")
- [ ] Requirements are testable (not "fast" — specify latency)
- [ ] Success metrics have numeric targets
- [ ] Out of scope list exists and is explicit
- [ ] No sections filled with generic filler
