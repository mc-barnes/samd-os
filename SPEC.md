# SPEC: Core PM Skills

## 1. Objective

Build 8 general-purpose PM skills that fill the "Layer 1: Core PM" gap in PM OS. Every PM does these tasks weekly regardless of industry. These skills make PM OS immediately useful to enterprise PMs at Basic/Unacceptable AI fluency — before they ever touch the SaMD or AI PM layers.

**Target user**: Enterprise PMs who barely use AI, at any company, in any industry.

**What changes**:
- Add 8 new skills under `skills/pm-core/`
- Update `CLAUDE.md` with new skill triggers
- Update `skills/README.md` with new category
- Update dashboard with new task cards (deferred — separate dashboard redesign)

**What stays**: All existing skills (SaMD regulatory, SaMD PM, Eleanor Health AI) remain unchanged.

---

## 2. Design Decisions

### Output Depth: Actionable (1-2 pages)
Each skill produces a focused, immediately usable document — not a comprehensive template. A PM should use the output as-is or with light editing. If they want depth, they ask Claude to expand specific sections.

### Industry Context: Agnostic + Optional Healthcare
Each skill works for any PM at any company. An optional `## If Regulated / Healthcare` section provides hooks for regulated industries. Clearly marked and skippable.

### No Scripts, No References
Pure prompt-based skills. Each skill is a single `SKILL.md` file — no Python scripts, no `references/` directories, no XLSX output. Markdown output only.

---

## 3. Project Structure

```
skills/pm-core/
├── prd-writer/SKILL.md
├── status-update/SKILL.md
├── research-synthesis/SKILL.md
├── competitive-analysis/SKILL.md
├── feature-prioritization/SKILL.md
├── metrics-definition/SKILL.md
├── decision-doc/SKILL.md
└── roadmap-planning/SKILL.md
```

---

## 4. Skill Structure Convention

Each SKILL.md follows this pattern:

```markdown
---
name: [skill-name]
description: >
  [One-paragraph description with trigger phrases.]
---

# [Skill Title]

## Purpose
[One sentence.]

## When to Use
- [3-5 bullets]

## When NOT to Use
- [2-3 bullets redirecting to other pm-core skills AND existing skills where relevant]

## Quick Start
Say `"[exact trigger phrase with placeholder]"` in Claude Code.

## Instructions
[Guidance for Claude: ask clarifying questions, don't fabricate, use [TBD] for missing input.]

## Template
[The output template — 1-2 pages when filled]

## If Regulated / Healthcare (Optional)
[Skip this section if you're not in a regulated industry.]
[Additional sections for regulated industries.]

## Verification Checklist
- [ ] [5-7 quality checks]
```

---

## 5. Skill Specifications

### 5.1 prd-writer (General PRD)

**Triggers**: "general PRD", "product spec", "feature requirements", "feature spec", "PRD for [product]"

**Purpose**: Generate a 1-2 page product requirements document for any product or feature.

**How it differs from `prd-writer-samd`**: No regulatory sections (no IEC 62304, no FDA pathway, no clinical validation). Universal structure any PM needs. If user says "write a PRD" without context, ask whether they need the general or SaMD version.

**Quick Start**: Say `"write a general PRD for [your product name]"` in Claude Code.

**Template sections**:
1. **Overview** — Problem statement, proposed solution, target user (1 sentence each)
2. **User Stories** — 3-5 core user stories: "As a [user], I want [action], so that [outcome]"
3. **Requirements** — Functional (numbered), non-functional (performance, security, accessibility)
4. **User Flow** — Step-by-step primary user journey
5. **Success Metrics** — 3-5 measurable outcomes with targets
6. **Scope** — In scope, explicitly out of scope
7. **Open Questions** — Unresolved items needing input

**When NOT to Use (cross-references)**:
- Medical device or FDA-regulated product → use `prd-writer-samd`
- Recording a decision between options → use `decision-doc`

**Optional healthcare**: Regulatory pathway, clinical requirements, HIPAA considerations.

**Key instruction**: Ask for product name, target user, and core problem before generating. Never fabricate user stories — use `[TBD — need user research]` if PM hasn't provided context. If user mentions medical device, FDA, or regulatory — redirect to `prd-writer-samd`.

**Verification checklist**:
- [ ] Problem statement is specific (not "improve user experience")
- [ ] User stories reference real user types (not generic "user")
- [ ] Requirements are testable (not "fast" — specify latency)
- [ ] Success metrics have numeric targets
- [ ] Out of scope list exists and is explicit
- [ ] No sections filled with generic filler

---

### 5.2 status-update (Stakeholder Comms)

**Triggers**: "write a status update", "weekly update", "stakeholder update", "exec summary", "project status"

**Purpose**: Generate a structured status update that leads with the headline, not the details. For upward communication to leadership or cross-functional stakeholders.

**Quick Start**: Say `"write a status update for [project name] this week"` in Claude Code.

**Template sections**:
1. **Status** — GREEN / YELLOW / RED + one-sentence summary
2. **Key Updates** — 3-5 bullets: shipped, in progress, blocked
3. **Decisions Needed** — Action items requiring stakeholder input (options + recommendation)
4. **Risks** — What could slip, with mitigation
5. **Next Week** — Top 3 priorities

**When NOT to Use (cross-references)**:
- Requesting a decision between options → use `decision-doc`
- Defining what metrics to track → use `metrics-definition`

**Optional healthcare**: Compliance/regulatory milestones, audit readiness, clinical validation status.

**Key instruction**: Ask for project name and time period. Push PM to state status color and one-sentence summary first — don't let them bury the lead. If no decisions needed, say so explicitly.

**Verification checklist**:
- [ ] Status color is stated in first line
- [ ] One-sentence summary captures the headline
- [ ] "Decisions Needed" has options with a recommendation (not open-ended asks)
- [ ] Risks have mitigations (not just risk statements)
- [ ] Next week priorities are ≤3 items
- [ ] Entire update fits on one page

---

### 5.3 research-synthesis (User Research Synthesis)

**Triggers**: "synthesize research", "research synthesis", "summarize interviews", "user research summary", "interview findings"

**Purpose**: Turn raw user research (interviews, surveys, feedback) into actionable product decisions — patterns, not summaries.

**Quick Start**: Say `"synthesize research from these interviews: [paste notes]"` in Claude Code.

**Template sections**:
1. **Research Overview** — Method, sample size, time period, research questions
2. **Key Findings** — 3-5 findings, each with: insight statement, supporting evidence (quotes/data), confidence level (high/medium/low)
3. **Patterns** — Themes across multiple sources, with frequency
4. **Surprises** — Findings that contradicted assumptions
5. **Implications** — What to build, change, or kill based on findings
6. **Raw Data Summary** — Table of participants, segments, key quotes

**When NOT to Use (cross-references)**:
- Analyzing competitors or market landscape → use `competitive-analysis`
- Defining what metrics to track → use `metrics-definition`

**Optional healthcare**: Patient safety implications, health equity considerations, clinical workflow impact.

**Key instruction**: Ask PM to paste or describe raw research. Never invent quotes or findings. Extract verbatim quotes from transcripts. Flag confidence level explicitly when findings are ambiguous.

**Verification checklist**:
- [ ] Every finding has supporting evidence (quotes or data)
- [ ] Confidence levels assigned (high/medium/low)
- [ ] Patterns cite frequency ("4 of 6 participants")
- [ ] Surprises section exists (even if empty — state "none")
- [ ] Implications are specific product actions, not vague themes
- [ ] No fabricated quotes or data

---

### 5.4 competitive-analysis (Competitive Analysis)

**Triggers**: "competitive analysis", "competitor analysis", "competitive landscape", "comp analysis", "market analysis"

**Purpose**: Structured competitive landscape analysis that informs product decisions — not a feature checklist.

**Quick Start**: Say `"competitive analysis for [market/product] vs [competitor 1], [competitor 2]"` in Claude Code.

**Template sections**:
1. **Market Context** — One paragraph: what market, what's changing, why now
2. **Competitor Profiles** — Each (3-5): positioning, target user, differentiator, pricing, notable weakness
3. **Feature Comparison** — Matrix of capabilities that matter for PM's decisions
4. **Strategic Insights** — Where market is going, gaps no one fills, positioning opportunities
5. **Implications for Us** — What to build, avoid, differentiate on

**When NOT to Use (cross-references)**:
- Synthesizing user interviews or feedback → use `research-synthesis`
- Ranking your own features → use `feature-prioritization`

**Optional healthcare**: Regulatory status (FDA, CE mark), clinical validation claims, compliance posture (HIPAA, SOC 2).

**Key instruction**: Ask for product/market area and 2-3 known competitors. Use web search to fill in current data. Flag uncertain or dated info. Use `[Verify — could not confirm]` for unverified claims. Never fabricate pricing or features.

**Verification checklist**:
- [ ] At least 3 competitors profiled
- [ ] Each has a notable weakness (not just strengths)
- [ ] Feature comparison covers capabilities relevant to PM's product
- [ ] Pricing information marked as verified or unverified
- [ ] "Implications for Us" gives specific, actionable recommendations
- [ ] Market context explains why this analysis matters now

---

### 5.5 feature-prioritization (Feature Prioritization)

**Triggers**: "prioritize features", "feature prioritization", "what should we build next", "backlog prioritization", "RICE scoring"

**Purpose**: Turn a messy backlog into a scored, ranked, defensible build order.

**Quick Start**: Say `"prioritize these features: [list your features]"` in Claude Code.

**Template sections**:
1. **Framework** — Which framework (RICE, Impact/Effort, ICE) and why
2. **Feature List** — Table: Feature, Score breakdown, Total, Rank, Rationale
3. **Tier Summary** — Build Now / Build Next / Build Later / Don't Build
4. **Dependencies** — Which features unlock others or need prerequisites
5. **Recommendation** — Top 3 to build first with reasoning

**When NOT to Use (cross-references)**:
- Sequencing work across quarters → use `roadmap-planning`
- Prioritizing AI use cases for deployment → use `ai-deployment-playbook`
- Comparing competitor features → use `competitive-analysis`

**Optional healthcare**: Risk/safety scoring column, regulatory dependency flags, clinical validation requirements per feature.

**Key instruction**: Ask for feature list (or brain-dump). Default to RICE unless PM specifies otherwise. Push back on inflated scores: "What's your evidence for this Impact score?" Don't let every feature score high.

**Verification checklist**:
- [ ] Framework choice is justified
- [ ] Scores have rationale (not just numbers)
- [ ] At least one feature is in "Don't Build" tier
- [ ] Dependencies are documented
- [ ] Top 3 recommendation has clear reasoning
- [ ] Scoring is honest — not everything is high-impact

---

### 5.6 metrics-definition (Metrics & Success Criteria)

**Triggers**: "define metrics", "success metrics", "KPIs", "how do we measure", "north star metric", "OKRs"

**Purpose**: Define what to measure, why, and what "good" looks like. Not just a metric list — a framework for knowing whether you're winning.

**Quick Start**: Say `"define success metrics for [product/feature]"` in Claude Code.

**Template sections**:
1. **North Star Metric** — Single metric capturing value delivery. Why this one.
2. **Input Metrics** — 3-5 leading indicators driving the north star
3. **Guardrail Metrics** — 2-3 metrics that must NOT degrade
4. **Metric Definitions** — Each: definition, data source, calculation, update frequency, owner
5. **Targets** — Baseline (current), target (30/60/90 day), stretch goal
6. **Anti-Metrics** — What you're explicitly NOT optimizing for, and why

**When NOT to Use (cross-references)**:
- Reporting status with existing metrics → use `status-update`
- Ranking features by impact → use `feature-prioritization`
- Defining AI adoption KPIs for a rollout → use `ai-deployment-playbook`

**Optional healthcare**: Clinical outcome metrics, patient safety metrics, regulatory compliance metrics.

**Key instruction**: Ask for product/feature and business goal. Push hard on North Star — if PM can't pick one, help narrow. If they list 10 metrics, ask "Which 3 would you check every Monday morning?" Anti-metrics section is mandatory.

**Verification checklist**:
- [ ] Exactly one North Star metric (not three)
- [ ] Input metrics are leading indicators (not lagging)
- [ ] Guardrail metrics prevent gaming the North Star
- [ ] Every metric has a data source and owner
- [ ] Targets have baselines (not just goals)
- [ ] Anti-metrics section exists with rationale

---

### 5.7 decision-doc (Decision Document)

**Triggers**: "decision doc", "write a decision document", "document this decision", "RFC", "design decision", "ADR"

**Purpose**: Record a product or technical decision — context, options, trade-offs, recommendation. Readable 6 months later by someone who wasn't in the room.

**Quick Start**: Say `"write a decision doc for [decision you're making]"` in Claude Code.

**Template sections**:
1. **Decision** — One sentence: what was decided
2. **Context** — Why this decision is needed now
3. **Options Considered** — 2-4 options: description, pros, cons, estimated effort
4. **Recommendation** — Which option and why. Trade-offs accepted.
5. **What We're Giving Up** — Downsides of the chosen path
6. **Reversibility** — One-way door or two-way door? Cost to reverse.
7. **Next Steps** — Who does what by when

**When NOT to Use (cross-references)**:
- Comparing and ranking features → use `feature-prioritization`
- Sequencing work into a timeline → use `roadmap-planning`

**Optional healthcare**: Regulatory impact, patient safety considerations, compliance review required (yes/no + reviewer).

**Key instruction**: Ask for decision context and options. If PM has only one option, push: "What's the alternative you rejected?" Every good decision doc needs ≥2 real options. "What We're Giving Up" is mandatory.

**Verification checklist**:
- [ ] Decision stated in one sentence at the top
- [ ] At least 2 real options considered (not strawmen)
- [ ] Each option has both pros and cons
- [ ] "What We're Giving Up" is specific (not "nothing significant")
- [ ] Reversibility is assessed
- [ ] Next steps have owners and dates

---

### 5.8 roadmap-planning (Roadmap Planning)

**Triggers**: "plan a roadmap", "product roadmap", "quarterly plan", "what should we build this quarter"

**Purpose**: Time-based product roadmap organized by outcomes, not features. Covers 1-3 quarters with decreasing specificity.

**Quick Start**: Say `"plan a roadmap for [product] this quarter"` in Claude Code.

**Template sections**:
1. **Vision** — One sentence: where are we going and why
2. **Strategic Pillars** — 2-4 themes grouping roadmap items
3. **Now (This Quarter)** — Committed: features, expected outcomes, success metrics, owners
4. **Next (Next Quarter)** — Planned: themes and bets, not detailed specs
5. **Later (2+ Quarters)** — Exploratory: opportunities, dependencies on Now/Next
6. **What We're NOT Doing** — Deprioritized requests with brief rationale
7. **Dependencies & Risks** — Cross-team, hiring, technical prerequisites

**When NOT to Use (cross-references)**:
- Scoring and ranking individual features → use `feature-prioritization`
- Planning an AI tool rollout specifically → use `ai-deployment-playbook`
- Defining metrics for a feature → use `metrics-definition`

**Optional healthcare**: Regulatory milestones, clinical validation timeline, compliance dependencies.

**Key instruction**: Ask for time horizon and strategic context. Push back if "Now" has too many items — 15 items in "Now" is a wish list. "What We're NOT Doing" is mandatory. Roadmaps are about what you cut as much as what you build.

**Verification checklist**:
- [ ] Vision is one sentence (not a paragraph)
- [ ] "Now" has ≤5 committed items
- [ ] "Next" is themes, not detailed specs
- [ ] "Later" is explicitly exploratory
- [ ] "What We're NOT Doing" exists and has rationale
- [ ] Each "Now" item has an owner and success metric

---

## 6. Build Order

Build in dependency order — skills referenced by others come first:

| Order | Skill | Rationale |
|-------|-------|-----------|
| 1 | prd-writer | Foundation document, referenced by other skills |
| 2 | metrics-definition | Referenced by status-update and roadmap |
| 3 | decision-doc | Self-contained, commonly needed |
| 4 | status-update | References metrics and decisions |
| 5 | research-synthesis | Feeds into PRDs and prioritization |
| 6 | competitive-analysis | Feeds into strategy and roadmaps |
| 7 | feature-prioritization | References research, feeds into roadmap |
| 8 | roadmap-planning | References most other skills, build last |

---

## 7. Code Style & Conventions

| Aspect | Convention |
|--------|-----------|
| SKILL.md frontmatter | YAML with `name` and `description` fields |
| Trigger phrases | Listed in `description` field |
| Output format | Markdown only (no XLSX, no JSON) |
| Output length | 1-2 pages when filled |
| Unfilled sections | `[TBD — need input]` (never generic filler) |
| Optional sections | Clearly marked `## If Regulated / Healthcare (Optional)` |
| Verification | `- [ ]` checkbox format at end of SKILL.md |

---

## 8. Boundaries

### Always
- Ask for context before generating — never produce a document from zero input
- Use `[TBD — need input]` for sections the PM hasn't provided context on
- Include verification checklist at end of every skill
- Keep outputs to 1-2 pages
- Include optional healthcare section (clearly marked, skippable)
- Match existing SKILL.md format exactly

### Never
- Fabricate data, quotes, metrics, or competitor information
- Fill sections with generic filler content
- Exceed 2 pages unless PM explicitly asks for depth
- Include SaMD-specific regulatory language in main template
- Add Python scripts or XLSX generation
- Modify existing skills (SaMD, Eleanor Health, agents)

### Ask First
- If PM input is too vague to produce useful output — clarify before guessing
- If request overlaps existing skill (e.g., "write a PRD" might want `prd-writer-samd`) — ask which version

---

## 9. Testing Strategy

Each skill tested by:
1. Run trigger phrase in Claude Code with realistic product context
2. Verify output follows template structure
3. Check `[TBD]` placeholders appear where PM didn't provide input
4. Confirm optional healthcare section is present but clearly optional
5. Verify output ≤ 2 pages
6. Confirm no collisions with existing skill trigger phrases

---

## 10. Deliverables Summary

| # | Deliverable | Type | Files |
|---|------------|------|-------|
| 1-8 | 8 core PM skills | SKILL.md × 8 | 8 files |
| 9 | Updated CLAUDE.md | Edit | 1 file |
| 10 | Updated skills/README.md | Edit | 1 file |
| **Total** | | | **10 files** |

---

## 11. Success Criteria

- All 8 skills installed in `skills/pm-core/`
- Each produces actionable output from a single trigger phrase
- A PM at Basic AI fluency gets useful output on their first try
- No trigger phrase collisions with existing skills
- CLAUDE.md and README.md updated with new category
- Dashboard redesign can showcase all 8 in the "I have a task" lane (separate task)
