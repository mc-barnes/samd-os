---
type: todo
status: draft
project: aiml-readiness-assessor
plan: ./aiml-readiness-assessor-plan.md
spec: ./aiml-readiness-assessor-spec.md
created: 2026-05-04
---

# AI/ML SaMD Readiness Assessor — Task List

## Phase 1: Foundation

- [ ] **T1: Create directory scaffold + heuristic schema** — Directory tree from spec §10. `heuristics/_schema.md` with full interface reference (all 5 match types, `SearchScope` closed enum with column bindings, guards, promotion, multi-artifact match_logic convention, finding object, axis-tagging convention). YAML examples throughout.
  - Blocked by: nothing
  - Blocks: T2, T3, T4

> **CHECKPOINT: Schema Review** — validate _schema.md is complete and unambiguous

## Phase 2: Reference Components (parallel)

- [ ] **T2: Write scoring rubric + thresholds** — `scoring/rubric.md` (4 axes × 5 levels, one-line + detailed descriptions, calibration notes) + `scoring/thresholds.md` (7-step decision tree, hard-cap, coverage adjustment, edge case examples)
  - Blocked by: T1
  - Blocks: T5

- [ ] **T3: Write pathway router** — `router/pathways.md` (7-step decision tree, modifier table, stacking rules, 3 worked examples, totality guarantee)
  - Blocked by: T1
  - Blocks: T5

- [ ] **T4: Author heuristic YAMLs (4 axes)** — 4 files, ≥15 heuristics total (≥3/axis). 6 starter heuristics from spec §8 + ≥9 new. All 5 match_logic types exercised, keyword_absence ≤50%. Multi-artifact heuristics use match_logic arrays. All search_scope values from closed enum. ≤2 `ceiling: "critical"`. Intake gating on retraining. FP guards for locked/non-clinical.
  - Blocked by: T1
  - Blocks: T5

> **CHECKPOINT: Heuristic Completeness Review** — validate coverage, match type diversity, axis balance

## Phase 3: Orchestration

- [ ] **T5: Write SKILL.md** — Triggers, When to Use, intake schema (8 fields + validation), scan procedure (7 steps with exact column bindings per spec §4 SearchScope enum), malformed-input degradation per spec §3, output template (6 sections from §9), boundaries (§12), references to all sub-files.
  - Blocked by: T2, T3, T4
  - Blocks: T6

> **CHECKPOINT: SKILL.md Dry-Run** — trace full execution path, all references resolve

## Phase 4: Example + Validation

- [ ] **T6: Write example gap report** — `examples/example-output.md`. Realistic device (SpO2 AI triage). Exercises: severity promotion, hard-cap, partial coverage, not-assessed heuristics, modifier text. Internally consistent (findings → scores → pathway align).
  - Blocked by: T5
  - Blocks: T7

- [ ] **T7: End-to-end validation + polish** — Cross-ref integrity, decision tree traceable through example, all 10 files consistent, no dead references, trigger non-overlap with existing skills. **Artifact-type coverage invariant:** verify every multi-artifact heuristic has match_logic entries and scan procedure coverage for all declared artifact_types.
  - Blocked by: T6
  - Blocks: nothing

> **CHECKPOINT: End-to-End Validation** — ready for `/review-arch`

---

## Parallel Execution Map

```
T1 (scaffold + schema)
 ├── T2 (scoring) ─────────┐
 ├── T3 (router) ───────────┤── T5 (SKILL.md) ── T6 (example) ── T7 (validation)
 └── T4 (heuristics) ──────┘
```

## Post-Build Gates

After T7 completes:
1. `/review-arch` — architecture review before investing in polish
2. `/review-code` — five-axis quality check on all files
3. Ship decision
