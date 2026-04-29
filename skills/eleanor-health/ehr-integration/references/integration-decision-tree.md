# Integration Pattern Decision Tree

## Purpose

Guides the selection of integration patterns when connecting systems to athenahealth or between other systems in Eleanor Health's stack. Use when designing a new integration or evaluating whether an existing pattern is appropriate.

## Decision Tree

Start at the top and follow the path based on your integration requirements.

```
START: What are you integrating?
│
├── Is real-time data exchange required?
│   │
│   ├── YES: Does the target system support FHIR R4?
│   │   │
│   │   ├── YES: Is this a read-only operation?
│   │   │   │
│   │   │   ├── YES ──────────────────────────→ FHIR R4 (read)
│   │   │   │
│   │   │   └── NO: Does FHIR R4 support write
│   │   │       for this resource?
│   │   │       │
│   │   │       ├── YES ──────────────────────→ FHIR R4 (read/write)
│   │   │       │
│   │   │       └── NO ───────────────────────→ Proprietary REST API
│   │   │
│   │   └── NO: Does the target system have a
│   │       REST API?
│   │       │
│   │       ├── YES ──────────────────────────→ Proprietary REST API
│   │       │
│   │       └── NO: Does it support HL7v2
│   │           messaging?
│   │           │
│   │           ├── YES ──────────────────────→ HL7v2 Interface
│   │           │
│   │           └── NO ───────────────────────→ Custom Middleware
│   │                                           (API adapter)
│   │
│   └── NO: Is this a bulk data exchange?
│       │
│       ├── YES: Is the data volume > 10,000
│       │   records per sync?
│       │   │
│       │   ├── YES ──────────────────────────→ Flat File / Bulk Export
│       │   │                                   (SFTP, CSV, delimited)
│       │   │
│       │   └── NO: Does an API batch endpoint
│       │       exist?
│       │       │
│       │       ├── YES ──────────────────────→ REST API (batch)
│       │       │
│       │       └── NO ───────────────────────→ Flat File / Bulk Export
│       │
│       └── NO: Is this a one-time or ad hoc
│           data transfer?
│           │
│           ├── YES ──────────────────────────→ Manual Export/Import
│           │                                   (with validation)
│           │
│           └── NO ───────────────────────────→ REST API (scheduled)
```

## Integration Patterns — Comparison

### Pattern Comparison Table

| Pattern | Best For | Latency | Complexity | Maintainability | PHI Risk | athenahealth Support |
|---------|----------|---------|------------|-----------------|----------|---------------------|
| **FHIR R4** | Interoperability, read-heavy clinical data, new integrations | Low (real-time) | Medium | High (standards-based) | Medium (encrypted, scoped) | Partial (subset of resources) |
| **Proprietary REST API** | Full athenahealth feature access, scheduling, billing, writes | Low (real-time) | Medium | Medium (vendor-specific) | Medium (encrypted, scoped) | Full |
| **HL7v2** | Legacy system integration, ADT events, lab results | Low-Medium | High | Low (complex parsing) | Medium | Limited (depends on config) |
| **Flat File (CSV/SFTP)** | Bulk data loads, historical migration, reporting feeds | High (batch) | Low | Medium | High (files at rest) | Via export tools |
| **Manual** | One-time migrations, ad hoc corrections, small datasets | Very High | Very Low | N/A | High (human handling) | Via EHR UI export |

### Pattern Details

#### FHIR R4

**Pros**:
- Industry standard — portable across EHR vendors
- Structured resource model (Patient, Encounter, Condition, etc.)
- Growing ecosystem of tools, libraries, and validators
- Supports SMART on FHIR for authorization
- Aligns with ONC/CMS interoperability mandates

**Cons**:
- athenahealth FHIR coverage is incomplete — not all resources are available
- Write support is limited for some resource types
- May require mapping between FHIR and internal data models
- Performance may differ from proprietary API for complex queries
- Versioning across FHIR releases (R4 vs. future R5) requires planning

**Best for Eleanor Health**: New integrations targeting clinical data reads (patient demographics, conditions, medications). Good long-term investment for interoperability but may need proprietary API fallback for scheduling and billing.

#### Proprietary REST API (athenahealth)

**Pros**:
- Most complete access to athenahealth features
- Well-documented for common workflows (scheduling, billing, clinical)
- Established authentication model (OAuth 2.0)
- Sandbox available for development and testing
- Direct vendor support for certified partners

**Cons**:
- Vendor lock-in — not portable to other EHR systems
- API versioning and deprecation require ongoing maintenance
- Rate limits may constrain high-volume operations
- Limited webhook/event support — polling often required
- Certification process required for production access

**Best for Eleanor Health**: Scheduling workflows (AI voice agents booking appointments), billing/eligibility verification, and any operation where FHIR R4 coverage is insufficient. Primary workhorse for athenahealth integration.

#### HL7v2

**Pros**:
- Widely supported by legacy healthcare systems
- Good for event-driven workflows (ADT, ORU, ORM messages)
- Mature integration engines (Mirth Connect, Rhapsody) available
- Low latency for real-time event notifications

**Cons**:
- Complex message format (pipe-delimited segments) with many optional fields
- Highly variable implementations across vendors ("HL7v2 is a standard the way English is a language")
- Requires an integration engine or parser
- Mapping and transformation are labor-intensive
- Declining investment as industry moves toward FHIR

**Best for Eleanor Health**: Only if connecting to a system that exclusively supports HL7v2 (e.g., a legacy lab or pharmacy system). Not recommended as a primary integration pattern with athenahealth.

#### Flat File (CSV / SFTP)

**Pros**:
- Simple to implement — no API development required
- Good for large-volume bulk transfers
- Easy to validate and audit (files can be inspected)
- Works with any system regardless of API capability
- Low technical barrier for non-engineering teams

**Cons**:
- High latency (batch only — typically nightly or weekly)
- File security is critical (PHI at rest in transit files)
- Error handling is manual — failed records require reprocessing
- No real-time capability
- Brittle — format changes break pipelines silently
- Encryption and access controls must be explicitly managed

**Best for Eleanor Health**: Historical data migration, reporting feeds to data warehouse, bulk demographic updates. Not suitable for real-time workflows like AI scheduling.

#### Manual Export/Import

**Pros**:
- No development effort
- Appropriate for one-time tasks
- Human review built in

**Cons**:
- Does not scale
- Error-prone (manual data entry)
- PHI handling risk (data on local machines, email, etc.)
- No audit trail unless explicitly documented

**Best for Eleanor Health**: One-time data migrations or corrections. Should be minimized and replaced with automated patterns as quickly as possible.

## Eleanor Health Scenario Recommendations

| Scenario | Recommended Pattern | Rationale |
|----------|-------------------|-----------|
| AI voice agent books appointment in athenahealth | Proprietary REST API | Real-time, requires write access to scheduling; FHIR R4 scheduling support is limited |
| Pre-visit data collection (demographics, symptoms) | Proprietary REST API | Writes to patient record; may combine with FHIR R4 reads for existing data |
| Sync patient demographics to Salesforce | Proprietary REST API (batch) | Bidirectional sync; Salesforce has strong REST API; schedule nightly or near-real-time |
| Transcript analysis pipeline | Flat File + REST API | Transcripts exported from telephony as files; analysis results written via API to relevant systems |
| Nightly reporting feed to data warehouse | Flat File or REST API (batch) | Bulk data; latency acceptable; flat file simpler for high-volume extracts |
| Real-time eligibility check during scheduling | Proprietary REST API | Must be real-time; eligibility endpoints are proprietary API only |
| Lab results from external lab | HL7v2 (ORU) or FHIR R4 | Depends on lab vendor capability; prefer FHIR R4 if available |
| Care gap identification | FHIR R4 (read) + Data Warehouse | Read clinical data via FHIR; aggregate in warehouse for analysis |

## Decision Checklist

Before finalizing an integration pattern, confirm:

- [ ] Data types and volumes are understood
- [ ] Latency requirements are defined (real-time, near-real-time, batch)
- [ ] Read vs. write requirements are clear
- [ ] Target system API capabilities are verified (not assumed)
- [ ] PHI handling requirements are documented
- [ ] Error handling and retry strategy is defined
- [ ] Monitoring and alerting plan exists
- [ ] Fallback plan if primary pattern fails (e.g., API down → queue for retry)
