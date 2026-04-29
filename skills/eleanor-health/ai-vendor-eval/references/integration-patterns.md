# Integration Patterns for Eleanor Health Tech Stack

## Purpose

Common integration patterns for connecting AI tools with Eleanor Health's tech stack: athenahealth (EHR), Salesforce (CRM), telephony, and data warehouse.

## athenahealth Integration Patterns

### Pattern 1: FHIR R4 API
**Best for**: Reading patient demographics, appointments, clinical data
**How it works**: RESTful API calls to athenahealth's FHIR endpoints
**Data format**: JSON (FHIR R4 resources)

```
AI Tool → HTTPS/OAuth 2.0 → athenahealth FHIR API → Patient/Appointment/Observation
```

**Pros**: Standard-based, well-documented, future-proof
**Cons**: athenahealth FHIR coverage is partial (not all data exposed), primarily read-only
**Use when**: Reading patient data for AI context, appointment lookups, clinical data retrieval

### Pattern 2: athenahealth Proprietary REST API
**Best for**: Full CRUD operations, scheduling, custom fields
**How it works**: athenahealth's native REST API with OAuth 2.0
**Data format**: JSON (proprietary schema)

```
AI Tool → HTTPS/OAuth 2.0 → athenahealth REST API → /patients, /appointments, /claims
```

**Pros**: Full functionality, write access, supports all athenahealth features
**Cons**: Proprietary (not portable), rate-limited, requires athenahealth developer certification
**Use when**: Writing back to EHR (appointment creation, status updates), accessing custom fields, any operation not available via FHIR

### Pattern 3: HL7v2 Messaging (ADT/ORM/ORU)
**Best for**: Real-time event-driven integration (admit/discharge/transfer, orders, results)
**How it works**: HL7v2 messages via TCP/MLLP or integration engine (Rhapsody, Mirth)
**Data format**: HL7v2 pipe-delimited messages

```
athenahealth → HL7v2/MLLP → Integration Engine → AI Tool
```

**Pros**: Real-time, event-driven, industry standard for clinical workflows
**Cons**: Complex message parsing, requires integration engine, older standard
**Use when**: Real-time notifications needed (new appointment, lab result, admission)

### Pattern 4: Flat File / Batch Export
**Best for**: Bulk data extracts, analytics, reporting
**How it works**: Scheduled CSV/Excel exports from athenahealth, loaded into data warehouse
**Data format**: CSV, delimited text

```
athenahealth → Scheduled Export → SFTP → Data Warehouse → AI Tool
```

**Pros**: Simple, reliable, good for large datasets
**Cons**: Not real-time (batch only), manual setup, data freshness lag
**Use when**: Historical data analysis, training data preparation, reporting

## Salesforce Integration Patterns

### Pattern 1: Salesforce REST API
**Best for**: CRM data access, lead management, care coordination records
**How it works**: REST API with OAuth 2.0

```
AI Tool → HTTPS/OAuth 2.0 → Salesforce REST API → Leads, Contacts, Cases, Custom Objects
```

**Pros**: Well-documented, high rate limits, full CRUD
**Cons**: Complex object relationships, governor limits on queries
**Use when**: Lead conversion workflows, member engagement tracking, care coordination

### Pattern 2: Salesforce Platform Events
**Best for**: Real-time event-driven workflows
**How it works**: Publish/subscribe model for real-time events

```
Salesforce Event → Platform Events → AI Tool (subscriber)
AI Tool → Platform Events → Salesforce (trigger automation)
```

**Pros**: Real-time, decoupled architecture, scalable
**Cons**: Requires Salesforce event configuration, message ordering not guaranteed
**Use when**: AI needs to react to CRM events in real-time (new lead, case update)

### Pattern 3: Salesforce Connect / External Objects
**Best for**: Surfacing external data (EHR, AI outputs) inside Salesforce UI
**How it works**: OData or custom Apex adapters

**Pros**: Staff sees AI insights without leaving Salesforce
**Cons**: Read-only for external objects, performance depends on external system
**Use when**: Displaying AI-generated insights or EHR data to CRM users

## Telephony Integration Patterns

### Pattern 1: SIP Trunking
**Best for**: AI voice agents replacing or augmenting IVR
**How it works**: SIP protocol for call routing between telephony and AI voice platform

```
PSTN → SIP Trunk → AI Voice Platform → Member Interaction
                                     → Transfer to Human (SIP REFER)
```

**Pros**: Industry standard, supports warm transfer, real-time audio
**Cons**: Requires telephony vendor cooperation, latency-sensitive
**Use when**: AI voice agents handling inbound/outbound calls

### Pattern 2: WebRTC
**Best for**: Browser-based or app-based voice/video
**How it works**: Peer-to-peer media streams with signaling server

**Pros**: No phone system needed, works in browser
**Cons**: Requires member to use app/browser, quality depends on connection
**Use when**: In-app voice features, virtual visit components

### Pattern 3: Telephony API (Twilio, Vonage, etc.)
**Best for**: SMS agents, programmable voice
**How it works**: REST API for sending/receiving SMS, initiating/receiving calls

```
AI Tool → Telephony API → SMS/Voice to Member
Member Reply → Webhook → AI Tool
```

**Pros**: Highly programmable, good documentation, scalable
**Cons**: Per-message/per-minute costs, vendor dependency
**Use when**: SMS agents, appointment reminders, outbound campaigns

## Data Warehouse Integration

### Pattern: ETL/ELT Pipeline
**Best for**: Analytics, reporting, AI model training data
**How it works**: Extract from source systems → Transform → Load into warehouse

```
athenahealth + Salesforce + Telephony
       ↓ (scheduled extracts)
    ETL Pipeline (dbt, Fivetran, custom)
       ↓
    Data Warehouse (Snowflake, BigQuery, Redshift)
       ↓
    AI Analytics / Reporting
```

**Pros**: Centralized data, optimized for analysis, historical data retention
**Cons**: Not real-time, data freshness depends on schedule, PHI in warehouse requires same protections
**Use when**: Transcript analysis, call analytics, scheduling optimization, trend analysis

## Integration Selection Quick Reference

| Scenario | Recommended Pattern | Rationale |
|----------|-------------------|-----------|
| AI reads patient demographics | athenahealth FHIR R4 | Standard, read-only, well-supported |
| AI books an appointment | athenahealth REST API | FHIR doesn't support full write operations |
| AI voice agent handles calls | SIP + Telephony API | Real-time voice with transfer capability |
| AI sends SMS reminders | Telephony API (Twilio-style) | Programmable, scalable, webhook-based |
| AI analyzes call transcripts | Data Warehouse ETL | Batch processing, historical analysis |
| AI updates CRM lead status | Salesforce REST API | Full CRUD, well-documented |
| Real-time alerts on new appointments | HL7v2 or Platform Events | Event-driven, real-time |
