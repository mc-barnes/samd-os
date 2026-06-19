---
type: plan
status: draft
owner: @Sterdb
project: voc-synthesizer
spec: ../SPEC.md
created: 2026-05-02
---

# VoC Synthesizer — Build Plan

## Dependency Graph

```
T1 Repo scaffold
 ├── T2 CLAUDE.md + domain config
 │    └── T3 Schema files (registry, input template, theme template)
 │         ├── T4 Synthetic inputs (20-30 files) ─────────────────┐
 │         │    ├── T5 Theme Extractor agent ◄────────────────────┤
 │         │    │    ├── T7 Severity Scorer agent                 │
 │         │    │    ├── T8 Bias Auditor agent                    │
 │         │    │    └── T9 Weekly Digest skill                   │
 │         │    │         └── T10 Example outputs + validation    │
 │         │    └────────────────────────────────────────────────  │
 │         └── T6 Transcript Cleaner skill (parallel with T5) ────┘
 └── T11 Agents README
```

**Critical path:** T1 → T2 → T3 → T4 → T5 → T7/T8 → T9 → T10

**Parallel opportunities:**
- T6 (Transcript Cleaner) can run in parallel with T5 (Theme Extractor) — both depend only on T3
- T7 (Severity Scorer) and T8 (Bias Auditor) can run in parallel — both depend only on T5
- T11 (Agents README) can run anytime after T5/T7/T8 are done

---

## Checkpoints

| After | Checkpoint | Gate Criteria |
|-------|-----------|---------------|
| T3 | **Schema Review** | Registry YAML validates, input template has all required fields, theme template matches spec Section 4.3 |
| T4 | **Input Distribution Review** | Inputs cover all 4 personas, 5+ channels, 4+ clients, dates across W14-W17. Intentional bias seeds present (Acme Corp concentration, W17 recency spike) |
| T5 | **Extraction Smoke Test** | Run extractor against example inputs. Verify: themes created, registry populated, quotes linked, no duplicates. This is the first "does the system work" gate |
| T9 | **Digest Format Review** | Generated digest matches spec Section 4.5 format exactly. WoW deltas calculate correctly. Bias flags surface inline |
| T10 | **End-to-End Validation** | Full panel run produces correct artifacts. All validation checklists from spec Section 7 pass |

---

## Tasks

### Phase 1: Foundation (T1-T3)

#### T1: Create repo scaffold
**Deliverable:** Empty repo at `~/voc-synthesizer` with directory structure from spec Section 3.

**Acceptance Criteria:**
- [ ] `git init` at `~/voc-synthesizer`
- [ ] Directory tree matches spec Section 3 exactly:
  ```
  .claude/skills/transcript-cleaner/
  .claude/skills/voc-weekly-digest/
  .claude/skills/agents/theme-extractor/references/
  .claude/skills/agents/severity-scorer/references/
  .claude/skills/agents/bias-auditor/references/
  inputs/
  themes/
  digests/
  audits/
  examples/inputs/
  examples/themes/
  examples/digests/
  examples/audits/
  ```
- [ ] `.gitignore` includes: `.DS_Store`, `*.swp`, `.env`
- [ ] Empty `.gitkeep` in leaf directories to preserve structure in git

**Verify:** `find ~/voc-synthesizer -type d | sort` matches expected tree.

---

#### T2: Write CLAUDE.md
**Deliverable:** Project root `CLAUDE.md` with full governance doc matching samd-os conventions.

**Acceptance Criteria:**
- [ ] Doc index section listing all folders and their purposes
- [ ] Domain Configuration section (spec Section 5) with personas, channels, severity-levels, kano-classes
- [ ] Document conventions section: frontmatter schema, type reference table, file naming rules, ID schemes, cross-reference syntax
- [ ] Boundaries section: Always / Ask First / Never (from spec Section 8)
- [ ] Skill and agent trigger table
- [ ] `currentDate` field set to today

**Verify:** CLAUDE.md is loadable by Claude Code and domain config is parseable YAML.

---

#### T3: Create schema files and templates
**Deliverable:** `_registry.yaml` (empty seed), `_INPUT_TEMPLATE.md`, `_THEME_TEMPLATE.md`

**Acceptance Criteria:**
- [ ] `themes/_registry.yaml` — empty registry with `next_id: 1`, empty `themes:` map, header comments explaining the schema
- [ ] `inputs/_INPUT_TEMPLATE.md` — template with all required/optional frontmatter fields from spec Section 4.1, with inline comments explaining each field and valid values
- [ ] `themes/_THEME_TEMPLATE.md` — template matching spec Section 4.3 structure with placeholder sections (Summary, Evidence, Kano, RICE, Bias Flags, Related)
- [ ] All templates include deletion instructions ("Remove this line after filling in")

**Verify:** Frontmatter in templates parses as valid YAML. Required fields match spec Section 6 table.

> **CHECKPOINT: Schema Review** — Pause for human review of registry schema, input template, and theme template before generating synthetic data.

---

### Phase 2: Synthetic Data (T4)

#### T4: Generate 25 synthetic input documents
**Deliverable:** 25 input files in `examples/inputs/` designed to produce ~7 known themes with intentional bias patterns.

**Design Intent:**
The inputs must be crafted to produce these known outcomes when run through the agent panel:
1. **THM-001: Urgent care coverage confusion** — ~10 mentions, heavily concentrated in Acme Corp (bias seed)
2. **THM-002: Surprise billing anxiety** — ~8 mentions, evenly distributed (control)
3. **THM-003: Plan structure change communication** — ~5 mentions, related to THM-001
4. **THM-004: Care Guide hold times** — ~4 mentions, care-guide persona dominated
5. **THM-005: Provider directory accuracy** — ~4 mentions, all in W17 (recency bias seed)
6. **THM-006: Mobile app navigation confusion** — ~3 mentions, all chat channel (channel skew seed)
7. **THM-007: Prescription coverage lookup** — ~3 mentions, emerging signal

**Distribution Requirements:**
| Dimension | Target | Actual (verify after generation) |
|-----------|--------|----------------------------------|
| Personas | member: 14, care-guide: 5, hr-admin: 3, broker: 2, prospect: 1 | |
| Channels | call-notes: 10, chat: 5, nps: 4, ticket: 3, qbr: 2, sales-call: 1 | |
| Clients | Acme Corp: 10, Beta Inc: 6, Gamma LLC: 5, Delta Health: 4 | |
| Weeks | W14: 4, W15: 5, W16: 6, W17: 10 | |

**Acceptance Criteria:**
- [ ] 25 files in `examples/inputs/`, all with valid frontmatter per spec Section 4.1
- [ ] Every required field populated; no placeholder values
- [ ] Content is realistic synthetic health benefits navigation feedback (not lorem ipsum)
- [ ] No real PHI/PII — all names, companies, providers are fictional
- [ ] File names follow convention: `{channel}-{date}-{nnn}.md`
- [ ] Bias seeds are verifiable: Acme Corp dominates THM-001, W17 dominates THM-005, chat dominates THM-006
- [ ] Distribution table filled in and matches targets (within +-1)

**Verify:** Count files, validate frontmatter with a grep sweep, check distribution with `grep -c` per dimension.

> **CHECKPOINT: Input Distribution Review** — Verify synthetic inputs have the right shape to test all agents before building them.

---

### Phase 3: Core Agent — Theme Extractor (T5)

#### T5: Write Theme Extractor agent
**Deliverable:** `SKILL.md` + `references/thematic-analysis.md` for the theme-extractor agent.

**Acceptance Criteria for SKILL.md:**
- [ ] Frontmatter: name, description (with trigger phrases), version
- [ ] "Your Background" section — qualitative research expertise persona (Braun & Clarke thematic analysis, mixed-methods research)
- [ ] Core Principles section covering:
  - Theme identification (latent vs. semantic)
  - Deduplication strategy (when are two mentions the same theme?)
  - Quote selection criteria (diversity across clients/personas)
  - Merge proposal discipline (propose, never auto-execute)
  - Registry update protocol (ID stability, weekly_counts, segment_distribution)
- [ ] Review Framework — how the extractor evaluates each input:
  1. Read input, identify candidate theme mentions
  2. Match against existing themes in registry (dedup)
  3. Create new theme if no match (assign next ID)
  4. Update counts, quotes, segment distribution
  5. Flag potential merges
  6. Mark input as `processed: true`
- [ ] Output Format matching spec Section 4.4 (Theme Extraction Report)
- [ ] Rules section (10 rules):
  - Never reuse theme IDs
  - Never auto-merge
  - Cap linked_quotes at 10 per theme
  - Prefer quote diversity over recency
  - Update registry and theme docs in same pass
  - Flag insufficient-data themes (<3 mentions)
  - Cite input source for every quote
  - Use ISO 8601 weeks for time-series
  - Read domain config from CLAUDE.md
  - All assignments are proposals pending human review

**Acceptance Criteria for references/thematic-analysis.md:**
- [ ] Braun & Clarke 6-phase methodology overview
- [ ] Adapted for VoC context (not academic research)
- [ ] Guidance on semantic vs. latent themes
- [ ] Deduplication heuristics: same root cause, same user need, or same product surface area
- [ ] Merge criteria: when two themes should become one vs. remain related

**Verify:** Run the extractor against `examples/inputs/`. Check that ~7 themes are created, registry is populated, no duplicate themes, quotes are linked.

> **CHECKPOINT: Extraction Smoke Test** — First end-to-end test of the core agent. Must produce reasonable themes from synthetic inputs before proceeding.

---

### Phase 3b: Transcript Cleaner (T6 — parallel with T5)

#### T6: Write Transcript Cleaner skill
**Deliverable:** `SKILL.md` for transcript-cleaner skill.

**Acceptance Criteria:**
- [ ] Frontmatter: name, description (with triggers: "clean transcript", "clean call notes"), version
- [ ] When to Use / When NOT to Use sections
- [ ] Processing steps:
  1. Accept raw text (pasted or file path)
  2. Identify and label speakers (if unlabeled, infer from context)
  3. Redact PII/PHI patterns (names → [MEMBER], SSN → [REDACTED], DOB → [REDACTED], phone → [REDACTED])
  4. Generate frontmatter: prompt user for persona, client, channel, date if not inferrable
  5. Output clean markdown file ready for `inputs/`
- [ ] Redaction patterns list (names, SSN, DOB, phone, email, MRN, address)
- [ ] Output format: markdown with valid input frontmatter + speaker-labeled body
- [ ] Sets `processed: false` in frontmatter
- [ ] Verification checklist: valid frontmatter, no PII leaks, speaker labels present

**Verify:** Clean a raw example transcript. Output has valid frontmatter, redacted PII, speaker labels.

---

### Phase 4: Scoring + Auditing (T7, T8 — parallel)

#### T7: Write Severity Scorer agent
**Deliverable:** `SKILL.md` + `references/kano-model.md` + `references/rice-scoring.md`

**Acceptance Criteria for SKILL.md:**
- [ ] Frontmatter with triggers ("score themes", "run severity scoring")
- [ ] Persona: product analytics / prioritization expert
- [ ] Core Principles — Two-Pass Methodology:
  - **Pass 1: Kano Classification** — Classify each theme as basic/performance/delighter/indifferent
    - Basic: absence causes dissatisfaction; presence is expected
    - Performance: more is better, linear relationship
    - Delighter: unexpected; absence OK, presence creates joy
    - Indifferent: no significant impact
  - **Pass 2: RICE Prioritization** — Score each theme independently
    - Reach: estimated number of users affected (from segment_distribution)
    - Impact: 1 (minimal) to 3 (massive) based on severity and Kano class
    - Confidence: percentage, reduced by bias flags
    - Effort: 1 (trivial) to 5 (major initiative), estimated from theme complexity
    - Formula: `(Reach * Impact * Confidence) / Effort / 8`
- [ ] Interaction with Bias Auditor: confidence is reduced when bias flags exist
- [ ] Skip rule: themes with <3 total mentions flagged as "insufficient data", not scored
- [ ] Output format matching spec Section 4.4 (Severity Scoring Report)
- [ ] Updates both `_registry.yaml` and individual theme docs
- [ ] Rules: 10 rules covering scoring discipline, formula correctness, Kano/RICE separation

**Acceptance Criteria for references/kano-model.md:**
- [ ] Kano model overview with the 5 categories
- [ ] Classification heuristics for VoC themes (not survey-based — adapted for qualitative data)
- [ ] Examples of each classification in health benefits context

**Acceptance Criteria for references/rice-scoring.md:**
- [ ] RICE framework overview
- [ ] Component scoring guides with scales
- [ ] Confidence adjustment rules (bias flags reduce confidence)
- [ ] Formula with worked example
- [ ] Common pitfalls (double-counting reach, inflating impact)

**Verify:** Run scorer against example themes. Kano classifications are reasonable. RICE scores calculate correctly per formula.

---

#### T8: Write Bias Auditor agent
**Deliverable:** `SKILL.md` + `references/response-bias.md`

**Acceptance Criteria for SKILL.md:**
- [ ] Frontmatter with triggers ("audit bias", "run bias audit")
- [ ] Persona: survey methodologist / research integrity expert
- [ ] Core Principles:
  - **Client concentration**: flag when >50% of a theme's mentions come from one client
  - **Recency bias**: flag when >80% of a theme's mentions are from the most recent week
  - **Channel skew**: flag when >70% of all inputs come from a single channel
  - **Persona imbalance**: flag when a persona is >3x overrepresented vs. expected mix
  - **Sample size**: flag themes with <5 mentions as low-confidence regardless of distribution
- [ ] Audit scope: reads `_registry.yaml` segment_distribution for per-theme checks, reads `inputs/` frontmatter for overall composition checks
- [ ] Output format matching spec Section 4.4 (Bias Audit Report) with:
  - Verdict (CLEAN / BIAS FLAGS RAISED)
  - Numbered findings (BA-nnn) with finding, risk, recommendation
  - "What Looks Sound" section
  - Sample Composition table
- [ ] Flags are advisory — the auditor recommends actions, does not veto or override scores
- [ ] Rules: 10 rules covering auditing discipline

**Acceptance Criteria for references/response-bias.md:**
- [ ] Overview of common biases in qualitative research (selection, recency, availability, survivorship, confirmation)
- [ ] Specific VoC biases: vocal minority, squeaky wheel, channel selection, escalation bias
- [ ] Threshold rationale: why 50%/80%/70% are the cutoffs
- [ ] Mitigation strategies per bias type

**Verify:** Run auditor against example themes. BA-001 (Acme concentration on THM-001), BA-002 (W17 recency on THM-005), BA-003 (channel skew) should all fire. THM-002 should be flagged as sound.

---

### Phase 5: Digest (T9)

#### T9: Write VoC Weekly Digest skill
**Deliverable:** `SKILL.md` for voc-weekly-digest skill.

**Acceptance Criteria:**
- [ ] Frontmatter with triggers ("weekly voc digest", "voc digest")
- [ ] When to Use / When NOT to Use
- [ ] Input requirements:
  - `themes/_registry.yaml` — for theme data, scores, distributions
  - `themes/THM-*.md` — for summaries and evidence
  - `audits/bias-audit-*.md` — for latest bias flags (optional — digest still works without)
  - `digests/digest-*.md` — prior digest for WoW delta calculation (optional for first run)
- [ ] Digest generation steps:
  1. Read registry, sort active themes by RICE score descending
  2. For each theme: render trend line, top quote, bias flags, roadmap status, recommended action
  3. Calculate WoW deltas: inputs processed, active themes, avg RICE, bias flags
  4. Identify emerging signals (<3 mentions, too early to score)
  5. Input gap analysis: which channels/personas are missing this period
  6. Render Bias Audit Summary table from latest audit
- [ ] Output format matching spec Section 4.5 exactly
- [ ] Frontmatter: type, period, generated, inputs-processed, themes-active, themes-new, bias-flags
- [ ] File naming: `digest-{year}-W{nn}.md`
- [ ] Verification checklist: all active themes present, RICE ranking correct, WoW deltas correct, bias flags surfaced

**Verify:** Generate digest from example data. Format matches spec Section 4.5. WoW deltas are mathematically correct.

> **CHECKPOINT: Digest Format Review** — The primary demo artifact must match spec format before proceeding to validation.

---

### Phase 6: Validation + Polish (T10, T11)

#### T10: Generate example outputs and run end-to-end validation
**Deliverable:** Populated `examples/` directory with reference outputs + validation report.

**Acceptance Criteria:**
- [ ] `examples/themes/_registry.yaml` — registry state after extraction from example inputs
- [ ] `examples/themes/THM-001.md` through `THM-007.md` — theme docs with summaries, evidence, scores
- [ ] `examples/digests/digest-2026-W18.md` — reference weekly digest
- [ ] `examples/audits/bias-audit-2026-W18.md` — reference bias audit report
- [ ] All validation checklists from spec Section 7 pass:
  - Theme Extractor: 7/7 checks
  - Severity Scorer: 5/5 checks
  - Bias Auditor: 5/5 checks
  - Weekly Digest: 5/5 checks
- [ ] End-to-end: running "synthesize feedback" against example inputs produces artifacts that match `examples/` directory

**Verify:** Diff generated output against expected output in `examples/`. Discrepancies are documented and justified.

---

#### T11: Write Agents README
**Deliverable:** `.claude/skills/agents/README.md` — agent index and routing guide.

**Acceptance Criteria:**
- [ ] Agent table with name, version, domain, triggers
- [ ] Scope boundaries: which agent owns what (no overlap)
- [ ] Orchestration order for full panel run
- [ ] Artifact routing: which input types go to which agents
- [ ] Output format summary per agent
- [ ] Disclaimer: AI-generated, human review required

**Verify:** README accurately describes all 3 agents and their relationships.

> **CHECKPOINT: End-to-End Validation** — Full panel run against example inputs produces correct artifacts. Ship it.

---

## Summary

| Task | Phase | Depends On | Est. Size |
|------|-------|-----------|-----------|
| T1: Repo scaffold | 1 | — | Small |
| T2: CLAUDE.md | 1 | T1 | Medium |
| T3: Schema files | 1 | T2 | Small |
| T4: Synthetic inputs (25) | 2 | T3 | Large |
| T5: Theme Extractor agent | 3 | T3, T4 | Large |
| T6: Transcript Cleaner skill | 3b | T3 | Medium |
| T7: Severity Scorer agent | 4 | T5 | Large |
| T8: Bias Auditor agent | 4 | T5 | Large |
| T9: Weekly Digest skill | 5 | T5, T7, T8 | Medium |
| T10: Example outputs + validation | 6 | T9 | Medium |
| T11: Agents README | 6 | T5, T7, T8 | Small |

**Parallel lanes:**
- Lane A: T1 → T2 → T3 → T4 → T5 → T7 → T9 → T10 (critical path)
- Lane B: T3 → T6 (joins after T3)
- Lane C: T5 → T8 (parallel with T7)
- Lane D: T8 → T11 (parallel with T9)
