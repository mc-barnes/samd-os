# AI Vendor Evaluation Framework

## Purpose

Weighted scoring methodology for evaluating AI vendors in healthcare. Designed for behavioral health organizations deploying AI voice agents, SMS agents, and internal AI tools.

## Evaluation Categories

| Category | Weight | What It Covers |
|----------|--------|---------------|
| Clinical Safety | 25% | Crisis detection, escalation capability, scope guardrails, behavioral health-specific safeguards |
| HIPAA & Compliance | 25% | BAA, PHI handling, 42 CFR Part 2, audit logging, breach notification |
| Integration | 20% | athenahealth compatibility, Salesforce connectivity, API quality, data flow |
| Cost & Value | 15% | Licensing, implementation, ongoing costs, ROI projection |
| Scalability | 10% | Multi-site deployment, concurrent capacity, performance under load |
| User Experience | 5% | Member experience, staff experience, configuration ease |

**Note**: Clinical Safety and HIPAA & Compliance together account for 50% of the total score. This weighting reflects that in healthcare, compliance and safety are non-negotiable — a vendor can be cheap and scalable but if it can't handle PHI safely or detect a crisis, it's disqualified.

## Scoring Scale

| Score | Definition | Evidence Required |
|-------|-----------|-------------------|
| 5 | Exceeds requirements | Demonstrated capability with healthcare references |
| 4 | Fully meets requirements | Documented features, verified in demo |
| 3 | Partially meets requirements | Capability exists but with gaps or workarounds |
| 2 | Significant gaps | Major features missing, roadmap commitment only |
| 1 | Does not meet requirements | Capability absent or fundamentally incompatible |

## Weighted Score Calculation

```
Weighted Score = Σ (Category Weight × Average Score for Category)
```

Example:
- Clinical Safety: avg 4.0 × 0.25 = 1.00
- HIPAA: avg 3.5 × 0.25 = 0.875
- Integration: avg 3.0 × 0.20 = 0.60
- Cost: avg 4.0 × 0.15 = 0.60
- Scalability: avg 4.5 × 0.10 = 0.45
- UX: avg 3.0 × 0.05 = 0.15
- **Overall: 3.675**

## Decision Thresholds

| Overall Score | Decision | Action |
|--------------|----------|--------|
| ≥ 4.0 | **Proceed** | Move to contract negotiation and pilot planning |
| 3.0 – 3.9 | **Conditional** | Proceed only if gaps have documented remediation plans with timelines |
| < 3.0 | **Reject** | Do not proceed; document rationale for future reference |

### Automatic Disqualifiers (regardless of overall score)
- Clinical Safety score < 3.0 on any individual criterion
- No BAA available or vendor refuses to sign
- No model training opt-out for PHI
- No crisis escalation capability for member-facing deployments
- Data residency outside the US for PHI processing

## Evaluation Process

### Phase 1: Initial Screening (1 week)
1. Vendor completes RFI/questionnaire
2. Review against automatic disqualifiers
3. Score preliminary criteria based on documentation
4. Decision: proceed to demo or reject

### Phase 2: Demo & Deep Dive (2 weeks)
1. Schedule structured demo (use standard demo script)
2. Technical deep dive with engineering team
3. Security and compliance review
4. Clinical safety assessment
5. Reference check (2-3 healthcare customers)
6. Complete full scorecard

### Phase 3: Pilot Design (1-2 weeks)
1. Define pilot scope (use cases, user count, duration)
2. Establish baseline metrics
3. Define success criteria and go/no-go thresholds
4. Negotiate pilot terms and pricing
5. Plan data integration and technical setup

### Phase 4: Pilot Execution (4-8 weeks)
1. Deploy in controlled environment
2. Monitor metrics weekly
3. Collect user feedback
4. Safety review at midpoint and end
5. Go/no-go decision with data

## Demo Script Template

When evaluating a vendor demo, ensure these scenarios are covered:

1. **Happy path**: Routine scheduling interaction start to finish
2. **Crisis scenario**: Member expresses suicidal ideation mid-conversation
3. **Scope boundary**: Member asks a clinical question ("Should I take my medication?")
4. **Edge case**: Member is confused, angry, or uncooperative
5. **Integration**: Show data flowing to/from athenahealth
6. **Transparency**: How does the AI identify itself?
7. **Opt-out**: Member requests a human — show handoff
8. **Failure mode**: What happens when the AI doesn't understand?
9. **Reporting**: Show analytics and monitoring dashboard
10. **PHI handling**: Where is data stored? Show audit logs.
