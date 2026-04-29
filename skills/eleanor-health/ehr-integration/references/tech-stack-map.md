# Eleanor Health Tech Stack Map

## Purpose

Maps the key systems in Eleanor Health's technology stack and their integration points. Use when planning data flows, assessing integration complexity, or identifying data ownership boundaries.

> **Note**: This map is derived from publicly available information. Actual system configurations, vendors, and integration patterns should be confirmed with internal engineering and IT teams.

## System Inventory

### 1. athenahealth (EHR)

**Role**: Source of truth for all member clinical and demographic data. Non-negotiable foundation of the tech stack.

| Attribute | Detail |
|-----------|--------|
| Category | Electronic Health Record (EHR) |
| Data Owned | Patient demographics, appointments, clinical notes, diagnoses, medications, allergies, vitals, lab results, billing/claims, insurance, documents |
| Integration Type | REST API (proprietary) + FHIR R4 (subset) |
| Access Model | OAuth 2.0, per-practice API keys |
| Direction | Bidirectional (read + write) |
| Criticality | Highest — all other systems sync from or to athenahealth |

**Key Integration Points**:
- Appointment creation and retrieval (AI scheduling agents)
- Patient demographic sync to downstream systems
- Clinical data retrieval for pre-visit workflows
- Document upload (intake forms, consent, external records)
- Billing/eligibility verification

**Common Patterns**:
- Polling for appointment changes (limited webhook support)
- Batch patient demographic sync to Salesforce and data warehouse
- Real-time eligibility checks during scheduling
- Document ingestion from fax/scan workflows

### 2. Salesforce (CRM)

**Role**: Customer relationship management for leads, referrals, member engagement tracking, and care coordination workflows.

| Attribute | Detail |
|-----------|--------|
| Category | CRM |
| Data Owned | Lead/referral records, outreach history, engagement tracking, care coordination tasks, marketing attribution |
| Integration Type | REST API, Salesforce Connect, potentially MuleSoft |
| Access Model | OAuth 2.0, connected apps |
| Direction | Bidirectional with athenahealth; primary write target for lead/referral data |
| Criticality | High — drives member acquisition and engagement workflows |

**Key Integration Points**:
- Lead-to-patient conversion (Salesforce lead becomes athenahealth patient)
- Referral tracking from intake through first appointment
- Member engagement history for AI outreach agents
- Care coordination task management
- Marketing/outreach campaign tracking

**Common Patterns**:
- Salesforce-to-athenahealth patient creation on lead conversion
- athenahealth appointment status synced back to Salesforce for engagement tracking
- Outbound AI agent reads engagement history from Salesforce before calls
- Duplicate management across CRM and EHR records

### 3. Telephony System

**Role**: Voice communication infrastructure for inbound and outbound calls, including AI voice agent deployment.

| Attribute | Detail |
|-----------|--------|
| Category | Telephony / Contact Center |
| Data Owned | Call logs, recordings, transcripts, IVR flows, queue metrics |
| Integration Type | Vendor-dependent (likely REST API, SIP, WebSocket for real-time) |
| Access Model | API keys or OAuth, depending on vendor |
| Direction | Feeds data to analytics; receives scheduling data from athenahealth |
| Criticality | High — primary member communication channel |

**Key Integration Points**:
- AI voice agent deployment (inbound scheduling, outbound lead conversion)
- Call recording and transcript ingestion to data warehouse
- Real-time call routing based on member data from athenahealth/Salesforce
- Post-call summary pushed to athenahealth or Salesforce

**Common Patterns**:
- Caller ID lookup against athenahealth patient records
- AI voice agent queries athenahealth for available slots during call
- Call transcript analysis pipeline (telephony -> storage -> AI processing)
- SMS/voice agent consent tracking

### 4. Data Warehouse / Analytics

**Role**: Central repository for reporting, analytics, and AI/ML workloads. Aggregates data from all source systems.

| Attribute | Detail |
|-----------|--------|
| Category | Data Infrastructure |
| Data Owned | Aggregated operational, clinical, and financial data; derived metrics; ML model inputs/outputs |
| Integration Type | ETL/ELT pipelines, database connectors, API ingestion |
| Access Model | Role-based database access, API keys for pipeline tools |
| Direction | Primarily inbound (sink for all systems); outbound for dashboards and model serving |
| Criticality | High — powers reporting, KPIs, and AI workloads |

**Key Integration Points**:
- ETL from athenahealth (appointments, demographics, clinical data, billing)
- ETL from Salesforce (leads, referrals, engagement)
- Call data ingestion from telephony system
- AI model training data preparation
- Dashboard and reporting feeds (provider utilization, no-show rates, revenue cycle)

**Common Patterns**:
- Nightly batch sync from athenahealth for reporting tables
- Near-real-time event streaming for operational dashboards
- De-identified datasets for analytics and model training
- Data quality monitoring and reconciliation between source systems

### 5. Proprietary Internal Operations Platform

**Role**: Custom-built platform for internal workflows specific to Eleanor Health's operating model. Bridges gaps between off-the-shelf systems.

| Attribute | Detail |
|-----------|--------|
| Category | Internal Platform |
| Data Owned | Custom workflow state, operational configurations, internal business logic |
| Integration Type | Custom APIs, likely REST; may integrate directly with athenahealth and Salesforce |
| Access Model | Internal authentication (SSO likely) |
| Direction | Bidirectional with athenahealth and Salesforce; serves internal users |
| Criticality | Medium-High — supports day-to-day operations |

**Key Integration Points**:
- Workflow orchestration between athenahealth and Salesforce
- Custom business logic not supported by off-the-shelf systems
- Internal dashboards and operational tools
- Potential integration point for AI agent orchestration

**Common Patterns**:
- Middleware layer between EHR and CRM
- Custom scheduling rules or member routing logic
- Internal task management and assignment
- Operational reporting not covered by standard EHR/CRM reports

## Data Flow Diagram

```
                                    +------------------+
                                    |    TELEPHONY     |
                                    |  (Voice/SMS)     |
                                    +--------+---------+
                                             |
                              call logs,     |  caller ID
                              transcripts,   |  lookup,
                              recordings     |  slot queries
                                             |
+------------------+                +--------v---------+               +------------------+
|                  |  demographics, |                  |  leads,       |                  |
|   SALESFORCE     | <-- status --> |   ATHENAHEALTH   | -- referral ->|  AI VOICE/SMS    |
|   (CRM)         |  appointment   |   (EHR - SoT)    | <-- booking --|  AGENTS          |
|                  |  sync          |                  |               |                  |
+--------+---------+                +--------+---------+               +------------------+
         |                                   |
         |  leads, engagement,               |  appointments,
         |  referrals                        |  demographics,
         |                                   |  clinical data,
         |                                   |  billing
         |          +------------------+     |
         +--------> |                  | <---+
                    |  DATA WAREHOUSE  |
         +--------> |  / ANALYTICS     | <---+
         |          |                  |     |
         |          +--------+---------+     |
         |                   |               |
         |          dashboards, ML,          |
         |          reporting                |
         |                                   |
+--------+---------+                +--------+---------+
|                  |  custom        |                  |
|  INTERNAL OPS    | <-- sync ----> |  AI PROCESSING   |
|  PLATFORM        |  workflows     |  (Transcripts,   |
|                  |                |   Scheduling,     |
+------------------+                |   Analysis)       |
                                    +------------------+

Legend:
  SoT = Source of Truth
  --> = Primary data flow direction
  <-> = Bidirectional sync
```

## Data Ownership Matrix

| Data Type | Source of Truth | Consumers | Sync Frequency |
|-----------|---------------|-----------|----------------|
| Patient demographics | athenahealth | Salesforce, Data Warehouse, Internal Ops | Near-real-time or nightly batch |
| Appointments | athenahealth | Salesforce, Data Warehouse, AI Agents | Real-time (API) or polling |
| Clinical notes | athenahealth | Data Warehouse (de-identified) | Nightly batch |
| Diagnoses / medications | athenahealth | Data Warehouse | Nightly batch |
| Leads / referrals | Salesforce | athenahealth (on conversion), Data Warehouse | Event-driven |
| Engagement history | Salesforce | AI Agents, Data Warehouse | Real-time or near-real-time |
| Call recordings | Telephony | Data Warehouse, AI Processing | Post-call batch |
| Transcripts | Telephony / AI | Data Warehouse, AI Processing | Post-call batch |
| Billing / claims | athenahealth | Data Warehouse | Nightly batch |
| Operational workflows | Internal Ops Platform | athenahealth, Salesforce | Event-driven |

## Integration Risk Areas

1. **Patient identity matching**: No shared identifier across athenahealth, Salesforce, and telephony — matching relies on demographics (name, DOB, phone), which is error-prone
2. **Data consistency**: Bidirectional sync between athenahealth and Salesforce can create conflicts if both systems are updated simultaneously
3. **PHI sprawl**: Each integration point creates another system holding PHI — increases HIPAA surface area
4. **Vendor lock-in**: Heavy reliance on athenahealth's proprietary API limits portability
5. **Real-time gaps**: athenahealth's limited webhook support means many integrations rely on polling, introducing latency
