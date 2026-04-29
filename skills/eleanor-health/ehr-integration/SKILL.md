---
name: ehr-integration
description: >
  Generate EHR integration assessments for AI deployments connecting to
  athenahealth and other healthcare systems. Covers data flow mapping,
  API capability assessment, authentication, data synchronization, error
  handling, and compliance checkpoints.
  Triggers: "EHR integration assessment", "athenahealth", "data flow",
  "API integration".
---

# EHR Integration Assessment Skill

## When to Use
- Designing a new integration between an AI system and athenahealth
- Assessing API capabilities for a specific workflow (scheduling, clinical data, billing)
- Mapping data flows between athenahealth, Salesforce, telephony, and other systems
- Evaluating integration patterns (FHIR R4 vs. proprietary REST vs. HL7v2 vs. flat file)
- Planning authentication and authorization for multi-system integrations
- Defining error handling, retry logic, and monitoring for EHR-connected workflows
- Reviewing an existing integration for gaps, risks, or improvement opportunities

## When NOT to Use
- Clinical safety requirements for member-facing AI (use `clinical-safety` instead)
- HIPAA/PHI governance frameworks (use `hipaa-governance` instead)
- Vendor evaluation and scoring (use `ai-vendor-eval` instead)
- AI rollout planning and adoption strategy (use `ai-deployment-playbook` instead)
- FHIR resource or bundle construction (use `fhir-builder` instead)
- General product requirements without EHR integration (use `prd-writer-samd` instead)

## Integration Assessment Template

When generating an EHR integration assessment, cover all 6 sections:

### 1. Data Flow Mapping
Map every data element that moves between systems:

| Data Element | Source System | Target System | Direction | Frequency | Format | PHI? |
|-------------|--------------|---------------|-----------|-----------|--------|------|
| Patient demographics | athenahealth | Salesforce | Push | Near-real-time | JSON (REST) | Yes |
| Appointment slots | athenahealth | AI Voice Agent | Pull | Real-time | JSON (REST) | No |
| Booking confirmation | AI Voice Agent | athenahealth | Push | Real-time | JSON (REST) | Yes |

For each data flow, document:
- Source system and endpoint
- Target system and endpoint
- Data elements included (field-level)
- Transformation or mapping required
- PHI classification (PHI, SUD, de-identified, non-PHI)
- Volume estimate (records per day/hour)

See `references/tech-stack-map.md` for the full system inventory and data ownership matrix.

### 2. API Capability Assessment
For each integration, verify the target API supports the required operations:

| Requirement | API Endpoint | Method | Supported? | Notes |
|-------------|-------------|--------|-----------|-------|
| Search available slots | /appointments/open | GET | Yes | Filter by provider, department, date range |
| Book appointment | /appointments | POST | Yes | Requires patient ID, appointment type |
| Retrieve patient record | /patients/{id} | GET | Yes | Returns demographics, insurance |
| Update patient demographics | /patients/{id} | PUT | Yes | Partial update supported |

For each endpoint, document:
- Request/response format
- Required vs. optional parameters
- Rate limits applicable to this endpoint
- Known limitations or quirks
- Sandbox vs. production behavior differences

See `references/athenahealth-api-overview.md` for endpoint categories, rate limits, and FHIR R4 coverage.

### 3. Authentication & Authorization
Define the auth model for each system-to-system connection:

| Connection | Auth Method | Token Lifetime | Refresh Strategy | Secrets Management |
|-----------|------------|----------------|------------------|-------------------|
| App -> athenahealth | OAuth 2.0 (client credentials) | 1 hour | Auto-refresh before expiry | Secrets manager (vault) |
| App -> Salesforce | OAuth 2.0 (JWT bearer) | Session-based | JWT re-issued per session | Certificate stored in vault |

For each connection, document:
- Authentication flow (OAuth grant type, API key, etc.)
- Token storage and rotation procedures
- Service account vs. user-context access
- Minimum required scopes/permissions
- Multi-practice or multi-org considerations
- Secret rotation schedule

### 4. Data Synchronization
Define how data stays consistent across systems:

**Sync Strategy**:
- Real-time (API call on event) vs. near-real-time (polling interval) vs. batch (scheduled)
- Push (source notifies target) vs. pull (target queries source)
- Conflict resolution: which system wins if both have updates?

**Sync Design**:
| Sync | Pattern | Frequency | Conflict Rule | Idempotency |
|------|---------|-----------|---------------|-------------|
| Patient demographics | Pull (polling) | Every 5 min | athenahealth wins | Match on practice ID + patient ID |
| Appointment status | Pull (polling) | Every 1 min | athenahealth wins | Match on appointment ID |
| Lead conversion | Push (event) | On conversion | Salesforce initiates, athenahealth creates | Dedupe on name + DOB |

For each sync, document:
- Source of truth designation
- Deduplication and matching logic
- Handling of deletes and soft-deletes
- Historical backfill strategy
- Data validation before write

See `references/integration-decision-tree.md` for pattern selection guidance.

### 5. Error Handling & Monitoring
Define how failures are detected, handled, and recovered:

**Error Categories**:
| Error Type | Example | Handling Strategy | Alert Level |
|-----------|---------|-------------------|-------------|
| Auth failure | 401 Unauthorized | Refresh token; retry once; alert if persists | Critical |
| Rate limit | 429 Too Many Requests | Exponential backoff; queue remaining calls | Warning |
| Validation error | 400 Bad Request | Log error details; skip record; flag for review | Warning |
| Server error | 500 Internal Server Error | Retry with backoff (3 attempts); alert on failure | Critical |
| Timeout | No response within 30s | Retry once; fail gracefully; queue for retry | Warning |
| Data conflict | Concurrent update | Apply conflict resolution rule; log both versions | Info |

**Monitoring Requirements**:
- API response time tracking (p50, p95, p99)
- Error rate by endpoint and error type
- Sync lag measurement (time between source update and target update)
- Queue depth monitoring (for async/retry queues)
- PHI access audit logging
- Alerting thresholds and escalation paths

**Recovery Procedures**:
- Dead letter queue for failed messages
- Manual reprocessing workflow for stuck records
- Rollback procedures for bad data writes
- Incident response for extended API outages

### 6. Compliance Checkpoints
Verify regulatory and security requirements for the integration:

| Checkpoint | Requirement | Status | Evidence |
|-----------|-------------|--------|----------|
| BAA with athenahealth | Signed BAA covering API access to PHI | [ ] Verified | BAA document |
| PHI encryption in transit | TLS 1.2+ for all API calls | [ ] Verified | API configuration |
| PHI encryption at rest | AES-256 for stored PHI | [ ] Verified | Infrastructure config |
| Audit logging | All PHI access logged with user, timestamp, purpose | [ ] Verified | Log configuration |
| Minimum necessary | Only required data fields accessed per integration | [ ] Verified | API scope documentation |
| 42 CFR Part 2 | SUD data handling if applicable | [ ] Assessed | Compliance review |
| HIPAA risk assessment | Integration included in security risk assessment | [ ] Verified | Risk assessment doc |
| Data retention | Retention and deletion policies for integration data | [ ] Defined | Policy document |

## Output Format

Generate integration assessments as a structured markdown document:

```markdown
# EHR Integration Assessment — [Integration Name]

## Overview
- Systems: [Source] -> [Target]
- Use case: [Description]
- Integration pattern: [FHIR R4 / REST API / HL7v2 / Flat File]
- Data classification: [PHI / SUD / De-identified / Non-PHI]

## 1. Data Flow Map
[Data element table with source, target, direction, frequency, format, PHI flag]

## 2. API Capability Assessment
[Endpoint verification table with support status and notes]

## 3. Authentication & Authorization
[Auth model per connection with token management details]

## 4. Data Synchronization
[Sync strategy, conflict resolution, deduplication, backfill plan]

## 5. Error Handling & Monitoring
[Error categories, handling strategies, monitoring requirements, recovery procedures]

## 6. Compliance Checkpoints
[Checkpoint table with verification status and evidence]

## Risks & Open Questions
[Integration-specific risks and items requiring clarification]

## Recommendations
[Pattern recommendation, phasing, and next steps]
```

## Reference Files
- `references/athenahealth-api-overview.md` — API endpoint categories, authentication, rate limits, FHIR R4 status, known limitations
- `references/tech-stack-map.md` — Eleanor Health system inventory, data ownership, integration points, data flow diagram
- `references/integration-decision-tree.md` — Pattern selection decision tree, pros/cons comparison, scenario recommendations

## Verification Checklist

Before finalizing an EHR integration assessment, verify:

- [ ] All data flows are mapped with source, target, direction, frequency, and PHI classification
- [ ] API endpoints are verified as supported (not assumed) for each required operation
- [ ] Authentication model is documented for every system-to-system connection with secret rotation plan
- [ ] Source of truth is designated for every shared data element with conflict resolution rules
- [ ] Error handling covers auth failures, rate limits, validation errors, server errors, and timeouts
- [ ] Monitoring includes API response times, error rates, sync lag, and PHI access audit logging
- [ ] BAA is confirmed for every connection involving PHI
- [ ] 42 CFR Part 2 applicability is assessed if SUD data flows through the integration
- [ ] Integration pattern selection is justified (see decision tree) with rationale documented
- [ ] Rollback and recovery procedures are defined for data write failures
