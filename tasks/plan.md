# Implementation Plan: PM OS — Eleanor Health Customization

## Dependency Graph

```
Phase 1: Prompt-based skills (independent, parallelizable)
  ├── T1: Clinical Safety skill (references → SKILL.md)
  ├── T2: HIPAA Governance skill (references → SKILL.md)
  ├── T3: AI Deployment Playbook skill (references → SKILL.md)
  ├── T4: EHR Integration skill (references → SKILL.md)
  └── T5: Behavioral Health Safety Reviewer agent (SKILL.md)

  ── CHECKPOINT 1: Review 4 prompt-based skills + agent ──

Phase 2: Script-based skill
  └── T6: AI Vendor Eval skill (references → SKILL.md → script → example XLSX)

  ── CHECKPOINT 2: Review vendor eval skill + run script ──

Phase 3: Configuration updates (depends on Phase 1 + 2)
  ├── T7: Update CLAUDE.md (add Eleanor Health context + triggers + boundaries)
  ├── T8: Update skills/README.md (add new category, install commands)
  ├── T9: Update interview-prep SKILL.md (Eleanor Health domain)
  └── T10: Update dashboard/pm-os.html (add new skills to table)

  ── CHECKPOINT 3: Final review — all files consistent ──
```

## Why This Order

1. **Prompt-based skills first** — they're independent of each other, follow the same pattern (SKILL.md + 3 references), and are the fastest to build. Can be parallelized.
2. **Agent persona with Phase 1** — it's just a SKILL.md, no dependencies, mirrors clinical-reviewer format.
3. **Vendor eval in Phase 2** — it's the most complex deliverable (Python script + XLSX generation). Isolating it means we can checkpoint the simpler work first.
4. **Config updates last** — CLAUDE.md, README, interview-prep, and dashboard all need to reference the new skills. Building them last ensures accuracy.

## Task Details

### T1: Behavioral Health Clinical Safety Skill
**Slice**: `skills/eleanor-health/clinical-safety/` (4 files)

**Files**:
- `references/crisis-escalation-protocols.md` — Behavioral health crisis indicators, 3-tier escalation (immediate danger → elevated risk → routine), warm handoff requirements, documentation standards
- `references/scope-of-practice-boundaries.md` — AI agent boundaries in behavioral health, state-by-state considerations for multi-state ops, SAMHSA guidance references
- `references/ai-transparency-requirements.md` — FTC AI disclosure guidance, state AI transparency laws, recommended disclosure language for voice/SMS
- `SKILL.md` — Frontmatter + When to Use + When NOT to Use + Safety Requirements Framework (6 sections per spec) + Verification Checklist

**Acceptance criteria**:
- [ ] YAML frontmatter with `name: clinical-safety` and trigger phrases
- [ ] 6-section safety framework matches spec (crisis detection, scope, de-escalation, consent, guardrails, monitoring)
- [ ] References cite actual regulatory sources (SAMHSA, FTC, state laws)
- [ ] Verification checklist has ≥5 items
- [ ] No overlap with existing SaMD skill triggers

**Verify**: Read each file, confirm format matches `risk-management/SKILL.md` pattern

---

### T2: HIPAA & PHI Governance Skill
**Slice**: `skills/eleanor-health/hipaa-governance/` (4 files)

**Files**:
- `references/hipaa-ai-controls.md` — PHI safeguards for LLM/AI (prompt logging, data residency, model training opt-out, re-identification risk)
- `references/42cfr-part2-summary.md` — 42 CFR Part 2 key provisions, consent requirements, QSOA, exceptions, 2024 rule changes
- `references/internal-ai-policy-template.md` — Employee AI usage policy template (approved tools, PHI rules, prohibited uses, reporting)
- `SKILL.md` — Frontmatter + 6-section governance framework per spec

**Acceptance criteria**:
- [ ] YAML frontmatter with `name: hipaa-governance` and trigger phrases
- [ ] 42 CFR Part 2 content is accurate (cite actual CFR sections)
- [ ] Internal AI policy template is actionable (not just headers)
- [ ] HIPAA AI controls address LLM-specific risks (not generic HIPAA)
- [ ] Verification checklist has ≥5 items

**Verify**: Read each file, confirm 42 CFR Part 2 references cite real provisions

---

### T3: AI Deployment Playbook Skill
**Slice**: `skills/eleanor-health/ai-deployment-playbook/` (4 files)

**Files**:
- `references/use-case-prioritization.md` — Scoring framework for AI use cases (transcript analysis, call analysis, data entry, scheduling, lead conversion, pre-visit data)
- `references/adoption-metrics.md` — KPIs for AI adoption (DAU, task completion, time saved, error reduction, NPS), healthcare benchmarks
- `references/training-program-template.md` — Role-based training structure (clinical, ops, leadership), prompt engineering basics, PHI dos/don'ts
- `SKILL.md` — Frontmatter + 6-section deployment plan template per spec

**Acceptance criteria**:
- [ ] YAML frontmatter with `name: ai-deployment-playbook` and trigger phrases
- [ ] Use case prioritization includes all 6 Eleanor Health initiatives from JD
- [ ] Adoption metrics are measurable (not vague)
- [ ] Training template covers 4 audience tiers
- [ ] Verification checklist has ≥5 items

**Verify**: Read each file, confirm use cases match JD (outbound lead conversion, pre-visit data, transcript/call analysis, scheduling optimization)

---

### T4: EHR Integration Assessment Skill
**Slice**: `skills/eleanor-health/ehr-integration/` (4 files)

**Files**:
- `references/athenahealth-api-overview.md` — Key athenahealth API endpoints (patient, appointment, clinical, billing), auth model, rate limits, sandbox/prod, known limitations
- `references/tech-stack-map.md` — Eleanor Health tech stack reference: athenahealth, Salesforce, telephony, data warehouse, ops platform — integration points and data ownership
- `references/integration-decision-tree.md` — Decision tree: FHIR R4 vs HL7v2 vs REST vs flat file vs manual, based on data type/frequency/capability
- `SKILL.md` — Frontmatter + 6-section integration assessment template per spec

**Acceptance criteria**:
- [ ] YAML frontmatter with `name: ehr-integration` and trigger phrases
- [ ] athenahealth API overview references real API capabilities (not fabricated endpoints)
- [ ] Tech stack map matches JD description exactly
- [ ] Decision tree covers realistic integration scenarios
- [ ] Verification checklist has ≥5 items

**Verify**: Read each file, confirm athenahealth references are grounded (publicly documented APIs)

---

### T5: Behavioral Health Safety Reviewer Agent
**Slice**: `skills/agents/behavioral-health-safety-reviewer/` (1 file)

**Files**:
- `SKILL.md` — Persona definition mirroring `clinical-reviewer/SKILL.md` structure: background, principles, 6-dimension review framework, output format, rules

**Acceptance criteria**:
- [ ] Follows `clinical-reviewer` SKILL.md format exactly (frontmatter, background, principles, review framework, output format, rules)
- [ ] 6 review dimensions match spec (crisis safety, scope compliance, de-escalation, consent, PHI handling, handoff)
- [ ] Verdict format: SAFE / CONDITIONAL / UNSAFE
- [ ] Rules section has ≥5 rules
- [ ] Persona is grounded in behavioral health expertise (not generic)

**Verify**: Side-by-side comparison with `clinical-reviewer/SKILL.md` to confirm structural match

---

### CHECKPOINT 1
**Gate**: Review T1-T5 deliverables before proceeding.
- All 5 SKILL.md files follow consistent frontmatter format
- No trigger phrase collisions between new skills or with existing SaMD skills
- Reference files are standalone (no cross-references to SKILL.md)
- Directory structure matches spec Section 5

---

### T6: AI Vendor Evaluation Skill (Script-Based)
**Slice**: `skills/eleanor-health/ai-vendor-eval/` (5 files)

**Files**:
- `references/evaluation-framework.md` — Weighted scoring methodology, category definitions, decision thresholds (>4.0 proceed, 3.0-4.0 conditional, <3.0 reject)
- `references/hipaa-vendor-checklist.md` — BAA requirements, PHI handling standards, breach notification, subcontractor obligations
- `references/integration-patterns.md` — Integration patterns for athenahealth (FHIR R4, HL7v2, flat file), Salesforce (REST, Apex), telephony (SIP, WebRTC)
- `SKILL.md` — Frontmatter + Quick Start (CLI commands) + 7-sheet XLSX structure + Reference Files section + Verification Checklist
- `scripts/generate_vendor_eval.py` — Python XLSX generator (~400-600 lines)

**Script requirements** (following `generate_design_controls.py` pattern):
- Imports: `openpyxl`, `argparse`, stdlib only
- Same styling constants: #1F4E79 headers, white bold text, thin borders, auto-width
- `get_eleanor_example()` — Pre-filled example for AI voice agent vendor evaluation
- `get_blank_scaffold(vendor_name, category)` — Minimal template with one row per sheet
- 7 sheet builder functions (one per sheet from spec)
- Data validation dropdowns: Yes/No/Partial, Must/Should/Nice, High/Med/Low, Acceptable/Conditional/Reject
- Conditional formatting: Green (Yes/Must/High/Acceptable), Red (No/Reject), Yellow (Partial/Conditional)
- COUNTIF summary formulas on Evaluation Summary sheet
- CLI: `--vendor`, `--category`, `--example eleanor`
- Output: `output/vendor-eval-{vendor-slug}.xlsx`

**Acceptance criteria**:
- [ ] Script runs without errors: `python generate_vendor_eval.py --example eleanor`
- [ ] Generated XLSX has all 7 sheets with correct headers
- [ ] Data validation dropdowns work in Excel/Google Sheets
- [ ] Conditional formatting renders correctly
- [ ] Auto-width produces readable columns
- [ ] Example data is realistic (Eleanor Health AI voice agent context)
- [ ] Blank scaffold works: `--vendor "Test" --category "sms-agent"`
- [ ] SKILL.md matches `risk-management/SKILL.md` format (frontmatter, quick start, sheet structure, references, checklist)

**Verify**: Run script, open generated XLSX, inspect each sheet

---

### CHECKPOINT 2
**Gate**: Vendor eval script runs, XLSX is well-formatted.
- Run `python generate_vendor_eval.py --example eleanor` — no errors
- Open output XLSX — verify 7 sheets, formatting, dropdowns
- Copy generated XLSX to `examples/vendor-eval-example.xlsx`

---

### T7: Update CLAUDE.md
**Slice**: Edit existing file (1 file)

**Changes**:
- Add `### Eleanor Health AI` table to Skills Available (5 skills with triggers and outputs)
- Add `behavioral-health-safety-reviewer` to Agent Personas table
- Add Eleanor Health Context block (below existing SaMD Context)
- Add Eleanor Health-specific boundaries (Always/Never) below existing boundaries

**Acceptance criteria**:
- [ ] All 5 new skills listed with correct triggers and outputs
- [ ] New agent listed with correct use case
- [ ] Eleanor Health Context block matches spec Section 4.1
- [ ] Boundaries don't conflict with existing SaMD boundaries
- [ ] Existing SaMD content unchanged

**Verify**: Read CLAUDE.md, confirm all new skills are referenced with accurate trigger phrases

---

### T8: Update skills/README.md
**Slice**: Edit existing file (1 file)

**Changes**:
- Add `### eleanor-health/` category header and table (5 skills)
- Add behavioral-health-safety-reviewer to agents table
- Add installation commands for Eleanor Health skills
- Add vendor eval script command to "Generating Artifacts" section
- Update skill structure diagram to show PM skills can have references too

**Acceptance criteria**:
- [ ] New category table matches format of existing tables
- [ ] Installation commands are correct paths
- [ ] Vendor eval CLI command is accurate
- [ ] Total skill count is accurate
- [ ] Existing content unchanged

**Verify**: Read README.md, confirm install commands would work

---

### T9: Update Interview Prep SKILL.md
**Slice**: Edit existing file (1 file)

**Changes**:
- Add `## Eleanor Health Domain Context` section with:
  - Role context (Senior PM AI, behavioral health, AI vendor management)
  - Company context (addiction treatment, multi-state, value-based care)
  - Tech context (athenahealth, Salesforce, Claude Enterprise, AI voice/SMS)
- Add STAR story templates for 6 themes from spec
- Add Eleanor Health-specific research prompts
- Update SaMD signal feedback dimension to also include "AI PM signal" and "healthcare AI signal"

**Acceptance criteria**:
- [ ] Eleanor Health section doesn't break existing SaMD interview prep flow
- [ ] 6 STAR story templates are specific and actionable (not generic)
- [ ] Research prompts reference real aspects of Eleanor Health (from JD)
- [ ] Feedback dimensions expanded to cover AI PM competencies

**Verify**: Read SKILL.md, confirm both SaMD and Eleanor Health modes work

---

### T10: Update Dashboard
**Slice**: Edit existing file (1 file)

**Changes**:
- Add Eleanor Health skills to the skill reference table
- Add behavioral-health-safety-reviewer to agents section
- Add Eleanor Health context summary

**Acceptance criteria**:
- [ ] New skills appear in dashboard skill table
- [ ] Trigger phrases match SKILL.md frontmatter
- [ ] Dashboard renders correctly in browser

**Verify**: Open `dashboard/pm-os.html` in browser, confirm new entries visible

---

### CHECKPOINT 3: Final Consistency Review
**Gate**: All files reference each other correctly.
- [ ] CLAUDE.md skill triggers match each SKILL.md frontmatter
- [ ] README.md skill list matches directory structure (`ls -R skills/`)
- [ ] No trigger phrase collisions across all skills
- [ ] Dashboard matches CLAUDE.md and README.md
- [ ] Interview prep references Eleanor Health consistently
- [ ] Example XLSX is in `examples/`
- [ ] All new directories follow naming convention (lowercase, hyphens)

## Estimated Scope
- **Phase 1**: 5 tasks, ~17 files (4 skills × 4 files + 1 agent × 1 file)
- **Phase 2**: 1 task, ~5 files + 1 generated example
- **Phase 3**: 4 tasks, 4 file edits
- **Total**: 10 tasks, ~27 files
