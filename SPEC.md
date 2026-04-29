# SPEC: PM OS — Eleanor Health Customization

## 1. Objective

Extend PM OS with a new skill category (`skills/eleanor-health/`) and updated configuration to support the **Senior Product Manager, AI** role at Eleanor Health. The role focuses on AI vendor evaluation, internal AI adoption (Claude Enterprise), AI agent deployment (voice/SMS), and HIPAA/behavioral health compliance.

**Target user**: A PM operating in behavioral health/addiction treatment, managing AI product strategy across vendor selection, internal deployment, clinical safety, and EHR integration.

**What changes**:
- Add 5 new skills under `skills/eleanor-health/`
- Update `CLAUDE.md` with Eleanor Health context, triggers, and boundaries
- Add `behavioral-health-safety-reviewer` agent alongside existing `clinical-reviewer`
- Update `interview-prep` skill for Eleanor Health domain
- Update `skills/README.md` with new skill category
- Add example outputs for new skills
- Update dashboard (`dashboard/pm-os.html`) skill table

**What stays**: All SaMD regulatory and PM skills remain in place. The repo supports both SaMD and Eleanor Health PM workflows.

---

## 2. New Skills

### 2.1 AI Vendor Evaluation (`skills/eleanor-health/ai-vendor-eval/`)

**Type**: Script-based (Python XLSX generator + SKILL.md)

**Triggers**: "vendor eval", "AI vendor", "scorecard", "pilot design", "vendor assessment", "vendor go/no-go"

**Output**: `output/vendor-eval-{vendor-slug}.xlsx`

**XLSX Sheets**:

| Sheet | Purpose | Columns |
|-------|---------|---------|
| Evaluation Summary | High-level scorecard | Vendor Name, Category, Overall Score, Recommendation, Decision Date, Owner |
| Criteria Scoring | Weighted evaluation matrix | Criterion, Category (Clinical Safety / HIPAA / Integration / Cost / Scalability / UX), Weight (%), Score (1-5), Weighted Score, Evidence/Notes |
| Clinical Safety | Safety-specific requirements | Requirement ID, Requirement, Priority (Must/Should/Nice), Met? (Yes/No/Partial), Evidence, Gap Notes |
| HIPAA & Compliance | Regulatory checklist | Requirement ID, Requirement (BAA, encryption, PHI handling, audit logging, 42 CFR Part 2), Status, Evidence, Risk if Unmet |
| Integration Assessment | Tech stack compatibility | System (athenahealth/Salesforce/telephony/data warehouse), Integration Type (API/HL7/flat file/manual), Feasibility (High/Med/Low), Effort Estimate, Dependencies, Notes |
| Pilot Design | Pilot plan template | Metric, Baseline, Target, Measurement Method, Duration, Success Threshold, Owner |
| Contract Requirements | Key contract terms | Term, Requirement, Vendor Response, Acceptable? (Yes/No), Negotiation Notes |

**Reference files**:
- `references/evaluation-framework.md` — Weighted scoring methodology, category definitions, decision thresholds (>4.0 = proceed, 3.0-4.0 = conditional, <3.0 = reject)
- `references/hipaa-vendor-checklist.md` — BAA requirements, PHI handling standards, breach notification, subcontractor obligations
- `references/integration-patterns.md` — Common integration patterns for athenahealth (FHIR R4, HL7v2, flat file), Salesforce (REST API, Apex), telephony (SIP, WebRTC)

**Script**: `scripts/generate_vendor_eval.py`
- CLI: `python scripts/generate_vendor_eval.py --vendor "Vendor Name" --category "voice-agent"`
- `--example eleanor` flag generates a pre-filled example for an AI voice agent vendor
- Follows existing patterns: `openpyxl` + stdlib only, same styling constants, auto-width, conditional formatting, data validation dropdowns

**Verification checklist**:
- [ ] BAA requirement explicitly listed
- [ ] 42 CFR Part 2 compliance addressed
- [ ] Crisis escalation capability assessed
- [ ] athenahealth integration feasibility documented
- [ ] Pilot success metrics are measurable
- [ ] Contract terms include data deletion/portability clauses

---

### 2.2 HIPAA & PHI Governance (`skills/eleanor-health/hipaa-governance/`)

**Type**: Prompt-based (SKILL.md + references only)

**Triggers**: "HIPAA", "PHI", "BAA", "data governance", "42 CFR Part 2", "SUD confidentiality"

**Output**: Markdown governance framework document

**SKILL.md sections**:
- When to Use: Any AI deployment that touches PHI, vendor selection, internal AI policy
- When NOT to Use: General product questions without PHI implications
- Governance Framework Template:
  1. Data Classification (PHI types, SUD records, de-identified data)
  2. AI-Specific PHI Controls (prompt injection risks, model training exclusions, audit logging)
  3. BAA Requirements (what must be in every AI vendor BAA)
  4. 42 CFR Part 2 Overlay (additional consent requirements for SUD treatment records)
  5. Internal AI Use Policy (what employees can/cannot input to Claude Enterprise)
  6. Incident Response (breach notification timelines, reporting chain)

**Reference files**:
- `references/hipaa-ai-controls.md` — PHI safeguards specific to LLM/AI deployments (prompt logging, data residency, model training opt-out, re-identification risk)
- `references/42cfr-part2-summary.md` — Key provisions of 42 CFR Part 2: consent requirements, qualified service organization agreements (QSOA), exceptions, 2024 rule changes aligning with HIPAA
- `references/internal-ai-policy-template.md` — Template for employee AI usage policy covering PHI, approved tools, prohibited uses, reporting obligations

---

### 2.3 AI Deployment Playbook (`skills/eleanor-health/ai-deployment-playbook/`)

**Type**: Prompt-based (SKILL.md + references only)

**Triggers**: "AI rollout", "adoption strategy", "Claude deployment", "internal AI", "AI training", "use case prioritization"

**Output**: Markdown deployment plan

**SKILL.md sections**:
- When to Use: Planning rollout of any AI tool (internal or member-facing)
- Deployment Plan Template:
  1. Use Case Inventory (prioritization matrix: impact × feasibility × risk)
  2. Rollout Phases (pilot → controlled expansion → general availability)
  3. Training Program Design (role-based onboarding, prompt engineering basics, PHI guardrails)
  4. Adoption Metrics (DAU, task completion rate, time saved, error reduction, NPS)
  5. Governance & Escalation (who approves new use cases, how to report issues)
  6. Success Criteria & Iteration (30/60/90 day checkpoints)

**Reference files**:
- `references/use-case-prioritization.md` — Framework for scoring AI use cases: transcript analysis, call analysis, data entry automation, schedule optimization, lead conversion, pre-visit data collection
- `references/adoption-metrics.md` — KPIs for measuring AI adoption success, benchmarks from healthcare AI deployments
- `references/training-program-template.md` — Role-based training structure (clinical staff, operations, leadership), prompt engineering basics, PHI dos/don'ts

---

### 2.4 Behavioral Health Clinical Safety (`skills/eleanor-health/clinical-safety/`)

**Type**: Prompt-based (SKILL.md + references only)

**Triggers**: "clinical safety", "crisis protocol", "escalation", "de-escalation", "scope of practice"

**Output**: Markdown safety requirements document

**SKILL.md sections**:
- When to Use: Any AI deployment that interacts with members (voice, SMS, chat) or processes clinical content
- Safety Requirements Framework:
  1. Crisis Detection & Escalation (suicidal ideation, overdose indicators, self-harm, withdrawal symptoms → immediate warm handoff to human)
  2. Scope of Practice Boundaries (what AI can/cannot say — no diagnosis, no medication advice, no clinical recommendations)
  3. De-escalation Protocols (tone, pacing, validation language for distressed callers)
  4. Consent & Transparency (AI must identify itself as AI, member opt-out at any time)
  5. Clinical Content Guardrails (approved language, prohibited topics, escalation triggers)
  6. Monitoring & QA (call/transcript review cadence, adverse event tracking, false negative analysis)

**Reference files**:
- `references/crisis-escalation-protocols.md` — Behavioral health crisis indicators, escalation tiers (Tier 1: immediate danger → Tier 2: elevated risk → Tier 3: routine), warm handoff requirements, documentation standards
- `references/scope-of-practice-boundaries.md` — What AI agents can and cannot do in a behavioral health context, state-by-state considerations for multi-state operations, SAMHSA guidance
- `references/ai-transparency-requirements.md` — FTC guidance on AI disclosure, state AI transparency laws, recommended disclosure language for voice and SMS agents

---

### 2.5 EHR Integration Assessment (`skills/eleanor-health/ehr-integration/`)

**Type**: Prompt-based (SKILL.md + references only)

**Triggers**: "EHR integration assessment", "athenahealth", "data flow", "API integration"

**Output**: Markdown integration assessment document

**SKILL.md sections**:
- When to Use: Evaluating how an AI tool will connect to athenahealth or other systems in the stack
- Integration Assessment Template:
  1. Data Flow Mapping (source system → AI tool → destination system, what data moves, format, frequency)
  2. API Capability Assessment (what athenahealth exposes via API, what requires workarounds)
  3. Authentication & Authorization (OAuth, API keys, role-based access, PHI scoping)
  4. Data Synchronization (real-time vs batch, conflict resolution, source-of-truth rules)
  5. Error Handling & Monitoring (retry logic, alerting, data reconciliation)
  6. Compliance Checkpoints (audit logging, consent verification before data exchange)

**Reference files**:
- `references/athenahealth-api-overview.md` — Key athenahealth API endpoints (patient, appointment, clinical, billing), authentication model, rate limits, sandbox vs production, known limitations
- `references/tech-stack-map.md` — Eleanor Health tech stack reference: athenahealth (EHR, source of truth), Salesforce (CRM), telephony, data warehouse, proprietary ops platform — integration points and data ownership
- `references/integration-decision-tree.md` — Decision tree for choosing integration pattern: FHIR R4 vs HL7v2 vs REST API vs flat file vs manual, based on data type, frequency, and system capabilities

---

## 3. Updated Agent Persona

### `skills/agents/behavioral-health-safety-reviewer/SKILL.md`

Adds `behavioral-health-safety-reviewer` alongside the existing `clinical-reviewer` (neonatal SpO2). New persona:

**Role**: Behavioral health clinical safety expert specializing in AI deployments for addiction treatment and SUD programs.

**Review dimensions** (mirrors clinical-reviewer's 6-dimension pattern):
1. **Crisis Safety** — Can the AI detect and escalate crisis situations (SI, overdose, withdrawal)?
2. **Scope Compliance** — Does the AI stay within practice boundaries (no diagnosis, no med advice)?
3. **De-escalation Quality** — Is the AI's tone and language appropriate for distressed members?
4. **Consent & Transparency** — Does the AI identify itself? Can the member opt out?
5. **PHI Handling** — Is member data protected per HIPAA and 42 CFR Part 2?
6. **Handoff Quality** — When AI escalates to human, is the handoff warm with full context?

**Verdict format**: SAFE / CONDITIONAL / UNSAFE with specific findings per dimension.

---

## 4. Updated Files

### 4.1 `CLAUDE.md`

**Changes**:
- Add `### Eleanor Health AI (`skills/eleanor-health/`)` section to Skills Available table
- Add behavioral-health-safety-reviewer to Agent Personas table
- Replace `SaMD Context` section with `Eleanor Health Context`:
  ```
  Compliance: HIPAA, 42 CFR Part 2 (SUD confidentiality)
  Clinical domain: Behavioral health, substance use disorder, addiction treatment
  Care model: Longitudinal, whole-person, value-based, multi-state
  EHR: athenahealth (source of truth, non-negotiable for member data)
  CRM: Salesforce
  AI tools deployed: Claude Enterprise (internal), AI voice/SMS agents (member-facing)
  AI initiatives: Outbound lead conversion, pre-visit data collection, transcript/call analysis, scheduling optimization
  Tech stack: athenahealth, Salesforce, telephony, data warehouse, proprietary ops platform
  ```
- Update Boundaries section:
  - Always: Check HIPAA implications, require BAA, verify crisis escalation, cite HIPAA/42 CFR Part 2
  - Never: Deploy AI with PHI sans BAA, skip clinical safety review for member-facing AI, assume AI can handle crisis without escalation, share SUD records without 42 CFR Part 2 consent

### 4.2 `skills/README.md`

**Changes**:
- Add Eleanor Health AI category table (5 skills with triggers and outputs)
- Add installation commands for new category
- Add artifact generation command for vendor eval script
- Update skill structure diagram

### 4.3 Interview Prep (`skills/samd-pm/interview-prep/SKILL.md`)

**Changes**:
- Add Eleanor Health domain context section (behavioral health, AI PM, vendor management)
- Add STAR story templates for:
  - AI vendor evaluation and deployment
  - HIPAA compliance in AI context
  - Cross-functional collaboration (clinical + ops + eng)
  - Building AI adoption programs
  - Crisis safety protocol design
  - EHR integration challenges
- Add Eleanor Health-specific research prompts (value-based care model, multi-state behavioral health, athenahealth ecosystem)

---

## 5. Project Structure (after changes)

```
pm-os/
├── CLAUDE.md                          # UPDATED — Eleanor Health context added
├── SPEC.md                            # THIS FILE
├── skills/
│   ├── README.md                      # UPDATED — new category added
│   ├── samd-regulatory/               # UNCHANGED — kept alongside
│   ├── samd-pm/
│   │   ├── interview-prep/
│   │   │   └── SKILL.md              # UPDATED — Eleanor Health domain
│   │   ├── networking-outreach/       # UNCHANGED
│   │   └── prd-writer-samd/          # UNCHANGED
│   ├── eleanor-health/               # NEW CATEGORY
│   │   ├── ai-vendor-eval/
│   │   │   ├── SKILL.md
│   │   │   ├── references/
│   │   │   │   ├── evaluation-framework.md
│   │   │   │   ├── hipaa-vendor-checklist.md
│   │   │   │   └── integration-patterns.md
│   │   │   └── scripts/
│   │   │       └── generate_vendor_eval.py
│   │   ├── hipaa-governance/
│   │   │   ├── SKILL.md
│   │   │   └── references/
│   │   │       ├── hipaa-ai-controls.md
│   │   │       ├── 42cfr-part2-summary.md
│   │   │       └── internal-ai-policy-template.md
│   │   ├── ai-deployment-playbook/
│   │   │   ├── SKILL.md
│   │   │   └── references/
│   │   │       ├── use-case-prioritization.md
│   │   │       ├── adoption-metrics.md
│   │   │       └── training-program-template.md
│   │   ├── clinical-safety/
│   │   │   ├── SKILL.md
│   │   │   └── references/
│   │   │       ├── crisis-escalation-protocols.md
│   │   │       ├── scope-of-practice-boundaries.md
│   │   │       └── ai-transparency-requirements.md
│   │   └── ehr-integration/
│   │       ├── SKILL.md
│   │       └── references/
│   │           ├── athenahealth-api-overview.md
│   │           ├── tech-stack-map.md
│   │           └── integration-decision-tree.md
│   └── agents/
│       ├── clinical-reviewer/         # KEPT (for SaMD use)
│       └── behavioral-health-safety-reviewer/  # NEW
│           └── SKILL.md
├── examples/                          # ADD new examples
│   ├── vendor-eval-example.xlsx       # NEW — generated from script
│   └── (existing examples unchanged)
└── dashboard/
    └── pm-os.html                     # UPDATED — new skill table entries
```

---

## 6. Code Style & Conventions

Follow existing PM OS patterns exactly:

| Aspect | Convention |
|--------|-----------|
| SKILL.md frontmatter | YAML with `name` and `description` fields |
| Trigger phrases | Comma-separated in `description` field |
| Reference files | Standalone `.md`, not cross-referenced from SKILL.md |
| Python scripts | `openpyxl` + stdlib only, same styling constants (#1F4E79 headers, white bold text) |
| XLSX output | `output/{artifact-type}-{slug}.xlsx` |
| Status dropdowns | Data validation with approved values |
| Conditional formatting | Green/Red/Yellow for pass/fail/pending or yes/no/partial |
| ID conventions | Prefixed sequential (e.g., CS-001, VE-001, HG-001) |
| Verification checklists | `- [ ]` checkbox format at end of SKILL.md |

---

## 7. Testing Strategy

- **Script testing**: Run `generate_vendor_eval.py --example eleanor` and verify:
  - XLSX generates without errors
  - All 7 sheets present with correct headers
  - Conditional formatting and data validation work in Excel/Google Sheets
  - Auto-width renders correctly
  - Example data is realistic and Eleanor Health-specific
- **SKILL.md validation**: Each skill's trigger phrases are unique (no collisions with existing SaMD skills)
- **CLAUDE.md validation**: All new skills listed in skills table, context section is accurate, boundary rules don't conflict with existing SaMD boundaries
- **Cross-reference check**: `skills/README.md` lists all skills, counts match actual directory structure

---

## 8. Boundaries

### Always
- Match existing SKILL.md format exactly (frontmatter, sections, checklist)
- Use HIPAA/42 CFR Part 2 as the regulatory framework (not IEC 62304/ISO 14971)
- Ground reference files in actual regulatory requirements (cite sections/provisions)
- Keep Eleanor Health skills independent from SaMD skills (no cross-dependencies)
- Keep the repo useful as a public template (no Eleanor Health proprietary information)

### Never
- Modify existing SaMD skill content
- Include real PHI or patient data in examples
- Hardcode Eleanor Health employee names or internal systems details
- Make medical or legal claims — reference files should cite sources and note "consult legal counsel"
- Break the existing skill installation workflow (`cp -r skills/ ~/.claude/skills/`)

---

## 9. Deliverables Summary

| # | Deliverable | Type | Files |
|---|------------|------|-------|
| 1 | AI Vendor Evaluation skill | SKILL.md + 3 references + script | 5 files |
| 2 | HIPAA & PHI Governance skill | SKILL.md + 3 references | 4 files |
| 3 | AI Deployment Playbook skill | SKILL.md + 3 references | 4 files |
| 4 | Behavioral Health Clinical Safety skill | SKILL.md + 3 references | 4 files |
| 5 | EHR Integration Assessment skill | SKILL.md + 3 references | 4 files |
| 6 | Behavioral Health Safety Reviewer agent | SKILL.md | 1 file |
| 7 | Updated CLAUDE.md | Edit | 1 file |
| 8 | Updated skills/README.md | Edit | 1 file |
| 9 | Updated interview-prep SKILL.md | Edit | 1 file |
| 10 | Vendor eval example output | Generated XLSX | 1 file |
| 11 | Updated dashboard | Edit | 1 file |
| **Total** | | | **~27 files** |
