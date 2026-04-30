---
type: decision
status: draft
owner: "@mc-barnes"
last-reviewed: 2025-04-30
related:
  - .claude/skills/agents/regulatory-reviewer/SKILL.md
  - .claude/skills/agents/clinical-reviewer/SKILL.md
  - .claude/skills/agents/qa-reviewer/SKILL.md
---
# Decision: DEC-001 — Review Panel Orchestration

## Context

With three agent personas now shipping (clinical-reviewer, regulatory-reviewer, qa-reviewer), the natural next layer is a fan-out orchestration skill that runs multiple reviewers against an artifact in parallel and synthesizes findings into a single review package. This was noted as future work in the regulatory-reviewer spec ("Not the review-panel fan-out skill — that will be spec'd separately") and risks being lost without a tracked decision record.

## Options Considered

| Option | Pros | Cons | Regulatory Impact |
|--------|------|------|-------------------|
| A: Single fan-out skill that dispatches to all agents | Simple, one command | May be slow, all-or-nothing | None — orchestration only |
| B: Configurable panel (select which reviewers to include) | Flexible, faster for targeted reviews | More complex to implement | None |
| C: Defer — keep manual agent invocation | Zero implementation cost | Loses cross-reviewer synthesis, easy to skip a reviewer | Risk of incomplete reviews |

## Decision

[Pending — to be decided when implementation is prioritized]

## Consequences

- **Product**: Enables one-command regulatory review across all dimensions
- **Regulatory**: Reduces risk of missing a review dimension when multiple agents exist
- **Engineering**: Requires agent orchestration pattern (parallel dispatch + result merge)

## Action Items

- [ ] Spec the orchestration skill when prioritized
- [ ] Define output format for merged review findings
- [ ] Decide on conflict resolution when agents disagree on severity

## Participants

[TBD]
