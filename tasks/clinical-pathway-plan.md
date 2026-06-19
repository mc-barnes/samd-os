---
type: plan
status: draft
owner: @Sterdb
project: clinical-pathway-designer
spec: ./clinical-pathway-designer-spec.md
created: 2026-05-03
---

# Clinical Pathway Designer — Build Plan

## Dependency Graph

```
T1 Directory scaffold
 └── T2 Reference files (3 files, parallel) ──────────────────┐
      ├── T2a sarcopenia-evidence-base.md                     │
      ├── T2b fhir-careplan-shape.md [verify TUG MCID, SNOMED]│
      └── T2c adherence-data.md                               │
           └── T3 SKILL.md skeleton ──────────────────────────┤
                └── T4 Sarcopenia example output (first draft)│
                     └── T5 SKILL.md complete ────────────────┤
                          └── T6 Output polish + checklist ───┤
                               └── T7 Ship decision ─────────┘
```

**Critical path:** T1 → T2 → T3 → T4 → T6 → T7

**Parallel opportunities:**
- T2a, T2b, T2c can all be written in parallel (no dependencies between reference files)
- T5 (SKILL.md complete) can happen in parallel with T6 (output polish) since they're different files

---

## Checkpoints

| After | Checkpoint | Gate Criteria |
|-------|-----------|---------------|
| T2 | **Reference Review** | All 3 reference files exist, evidence anchors match spec Section 5 exactly, TUG MCID verified, SNOMED code verified |
| T4 | **First Draft Review** | Sarcopenia output exists with all sections populated (rough prose OK). Both provider workflow and patient journey share ≥ 3 device data spine connections. FHIR JSON renders correctly. |
| T6 | **Ship Readiness** | Full verification checklist (spec Section 7) passes. All 5 failure modes (spec Section 7.5) tested negative. Read-aloud test passed (no stumbles). Non-FHIR reader can parse in < 5 min. |

---

## Tasks

### Phase 1: Foundation (Day 1, first hour)

#### T1: Create directory scaffold
**Deliverable:** Empty directory structure matching spec Section 3.

**Acceptance Criteria:**
- [ ] `.claude/skills/clinical-pathway-designer/` exists
- [ ] `.claude/skills/clinical-pathway-designer/references/` exists
- [ ] Structure matches spec Section 3 exactly

**Verify:** `ls -R .claude/skills/clinical-pathway-designer/`

---

### Phase 2: Reference Material (Day 1, hours 2-4)

#### T2a: Write sarcopenia evidence base reference
**Deliverable:** `references/sarcopenia-evidence-base.md` — structured synthesis of the research output.

**Acceptance Criteria:**
- [ ] All 6 evidence anchors (E1-E6) from spec Section 5 present with full citations
- [ ] Diagnostic criteria table (EWGSOP2 thresholds) included
- [ ] Training parameters table (intensity, frequency, duration, mode, muscle groups) included
- [ ] Literature gap finding (zero connected strength training device studies) explicitly stated
- [ ] Key effect sizes cited with confidence intervals: handgrip SMD 0.81, knee extension SMD 1.26, gait speed SMD 1.28, TUG SMD -0.93
- [ ] Explicit note: muscle mass outcomes NOT significant (SMM, ASMI, LLM all NS)
- [ ] ICFSR recommendation grade + evidence certainty stated: Strong, Moderate (+++)
- [ ] Content sourced from the three PDFs reviewed in prior session — not fabricated

**Verify:** Every claim in the file traces to a specific source. No unsourced statistics.

---

#### T2b: Write FHIR CarePlan shape reference
**Deliverable:** `references/fhir-careplan-shape.md` — 5-field subset rationale and structure.

**Acceptance Criteria:**
- [ ] 5 fields documented: addresses, goal, activity, careTeam, supportingInfo
- [ ] Each field has: FHIR R4 definition, why it was selected, what clinical question it answers
- [ ] Goal framing rationale: functional measures only, with Chen 2021 evidence for why not muscle mass
- [x] ~~**[VERIFY] TUG MCID**~~: **RESOLVED.** 3.4s was post-surgical lumbar (Gautschi 2017), not sarcopenic 65+. Updated to 0.9s — aligns with Chen 2021 WMD (-0.93s).
- [x] ~~**[VERIFY] SNOMED code**~~: **RESOLVED.** 229912004 = enteral tube feeding. Updated to 11816003 ("Diet education").
- [ ] Activity array structure documented: exercise therapy (primary) + protein supplementation (adjunct per ICFSR 4C)
- [ ] Cross-reference to existing fhir-builder skill references for CarePlan resource structure
- [ ] Plain-English preamble template included

**Verify:** JSON example in reference file parses as valid JSON. SNOMED/LOINC codes verified against external reference.

---

#### T2c: Write adherence data reference
**Deliverable:** `references/adherence-data.md` — supervised vs. unsupervised adherence synthesis.

**Acceptance Criteria:**
- [ ] Primary statistic: 72% → 43% adherence drop (Supervised vs. Unsupervised MA, n=2,830)
- [ ] Context: 34 studies, average age 72, intervention duration 4-52 weeks
- [ ] Supervised advantages quantified: knee extension SMD 0.18, gait speed SMD 0.29, lean mass +1.05 kg
- [ ] True adherence vs. attendance distinction noted (17-25% completed ≥75% of prescribed sessions)
- [ ] Patient barriers from ICFSR: cost, transportation, lack of support — with guideline reference
- [ ] Digital intervention adherence context: 85% (14/16 studies) reported high adherence in Berry 2025
- [ ] Connection to device thesis: home-connected device addresses all three ICFSR barriers

**Verify:** All statistics match the research output from the prior session.

> **CHECKPOINT: Reference Review** — All 3 files exist, evidence matches spec Section 5, TUG MCID resolved, SNOMED code resolved. Pause before proceeding.

---

### Phase 3: Skill Definition (Day 1, hours 4-5)

#### T3: Write SKILL.md skeleton
**Deliverable:** `SKILL.md` with complete structure, partial content.

**Acceptance Criteria:**
- [ ] Frontmatter: name (`clinical-pathway-designer`), version (`1.0.0`), description with all triggers from spec Section 2
- [ ] "When to Use" section — 3-4 bullet points
- [ ] "When NOT to Use" section — references other skills for out-of-scope work (fhir-builder for raw FHIR, risk-management for ISO 14971, prd-writer-samd for PRDs)
- [ ] Evidence anchors table (copy from spec Section 5)
- [ ] Boundaries section: always/ask first/never (copy from spec Section 6)
- [ ] Output format section: frontmatter schema, section structure
- [ ] Verification checklist (copy from spec Section 7)
- [ ] Reference files linked
- [ ] Placeholder for detailed instructions (to be completed in T5)

**Verify:** Skill triggers match spec Section 2 exactly. Boundaries match spec Section 6 exactly.

---

### Phase 4: First Draft Output (Day 1, hours 5-8)

#### T4: Generate sarcopenia example output (first draft)
**Deliverable:** `examples/clinical-pathway-sarcopenia-65plus.md` — complete first draft, rough prose acceptable.

This is the most important task. Completeness over polish. Every section populated, every citation placed, every device data touchpoint annotated. Prose quality can be rough — that's Day 2 work.

**Acceptance Criteria:**
- [ ] Frontmatter matches spec Section 4.1 schema — all fields populated
- [ ] **Section 1: Provider Workflow**
  - [ ] Clinical context: sarcopenia definition, prevalence (6-22% in 65+), EWGSOP2 criteria, literature gap
  - [ ] 6 provider workflow phases, each with: clinical actions, device data touchpoint [annotated], decision criteria
  - [ ] Phase 4 (Active Training) explicitly names progressive resistance loading as device capability + key moderator
  - [ ] FHIR CarePlan JSON block with 5 fields, matching spec Section 4.2.3 exactly
  - [ ] Plain-English preamble above JSON block
  - [ ] CarePlan goals: grip strength, gait speed, chair stand, TUG (MCID) — NO muscle mass
  - [ ] Activity array: exercise therapy + protein supplementation (ICFSR 4C)
  - [ ] Monitoring & adjustment triggers table (5 rows from spec Section 4.2.4)
- [ ] **Section 2: Patient Journey**
  - [ ] 6 patient journey phases, each with all 5 elements: touchpoints, data, drop-off risk, re-engagement, barriers
  - [ ] Phase 1: referral attrition framed as clinical knowledge (not unsourced percentage)
  - [ ] Phase 2: setup friction lead, 95% feasibility as enabler not contradiction
  - [ ] Phase 4: 72%→43% adherence delta cited with full context (n=2,830)
  - [ ] Every phase maps to ≥ 1 ICFSR barrier {cost, transportation, support}
- [ ] **Data spine test:** ≥ 3 device data elements appear in BOTH provider workflow and patient journey
  - [ ] Load progression data (provider: monitoring trigger → patient: micro-progress visibility)
  - [ ] Session compliance (provider: missed session alerts → patient: streak tracking)
  - [ ] Baseline strength metrics (provider: initial assessment → patient: onboarding calibration)
- [ ] All clinical claims trace to a source in spec Section 5

**Verify:** Read start to finish. Does it read as one artifact with two connected views, or two parallel lists? If parallel lists, add data spine connections before proceeding.

> **CHECKPOINT: First Draft Review** — Output exists with all sections. Data spine visible. FHIR JSON valid. Rough prose acceptable — polish is Day 2.

---

### Phase 5: Completion + Polish (Day 2)

#### T5: Complete SKILL.md with full instructions
**Deliverable:** Complete SKILL.md with detailed generation instructions.

**Acceptance Criteria:**
- [ ] Detailed instructions section: step-by-step how to generate a clinical pathway artifact
  - Step 1: Validate evidence base exists for the condition
  - Step 2: Generate clinical context (definition, prevalence, diagnostic criteria, literature gap)
  - Step 3: Build provider workflow (6 phases with device data annotations)
  - Step 4: Generate FHIR CarePlan (5 fields, preamble, functional goals)
  - Step 5: Build patient journey (6 phases with empirical anchors and barrier mapping)
  - Step 6: Verify data spine connections (≥ 3 shared device data elements)
- [ ] Sarcopenia-specific guidance section (condition-specific evidence, parameters, thresholds)
- [ ] Output format section fully specified (not just schema — full prose guidance)
- [ ] Failure modes from spec Section 7.5 included as anti-patterns
- [ ] All placeholder content from T3 replaced with final content

**Verify:** A reader could follow the SKILL.md instructions to generate a new pathway artifact for a different condition (given they had the evidence base).

---

#### T6: Polish output + run verification checklist
**Deliverable:** Polished `examples/clinical-pathway-sarcopenia-65plus.md` that passes all checks.

**Acceptance Criteria:**
- [ ] Prose quality: every paragraph is concrete, not hand-wavy. What data → what threshold → what action.
- [ ] Citation discipline: every evidence citation is followed by its design implication ("therefore, the pathway does X")
- [ ] Read-aloud test: read the full artifact aloud cold. No stumbles or sections that need explaining.
- [ ] **Verification checklist** (spec Section 7) — all items pass:
  - [ ] Frontmatter complete
  - [ ] 6 provider phases with device touchpoints
  - [ ] FHIR CarePlan: 5 fields, functional goals only, preamble present, protein in activity
  - [ ] 6 patient journey phases with all 5 elements
  - [ ] 72%→43% cited, ICFSR barriers mapped, all claims sourced
  - [ ] EWGSOP2 thresholds correct, training parameters match evidence
- [ ] **Failure mode test** (spec Section 7.5) — all 5 modes test negative:
  - [ ] NOT a generic template with keywords
  - [ ] Prose around FHIR JSON is specific (data → threshold → action)
  - [ ] Citations connected to design decisions (not just present)
  - [ ] Data spine visible (≥ 3 shared elements)
  - [ ] Drop-off risks are population-specific with named mitigations
- [ ] Non-FHIR reader can read in < 5 minutes

**Verify:** Have the artifact ready to point at in a screen conversation. Can you narrate the key insight (connected device gap) in 30 seconds?

---

### Phase 6: Ship Decision (Day 3)

#### T7: Ship decision + screen prep
**Deliverable:** Decision: ship or fix. If ship, final commit. If fix, specific failure modes identified.

**Acceptance Criteria:**
- [ ] Re-read artifact cold (first read of the day)
- [ ] Re-run failure mode test (spec Section 7.5)
- [ ] Verify all citations one more time
- [ ] Screen prep: rehearse the narrative
  - Opening: "I noticed the literature gap..." (30 seconds)
  - Key stats: 72%→43%, SMD 0.81-1.28, zero connected device studies, strong recommendation
  - Anticipated Q&A: other conditions, EHR integration, muscle mass
- [ ] If shipping: commit all files, verify repo structure
- [ ] If not shipping: identify specific failure modes, create targeted fix list for Day 4

**Verify:** Can you walk someone through the artifact in a 5-minute conversation without reading from it?

---

## Summary

| Task | Phase | Day | Depends On | Est. Size |
|------|-------|-----|-----------|-----------|
| T1: Directory scaffold | 1 | 1 | — | Small |
| T2a: Evidence base reference | 2 | 1 | T1 | Medium |
| T2b: FHIR CarePlan reference | 2 | 1 | T1 | Medium |
| T2c: Adherence data reference | 2 | 1 | T1 | Small |
| T3: SKILL.md skeleton | 3 | 1 | T2 | Medium |
| T4: Sarcopenia output (first draft) | 4 | 1 | T3 | Large |
| T5: SKILL.md complete | 5 | 2 | T4 | Medium |
| T6: Output polish + checklist | 5 | 2 | T4 | Medium |
| T7: Ship decision + screen prep | 6 | 3 | T5, T6 | Small |

**Critical path:** T1 → T2 → T3 → T4 → T6 → T7

**Parallel lanes:**
- Lane A: T2a, T2b, T2c (all three reference files)
- Lane B: T5 (SKILL.md complete) and T6 (output polish) can overlap on Day 2

**Build-time verifications (resolve in T2b):**
- TUG MCID: 1.4s vs 3.4s — verify for sarcopenic 65+ specifically
- SNOMED code: 229912004 — verify for protein supplementation advice
