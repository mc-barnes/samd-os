# Test Fixtures for Regulatory Reviewer Agent

These are **deliberately broken** SaMD artifacts used to validate the `regulatory-reviewer` agent's detection capabilities. Each file contains realistic but non-compliant content designed to trigger specific findings.

## Purpose

- Verify the agent catches known regulatory gaps
- Regression-test after agent updates (SKILL.md changes, new review dimensions)
- Provide concrete examples of common submission deficiencies for onboarding

## How to Use

1. Run the regulatory-reviewer agent against any fixture file
2. Compare the agent's findings against the expected findings listed at the top of each file
3. All BLOCKER-level expected findings should appear in the agent's output
4. WARNING-level findings are desirable but not strictly required for a passing eval

## Fixtures

| File | Artifact Type | Key Deficiencies | Expected Verdict |
|------|--------------|------------------|-----------------|
| `prd-missing-intended-use.md` | PRD | No intended use, no contraindications, no named predicate, unjustified classification | NOT SUBMITTABLE |
| `requirements-no-traceability.md` | Software Requirements | No requirement IDs, no traceability, orphan requirement, missing acceptance criteria | NOT SUBMITTABLE |
| `soup-list-incomplete.md` | SOUP Register | Missing risk classifications, missing version, no verification dates, no monitoring cycle | NEEDS REVISION |
| `change-request-no-pccp.md` | Change Request | Misclassified severity, no risk impact analysis, no PCCP assessment, no V&V plan | NOT SUBMITTABLE |

## Expected Findings Format

Each fixture includes a YAML-style comment block after the frontmatter:

```markdown
# Expected findings:
# - BLOCKER: [description with standard/guidance reference]
# - WARNING: [description]
# - Expected verdict: NOT SUBMITTABLE | NEEDS REVISION
```

## Scoring a Run

A run is considered **passing** if:
- All expected BLOCKERs are detected (may be worded differently but must cover the same gap)
- The verdict matches or is more conservative than expected (e.g., NOT SUBMITTABLE when NEEDS REVISION was expected is acceptable)
- No false BLOCKERs are raised on compliant sections

A run is considered **failing** if:
- Any expected BLOCKER is missed
- The verdict is ACCEPTABLE when BLOCKERs exist
- The agent fabricates citations to standards or guidance documents

## Maintenance

Re-run these fixtures after any change to:
- `.claude/skills/agents/regulatory-reviewer/SKILL.md`
- Reference documents in `references/` (shared across all agents)
- Review framework dimensions or output format

Add new fixtures when:
- A new review dimension is added to the agent
- A real-world regulatory gap is discovered that the agent should catch
- Coverage for a specific artifact type is missing
