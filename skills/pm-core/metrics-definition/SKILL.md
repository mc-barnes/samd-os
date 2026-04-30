---
name: metrics-definition
description: >
  Define success metrics framework: North Star, input metrics, guardrails, targets, and anti-metrics.
  Triggers: "define metrics", "success metrics", "KPIs", "how do we measure",
  "north star metric", "OKRs".
---

# Metrics & Success Criteria

## Purpose
Define what to measure, why, and what "good" looks like — a framework for knowing whether you're winning.

## When to Use
- Launching a new product or feature and need to define success
- Current metrics are vanity metrics or don't drive decisions
- Stakeholders disagree on what "good" looks like
- Setting OKRs or quarterly goals

## When NOT to Use
- Reporting status with existing metrics → use `status-update`
- Ranking features by impact → use `feature-prioritization`
- Defining AI adoption KPIs for a rollout → use `ai-deployment-playbook`

## Quick Start
Say `"define success metrics for [product/feature]"` in Claude Code.

## Instructions

Ask for:
1. **Product/feature** — what are we measuring?
2. **Business goal** — what outcome matters?

Push hard on the North Star. If the PM lists 5 metrics as "equally important," ask: *"Which one would you check every Monday morning?"* There is exactly one North Star — help them pick it.

If the PM lists 10+ metrics, push back: *"Which 3 would tell you if this is working?"*

The Anti-Metrics section is mandatory. Every metric incentivizes something — name what you're explicitly NOT optimizing for.

Do NOT fabricate baselines or targets. Use `[TBD — need data]` for numbers the PM hasn't provided.

## Template

```markdown
# Metrics: [Product/Feature Name]
**Date**: [Date]
**Owner**: [Name]

---

## 1. North Star Metric
**Metric**: [Single metric that captures value delivery]
**Why this one**: [One sentence — why this metric, not others]
**Current baseline**: [Number or TBD]
**Target**: [Number by when]

## 2. Input Metrics
Leading indicators that drive the North Star.

| Input Metric | Why It Matters | Baseline | 30-Day Target |
|-------------|----------------|----------|---------------|
| [Metric] | [Drives North Star because...] | [Current] | [Target] |
| [Metric] | [Drives North Star because...] | [Current] | [Target] |
| [Metric] | [Drives North Star because...] | [Current] | [Target] |
[3-5 leading indicators.]

## 3. Guardrail Metrics
Metrics that must NOT degrade while pursuing the North Star.

| Guardrail | Current | Threshold | Action if Breached |
|-----------|---------|-----------|-------------------|
| [Metric] | [Current] | [Floor] | [What you do] |
| [Metric] | [Current] | [Floor] | [What you do] |
[2-3 guardrails.]

## 4. Metric Definitions
| Metric | Definition | Data Source | Calculation | Frequency | Owner |
|--------|-----------|-------------|-------------|-----------|-------|
| [Name] | [Precise definition] | [Where data lives] | [Formula] | [Daily/Weekly] | [Who] |
[One row per metric from sections 1-3.]

## 5. Targets
| Metric | Baseline | 30-Day | 60-Day | 90-Day | Stretch |
|--------|----------|--------|--------|--------|---------|
| [North Star] | [Current] | [Target] | [Target] | [Target] | [Aspirational] |
| [Input 1] | [Current] | [Target] | [Target] | [Target] | [Aspirational] |
[All metrics with time-based targets.]

## 6. Anti-Metrics
What we are explicitly NOT optimizing for, and why.

| Anti-Metric | Why We're Not Optimizing | Risk if We Did |
|------------|-------------------------|----------------|
| [Metric] | [Rationale] | [What breaks] |
| [Metric] | [Rationale] | [What breaks] |
[At least 2. This section is mandatory.]
```

## If Regulated / Healthcare (Optional)
*Skip this section if you're not in a regulated industry.*

Add these metric categories:
- **Clinical outcome metrics**: Patient safety events, clinical accuracy, time to diagnosis
- **Patient safety metrics**: Adverse event rate, false alarm rate, missed detection rate
- **Regulatory compliance metrics**: Audit findings, CAPA closure time, complaint rate

## Verification Checklist
- [ ] Exactly one North Star metric (not three)
- [ ] Input metrics are leading indicators (not lagging)
- [ ] Guardrail metrics prevent gaming the North Star
- [ ] Every metric has a data source and owner
- [ ] Targets have baselines (not just goals)
- [ ] Anti-metrics section exists with rationale
