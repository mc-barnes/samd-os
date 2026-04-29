# AI Training Program Template

## Purpose

Role-based training structure for AI tool adoption. Covers three audience levels: clinical staff, operations/admin, and leadership. Designed for healthcare organizations deploying both internal AI (Claude Enterprise) and member-facing AI agents.

## Training Tiers

### Tier 1: All Employees — AI Foundations (Required)
**Duration**: 60 minutes (self-paced) + 30 minute live Q&A
**Prerequisite**: None
**Completion deadline**: Within 2 weeks of AI tool access

#### Modules
1. **What AI Can and Can't Do** (15 min)
   - How LLMs work (high-level, non-technical)
   - What AI is good at: drafting, summarizing, analyzing, brainstorming
   - What AI is bad at: factual accuracy (hallucinations), clinical judgment, math, real-time data
   - AI is a tool, not a colleague — always verify outputs

2. **PHI and AI — The Rules** (20 min)
   - What is PHI (the 18 HIPAA identifiers)
   - What you CAN put into approved AI tools
   - What you CANNOT put into AI tools (raw member data, SUD records)
   - How to de-identify data before AI input
   - 42 CFR Part 2 basics: why SUD data is different
   - Incident reporting: what to do if PHI is mishandled

3. **Prompt Engineering Basics** (15 min)
   - Be specific: "Summarize this in 3 bullet points" > "Summarize this"
   - Provide context: give the AI relevant background
   - Iterate: refine your prompt based on the first output
   - Use examples: show the AI what good output looks like
   - Set constraints: word limits, format requirements, audience level

4. **Our AI Policy** (10 min)
   - Approved tools and use cases
   - Prohibited uses
   - How to report issues
   - Where to get help
   - Policy acknowledgment sign-off

#### Assessment
- 10-question quiz (80% pass rate required)
- Covers: PHI identification, approved/prohibited uses, de-identification, incident reporting

---

### Tier 2: Clinical Staff — AI in Clinical Workflows
**Duration**: 90 minutes (instructor-led)
**Prerequisite**: Tier 1 completed
**Audience**: Providers, nurses, care coordinators, clinical support staff

#### Modules
1. **Clinical AI Use Cases** (30 min)
   - Clinical note summarization (with human review requirements)
   - Visit preparation (pulling relevant history, pre-visit summaries)
   - Care coordination (summarizing member status across providers)
   - Research assistance (evidence-based practice lookups)
   - What AI CANNOT replace: clinical judgment, diagnosis, treatment decisions

2. **Member-Facing AI Agents — What Clinical Staff Need to Know** (20 min)
   - How voice/SMS AI agents interact with members
   - When and how AI escalates to clinical staff (crisis tiers)
   - What context AI provides during handoff
   - How to respond to members who say "the AI told me..."
   - Feedback loop: reporting AI issues to the product team

3. **SUD-Specific Considerations** (20 min)
   - 42 CFR Part 2 in practice: what you can and cannot share with AI
   - SUD treatment records in the EHR: what's Part 2 protected
   - Scenarios: "Can I use AI to summarize a member's treatment history?"
   - When to ask compliance before using AI with SUD data

4. **Hands-On Practice** (20 min)
   - Draft a clinical handoff note using Claude Enterprise
   - De-identify a clinical scenario and analyze with AI
   - Practice: identify PHI in an AI prompt (spot the violation)

---

### Tier 3: Operations & Admin — AI for Productivity
**Duration**: 60 minutes (instructor-led or self-paced)
**Prerequisite**: Tier 1 completed
**Audience**: Operations, finance, HR, admin, marketing

#### Modules
1. **High-Value Use Cases for Your Role** (20 min)
   - Operations: workflow documentation, process improvement, data analysis
   - Finance: report generation, data reconciliation, variance analysis
   - HR: policy drafting, job descriptions, onboarding materials
   - Marketing: content drafting, outreach messages, social media
   - Admin: meeting notes, email drafting, scheduling coordination

2. **Advanced Prompt Techniques** (20 min)
   - Chain of thought: "Think step by step about..."
   - Role assignment: "You are a [role] helping me with [task]"
   - Output formatting: tables, bullet points, structured templates
   - Iterative refinement: building on previous outputs
   - Batch processing: handling multiple items in one prompt

3. **Workflow Integration** (20 min)
   - Building AI into your daily routine (not a separate tool, but part of your workflow)
   - Templates: save effective prompts for recurring tasks
   - Team sharing: sharing successful AI workflows with colleagues
   - Measuring your productivity gains: before/after tracking

---

### Tier 4: Leadership — AI Strategy & Governance
**Duration**: 45 minutes (executive briefing)
**Prerequisite**: Tier 1 completed
**Audience**: Directors, VPs, C-suite

#### Modules
1. **AI Strategy Overview** (15 min)
   - Current AI deployments and roadmap
   - ROI metrics and business case
   - Competitive landscape: how peers are using AI
   - Risk profile: what could go wrong and how we mitigate

2. **Governance & Decision-Making** (15 min)
   - New use case approval process
   - Budget and vendor evaluation
   - Compliance and regulatory considerations
   - Board reporting on AI initiatives

3. **Leading AI Adoption** (15 min)
   - Modeling AI usage (leaders who use AI signal it's valued)
   - Removing barriers: what's stopping your team from adopting?
   - Celebrating wins: share stories of AI-driven productivity gains
   - Feedback loop: how to surface issues and opportunities to the AI PM

## Training Delivery Plan

| Phase | Timeline | Action |
|-------|----------|--------|
| Week 1-2 | Pre-launch | Train trainers, finalize materials, set up LMS |
| Week 3-4 | Pilot | Tier 1 + Tier 2 for pilot group (1 team) |
| Week 5-6 | Feedback | Collect feedback, iterate on materials |
| Week 7-10 | Rollout | Tier 1 for all employees; Tier 2/3 for respective audiences |
| Week 11-12 | Leadership | Tier 4 executive briefing |
| Ongoing | Monthly | Office hours, advanced workshops, new feature training |
| Ongoing | Quarterly | Refresher training, policy updates, new use case reviews |

## Training Effectiveness Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Completion rate (Tier 1) | 100% within 2 weeks of access | LMS tracking |
| Quiz pass rate | >90% on first attempt | LMS quiz results |
| AI adoption rate (post-training) | >50% WAU within 30 days of training | Tool analytics |
| Training satisfaction | >4.0/5.0 | Post-training survey |
| PHI incidents (post-training) | 0 | Compliance reporting |
