---
type: plan
status: draft
owner: @Sterdb
project: aiml-readiness-assessor
spec: ./aiml-readiness-assessor-spec.md
created: 2026-05-04
---

# AI/ML SaMD Readiness Assessor — Build Plan

## Dependency Graph

```
T1 Directory scaffold + heuristic schema
 ├── T2 Scoring rubric + thresholds (parallel)
 ├── T3 Pathway router (parallel)
 └── T4 Heuristic YAML files — all 4 axes (parallel)
      │
      ├── T2 ──┐
      ├── T3 ──┤
      └────────┴── T5 SKILL.md (orchestration doc — references T1-T4)
                    └── T6 Example output (full gap report)
                         └── T7 End-to-end validation + polish
```

**Critical path:** T1 → T4 → T5 → T6 → T7
**Parallel opportunities:** T2, T3, T4 are independent after T1

---

## Checkpoints

| After | Checkpoint | Gate Criteria |
|-------|-----------|---------------|
| T1 | **Schema Review** | `_schema.md` fully specifies heuristic shape, all match logic types documented, YAML example validates |
| T4 | **Heuristic Completeness Review** | ≥3 heuristics per axis, all 5 match_logic types exercised, starter set from §8 present, at least 2 `cross_reference_missing` heuristics |
| T5 | **SKILL.md Dry-Run** | Mentally trace: intake → scan → findings → scores → pathway → output. No dead ends, all references resolve |
| T7 | **End-to-End Validation** | Example output is internally consistent: findings → scores → pathway all align. Ready for `/review-arch` |

---

## Tasks

### Phase 1: Foundation (T1)

#### T1: Create directory scaffold + heuristic schema reference

**Deliverable:** Directory structure from spec §10 + `heuristics/_schema.md` documenting the full heuristic interface.

**Acceptance Criteria:**
- [ ] Directory tree created:
  ```
  .claude/skills/aiml-readiness-assessor/
  ├── heuristics/
  ├── scoring/
  ├── router/
  └── examples/
  ```
- [ ] `heuristics/_schema.md` contains:
  - Full `Heuristic` interface from spec §4 (adapted as a reference doc, not TypeScript)
  - All 5 `MatchLogic` types with descriptions and YAML examples for each
  - `SearchScope` closed enum — all 8 values with exact XLSX sheet + column header bindings (from spec §4)
  - Multi-artifact `match_logic` convention: when `artifact_types` lists >1 type, `match_logic` is an array with OR semantics
  - `FalsePositiveGuard` structure with examples
  - `SeverityPromotion` rules (ceiling constraints, when promotion activates)
  - `Finding` object structure (output of a triggered heuristic)
  - Primary-axis tagging convention from spec §5 (inline, not a separate file)
  - Intake condition syntax for gating
  - Malformed-input handling reference (pointer to spec §3)
- [ ] Schema uses YAML examples (not TypeScript) since heuristics are authored in YAML

**Verify:** Read `_schema.md` — every field in the spec §4 interface is documented with a concrete YAML example.

> **CHECKPOINT: Schema Review** — Validate that the schema is complete and unambiguous before authoring heuristics.

---

### Phase 2: Reference Components (T2, T3, T4 — parallel)

#### T2: Write scoring rubric + thresholds

**Deliverable:** `scoring/rubric.md` + `scoring/thresholds.md`

**Acceptance Criteria for `rubric.md`:**
- [ ] All 4 axes with Level 1-5 definitions (from spec §6)
- [ ] Each level has a one-line summary (for output template) AND a detailed description (for scoring guidance)
- [ ] Axis-specific calibration notes (what "Level 5" looks like in practice for each axis)
- [ ] Calibration source disclosure: "Based on FDA PCCP Guidance §VII.B.1-4"

**Acceptance Criteria for `thresholds.md`:**
- [ ] Finding-density decision tree from spec §6 (all 7 steps)
- [ ] Hard-cap rule: ≥1 critical → Level 2
- [ ] Exhaustiveness proof preserved as comments
- [ ] Coverage adjustment rules:
  - `not_assessed` heuristics don't count toward thresholds
  - `coverage_note` append rules
  - Minimum viable scan (at least one artifact type present)
- [ ] Edge case examples (3+ from spec §6)
- [ ] Axis-specific calibration guidance (low heuristic count adjustment)

**Verify:** Trace the scoring examples from spec §6 through the decision tree. Confirm they produce the stated level.

---

#### T3: Write pathway router

**Deliverable:** `router/pathways.md`

**Acceptance Criteria:**
- [ ] Decision tree from spec §7 — all 7 steps with first-match-wins semantics
- [ ] Input variables defined: `min_level`, `max_level`, `has_critical_cap`, `learning_type`, `regulatory_status`
- [ ] Each step has:
  - Condition (as a boolean expression)
  - Recommendation text (exact wording from spec)
  - Rationale (why this pathway is appropriate)
- [ ] Totality guarantee commentary preserved
- [ ] Modifier table: 3 conditions with appended text
- [ ] Modifier stacking rules (what if multiple modifiers apply)
- [ ] Worked examples: trace 3 different maturity profiles through the tree

**Verify:** Trace all 7 decision tree paths. Confirm no unreachable conditions. Confirm modifiers append correctly.

---

#### T4: Author heuristic YAML files (all 4 axes)

**Deliverable:** 4 YAML files containing ≥15 heuristics total (≥3 per axis minimum).

**Acceptance Criteria:**

**`heuristics/data-management.yaml`** (≥4 heuristics):
- [ ] DM-CRIT-001: Training data sources unspecified (from spec §8 — `keyword_absence`)
- [ ] DM-MIN-001: Dataset version not pinned in SOUP register (from spec §8 — `version_unpin`)
- [ ] DM-MAJ-001: No representativeness analysis (new — `keyword_absence`)
- [ ] DM-MAJ-002: Training data referenced but not validated (new — `cross_reference_missing`)

**`heuristics/retraining.yaml`** (≥4 heuristics):
- [ ] RT-CRIT-002: No retraining trigger criteria (from spec §8 — `keyword_absence`)
- [ ] RT-MAJ-001: No model versioning protocol (new — `keyword_absence`)
- [ ] RT-MAJ-002: Retraining defined but no rollback procedure (new — `cross_reference_missing`)
- [ ] RT-MIN-001: No automated pipeline validation (new — `keyword_absence`)

**`heuristics/performance-evaluation.yaml`** (≥4 heuristics):
- [ ] PE-MAJ-001: No subgroup performance analysis (from spec §8 — `keyword_absence`)
- [ ] PE-MIN-002: No statistical analysis plan pre-specified (from spec §8 — `keyword_absence`)
- [ ] PE-MAJ-002: Bias testing methodology absent (new — `keyword_absence`)
- [ ] PE-CRIT-001: No ML-specific validation methodology (new — `column_absence`)

**`heuristics/update-monitoring.yaml`** (≥4 heuristics):
- [ ] UM-MAJ-002: No drift detection mechanism (from spec §8 — `keyword_absence`, multi-artifact: design-controls + risk-management FMEA)
- [ ] UM-MAJ-001: No post-deployment monitoring plan (new — `keyword_absence`)
- [ ] UM-MIN-001: No user notification protocol for model updates (new — `pattern_absence`)
- [ ] UM-MAJ-003: Monitoring defined but no re-validation trigger linked (new — `cross_reference_missing`)

**Cross-cutting requirements:**
- [ ] All 5 match_logic types exercised across the set: `keyword_absence` (≤50% of total, i.e. ≤8 of 16), `version_unpin` (≥1), `column_absence` (≥1), `cross_reference_missing` (≥3), `pattern_absence` (≥1)
- [ ] All `search_scope` values use the closed enum from spec §4 (`design_inputs_requirements`, `verification_validation_combined`, etc.) — no free-form strings
- [ ] Multi-artifact heuristics use `match_logic` array with one entry per declared `artifact_type`
- [ ] Each heuristic conforms to `_schema.md` structure
- [ ] Primary-axis tagging follows §5 convention (activity-whose-absence, not subject-matter domain)
- [ ] `severity_promotion.ceiling: "critical"` used on ≤2 heuristics with explicit patient-harm justification
- [ ] Intake conditions gate retraining heuristics on `learning_type ∈ {batch-retrained, continuous}`
- [ ] False-positive guards present where applicable (locked model suppression, non-clinical output)

**Verify:** Count heuristics per axis (≥3 each, ≥15 total). Verify keyword_absence ≤50%. Verify all 5 match types present. Check no ceiling:"critical" on >2 heuristics. Verify every multi-artifact heuristic has match_logic entries covering all declared artifact_types.

> **CHECKPOINT: Heuristic Completeness Review** — Validate coverage, match type diversity, and axis balance before writing SKILL.md.

---

### Phase 3: Orchestration (T5)

#### T5: Write SKILL.md

**Deliverable:** The main skill definition file — triggers, instructions, scan procedure, output template.

**Acceptance Criteria:**

**Frontmatter:**
- [ ] `name: aiml-readiness-assessor`
- [ ] `description:` with trigger phrases: "AI/ML readiness", "PCCP readiness", "AI compliance gaps", "ML regulatory assessment"
- [ ] `version: 1.0.0`

**When to Use / When NOT to Use:**
- [ ] When: scanning existing artifacts for AI/ML gaps, pre-submission readiness, PCCP pathway determination
- [ ] When NOT: initial design controls (use `design-controls`), risk from scratch (use `risk-management`), EU AI Act, startup with no artifacts

**Structured Intake:**
- [ ] All 8 fields from spec §2 with types and valid values
- [ ] Validation rules: fields 1-6 required, field 7 defaults to false, field 8 must resolve to ≥1 artifact
- [ ] Error messages for precondition failures (not gap reports — exits with error)

**Scan Procedure (step-by-step instructions for Claude):**
- [ ] Step 1: Validate intake fields
- [ ] Step 2: Resolve `artifact_paths` — identify artifact types (design-controls XLSX, risk-management XLSX, SOUP register MD/XLSX). Apply malformed-input handling per spec §3: missing sheets/columns → `not_assessed`, unreadable files → `not_assessed` with error reason.
- [ ] Step 3: For each artifact, read relevant sheets/sections by column header (not position):
  - Design controls XLSX:
    - `Design_Inputs` sheet → col C (header: `Requirement`) — primary scan target for `design_inputs_requirements` scope
    - `Verification` sheet → cols C-D (headers: `Test Protocol`, `Pass Criteria`) — scan target for `verification_test_protocol` scope
    - `Validation` sheet → cols C-D (headers: `Validation Method`, `Acceptance Criteria`) — scan target for `validation_method` scope
    - Combined scope `verification_validation_combined` = union of Verification + Validation columns above
  - Risk management XLSX:
    - `Hazard_Identification` sheet → cols B-E (headers: `Hazard`, `Hazardous Situation`, `Harm`, `Sequence of Events`) — scan target for `hazard_identification` scope
    - `Risk_Controls` sheet → col C (header: `Control Measure`) — scan target for `risk_controls` scope
    - `FMEA` sheet → cols B-D (headers: `Failure Mode`, `Effect`, `Cause`) — scan target for `fmea_failure_modes` scope
  - SOUP register (XLSX or MD):
    - XLSX: `SOUP_Register` sheet → all text columns, specifically `Version` (col C) and `Known Anomalies Reviewed` (col J) for `version_unpin` checks
    - MD: text-based scan only; `version_unpin` heuristics marked `not_assessed` (no structured columns)
- [ ] Step 4: For each applicable heuristic (filtered by intake conditions + artifact availability):
  - Check false-positive guards → suppress if matched
  - Execute match logic → emit Finding if triggered
  - Apply severity promotion if `decision_autonomy` qualifies
- [ ] Step 5: Compute maturity scores per axis (reference `scoring/thresholds.md`)
- [ ] Step 6: Run pathway router (reference `router/pathways.md`)
- [ ] Step 7: Generate output markdown using template

**Output Template:**
- [ ] Full template from spec §9 embedded in SKILL.md
- [ ] Frontmatter schema documented
- [ ] All 6 sections: Device Context, Scan Summary, Findings, Maturity Profile, Pathway Recommendation, Remediation Roadmap

**Boundaries:**
- [ ] Always/Ask First/Never from spec §12 (verbatim)
- [ ] Cross-reference to invariants from spec preamble

**References section:**
- [ ] Pointers to all sub-files: `heuristics/_schema.md`, `heuristics/*.yaml`, `scoring/rubric.md`, `scoring/thresholds.md`, `router/pathways.md`
- [ ] Source documents: FDA PCCP Guidance, AI/ML Action Plan, IMDRF N67, ISO 14971, IEC 62304

**Verify:** Mentally trace a complete invocation: intake → validate → scan → match heuristics → emit findings → score → route → output. No dead ends.

> **CHECKPOINT: SKILL.md Dry-Run** — Trace full execution path through SKILL.md. All references resolve, no ambiguity.

---

### Phase 4: Example + Validation (T6, T7)

#### T6: Write example gap report

**Deliverable:** `examples/example-output.md` — a complete, internally-consistent gap report demonstrating all output sections.

**Acceptance Criteria:**
- [ ] Realistic device context (e.g., a hypothetical SpO2 AI triage device)
- [ ] Intake values that exercise:
  - `learning_type: batch-retrained` (exercises retraining heuristics)
  - `decision_autonomy: output-clinical-drive` (exercises severity promotion)
  - `regulatory_status: pre-submission`
- [ ] Scan summary showing partial coverage (design-controls + risk-management, no SOUP register) to demonstrate `coverage: partial` handling
- [ ] Findings section with:
  - ≥1 critical finding (with hard-cap demonstrated)
  - ≥2 major findings (at least 1 promoted, 1 not promoted)
  - ≥2 minor findings
  - ≥1 not-assessed heuristic (gated by missing SOUP)
- [ ] Maturity profile with scores traceable to findings via decision tree
- [ ] Pathway recommendation matching the maturity profile per router logic
- [ ] Remediation roadmap with all findings prioritized
- [ ] Frontmatter with all required fields
- [ ] Footer with skill version and date

**Verify:** Manually trace: count findings per axis → apply decision tree → confirm levels match. Confirm pathway matches min_level + modifiers.

---

#### T7: End-to-end validation + polish

**Deliverable:** Validation pass across all files + any corrections needed.

**Acceptance Criteria:**
- [ ] Cross-reference integrity: every heuristic ID in YAML files matches `_schema.md` conventions
- [ ] SKILL.md references all sub-files by correct relative path
- [ ] Example output is internally consistent (findings → scores → pathway all align)
- [ ] No dead-end references (every `see X` actually exists)
- [ ] Scoring decision tree in `thresholds.md` produces correct levels for the example
- [ ] Router decision tree in `pathways.md` produces correct pathway for the example
- [ ] Severity promotion in example correctly applies ceiling rules
- [ ] Coverage adjustment in example correctly handles missing SOUP register
- [ ] All 6 starter heuristics from spec §8 are present and match spec exactly
- [ ] Heuristic count per axis is ≥3
- [ ] All 5 match_logic types are exercised, keyword_absence ≤50%
- [ ] All `search_scope` values use the closed enum from spec §4
- [ ] **Artifact-type coverage invariant:** For every heuristic that declares multiple `artifact_types`, verify that (a) `match_logic` is an array with entries covering each declared type, and (b) the SKILL.md scan procedure includes sheets/columns for each declared type. This invariant would have caught B3 (FMEA sheet omission) pre-build.
- [ ] Malformed-input handling: SKILL.md scan procedure references spec §3 degradation rules (missing sheets → `not_assessed`, column mismatch → `not_assessed`, unreadable file → `not_assessed`)
- [ ] SKILL.md triggers don't overlap with existing skills (check `change-impact`, `design-controls`, `risk-management`)

**Verify:** Full read-through of all 10 files. Fix any inconsistencies found.

> **CHECKPOINT: End-to-End Validation** — All files consistent, example verifiable, ready for `/review-arch`.

---

## Summary

| Task | Phase | Depends On | Est. Size | Files |
|------|-------|-----------|-----------|-------|
| T1: Scaffold + schema | 1 | — | Medium | 1 dir structure + `_schema.md` |
| T2: Scoring rubric + thresholds | 2 | T1 | Medium | `rubric.md` + `thresholds.md` |
| T3: Pathway router | 2 | T1 | Small | `pathways.md` |
| T4: Heuristic YAMLs (4 axes) | 2 | T1 | Large | 4 YAML files, ≥15 heuristics |
| T5: SKILL.md | 3 | T2, T3, T4 | Large | 1 file (main orchestration) |
| T6: Example output | 4 | T5 | Medium | `example-output.md` |
| T7: Validation + polish | 4 | T6 | Small | Edits across all files |

**Parallel lanes:**
- Lane A (critical): T1 → T4 → T5 → T6 → T7
- Lane B: T1 → T2 (joins at T5)
- Lane C: T1 → T3 (joins at T5)

**Total files:** 10 (SKILL.md + _schema.md + 4 YAMLs + rubric.md + thresholds.md + pathways.md + example-output.md)
