---
name: ai-deployment-playbook
description: >
  Generate AI deployment plans for healthcare organizations. Covers use case
  prioritization, rollout phases, training program design, adoption metrics,
  governance, and success criteria. Use when planning the rollout of AI tools
  (internal or member-facing) in a healthcare context.
  Triggers: "AI rollout", "adoption strategy", "Claude deployment",
  "internal AI", "AI training", "use case prioritization".
---

# AI Deployment Playbook Skill

## When to Use
- Planning rollout of any AI tool (internal or member-facing)
- Prioritizing which AI use cases to pursue first
- Designing training programs for AI tool adoption
- Defining adoption metrics and success criteria
- Building the AI product roadmap
- Preparing AI initiative business cases for leadership

## When NOT to Use
- Clinical safety requirements for AI agents (use `clinical-safety` instead)
- HIPAA/PHI governance frameworks (use `hipaa-governance` instead)
- Vendor evaluation and scoring (use `ai-vendor-eval` instead)
- EHR integration architecture (use `ehr-integration` instead)

## Deployment Plan Template

When generating a deployment plan, cover all 6 sections:

### 1. Use Case Inventory
Build a prioritized list of AI use cases using the Impact × Feasibility × Risk framework:

| Use Case | Impact (1-5) | Feasibility (1-5) | Risk (1-5, inverted) | Score | Priority |
|----------|-------------|-------------------|---------------------|-------|----------|

**Eleanor Health priority use cases**:
- AI voice/SMS agents for member access and scheduling
- Outbound AI for lead conversion
- Pre-visit data collection
- Transcript and call analysis
- AI-driven scheduling optimization
- Internal AI adoption (Claude Enterprise)

See `references/use-case-prioritization.md` for the full scoring framework and pre-scored Eleanor Health use cases.

### 2. Rollout Phases
Structure deployment in controlled phases:

**Phase 1: Pilot** (4-6 weeks)
- Select 1 team or location
- Define pilot scope (specific use cases, user count)
- Establish baseline metrics before pilot starts
- Daily check-ins during week 1, weekly thereafter
- Go/no-go decision at end of pilot

**Phase 2: Controlled Expansion** (6-8 weeks)
- Expand to 2-3 additional teams/locations
- Incorporate pilot learnings into training and configuration
- Monitor for issues at scale
- Adjust success thresholds based on pilot data

**Phase 3: General Availability** (ongoing)
- Roll out to all eligible users/locations
- Transition from project mode to BAU (business-as-usual)
- Establish ongoing support and feedback channels
- Regular feature updates and use case expansion

### 3. Training Program Design
Role-based training covering:
- **All employees**: AI foundations, PHI rules, prompt basics, company policy
- **Clinical staff**: Clinical AI use cases, member-facing agent awareness, SUD considerations
- **Operations/Admin**: Productivity use cases, advanced prompts, workflow integration
- **Leadership**: Strategy overview, governance, decision-making

See `references/training-program-template.md` for the full 4-tier training program.

### 4. Adoption Metrics
Track adoption across dimensions:

**Usage**: DAU, WAU, sessions per user, use case diversity
**Productivity**: Time saved, task completion rate, error reduction
**Quality**: User satisfaction (NPS), revision cycles, output accuracy
**Safety** (member-facing): Escalation accuracy, scope violations, time-to-human

See `references/adoption-metrics.md` for full KPI definitions, targets, and healthcare benchmarks.

### 5. Governance & Escalation
Define who makes decisions about AI:
- **Use case approval**: Who approves new AI use cases? (Recommend: AI PM + relevant department head + compliance)
- **Issue escalation**: How do users report AI problems? (Recommend: Slack channel + monthly review)
- **Policy updates**: How often is AI policy reviewed? (Recommend: quarterly)
- **Vendor changes**: Who approves new AI vendors or tools? (Recommend: AI PM + Director of Technology + Privacy Officer)
- **Budget authority**: Who controls AI spending? (Recommend: AI PM with ELT approval above threshold)

### 6. Success Criteria & Iteration
Define concrete checkpoints:

**30-Day Checkpoint**
- Tier 1 training complete for all pilot users
- AI tools configured and accessible
- Baseline metrics captured
- First user feedback collected

**60-Day Checkpoint**
- Adoption rate >50% of pilot users
- At least 3 productive use cases identified per team
- No PHI incidents
- User satisfaction >3.5/5.0
- Safety metrics at target (if member-facing)

**90-Day Checkpoint**
- Adoption rate >70% of pilot users
- Measurable productivity gains documented
- Business case validated with data
- Go/no-go decision for Phase 2 expansion
- Training materials iterated based on feedback

## Output Format

```markdown
# AI Deployment Plan — [Initiative Name]

## Executive Summary
[2-3 sentences: what, why, timeline, expected ROI]

## 1. Use Case Inventory
[Prioritized table with scores and rationale]

## 2. Rollout Phases
[Phase 1/2/3 timeline, scope, go/no-go criteria]

## 3. Training Program
[Tier summary, timeline, completion targets]

## 4. Adoption Metrics
[KPI table with baselines and targets]

## 5. Governance
[Decision rights, escalation paths, review cadence]

## 6. Success Criteria
[30/60/90 day checkpoints with specific targets]

## Risks & Mitigations
[Top 3-5 risks with mitigation strategies]

## Budget Estimate
[Cost categories: licensing, training, integration, ongoing]
```

## Reference Files
- `references/use-case-prioritization.md` — Scoring framework and pre-scored Eleanor Health use cases
- `references/adoption-metrics.md` — KPI definitions, targets, healthcare benchmarks
- `references/training-program-template.md` — 4-tier role-based training program

## Verification Checklist

Before presenting a deployment plan, verify:

- [ ] All use cases scored with Impact × Feasibility × Risk
- [ ] Rollout phases have explicit go/no-go criteria
- [ ] Training covers all 4 audience tiers (all-employee, clinical, ops, leadership)
- [ ] Adoption metrics include both usage and productivity measures
- [ ] Safety metrics included for any member-facing deployment
- [ ] Governance section defines decision rights clearly
- [ ] 30/60/90 day checkpoints have measurable targets
- [ ] Risks identified with mitigation strategies
- [ ] Budget estimate included (even if rough order of magnitude)
