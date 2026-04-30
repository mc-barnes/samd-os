# PM OS — Claude Code Configuration

## Who This Is For
Product managers using Claude Code who want AI-powered PM workflows. Includes general-purpose PM skills for any industry, plus specialized skills for SaMD regulatory work, AI product management, and behavioral health.

## Skills Available

### Core PM (`skills/pm-core/`)
| Skill | Trigger | Output |
|-------|---------|--------|
| PRD Writer | "general PRD", "product spec", "feature requirements", "feature spec", "PRD for [product]" | Markdown PRD |
| Metrics Definition | "define metrics", "success metrics", "KPIs", "how do we measure", "north star metric", "OKRs" | Markdown metrics framework |
| Decision Doc | "decision doc", "write a decision document", "document this decision", "RFC", "design decision", "ADR" | Markdown decision record |
| Status Update | "write a status update", "weekly update", "stakeholder update", "exec summary", "project status" | Markdown status report |
| Research Synthesis | "synthesize research", "research synthesis", "summarize interviews", "user research summary", "interview findings" | Markdown research summary |
| Competitive Analysis | "competitive analysis", "competitor analysis", "competitive landscape", "comp analysis", "market analysis" | Markdown competitive report |
| Feature Prioritization | "prioritize features", "feature prioritization", "what should we build next", "backlog prioritization", "RICE scoring" | Markdown ranked backlog |
| Roadmap Planning | "plan a roadmap", "product roadmap", "quarterly plan", "what should we build this quarter" | Markdown roadmap |

### SaMD Regulatory (`skills/samd-regulatory/`)
| Skill | Trigger | Output |
|-------|---------|--------|
| Design Controls | "design controls", "traceability matrix", "IEC 62304", "user needs" | XLSX traceability matrix |
| Risk Management | "risk management", "ISO 14971", "FMEA", "hazard analysis" | XLSX risk analysis |
| FHIR Builder | "FHIR resource", "FHIR bundle", "HL7v2 to FHIR" | JSON FHIR bundle |
| Change Impact | "change impact", "software change", "re-verification scope" | XLSX change impact report |
| Design Review | "design review", "PDR", "CDR", "FDR", "GO/NO-GO gate" | XLSX + narrative |

### SaMD PM (`skills/samd-pm/`)
| Skill | Trigger | Output |
|-------|---------|--------|
| PRD Writer (SaMD) | "write PRD", "product requirements" | Markdown PRD |
| Interview Prep | "interview prep", "STAR stories" | Structured prep doc |
| Networking Outreach | "networking", "outreach message" | Personalized outreach |

### Eleanor Health AI (`skills/eleanor-health/`)
| Skill | Trigger | Output |
|-------|---------|--------|
| AI Vendor Evaluation | "vendor eval", "AI vendor", "scorecard", "pilot design", "vendor assessment", "vendor go/no-go" | XLSX vendor scorecard |
| HIPAA & PHI Governance | "HIPAA", "PHI", "BAA", "data governance", "42 CFR Part 2", "SUD confidentiality" | Markdown governance framework |
| AI Deployment Playbook | "AI rollout", "adoption strategy", "Claude deployment", "internal AI", "AI training", "use case prioritization" | Markdown deployment plan |
| Behavioral Health Clinical Safety | "clinical safety", "crisis protocol", "crisis escalation", "de-escalation", "scope of practice" | Markdown safety requirements |
| EHR Integration Assessment | "EHR integration assessment", "athenahealth", "data flow", "API integration" | Markdown integration assessment |

### Agent Personas (`skills/agents/`)
| Agent | Use Case |
|-------|----------|
| Clinical Reviewer | Neonatal SpO2 clinical logic review, alarm management, handoff quality |
| `behavioral-health-safety-reviewer` | Behavioral health AI safety review, crisis escalation, scope compliance, PHI handling, handoff quality |

## Workflow Router

### Triage
Assess task size before diving in:
- **Small** (1-2 files, <50 lines, no new APIs): Just do it → `/review-code` when done
- **Medium** (3-5 files, new logic or UI): `/spec` → `/plan` → `/build` → `/review-code`
- **Large** (new feature, multi-system, API changes): `/spec` → `/plan` → `/review-arch` → `/build` → `/review-code` → `/ship`

### Phase Prompts
After completing each phase, prompt the user with the next step:
- After `/spec` → "Spec is ready. Want me to `/plan` the tasks?"
- After `/plan` → "Tasks are broken down. Run `/review-arch` before building, or go straight to `/build`?"
- After `/build` → "Implementation complete. Running `/review-code`..."
- After `/review-code` → "Code review passed. Is this shipping? If so, run `/ship`?"

### Early-Stage Detection
Route vague requests to ideation:
- Vague idea, no clear direction → suggest `ideate`
- Multiple directions to explore → suggest `/concept-gen`
- Clear direction, needs UI → suggest `/rapid_prototype`
- Clear direction, needs spec → suggest `/spec`

## SaMD Context
Customize this section for your regulatory environment:

```
Device classification: [Class II / Class III]
Predicate device: [predicate or De Novo]
Standards: [IEC 62304, ISO 14971, ISO 13485, IEC 62366]
Clinical domain: [e.g., neonatal monitoring, cardiac, respiratory]
Submission type: [510(k) / De Novo / PMA]
Quality system: [e.g., ISO 13485 certified, FDA QSR]
```

## Eleanor Health Context

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

## Boundaries

### Always
- Confirm approach BEFORE implementing — never start coding without explicit approval
- Check if a skill matches the task before starting work — suggest it first
- Check design controls impact for any clinical logic change
- Cite standards (IEC 62304, ISO 14971) when making regulatory claims
- Run `/review-code` after any non-trivial implementation
- Start with the simplest explanation first
- Check HIPAA implications for any AI deployment touching PHI
- Require BAA for any AI vendor processing PHI
- Verify crisis escalation protocols before any member-facing AI launch
- Cite HIPAA / 42 CFR Part 2 when making compliance claims

### Never
- Skip risk analysis for safety-related changes
- Commit without review
- Push to main without approval
- Make assumptions about regulatory requirements — ask or check the standard
- Add features not explicitly requested
- Deploy AI that handles PHI without a BAA in place
- Skip clinical safety review for member-facing AI
- Assume AI can handle crisis situations without human escalation
- Share SUD treatment records without 42 CFR Part 2 compliant consent

## How to Customize
1. Copy this repo to your machine
2. Copy skills you need to `~/.claude/skills/`
3. Replace `[placeholders]` in this file with your project details
4. Add your own skills to `skills/` as needed

See `skills/README.md` for detailed installation instructions.
