# athenahealth API Overview

## Purpose

Reference guide for athenahealth's API capabilities relevant to EHR integration planning. Use when assessing what data can be accessed programmatically and what constraints exist.

> **Disclaimer**: API capabilities, rate limits, and endpoints change over time. Always verify details against the current [athenahealth developer documentation](https://docs.athenahealth.com/) before making integration decisions. This reference reflects publicly documented capabilities and is intended for planning purposes only.

## Authentication Model

### OAuth 2.0 (Client Credentials)
- athenahealth uses OAuth 2.0 with client credentials grant for server-to-server API access
- Access tokens are short-lived (typically 1 hour) and must be refreshed
- Each practice has a unique practice ID used in API calls
- API keys (client ID + client secret) are issued per application registration
- Separate credentials for sandbox vs. production environments

### Key Auth Considerations
- Tokens must be securely stored and never exposed client-side
- API key rotation should be planned into operational procedures
- Multi-practice deployments require managing practice IDs across the organization
- HIPAA-compliant token handling is required since tokens grant access to PHI

## Key API Endpoint Categories

### Patient Demographics
- Search patients by name, DOB, SSN, or custom fields
- Create and update patient records
- Retrieve patient demographics, contacts, insurance information
- Patient photo management
- Patient portal enrollment status
- **Common use**: Member identity matching, demographic sync, insurance verification

### Appointments
- Search available appointment slots by provider, department, date range
- Book, cancel, and reschedule appointments
- Retrieve appointment details and status
- Check-in and check-out workflows
- Appointment type and reason management
- **Common use**: AI scheduling agents, appointment reminders, no-show tracking

### Clinical Data
- Problems/diagnoses (ICD-10 coded)
- Medications (active, historical)
- Allergies
- Vitals
- Lab results and orders
- Clinical documents (encounter summaries, visit notes)
- **Common use**: Pre-visit data collection, clinical note retrieval, care gap identification

### Billing & Claims
- Charge posting
- Claim submission and status
- Payment posting
- Insurance eligibility verification
- Fee schedules
- **Common use**: Revenue cycle automation, eligibility checks, claim status monitoring

### Documents
- Upload and retrieve clinical documents
- Document types: lab results, imaging, referral letters, consent forms
- PDF and image support
- **Common use**: Document ingestion pipelines, fax-to-EHR workflows

## Rate Limits & Throttling

### Published Limits
- Rate limits are enforced per API key (client credentials)
- Typical limit: 100-200 calls per second per practice (varies by endpoint)
- Batch endpoints available for high-volume operations
- Throttling returns HTTP 429 with retry-after header

### Best Practices
- Implement exponential backoff for 429 responses
- Use subscription/webhook endpoints where available to reduce polling
- Cache frequently accessed reference data (appointment types, departments, providers)
- Batch read operations when retrieving multiple records
- Monitor API usage against limits proactively

## Sandbox vs. Production

### Sandbox Environment
- Free access for development and testing
- Pre-populated with synthetic patient data (not real PHI)
- Same API structure as production
- Separate credentials required
- Limitations: some features may not behave identically to production
- Use for: integration development, testing, demos, certification

### Production Environment
- Requires completion of athenahealth's app certification process
- Access to real patient data (PHI) — HIPAA obligations apply
- Higher rate limits than sandbox (negotiable for high-volume partners)
- BAA required between integrating organization and athenahealth
- Monitoring and audit logging required

### Certification Process
- Submit application for review by athenahealth partner team
- Demonstrate proper API usage, error handling, and security practices
- May require code review or security assessment depending on data scope
- Timeline: weeks to months depending on integration complexity

## FHIR R4 Support

### Current Status
- athenahealth supports FHIR R4 endpoints for a subset of resources
- FHIR R4 is available alongside the proprietary REST API (not a replacement)
- Supported FHIR resources typically include: Patient, Encounter, Condition, Observation, MedicationRequest, AllergyIntolerance, Procedure, DocumentReference
- FHIR endpoints primarily support read operations; write support varies by resource

### FHIR vs. Proprietary API
- Proprietary API is more feature-complete and widely used by existing integrations
- FHIR R4 is better for interoperability with other FHIR-capable systems
- Some operations (scheduling, billing) may only be available via the proprietary API
- FHIR R4 is the recommended path for new integrations targeting long-term interoperability

### USCDI and ONC Compliance
- athenahealth supports USCDI v1 data elements via FHIR R4
- SMART on FHIR authorization supported for patient-facing applications
- Aligns with CMS Interoperability and Patient Access Final Rule requirements

## Known Limitations & Common Challenges

### Data Model Constraints
- **Custom fields**: athenahealth supports custom fields but they may not all be API-accessible
- **Multi-location complexity**: Each department and provider has separate scheduling, requiring careful mapping
- **Historical data**: Bulk export of historical data may require separate arrangement outside the standard API
- **Real-time events**: Limited native webhook/subscription support — many integrations rely on polling

### Integration Challenges
- **Appointment type mapping**: athenahealth appointment types may not map 1:1 to external system concepts
- **Patient matching**: No universal patient identifier — matching relies on demographics, which can be inconsistent
- **Document formats**: Uploaded documents must meet format/size requirements; OCR not natively provided
- **Concurrency**: Simultaneous writes to the same record from multiple systems can cause conflicts
- **API versioning**: Breaking changes can occur across API versions; monitor deprecation notices

### Operational Considerations
- **Support model**: Developer support quality varies; community forums supplement official docs
- **Testing coverage**: Some edge cases (insurance-specific workflows, state-specific rules) are hard to replicate in sandbox
- **Downtime windows**: Scheduled maintenance windows may affect real-time integrations
- **Data latency**: Some API data refreshes are not instantaneous — plan for eventual consistency
