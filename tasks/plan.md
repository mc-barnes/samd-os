# Build Plan: Core PM Skills

## Architecture

All 8 skills are independent prompt-based SKILL.md files. No cross-references, no shared code, no runtime dependencies. Each follows the identical structure defined in SPEC.md §4.

**Dependency graph**: None — all 8 are leaf nodes. The spec's "build order" is conceptual (which skills reference each other's *concepts*), not technical. We batch for speed.

**Integration points**:
- `CLAUDE.md` — add `pm-core` skills table (after all 8 are built)
- `skills/README.md` — add `pm-core` category (after all 8 are built)

## Batching Strategy

Two batches of 4 skills each (ordered by spec priority within each batch), then one integration task. Each batch can be built in a single session since the pattern is uniform.

---

## Tasks

### Batch 1: Foundation Skills (Tasks 1-4)

The most commonly used PM deliverables — what a new PM reaches for first.

**Task 1: prd-writer**
- Create `skills/pm-core/prd-writer/SKILL.md`
- Sections: Overview, User Stories, Requirements, User Flow, Success Metrics, Scope, Open Questions
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.1 exactly
  - [ ] Trigger phrases don't collide with `prd-writer-samd`
  - [ ] "When NOT to Use" redirects to `prd-writer-samd` for regulated products
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

**Task 2: metrics-definition**
- Create `skills/pm-core/metrics-definition/SKILL.md`
- Sections: North Star, Input Metrics, Guardrail Metrics, Metric Definitions, Targets, Anti-Metrics
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.6 exactly
  - [ ] Anti-metrics section is mandatory (not optional)
  - [ ] Instructions push PM to pick ONE North Star
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

**Task 3: decision-doc**
- Create `skills/pm-core/decision-doc/SKILL.md`
- Sections: Decision, Context, Options Considered, Recommendation, What We're Giving Up, Reversibility, Next Steps
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.7 exactly
  - [ ] Instructions require ≥2 real options
  - [ ] "What We're Giving Up" is mandatory
  - [ ] Reversibility assessment included
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

**Task 4: status-update**
- Create `skills/pm-core/status-update/SKILL.md`
- Sections: Status (color + summary), Key Updates, Decisions Needed, Risks, Next Week
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.2 exactly
  - [ ] Status color is FIRST line of output
  - [ ] Decisions Needed includes options + recommendation
  - [ ] Template fits 1 page when filled
  - [ ] All 6 verification checks present

### Checkpoint 1
Review all 4 skills for consistency — same frontmatter format, same section order, same verification checklist style. Fix drift before Batch 2.

---

### Batch 2: Analysis & Strategy Skills (Tasks 5-8)

These require more PM context (research data, competitor info, feature lists) and produce analytical outputs.

**Task 5: research-synthesis**
- Create `skills/pm-core/research-synthesis/SKILL.md`
- Sections: Research Overview, Key Findings (with evidence + confidence), Patterns, Surprises, Implications, Raw Data Summary
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.3 exactly
  - [ ] Instructions: never fabricate quotes
  - [ ] Confidence levels required on every finding
  - [ ] Surprises section is mandatory (even if "none")
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

**Task 6: competitive-analysis**
- Create `skills/pm-core/competitive-analysis/SKILL.md`
- Sections: Market Context, Competitor Profiles, Feature Comparison, Strategic Insights, Implications
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.4 exactly
  - [ ] Instructions: flag unverified data with `[Verify]`
  - [ ] Each competitor must have a weakness listed
  - [ ] Implications are specific product actions
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

**Task 7: feature-prioritization**
- Create `skills/pm-core/feature-prioritization/SKILL.md`
- Sections: Framework choice, Feature scoring table, Tier Summary, Dependencies, Recommendation
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.5 exactly
  - [ ] Default framework is RICE
  - [ ] At least one feature must land in "Don't Build"
  - [ ] Instructions push back on inflated scores
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

**Task 8: roadmap-planning**
- Create `skills/pm-core/roadmap-planning/SKILL.md`
- Sections: Vision, Strategic Pillars, Now/Next/Later, What We're NOT Doing, Dependencies & Risks
- Acceptance criteria:
  - [ ] Follows SPEC.md §5.8 exactly
  - [ ] "Now" limited to ≤5 items
  - [ ] "What We're NOT Doing" is mandatory
  - [ ] Now/Next/Later has decreasing specificity
  - [ ] Template fits 1-2 pages when filled
  - [ ] All 6 verification checks present

### Checkpoint 2
Review all 8 skills for cross-batch consistency. Verify no trigger phrase collisions across all skills (pm-core + existing).

---

### Integration (Tasks 9-10)

**Task 9: Update CLAUDE.md**
- Add `### Core PM (skills/pm-core/)` section to Skills Available
- Add table with all 8 skills: name, triggers, output format
- Update "Who This Is For" to include general PM use
- Acceptance criteria:
  - [ ] New table matches format of existing SaMD/Eleanor tables
  - [ ] All 8 skills listed with correct trigger phrases
  - [ ] Existing sections unchanged

**Task 10: Update skills/README.md**
- Add `### pm-core/ — Core PM Skills` category
- Add table with all 8 skills
- Add install command: `cp -r skills/pm-core/* ~/.claude/skills/`
- Acceptance criteria:
  - [ ] New category table matches existing format
  - [ ] Installation instructions work
  - [ ] Existing categories unchanged

### Checkpoint 3 (Final)
- [ ] 8 SKILL.md files exist in `skills/pm-core/*/`
- [ ] CLAUDE.md has pm-core section
- [ ] README.md has pm-core category
- [ ] No trigger phrase collisions
- [ ] All verification checklists present
- [ ] Ready for `/review-code`

---

## Estimated Effort

| Phase | Tasks | Files |
|-------|-------|-------|
| Batch 1 | 4 skills | 4 SKILL.md files |
| Batch 2 | 4 skills | 4 SKILL.md files |
| Integration | 2 edits | CLAUDE.md + README.md |
| **Total** | **10 tasks** | **10 files** |

Single session build — all skills follow the same pattern.
