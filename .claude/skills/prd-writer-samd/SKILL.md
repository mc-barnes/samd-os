---
name: prd-writer-samd
version: 2.0.0
description: >
  Generate a structured PRD for a software medical device with regulatory sections.
  Triggers: "write PRD", "product requirements", "SaMD PRD", "medical device PRD".
---

# Skill: PRD Writer — Software Medical Device (SaMD)

## Purpose
Generate a product requirements document for a software medical device that is compelling, evidence-backed, and honest about gaps. A great SaMD PRD excites the team to build while grounding every claim in clinical evidence and regulatory reality.

## When to Use
- Starting a new SaMD feature or product
- Portfolio piece: write a PRD to demonstrate regulatory and clinical product thinking
- Interview prep: walk through a PRD you authored to show depth

## When NOT to Use
- Non-regulated product or feature with no FDA/clinical requirements → use `prd-writer`

## Instructions

When asked to write a PRD, ask for these things before generating:
1. **Product/feature name** — what are we calling this?
2. **Intended use** — what does the device do and for whom?
3. **Core clinical problem** — what clinical/workflow gap does this address?
4. **Evidence** — any clinician feedback, clinical literature, post-market data, or complaint trends that prove this is a real problem? (If none, we'll mark it [TBD].)

### Content Quality Rules

**Never do these:**
- Fill sections with generic filler ("ensure alignment with standards", "high accuracy")
- Use tautologies — if a section restates the heading, it's empty
- Claim the doc is "comprehensive" when sections are incomplete — use `[WIP]` in the title
- Delegate all design thinking — the PM should describe edge cases, clinical user states, and alarm conditions
- List standards without editions (write "IEC 62304:2006+A1:2015", not "IEC 62304")

**Always do these:**
- Use `[TBD — need input]` for anything the PM hasn't provided
- Ground the problem in real evidence: clinician quotes, complaint trends, literature, post-market surveillance data
- Address trade-offs — clinical sensitivity vs. alarm fatigue, accuracy vs. latency, etc.
- Make it compelling — the reader should feel the clinical need and want to solve it
- If the PM describes a non-regulated product, redirect to `prd-writer`

## PRD Template

```markdown
# PRD: [Product/Feature Name]
**Author**: [Name]
**Date**: [Date]
**Status**: Draft / In Review / Approved / [WIP]
**Document Version**: 1.0

### Stakeholders
| Name | Role | Sign-off |
|------|------|----------|
| [Name] | PM / Owner | [ ] |
| [Name] | Engineering Lead | [ ] |
| [Name] | Clinical Lead | [ ] |
| [Name] | Regulatory Affairs | [ ] |
| [Name] | Quality Assurance | [ ] |
| [Name] | Design Lead | [ ] |

---

## 1. Intended Use / Indications for Use
- **Intended use statement**: [One sentence — what the device does and for whom]
- **Indications for use**: [Clinical conditions, patient populations, care settings]
- **Contraindications**: [When this device should NOT be used]
- **Target user**: [Clinician type — e.g., telehealth nurse, cardiologist, primary care]

## 2. Clinical & User Evidence
[Ground the problem in reality. Include any of the following:]
- Clinician feedback (quotes from interviews, usability sessions, or field observations)
- Complaint trends or post-market surveillance signals
- Clinical literature supporting the need (cite author, year, key finding)
- Workflow observations or time-motion study data
- Comparable device post-market performance data

[If no evidence exists yet, write: `[TBD — need clinical/user research before proceeding]` and flag this as a risk in section 10.]

## 3. Competitive & Predicate Landscape
| Device / Competitor | Regulatory Status | How they handle this | Strength | Weakness |
|---------------------|-------------------|---------------------|----------|----------|
| [Predicate device] | [510(k) #, class] | [Approach] | [What works] | [Gap we address] |
| [Competitor 1] | [Status] | [Approach] | [What works] | [What doesn't] |
| [Competitor 2] | [Status] | [Approach] | [What works] | [What doesn't] |

[What can we learn from predicate devices? Where is the clinical/UX opportunity to differentiate?]

## 4. Product Overview
- **Problem statement**: [What clinical/workflow problem does this solve?]
- **Proposed solution**: [How the product solves it]
- **Key outcomes**: [What changes for the patient/clinician when this works?]

## 5. Regulatory Context
- **Device classification**: [Class I / II / III]
- **Software classification (IEC 62304)**: [Class A / B / C]
- **Regulatory pathway**: [510(k) / De Novo / PMA / Exempt]
- **Predicate device(s)**: [If 510(k) — predicate device name, 510(k) number, substantial equivalence rationale]
- **Applicable standards**: [IEC 62304:2006+A1:2015, ISO 14971:2019, IEC 62366-1:2015+A1:2020, FDA guidance docs — cite editions]
- **Quality system**: [Design controls per 21 CFR 820]

## 6. Clinical Requirements
- **Clinical evidence needed**: [What studies/data support this?]
- **Clinical validation plan**: [How will clinical accuracy be validated?]
- **Performance targets**: [Sensitivity, specificity, PPV, NPV — with numeric thresholds]
- **Gold standard comparator**: [What is the reference standard?]
- **Patient population considerations**: [Age, comorbidities, skin tone, gestational age, etc.]

## 7. Design Inputs
### Functional Requirements
1. The system shall [requirement]
2. The system shall [requirement]
3. The system shall [requirement]

### Performance Requirements
- [Latency, throughput, accuracy thresholds — specific numbers]

### User Interface Requirements
- [Key screens, information hierarchy, clinical workflow fit]

### Safety Requirements
- [Per ISO 14971 risk analysis — what can go wrong?]

### Cybersecurity Requirements
- [Per FDA premarket cybersecurity guidance]

## 8. User Flow & Design Direction
1. Clinician [action]
2. System [response]
3. Clinician [action]
4. System [response]
[Step-by-step primary clinical workflow. One flow — not every edge case.]

**Key edge cases & clinical states the PM has identified:**
- [Edge case 1 — e.g., "What happens when connectivity to EHR is lost mid-session?"]
- [Edge case 2 — e.g., "How does the alarm behave during sensor artifact?"]
- [Entry point — e.g., "Clinician can access from patient chart, alarm queue, and worklist"]

**Mockup / sketch**: [Include a rough wireframe, ASCII sketch, or link to Figma. The PM should think through clinical layout — don't fully delegate to design.]

## 9. Design Outputs
- **Architecture overview**: [System diagram — data flow from input to output]
- **Algorithm description**: [What the model/algorithm does, inputs, outputs]
- **Verification plan**: [How design outputs will be verified against design inputs]
- **Validation plan**: [How the product will be validated in the intended use environment]

## 10. EHR Integration
- **Integration engine**: [e.g., Rhapsody]
- **Data standards**: [HL7 v2 / FHIR R4 / CDA — specify which and version]
- **Message types**: [ADT, ORU, ORM, CCD — specify which]
- **Data elements exchanged**: [What data flows in/out of the EHR?]
- **Authentication**: [OAuth 2.0 / SMART on FHIR / other]
- **Target EHR systems**: [Epic, Cerner, Meditech, etc.]
- **Interoperability testing plan**: [How will integration be validated?]

## 11. Risk Analysis (ISO 14971)
- **Hazard identification**: [Top 5 hazards]
- **Risk estimation**: [Severity x probability for each]
- **Risk control measures**: [How each hazard is mitigated]
- **Residual risk acceptability**: [Per risk management plan]

## 12. Trade-offs & Risks
| Risk / Trade-off | Impact | Mitigation |
|------------------|--------|------------|
| [e.g., "Higher sensitivity increases false alarm rate"] | [High/Med/Low] | [How we address it] |
| [e.g., "No clinical validation data yet — building on literature alone"] | [High/Med/Low] | [How we address it] |
| [e.g., "EHR integration delays may push regulatory submission"] | [High/Med/Low] | [How we address it] |

[Be honest. Every device feature has clinical, regulatory, or operational trade-offs. Name them.]

## 13. Data & Privacy
- **Data classification**: [PHI / PII / de-identified]
- **HIPAA compliance**: [Required controls]
- **Data retention policy**: [How long, where stored, deletion process]
- **Audit trail requirements**: [What actions are logged?]

## 14. Success Metrics
| Metric | Category | Current | Target | Measurement |
|--------|----------|---------|--------|-------------|
| [Metric 1] | Clinical | [Baseline] | [Goal] | [How measured] |
| [Metric 2] | Operational | [Baseline] | [Goal] | [How measured] |
| [Metric 3] | Business | [Baseline] | [Goal] | [How measured] |
[Include current baseline where known. If baseline is unknown, write `[TBD — need analytics]`.]

**Anti-metrics** (metrics we do NOT want to regress):
- [e.g., "False alarm rate should not exceed X per patient-day"]
- [e.g., "Alert response time should not increase beyond Xs"]
- [e.g., "Clinician workflow steps should not increase"]

## 15. Scope
**In scope**:
- [Feature/capability 1]
- [Feature/capability 2]

**Out of scope**:
- [Explicitly excluded item 1]
- [Explicitly excluded item 2]

## 16. Open Questions
- [ ] [Question needing clinical input]
- [ ] [Question needing regulatory input]
- [ ] [Question needing engineering input]

## 17. Appendix
- [References, related documents, prior art, clinical literature citations]
```

## Quality Checklist
- [ ] Intended use is specific enough to define regulatory pathway
- [ ] Clinical & user evidence section has real data, quotes, or literature (not just stated assumptions)
- [ ] Predicate/competitive landscape surveyed — at least 1 predicate + 1 competitor analyzed
- [ ] Risk analysis covers the top clinical hazards (not just technical risks)
- [ ] Trade-offs section is honest — at least one real clinical or regulatory downside acknowledged
- [ ] EHR integration section specifies actual message types and versions, not just "HL7"
- [ ] Performance targets have specific numbers, not "high accuracy"
- [ ] PM has identified key edge cases and clinical states (not fully delegated to design)
- [ ] Success metrics have numeric targets with baselines where available
- [ ] Anti-metrics defined — what must NOT regress (alarm fatigue, workflow burden, etc.)
- [ ] Standards cited with editions (e.g., "ISO 14971:2019", not "ISO 14971")
- [ ] Stakeholder table has names, roles, and sign-off status
- [ ] Out of scope is explicit — prevents scope creep
- [ ] Patient population considerations address health equity (skin tone, age, comorbidities)
- [ ] No sections filled with generic filler — every sentence adds information
- [ ] If sections are incomplete, title includes `[WIP]` and gaps use `[TBD — need X]`
