# AI Use Case Prioritization Framework

## Purpose

Scoring framework for evaluating and prioritizing AI use cases. Designed for healthcare organizations deploying AI across member-facing and internal workflows.

## Prioritization Matrix

Score each use case on three dimensions (1-5 scale):

| Dimension | 1 (Low) | 3 (Medium) | 5 (High) |
|-----------|---------|------------|----------|
| **Impact** | Saves <1 hr/week, affects few staff | Saves 5-10 hr/week, affects one team | Saves 20+ hr/week, affects multiple teams or member experience |
| **Feasibility** | No existing tools, heavy custom build, unclear data | Tools exist but need customization, data partially available | Off-the-shelf solution, data readily available, clear integration path |
| **Risk** (inverted) | Touches PHI, member-facing, clinical adjacency | Internal use with some PHI, non-clinical | No PHI, no member interaction, low compliance burden |

**Priority Score** = Impact × Feasibility × (6 - Risk)

Higher scores = higher priority. Maximum score = 125, minimum = 1.

## Eleanor Health AI Use Cases

### Member-Facing Use Cases

| Use Case | Impact | Feasibility | Risk | Score | Notes |
|----------|--------|-------------|------|-------|-------|
| AI Voice Agent — Inbound Scheduling | 4 | 4 | 4 | 32 | High call volume; reduces front desk load; PHI handling required |
| AI Voice Agent — Outbound Lead Conversion | 5 | 3 | 3 | 45 | Direct revenue impact; requires clinical safety guardrails; consent required |
| AI SMS Agent — Appointment Reminders | 3 | 5 | 3 | 45 | Simple automation; high feasibility; TCPA compliance needed |
| AI SMS Agent — Pre-Visit Data Collection | 4 | 4 | 4 | 32 | Saves intake time; collects demographics/symptoms; PHI management |
| AI Voice Agent — Post-Visit Follow-Up | 3 | 3 | 4 | 18 | Member engagement; relapse check-in; crisis escalation risk |

### Internal Use Cases

| Use Case | Impact | Feasibility | Risk | Score | Notes |
|----------|--------|-------------|------|-------|-------|
| Transcript Analysis | 5 | 4 | 3 | 60 | High volume of call recordings; extract insights; PHI in transcripts |
| Call Analysis & QA | 4 | 4 | 3 | 48 | Automate call quality scoring; identify coaching opportunities |
| Data Entry Automation | 4 | 3 | 4 | 24 | Reduce manual EHR data entry; athenahealth API constraints |
| Schedule Optimization | 5 | 3 | 2 | 60 | Provider utilization; no-show prediction; complex but high payoff |
| Clinical Note Summarization | 4 | 4 | 5 | 16 | Time saver for providers; highest clinical risk; needs clinical validation |
| Internal Knowledge Base (Claude Enterprise) | 4 | 5 | 1 | 100 | Lowest risk; immediate productivity gains; no PHI if policy enforced |

## Recommended Prioritization Order

Based on scoring:

1. **Internal Knowledge Base (Claude Enterprise)** — Score 100. Lowest risk, highest feasibility. Start here to build organizational AI literacy before tackling PHI-touching use cases.
2. **Schedule Optimization** — Score 60. High impact on provider utilization and member access. Complex but no direct member interaction.
3. **Transcript Analysis** — Score 60. High volume of existing data. PHI handling required but internal-only.
4. **Call Analysis & QA** — Score 48. Pairs naturally with transcript analysis.
5. **AI SMS Agent — Appointment Reminders** — Score 45. Simple, high-feasibility member-facing automation.
6. **AI Voice Agent — Outbound Lead Conversion** — Score 45. Revenue impact but requires safety guardrails and consent framework.
7. **AI Voice/SMS — Inbound Scheduling & Pre-Visit** — Score 32. Important but more complex integration with athenahealth.
8. **Data Entry Automation** — Score 24. Constrained by EHR API capabilities.
9. **Post-Visit Follow-Up** — Score 18. Clinical adjacency increases risk.
10. **Clinical Note Summarization** — Score 16. Highest clinical risk; deploy last with extensive validation.

## Decision Criteria for Go/No-Go

Before greenlighting a use case:
- [ ] PHI handling plan documented (if applicable)
- [ ] BAA in place with vendor (if applicable)
- [ ] Clinical safety review completed (if member-facing)
- [ ] Success metrics defined (baseline + target)
- [ ] Pilot plan with defined duration and scope
- [ ] Rollback plan if pilot fails
- [ ] Stakeholder alignment (clinical, ops, tech, compliance)
