# Skill: Interview Prep

## Purpose
Run a mock interview session or prep the user for a specific upcoming interview. Pulls from STAR stories, interview playbook, and company research.

## When to Use
- "Prep me for [company] interview"
- "Run a mock interview"
- "Help me practice [question type]"
- "What stories should I use for [role]?"

## Instructions

### Mock Interview Mode
When the user asks for a mock interview:

1. **Check context**: Read `job-search/companies/[company].md` if it exists. Read `job-search/INTERVIEW-PLAYBOOK.md` and `job-search/STAR-STORIES.md`.
2. **Determine format**: Ask if this is a specific round (product sense, execution, leadership, analytical) or a general practice session.
3. **Ask 3-5 questions** one at a time. Wait for the user's answer before moving on.
4. **After each answer, give feedback on**:
   - **Structure**: Did the answer follow STAR? Was it under 2 minutes?
   - **Specificity**: Were there concrete numbers, outcomes, and decisions?
   - **SaMD signal**: Did the answer demonstrate healthcare/regulatory depth where relevant?
   - **Improvement**: One specific thing to change.
5. **After the session**: Summarize strengths, patterns to fix, and which stories landed best.

### Company Prep Mode
When the user asks to prep for a specific company:

1. Read `job-search/companies/[company].md` if it exists. If not, offer to create one.
2. Research the company (products, regulatory status, recent news, role details).
3. Map the user's experience to what the role needs — identify strongest angles and gaps.
4. Suggest which STAR stories to prioritize for this company.
5. Draft 3 company-specific questions the user should ask the interviewer.
6. Flag any potential concerns the interviewer might have and how to address them.

### Story Selection Mode
When the user asks which stories to use:

1. Read `job-search/STAR-STORIES.md`
2. Based on the role type and company, recommend 4-5 stories with rationale
3. Identify any competency gaps not covered by existing stories
4. Suggest how to adapt stories to emphasize what this specific company cares about

## Eleanor Health Domain Context

When prepping for an AI PM role in behavioral health (e.g., Eleanor Health), use this additional context:

### Role Context
- Senior Product Manager, AI — owns AI vendor evaluation, internal AI deployment, and AI agent strategy
- Intersection of technology and clinical operations
- AI is an active strategic priority, not a future initiative
- Owns full lifecycle: evaluation → deployment → iteration → performance management

### Company Context
- Behavioral health / addiction treatment (SUD)
- Longitudinal, whole-person, value-based care model
- Multi-state operations
- Community members (not "patients" — Eleanor Health uses "community members")
- Tech stack: athenahealth (EHR), Salesforce (CRM), telephony, data warehouse, proprietary ops platform

### Tech Context
- AI voice and SMS agents for member access (deployed/deploying)
- Claude Enterprise for internal productivity (deployed)
- Roadmap: outbound lead conversion, pre-visit data collection, transcript/call analysis, scheduling optimization
- HIPAA + 42 CFR Part 2 compliance required for all AI touching member data

### STAR Story Templates for AI PM Roles

**AI Vendor Evaluation & Deployment**
- Situation: Organization needed to deploy AI voice agents but had no evaluation framework
- Task: Own end-to-end vendor selection for [AI capability]
- Action: Built weighted scorecard, ran structured demos, coordinated clinical safety review, negotiated BAA and contract terms
- Result: Selected vendor, deployed pilot, achieved [metric] improvement in [timeframe]

**HIPAA Compliance in AI Context**
- Situation: Team wanted to use AI tools with member data but lacked governance
- Task: Establish AI usage policy that enabled productivity without PHI risk
- Action: Assessed tools for HIPAA compliance, created internal AI policy, trained staff, implemented audit logging
- Result: Rolled out AI tools to [N] employees with zero PHI incidents over [timeframe]

**Cross-Functional Collaboration (Clinical + Ops + Eng)**
- Situation: AI deployment required buy-in from clinical, operations, and engineering simultaneously
- Task: Align three teams on AI agent requirements and safety guardrails
- Action: Ran joint requirements sessions, created shared success metrics, established clinical safety review gate
- Result: Launched AI agent with clinical sign-off, [metric] improvement, no safety incidents

**Building AI Adoption Programs**
- Situation: Organization deployed AI tools but adoption was low
- Task: Drive meaningful adoption beyond early enthusiasts
- Action: Created role-based training, identified high-value use cases per team, ran office hours, tracked adoption metrics
- Result: Grew from [N]% to [N]% adoption in [timeframe], documented [X] hours saved per week

**Crisis Safety Protocol Design**
- Situation: Member-facing AI agent needed to handle crisis situations safely
- Task: Design crisis escalation protocols for AI voice/SMS agents in behavioral health
- Action: Defined 3-tier escalation (immediate danger, elevated risk, routine), built crisis detection logic, tested warm handoff end-to-end
- Result: AI correctly escalated [N]% of crisis scenarios, zero missed crisis events in [timeframe]

**EHR Integration Challenges**
- Situation: AI tool needed to integrate with legacy EHR (e.g., athenahealth) with limited API support
- Task: Design integration that maintained EHR as source of truth while enabling AI capabilities
- Action: Assessed API capabilities, chose integration pattern (FHIR/REST/HL7v2), built data flow with compliance checkpoints
- Result: Achieved real-time data sync with [latency], maintained PHI compliance, reduced manual data entry by [N]%

### Eleanor Health Research Prompts
When prepping for an Eleanor Health interview, research:
- Eleanor Health's care model (value-based, longitudinal, whole-person)
- Their geographic footprint (which states, expansion plans)
- Recent news about AI adoption in behavioral health
- athenahealth ecosystem and API capabilities
- 42 CFR Part 2 and its implications for AI in SUD treatment
- Competitive landscape: other tech-enabled behavioral health companies
- SAMHSA treatment guidelines and standards

### AI PM Interview Signal (replaces SaMD signal for this domain)
When giving feedback on answers, evaluate for:
- **AI PM signal**: Does the answer demonstrate hands-on AI deployment experience (not just strategy)?
- **Healthcare AI signal**: Does the answer show understanding of HIPAA, clinical safety, and regulatory constraints?
- **Vendor management signal**: Does the answer show structured evaluation, not just "we picked the best one"?
- **Cross-functional signal**: Does the answer show ability to work across clinical, ops, and engineering?
- **Ambiguity signal**: Does the answer show comfort building in undefined spaces?

## Feedback Style
- Be direct. "That answer was too long" not "You might consider being more concise."
- Call out when an answer sounds rehearsed or generic.
- Push for the specific moment — "What did YOU decide? What was the turning point?"
- If the user gives a vague answer, ask a follow-up probe like an interviewer would.
