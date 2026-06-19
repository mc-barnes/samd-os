---
type: todo
status: draft
project: voc-synthesizer
plan: ./plan.md
created: 2026-05-02
---

# VoC Synthesizer — Task List

## Phase 1: Foundation

- [ ] **T1: Create repo scaffold** — `git init` at `~/voc-synthesizer`, directory tree from spec Section 3, `.gitignore`, `.gitkeep` in leaf dirs
  - Blocked by: nothing
  - Blocks: T2

- [ ] **T2: Write CLAUDE.md** — Doc index, domain config (personas/channels/severity/kano), conventions (frontmatter, naming, IDs, cross-refs), boundaries (always/ask first/never), skill+agent triggers
  - Blocked by: T1
  - Blocks: T3

- [ ] **T3: Create schema files** — `themes/_registry.yaml` (empty seed), `inputs/_INPUT_TEMPLATE.md`, `themes/_THEME_TEMPLATE.md`. All with inline docs
  - Blocked by: T2
  - Blocks: T4, T5, T6

> **CHECKPOINT: Schema Review** — validate registry YAML, input template fields, theme template structure

## Phase 2: Synthetic Data

- [ ] **T4: Generate 25 synthetic inputs** — In `examples/inputs/`. 4 personas, 6 channels, 4 clients, dates W14-W17. Bias seeds: Acme concentration, W17 recency, chat channel skew. Realistic health benefits content
  - Blocked by: T3
  - Blocks: T5

> **CHECKPOINT: Input Distribution Review** — verify persona/channel/client/week counts match targets

## Phase 3: Core Agents

- [ ] **T5: Write Theme Extractor agent** — `SKILL.md` (persona, principles, framework, output format, 10 rules) + `references/thematic-analysis.md` (Braun & Clarke adapted for VoC)
  - Blocked by: T3, T4
  - Blocks: T7, T8, T9, T10, T11

- [ ] **T6: Write Transcript Cleaner skill** — `SKILL.md` (PII redaction, speaker labeling, frontmatter generation, output format)
  - Blocked by: T3
  - Blocks: nothing (parallel with T5)

> **CHECKPOINT: Extraction Smoke Test** — run extractor against examples, verify ~7 themes created

## Phase 4: Scoring + Auditing

- [ ] **T7: Write Severity Scorer agent** — `SKILL.md` (two-pass: Kano then RICE, skip <3 mentions) + `references/kano-model.md` + `references/rice-scoring.md`
  - Blocked by: T5
  - Blocks: T9, T10

- [ ] **T8: Write Bias Auditor agent** — `SKILL.md` (concentration >50%, recency >80%, channel >70%, persona imbalance) + `references/response-bias.md`
  - Blocked by: T5
  - Blocks: T9, T10

## Phase 5: Digest

- [ ] **T9: Write VoC Weekly Digest skill** — `SKILL.md` (RICE-ranked themes, WoW deltas, bias flags inline, input gap analysis, emerging signals)
  - Blocked by: T5, T7, T8
  - Blocks: T10

> **CHECKPOINT: Digest Format Review** — generated digest matches spec Section 4.5 exactly

## Phase 6: Validation + Polish

- [ ] **T10: Generate example outputs + validation** — Populate `examples/` with reference registry, themes, digest, audit. Run all validation checklists from spec Section 7
  - Blocked by: T9
  - Blocks: nothing

- [ ] **T11: Write Agents README** — Agent index, scope boundaries, orchestration order, artifact routing, output formats
  - Blocked by: T5, T7, T8
  - Blocks: nothing

> **CHECKPOINT: End-to-End Validation** — full panel run against examples produces correct artifacts

---

## Parallel Execution Map

```
Week 1:  T1 ── T2 ── T3 ──┬── T4 ──┬── T5 ──┬── T7 ──┐
                            │        │        └── T8 ──┤── T9 ── T10
                            └── T6   │               └── T11
                                     └─ (checkpoint)
```
