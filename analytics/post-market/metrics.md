# Post-Market Surveillance Metrics

Metrics for monitoring device safety and performance after market release. Required under 21 CFR 803 (MDR) and ISO 13485 Clause 8.2.1.

## Key Metrics

| Metric | Definition | Target | Frequency |
|--------|-----------|--------|-----------|
| Complaint rate | Complaints per 1,000 device-days | < [threshold] | Monthly |
| CAPA cycle time | Days from CAPA initiation to closure | < 90 days | Per CAPA |
| MDR rate | Medical Device Reports filed per quarter | 0 target | Quarterly |
| Field safety action rate | Corrections or removals per year | 0 target | Annual |
| Trend signal detection | Complaints exceeding 2σ baseline | Alert on breach | Weekly |

## Data Sources
- Complaint management system: [system name]
- CAPA database: [system name]
- FDA MAUDE (public adverse events): [query parameters]

## Alerting Rules
- Complaint rate > [threshold]: Escalate to quality manager
- Any MDR event: Immediate notification to regulatory + quality
- CAPA overdue > 30 days: Weekly escalation
