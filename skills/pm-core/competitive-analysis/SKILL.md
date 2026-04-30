---
name: competitive-analysis
description: >
  Structured competitive landscape analysis that informs product decisions.
  Triggers: "competitive analysis", "competitor analysis", "competitive landscape",
  "comp analysis", "market analysis".
---

# Competitive Analysis

## Purpose
Structured competitive landscape analysis that informs product decisions — not a feature checklist.

## When to Use
- Entering a new market or launching a new product
- Stakeholders ask "what are competitors doing?"
- Positioning your product against alternatives
- Identifying gaps and opportunities in the market

## When NOT to Use
- Synthesizing user interviews or feedback → use `research-synthesis`
- Ranking your own features → use `feature-prioritization`
- Writing a product spec → use `prd-writer`

## Quick Start
Say `"competitive analysis for [market/product] vs [competitor 1], [competitor 2]"` in Claude Code.

## Instructions

Ask for:
1. **Product/market area** — what space are we analyzing?
2. **Known competitors** — name 2-3 to start (will research more)

Use web search to fill in current data on competitors. Flag uncertain or dated information explicitly. Use `[Verify — could not confirm]` for unverified claims. Never fabricate pricing, features, or funding data.

Each competitor profile MUST include a notable weakness — not just strengths. Implications must be specific product actions, not generic "differentiate on UX."

## Template

```markdown
# Competitive Analysis: [Market/Product Area]
**Date**: [Date]
**Author**: [Name]

---

## 1. Market Context
[One paragraph: What market is this? What's changing? Why does this analysis matter now?]

## 2. Competitor Profiles

### [Competitor A]
- **Positioning**: [How they describe themselves]
- **Target user**: [Who they serve]
- **Differentiator**: [What makes them unique]
- **Pricing**: [Pricing model — or [Verify — could not confirm]]
- **Notable weakness**: [Where they fall short]

### [Competitor B]
- **Positioning**: [How they describe themselves]
- **Target user**: [Who they serve]
- **Differentiator**: [What makes them unique]
- **Pricing**: [Pricing model — or [Verify — could not confirm]]
- **Notable weakness**: [Where they fall short]

### [Competitor C]
- **Positioning**: [How they describe themselves]
- **Target user**: [Who they serve]
- **Differentiator**: [What makes them unique]
- **Pricing**: [Pricing model — or [Verify — could not confirm]]
- **Notable weakness**: [Where they fall short]
[3-5 competitors.]

## 3. Feature Comparison
| Capability | Us | [Comp A] | [Comp B] | [Comp C] |
|-----------|-----|----------|----------|----------|
| [Capability 1] | [Status] | [Status] | [Status] | [Status] |
| [Capability 2] | [Status] | [Status] | [Status] | [Status] |
| [Capability 3] | [Status] | [Status] | [Status] | [Status] |
[Capabilities that matter for PM's product decisions. Status: Yes / No / Partial / Unknown.]

## 4. Strategic Insights
- **Where the market is heading**: [Trend]
- **Gaps no one fills**: [Opportunity]
- **Positioning opportunities**: [How to differentiate]

## 5. Implications for Us
- **Build**: [Capability to invest in — why]
- **Avoid**: [Area to stay away from — why]
- **Differentiate on**: [Where to focus positioning — why]
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add a column or section for each competitor:
- **Regulatory status**: FDA clearance/approval, CE mark, certifications
- **Clinical validation**: Published studies, clinical evidence claims
- **Compliance posture**: HIPAA, SOC 2, ISO 13485, other certifications

## Verification Checklist
- [ ] At least 3 competitors profiled
- [ ] Each has a notable weakness (not just strengths)
- [ ] Feature comparison covers capabilities relevant to PM's product
- [ ] Pricing information marked as verified or unverified
- [ ] "Implications for Us" gives specific, actionable recommendations
- [ ] Market context explains why this analysis matters now
