---
type: spec
status: draft
owner: @Sterdb
project: clinical-pathway-designer
created: 2026-05-03
---

# Clinical Pathway Designer — Specification

## 1. Objective

Build a Claude Code skill that takes a clinical condition and generates a **unified clinical pathway artifact** with two connected outputs: a provider workflow (with illustrative FHIR CarePlan) and a patient journey — linked by a device data spine. The artifact demonstrates how a connected strength training device bridges the gap between clinician and patient for conditions where resistance training is a primary intervention.

### Problem

The clinical evidence strongly supports resistance training for sarcopenia management (ICFSR: strong recommendation, moderate certainty). But the literature reveals a critical gap: **zero studies have evaluated connected strength training devices** as an intervention modality (Berry et al. 2025, 34 studies). Exergames, tablets, videoconferencing, and robotics have been studied — but not the device class Tonal occupies. Meanwhile, adherence drops from 72% (supervised) to 43% (unsupervised) in older adults doing resistance training (n=2,830), and the ICFSR cites cost, transportation, and lack of support as primary patient barriers.

A connected home-based resistance device addresses all three barriers and maintains supervised-equivalent adherence through adaptive programming and provider monitoring. This skill generates the clinical thinking that connects these dots — the pathway design a healthcare platform PM would need to produce.

### Target Users

- PM preparing for a healthcare platform role (primary — interview portfolio piece)
- PM designing clinical workflows for connected device interventions
- Product teams translating clinical evidence into product specifications

### What "Done" Looks Like

The skill, when invoked with "sarcopenia in adults 65+", produces a single markdown artifact containing:

1. **Provider Workflow** with annotated device data touchpoints and an illustrative FHIR CarePlan JSON block (5 fields, plain-English preamble)
2. **Patient Journey** with empirically-anchored drop-off risks, re-engagement mechanisms, and ICFSR-cited barrier mapping per phase
3. A **pre-generated example output** hosted in `examples/` that can be pointed at in a screen

The two outputs share a data spine — the device — making the connection between clinical workflow and patient experience explicit rather than implicit.

---

## 2. Skill Interface

### Trigger

`"clinical pathway"`, `"design clinical pathway"`, `"clinical pathway for [condition]"`, `"care pathway for [condition]"`, `"treatment pathway"`, `"provider workflow for [condition]"`, `"patient journey for [condition]"`

### Input

| Parameter | Required | Description |
|-----------|----------|-------------|
| Condition | Yes | Clinical condition (e.g., "sarcopenia in adults 65+") |
| Device context | No | Connected device type and capabilities (defaults to connected resistance training device with adaptive weight) |
| Care setting | No | Clinical context (defaults to "outpatient, home-based with remote provider monitoring") |

### Output

Single markdown file with frontmatter + two sections + FHIR JSON block.

**File naming:** `clinical-pathway-{condition-slug}.md`
**Example:** `clinical-pathway-sarcopenia-65plus.md`

---

## 3. Project Structure

```
.claude/skills/clinical-pathway-designer/
├── SKILL.md                          # Skill instructions
├── references/
│   ├── sarcopenia-evidence-base.md   # Research synthesis (from /research output)
│   ├── fhir-careplan-shape.md        # CarePlan R4 field reference (5-field subset)
│   └── adherence-data.md             # Supervised vs. unsupervised adherence evidence
examples/
└── clinical-pathway-sarcopenia-65plus.md  # Pre-generated demo output
```

No scripts. No XLSX generation. Pure markdown skill — the output is a document, not a spreadsheet.

---

## 4. Output Format

### 4.1 Frontmatter

```yaml
---
type: clinical-pathway
condition: [condition name]
population: [target population]
device-class: [connected device type]
care-setting: [care setting]
evidence-base:
  guideline: [primary guideline citation]
  efficacy: [primary efficacy citation]
  adherence: [primary adherence citation]
  digital-interventions: [primary digital evidence citation]
generated: [ISO 8601 date]
status: draft
---
```

### 4.2 Section 1: Provider Workflow + FHIR CarePlan

Structure (in order):

#### 4.2.1 Clinical Context
- Condition definition and prevalence
- Diagnostic criteria (EWGSOP2: grip strength < 27kg M / < 16kg F, or chair stand > 15s)
- Why this condition warrants a connected device intervention (the literature gap)

#### 4.2.2 Provider Workflow

Six phases, each with:
- **Phase name and objective**
- **Clinical actions** (what the provider does)
- **Device data touchpoint** [annotated inline] — what data the device captures or surfaces at this phase
- **Decision criteria** for progressing to next phase

Phases:
1. **Screening & Referral** — Gait speed or SARC-F screening → referral to PT/Exercise Physiologist → sarcopenia diagnosis confirmed via EWGSOP2 criteria
2. **Prescription** — Provider creates resistance training prescription: progressive loading protocol, frequency (2-3x/week per evidence), target functional outcomes. [Device: adaptive resistance calibration based on initial assessment]
3. **Initial Assessment** — Baseline functional measures: grip strength, gait speed, 30-second chair stand, TUG. [Device: captures baseline strength metrics across major muscle groups]
4. **Active Training** — Patient executes prescribed program. Provider monitors remotely via device data dashboard. Adjustment triggers: plateau detection, pain reports, missed sessions. [Device: progressive load adjustment per session — the single most evidence-supported training moderator across 14 RCTs]
5. **Progress Monitoring** — Scheduled reassessment at 6, 12, and 24 weeks. Compare functional measures to baseline. Adjust prescription based on trajectory. [Device: longitudinal strength curves, session compliance, load progression data]
6. **Discharge / Maintenance** — Functional targets met → transition to maintenance protocol. Ongoing remote monitoring at reduced frequency. Re-assessment triggers defined.

#### 4.2.3 FHIR CarePlan (Illustrative)

**Plain-English preamble** (required — appears above the JSON block):

> This CarePlan uses five fields chosen to represent the minimum clinical information a provider needs to prescribe, monitor, and adjust a connected-device strength training program. The fields map to the core questions a clinician asks: What condition am I treating? (`addresses`) What outcomes am I targeting? (`goal`) What am I prescribing? (`activity` — exercise therapy + protein supplementation as a combined intervention per ICFSR 4C) Who is on the care team? (`careTeam`) What device supports this plan? (`supportingInfo`).
>
> Goals target **functional measures** (grip strength, gait speed, sit-to-stand, TUG) — not muscle mass. The Chen et al. 2021 meta-analysis of 14 RCTs (n=561) found resistance training significantly improved strength and physical performance (SMD 0.81-1.28) but had no significant effect on skeletal muscle mass, appendicular skeletal muscle mass index, or leg lean mass. Framing goals around hypertrophy would misrepresent what the evidence supports.

**JSON block** — five fields only:

```json
{
  "resourceType": "CarePlan",
  "status": "active",
  "intent": "plan",
  "title": "Sarcopenia Resistance Training Program",
  "addresses": [
    {
      "reference": "Condition/sarcopenia-001",
      "display": "Sarcopenia (ICD-10: M62.84)"
    }
  ],
  "goal": [
    {
      "reference": "Goal/grip-strength-target",
      "display": "Handgrip strength ≥ 27 kg (M) / ≥ 16 kg (F) — EWGSOP2 threshold"
    },
    {
      "reference": "Goal/gait-speed-target",
      "display": "Gait speed ≥ 0.8 m/s — EWGSOP2 functional threshold"
    },
    {
      "reference": "Goal/chair-stand-target",
      "display": "30-second chair stand ≥ age-normative value"
    },
    {
      "reference": "Goal/tug-target",
      "display": "Timed Up and Go improvement ≥ 0.9 seconds from baseline (MCID lower bound; Chen et al. 2021 WMD = -0.93s in sarcopenic older adults)"
    }
  ],
  "activity": [
    {
      "detail": {
        "code": {
          "coding": [
            {
              "system": "http://snomed.info/sct",
              "code": "229065009",
              "display": "Exercise therapy"
            }
          ]
        },
        "description": "Progressive resistance training via connected device. 2-3 sessions/week, 40-80% 1RM, major muscle groups (upper and lower limbs). Adaptive load adjustment per session.",
        "scheduledTiming": {
          "repeat": {
            "frequency": 3,
            "period": 1,
            "periodUnit": "wk"
          }
        }
      }
    },
    {
      "detail": {
        "code": {
          "coding": [
            {
              "system": "http://snomed.info/sct",
              "code": "11816003",
              "display": "Diet education"
            }
          ]
        },
        "description": "Protein supplementation — 1.0-1.2 g/kg/day per ICFSR Recommendation 4A/4C. Combined nutrition + physical activity intervention endorsed by guidelines.",
        "status": "scheduled"
      }
    }
  ],
  "careTeam": [
    {
      "reference": "CareTeam/sarcopenia-team",
      "display": "Primary care physician, Exercise Physiologist/PT, Registered Dietitian"
    }
  ],
  "supportingInfo": [
    {
      "reference": "Device/connected-resistance-trainer",
      "display": "Connected resistance training device with adaptive weight and session tracking"
    }
  ]
}
```

#### 4.2.4 Monitoring & Adjustment Triggers

Table format:

| Trigger | Data Source | Action |
|---------|-----------|--------|
| Missed 3+ sessions in 2 weeks | Device session log | Provider alert → patient outreach |
| Strength plateau (< 5% improvement over 4 weeks) | Device load progression data | Review prescription, adjust program |
| Pain reported during session | Patient self-report via device | Reduce load, flag for PT reassessment |
| Functional measure regression at reassessment | Clinical assessment | Investigate cause, modify protocol |
| Functional targets met and sustained 4+ weeks | Clinical assessment + device data | Transition to maintenance protocol |

### 4.3 Section 2: Patient Journey

Six phases, each with:
- **Phase name** and timeline
- **Touchpoints** — interactions with provider, device, and support system
- **Data captured** — what is recorded and by whom
- **Drop-off risk** — empirically anchored with population-specific citation
- **Re-engagement mechanism** — specific intervention, not generic "follow up"
- **ICFSR barriers addressed** — which of {cost, transportation, support} this phase mitigates, mapped to the ICFSR guideline

Phases:

1. **Referral & Enrollment** (Week -2 to 0)
   - Touchpoints: PCP/geriatrician referral, sarcopenia screening, insurance/eligibility check, device ordering
   - Data: SARC-F score, baseline vitals, insurance verification
   - Drop-off risk: **Referral attrition is a well-documented barrier in older adult populations** — incomplete referral-to-appointment conversion is common in geriatric care, driven by transportation burden, scheduling friction, and low urgency perception. Mitigated by: direct-to-home device delivery eliminates transportation barrier; enrollment coordinator follow-up call within 48 hours
   - Barriers addressed: **Transportation** (home delivery), **Cost** (insurance/employer coverage pathway)

2. **Device Setup & Onboarding** (Week 0-1)
   - Touchpoints: Device delivery, guided setup (in-app or remote technician), initial calibration session, onboarding video with PT
   - Data: Device activation, calibration metrics, initial strength assessment
   - Drop-off risk: **Device setup is the highest-friction window** for digital interventions in older adults. The broader evidence is encouraging — 95% of digital PA interventions were feasible in 60+ populations (Berry et al. 2025, 19/20 studies) — but this depends on well-designed onboarding. Mitigated by: white-glove setup option, simplified interface for 65+ users, family/caregiver involvement in setup
   - Barriers addressed: **Support** (guided onboarding), **Transportation** (home-based)

3. **Initial Assessment & Prescription** (Week 1-2)
   - Touchpoints: Virtual or in-person PT assessment, baseline functional testing (grip, gait, chair stand, TUG), personalized program creation
   - Data: Baseline functional measures, device strength baseline, program parameters
   - Drop-off risk: **Assessment-to-first-session gap** — longest delay is between assessment and beginning the program. Mitigated by: first device session scheduled within 48 hours of assessment; device pre-loads personalized program immediately after PT input
   - Barriers addressed: **Support** (PT-designed program), **Transportation** (virtual assessment option)

4. **Active Training** (Weeks 2-12)
   - Touchpoints: 2-3 device sessions/week, automated progress notifications, PT check-in at week 4 and 8, provider dashboard review
   - Data: Session completion, load progression, rep quality, session duration, self-reported pain/difficulty
   - Drop-off risk: **72% → 43% adherence drop when supervision ends** (Winters-Stone et al. 2022, n=114, mean age 72). The broader MA (Gomez-Redondo 2024, n=2,830) found ~81% attendance for both groups, but 21/34 "unsupervised" studies retained some supervision — the Winters-Stone longitudinal design is the cleaner test of what happens when supervision genuinely stops. The critical window is weeks 3-6 when novelty wears off. Mitigated by: adaptive difficulty (progressive resistance = the key moderator), session streak tracking, PT-triggered outreach when 3+ sessions missed, peer community features
   - Barriers addressed: **Support** (remote monitoring maintains supervised-equivalent engagement), **Transportation** (all sessions at home), **Cost** (no per-session PT fees during active training)

5. **Progress Check-ins** (Weeks 6, 12, 24)
   - Touchpoints: Scheduled functional reassessment (virtual or in-person), provider review of device data trends, program adjustment, nutritional counseling check
   - Data: Updated functional measures vs. baseline, device longitudinal strength curves, adherence percentage, self-reported outcomes
   - Drop-off risk: **Assessment burden fatigue** — patients who don't see measurable progress at the 12-week mark are significantly more likely to discontinue. The evidence shows resistance training effects on strength require ≥ 12 weeks of consistent training (Chen et al. 2021). Mitigated by: showing device-captured micro-progress (load increases, rep improvements) even before clinical measures move; celebrating functional wins (e.g., "you're lifting 15% more than week 1")
   - Barriers addressed: **Support** (data-driven progress visibility reduces "is this working?" uncertainty)

6. **Maintenance & Long-term Engagement** (Week 24+)
   - Touchpoints: Transition to maintenance protocol (reduced intensity/frequency), quarterly provider check-in, annual functional reassessment
   - Data: Ongoing session compliance, strength maintenance vs. peak, annual functional measures
   - Drop-off risk: **Long-term adherence decay** — the 72%→43% delta represents the transition from supervised to unsupervised. Maintenance phase must sustain engagement without active PT oversight. Mitigated by: goal refreshing (new functional targets), social features, program variety, provider "pulse check" triggers based on declining session frequency
   - Barriers addressed: **Support** (continued remote monitoring at reduced frequency), **Cost** (maintenance phase has lower clinical touchpoint cost), **Transportation** (remains home-based indefinitely)

---

## 5. Evidence Anchors

These citations are embedded in the skill's reference material and must be used in the generated output. The skill should cite these — not fabricate or substitute alternative citations.

### Primary Sources

| ID | Citation | Key Finding | Use In Artifact |
|----|----------|-------------|-----------------|
| E1 | ICFSR 2018 (Dent et al.) — *J Nutr Health Aging* 22(10):1148-1161 | **Strong recommendation, moderate certainty** for resistance training as first-line sarcopenia therapy | Clinical context, prescription rationale |
| E2 | Chen et al. 2021 — *Eur Rev Aging Phys Act* 18:23. 14 RCTs, n=561 | Strength/function improved (SMD 0.81-1.28); **muscle mass NOT significant** (SMM, ASMI, LLM all NS) | CarePlan goals framing, functional outcome selection |
| E3 | Gomez-Redondo et al. 2024 — *Sports Med* 54(7):1877-1906. 34 RCTs, n=2,830; Winters-Stone et al. 2022 — *Support Care Cancer*. n=114 | MA: ~81% attendance both groups (methodologically fragile — 21/34 "unsupervised" retained some supervision). Longitudinal: **72% → 43% adherence** when supervision genuinely removed (Winters-Stone). Supervised advantage for knee extension (only outcome surviving sensitivity analysis). | Patient journey drop-off anchors, re-engagement rationale |
| E4 | Berry et al. 2025 — *Front. Aging* 6:1516481. 34 studies | 95% feasibility, 100% usability for digital PA in 60+; **zero connected strength training device studies** | Literature gap framing, device setup feasibility |
| E5 | ICFSR 2018, Recommendation 4A/4C | Protein supplementation as adjunct; nutrition + physical activity combined | CarePlan supportingInfo, provider workflow |
| E6 | ICFSR 2018, Table 1 + patient barriers section | Cost, transportation, lack of support as patient barriers | Patient journey barrier mapping |

### Diagnostic Criteria

| Measure | Threshold | Source |
|---------|-----------|--------|
| Grip strength (M) | < 27 kg | EWGSOP2 (2019) |
| Grip strength (F) | < 16 kg | EWGSOP2 (2019) |
| Chair stand | > 15 s for 5 rises | EWGSOP2 (2019) |
| Gait speed | < 0.8 m/s | EWGSOP2 (2019) |
| SARC-F screening | ≥ 4 points | EWGSOP2 (2019) |

### Training Parameters (from meta-analysis evidence)

| Parameter | Range | Evidence |
|-----------|-------|----------|
| Intensity | 40-80% 1RM | Chen et al. 2021 (14 RCTs) |
| Frequency | 2-3x/week | Chen et al. 2021 |
| Duration | ≥ 12 weeks for significant effects | Chen et al. 2021 |
| Mode | Progressive resistance loading (key moderator) | Chen et al. 2021, subgroup analysis |
| Muscle groups | Upper and lower limbs | 11/14 studies in Chen et al. 2021 |

---

## 6. Boundaries

### Always
- Cite evidence sources inline (not just in references) — every clinical claim traces to a specific source from Section 5
- Frame CarePlan goals around functional measures (grip strength, gait speed, sit-to-stand, TUG) — never muscle mass/hypertrophy
- Include the plain-English preamble above the FHIR JSON block
- Map each patient journey phase to ICFSR-cited barriers {cost, transportation, support}
- Use the 72%→43% adherence delta as the primary drop-off anchor (not generic exercise adherence data)
- Note progressive resistance loading as the device's clinical differentiator, grounded in the moderator analysis
- Include protein supplementation as a second activity in the CarePlan per ICFSR 4C (combined intervention)

### Ask First
- Adding conditions beyond sarcopenia (the skill structure supports it, but each condition needs its own evidence base validation)
- Modifying the FHIR CarePlan fields beyond the specified five
- Adding clinical outcome measures not in the EWGSOP2 diagnostic criteria
- Expanding the provider workflow beyond the six phases

### Never
- Frame goals around muscle mass/hypertrophy (the evidence doesn't support it)
- Use generic exercise adherence citations (e.g., Dishman & Buckworth 1996) instead of population-specific data
- Generate a production-valid FHIR CarePlan (this is illustrative)
- Include EHR integration architecture (separate skill scope)
- Include reimbursement analysis (separate skill scope)
- Present the FHIR JSON without the plain-English preamble

---

## 7. Verification Checklist

Before shipping the skill or its output:

### Skill (SKILL.md)
- [ ] Frontmatter: name, version, description with triggers
- [ ] "When to Use" and "When NOT to Use" sections
- [ ] Evidence anchors table with all 6 sources
- [ ] Boundaries section (always/ask first/never)
- [ ] References directory populated (3 files)

### Generated Output
- [ ] Frontmatter includes condition, population, device-class, evidence-base citations
- [ ] Provider workflow has 6 phases, each with device data touchpoint annotations
- [ ] FHIR CarePlan has exactly 5 fields: addresses, goal, activity, careTeam, supportingInfo
- [ ] CarePlan goals are functional measures only — no muscle mass targets
- [ ] Plain-English preamble appears above the JSON block and explains field selection rationale
- [ ] Protein supplementation appears as second activity in the CarePlan (ICFSR 4C combined intervention)
- [ ] Progressive resistance loading called out as device capability in Phase 4 (Active Training)
- [ ] Patient journey has 6 phases, each with: touchpoints, data, drop-off risk, re-engagement, barriers addressed
- [ ] 72%→43% adherence delta cited in patient journey (not generic adherence data)
- [ ] Every patient journey phase maps to at least one ICFSR barrier {cost, transportation, support}
- [ ] All clinical claims trace to a source in Section 5
- [ ] EWGSOP2 diagnostic thresholds are correct (grip < 27/16 kg, gait < 0.8 m/s, chair stand > 15s)
- [ ] Training parameters match evidence (40-80% 1RM, 2-3x/week, ≥ 12 weeks)

### Example Output (examples/)
- [ ] File exists at `examples/clinical-pathway-sarcopenia-65plus.md`
- [ ] Output passes all "Generated Output" checks above
- [ ] Readable as a standalone document without the skill context
- [ ] No placeholder text — all sections fully populated
- [ ] Could be pointed at in a screen conversation
- [ ] **Non-FHIR-literate reader can read the full artifact in < 5 minutes** and understand the clinical pathway without needing to parse JSON (test: read aloud cold on ship day — if you stumble, rewrite that section)

### 7.5 Failure Modes

The artifact is bad if any of these are true. Test against this list on Day 3 before the ship decision.

| Failure Mode | Symptom | Fix |
|---|---|---|
| **Generic template with keywords** | Provider workflow reads like a boilerplate care pathway with "sarcopenia" search-and-replaced in. No evidence-specific design decisions visible. | Every phase must have at least one design choice that only makes sense because of the specific evidence (e.g., progressive loading as key moderator, functional goals not mass). |
| **FHIR JSON is correct but prose is hand-wavy** | The JSON block is clean but the paragraphs around it say vague things like "providers can monitor progress" without specifying what data, what thresholds, what actions. | Every prose claim must be concrete: what data → what threshold → what action. |
| **Citations present but disconnected** | All 6 sources appear in the text but the link between evidence and design decision isn't explicit. Reader has to infer why the evidence matters. | Each citation must be followed by "therefore, the pathway does X" — the design implication must be stated, not implied. |
| **Two parallel lists, not a shared data spine** | Provider workflow and patient journey are two independent sections that could be read separately without losing anything. The device data doesn't visibly connect them. | At least 3 points where the same device data element appears in both sections — e.g., load progression shows up in provider monitoring triggers AND patient progress visibility. |
| **Drop-off risks are generic** | Patient journey phases have risks like "patients may lose motivation" without population-specific evidence or specific re-engagement mechanisms. | Every risk must cite a specific finding; every mitigation must name a specific product mechanism, not a category. |

---

## 8. Build Plan

### Day 1: Reference files + SKILL.md + first draft output
- Create directory structure
- Convert research output into three reference files (research exists — this is reformatting, not writing):
  - `references/sarcopenia-evidence-base.md`
  - `references/fhir-careplan-shape.md`
  - `references/adherence-data.md`
- Write SKILL.md skeleton with triggers, boundaries, evidence table
- Generate first draft of sarcopenia example output end-to-end (rough is fine — completeness over polish)

### Day 2: SKILL.md complete + output polish + screen prep
- Complete SKILL.md with full instructions
- Polish sarcopenia output: prose quality, citation accuracy, read-aloud test
- Run full verification checklist
- Screen prep: rehearse how to bring up the artifact in conversation, key stats at hand, anticipated questions
- **Checkpoint:** Read the artifact aloud cold. If you stumble or have to explain a section, rewrite that section.

### Day 3: Ship decision
- **Checkpoint:** Is the sarcopenia output good enough to walk into a screen with as-is?
- Test against failure modes (Section 7.5) — does it hit any?
- If yes to ship: final citation verification, commit, done
- If no: take day 4 for targeted fixes on specific failure modes identified

### Day 4 (if needed): Targeted fixes
- Address specific gaps from day-3 checkpoint
- Re-run failure mode test
- Final read-aloud before ship

---

## 9. Out of Scope

| Item | Reason |
|------|--------|
| Production-valid FHIR CarePlan | Illustrative is sufficient for portfolio; full validation is engineering work |
| EHR integration architecture | Separate skill (`ehr-integration-planner`) — this skill stops at the CarePlan shape |
| Reimbursement pathway analysis | Separate skill — different domain expertise |
| MSK rehab condition | Cut per feedback — sarcopenia-only is stronger, less crowded, evidence is cleaner |
| Multiple conditions at equal depth | Skill structure generalizes by inspection; no need to prove it with a second run |
| Nutrition planning module | Protein supplementation is referenced as adjunct, not fully specified |
| Resume link / hosted demo | Build for live screen mention, not application packet |

---

## 10. Demo Strategy

**Live mention in the screen, not resume reference.**

The artifact serves the conversation: "I noticed the literature gap — zero connected strength training device studies in the Berry et al. 2025 scoping review of 34 digital intervention studies. I built a clinical pathway artifact against sarcopenia to think through how a connected device fills that gap. Here's what I learned."

Key stats to have at hand:
- **72% → 43%**: adherence drop supervised → unsupervised (Winters-Stone 2022, n=114; broader MA context: Gomez-Redondo 2024, n=2,830)
- **SMD 0.81-1.28**: effect sizes for strength/function outcomes (n=561)
- **95% / 100%**: feasibility/usability of digital PA interventions in 60+ adults
- **Zero**: connected strength training device studies in the literature
- **Strong recommendation, moderate certainty**: ICFSR grade for resistance training
- **Progressive resistance loading**: single most evidence-supported moderator

Anticipated interviewer questions:
- "Does this work for other conditions?" → "Yes, the structure is condition-agnostic. I picked sarcopenia specifically because the connected-device gap aligns with where Tonal sits."
- "How does this integrate with EHR?" → "Out of scope for this skill — the CarePlan shape shows what would flow into an EHR. Integration architecture is a separate problem."
- "What about muscle mass outcomes?" → "The evidence doesn't support it. Chen et al. 2021 found strength and function improvements but SMM, ASMI, and LLM were all non-significant. Goals should be functional."
