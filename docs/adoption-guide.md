---
type: onboarding
status: draft
owner: "@mc-barnes"
last-reviewed: 2026-04-30
related:
  - docs/responsible-use.md
  - docs/auditor-briefing.md
  - CONTRIBUTING.md
---
# Adoption Guide

For product leaders evaluating SaMD Team OS for their team.

## Who Runs This

| Role | How they use it | Frequency |
|------|----------------|-----------|
| **Product Manager** | Writes PRDs using the SaMD PRD skill, runs regulatory-reviewer on drafts before RA handoff | Per PRD or feature spec |
| **Regulatory Affairs** | Reviews agent findings, runs design-controls and risk-management skills, validates agent output against submission requirements | Per submission cycle |
| **Quality / QA** | Runs qa-reviewer on CAPA records, complaint files, and management review minutes; uses change-impact skill for change requests | Per CAPA, per change request |
| **Engineering** | References SOUP register template, runs safety-reviewer on risk analysis updates, uses FHIR builder for integration work | Per release cycle |

**The typical flow**: PM drafts in samd-os → runs agent review → fixes findings → hands off to RA/QA for human review → approved artifact goes into eQMS as the controlled record.

## Where It Fits

```
┌─────────────────────────────────────────────────┐
│  Working environment (samd-os)                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │ Draft    │→ │ Agent    │→ │ Revised  │──────→│ eQMS (controlled record)
│  │ artifact │  │ review   │  │ draft    │      ││ Greenlight Guru / MasterControl / Qualio
│  └──────────┘  └──────────┘  └──────────┘      │
│                                                 │
│  Also: Jira/Confluence for task tracking        │
└─────────────────────────────────────────────────┘
```

SaMD Team OS is a **draft layer** that feeds your existing systems:

- **vs. Jira/Confluence**: samd-os is where artifacts are authored and pre-reviewed. Jira tracks the work items; Confluence may hold meeting notes. samd-os holds the artifact content that eventually becomes a controlled record.
- **vs. eQMS (Greenlight Guru, MasterControl, Qualio)**: samd-os outputs are uncontrolled drafts. When a draft passes human review, it gets uploaded to your eQMS with proper document control (approval signatures, revision history, Part 11 compliance). samd-os never replaces the eQMS.
- **vs. GitHub**: samd-os lives in a Git repo. You get version history, branching, and diffs for free — useful for tracking draft evolution, but not a substitute for eQMS document control.

## Team Structure

### Single team (recommended starting point)
One repo per product. The PM, RA specialist, and QA lead all work in the same repo. Customize the root `CLAUDE.md` with your team roster, device context, and standards baseline.

### Multiple feature teams
Each product or device gets its own fork. Shared elements (agent SKILLs, reference docs) can be pulled from an upstream `samd-os` fork. Team-specific content (PRDs, risk records, submission packages) stays in the product repo.

### Shared services model
A central RA/QA team maintains the agent SKILLs and reference docs in a shared repo. Product teams fork and add their product-specific content. Agent updates flow downstream via git merge.

## Cost

Agent reviews use the Claude API. Costs scale with artifact length and number of agents invoked.

| Operation | Estimated Cost | Notes |
|-----------|---------------|-------|
| Single agent review | $0.05 – $0.15 | One agent reviewing one artifact |
| Full review panel (5 agents) | $0.25 – $0.75 | All agents in parallel on one artifact |
| Eval run (20 fixtures) | ~$2.00 | Validation suite, run after SKILL.md changes |
| Weekly team usage (5 artifacts/week, panel review) | $5 – $15/month | Typical for a small team |

Costs depend on artifact length, model pricing (which changes over time), and response verbosity. These are estimates based on current Claude API pricing as of April 2026.

For context: a single RA review cycle that catches a missing intended use statement after submission prep has already started costs far more in rework than a year of agent API calls.

## Organizational Prep

Before rolling out to your team, address these:

### 1. QMS documentation (required for regulated teams)

Your quality system likely needs a procedure or work instruction covering AI tool usage. Options:

- **Add a section to an existing SOP** (e.g., Document Control SOP, Design Control SOP) describing samd-os as a pre-review screening tool with human review required before document approval
- **Create a new work instruction**: "Use of AI Tools in Support of QMS Activities" — scope, approved tools, human accountability, validation requirements, re-validation triggers

The [Responsible Use](responsible-use.md) doc provides the content; your QMS team wraps it in your SOP template.

### 2. Validation evidence (recommended)

Before your QA lead signs off on adoption:

1. Run the eval suite (`./scripts/eval-agents.sh all`) and review results
2. Have your RA/QA lead manually review 3-5 agent outputs against the same artifacts
3. Document the comparison in a validation summary (agreement rate, false positives, missed findings)
4. Define re-validation triggers: SKILL.md changes, model version updates, standards updates

See [Responsible Use — Validation Approach](responsible-use.md#validation-approach) for details.

### 3. Access and permissions

- samd-os requires [Claude Code](https://claude.com/claude-code) with API access
- Team members who run agent reviews need API credentials
- Consider a shared API key with usage tracking, or individual keys with a spend cap

### 4. Training (30 minutes)

- What samd-os is and isn't (10 min) — draft layer, not eQMS, not sign-off
- How to run a skill and an agent review (10 min) — live demo
- How to interpret findings and verdicts (10 min) — what BLOCKER vs. WARNING means, when to push back on a finding

## Getting Started Checklist

- [ ] Fork the repo and customize `CLAUDE.md` (team roster, device context, standards)
- [ ] Run `./scripts/eval-agents.sh --dry-run all` to verify fixture integrity
- [ ] Have one PM draft a PRD using the SaMD PRD skill
- [ ] Run the regulatory-reviewer on that PRD and compare findings to RA feedback
- [ ] Decide: adopt, customize further, or defer
- [ ] If adopting: update QMS documentation, run validation, train the team

## What This Doesn't Cover

- **eQMS migration**: samd-os doesn't import from or export to your eQMS. Copy-paste or file upload is the interface.
- **CI/CD integration**: No automated hooks into build pipelines. Agent reviews are manual (invoke via Claude Code).
- **Multi-language support**: Agent SKILLs and findings are English-only.
- **EU MDR / IVDR specifics**: Agent standards baselines are FDA-focused. EU teams will need to add notified body expectations and MDR-specific requirements to agent SKILLs.
