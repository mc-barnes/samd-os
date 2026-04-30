---
type: validation
status: approved
owner: "@mc-barnes"
last-reviewed: 2026-04-30
related:
  - examples/test-fixtures/README.md
  - scripts/eval-agents.sh
---
# Agent Evaluation Results — 2026-04-30

## Summary

| Metric | Value |
|--------|-------|
| Date | 2026-04-30 |
| Fixture format validation (dry-run) | **20/20 PASS** |
| Agents evaluated | 5 (regulatory, clinical, safety, QA, cybersecurity) |
| Fixtures per agent | 4 |
| Eval script version | eval-agents.sh v1 |

Dry-run validates: YAML frontmatter has `type` + `status`, expected findings block exists with at least one blocker-level finding, and expected verdict uses valid agent terminology. All 20 fixtures pass format validation.

## Results by Agent

### regulatory-reviewer (4 fixtures)

| Fixture | Expected Blockers | Expected Verdict | Dry-Run |
|---------|-------------------|------------------|---------|
| prd-missing-intended-use | Missing intended use, missing contraindications, no predicate named | NOT SUBMITTABLE | PASS |
| requirements-no-traceability | No requirement IDs, no traceability, orphan requirement | NOT SUBMITTABLE | PASS |
| soup-list-incomplete | Missing risk classification, missing version number | NEEDS REVISION | PASS |
| change-request-no-pccp | Misclassified severity, no risk impact analysis | NOT SUBMITTABLE | PASS |

### clinical-reviewer (4 fixtures)

| Fixture | Expected Blockers | Expected Verdict | Dry-Run |
|---------|-------------------|------------------|---------|
| spo2-fixed-threshold | No GA adjustment, no depth x duration | CLINICALLY UNSAFE | PASS |
| alarm-no-fatigue-analysis | No alarm fatigue analysis, no SatSeconds | NEEDS REVISION | PASS |
| nurse-handoff-jargon | No urgency level, researcher jargon | NEEDS REVISION | PASS |
| home-monitor-no-validation | Implied SIDS benefit, no ABG validation | CLINICALLY UNSAFE | PASS |

### safety-reviewer (4 fixtures)

| Fixture | Expected Blockers | Expected Verdict | Dry-Run |
|---------|-------------------|------------------|---------|
| risk-analysis-happy-path | No foreseeable misuse, incomplete hazard chains | SAFETY CONCERN | PASS |
| fmea-no-afap | No AFAP rationale, controls skip hierarchy | SAFETY CONCERN | PASS |
| usability-engineers-only | Non-representative users, satisfaction-based pass criteria | SAFETY CONCERN | PASS |
| aiml-confidence-untested | "Clinician decides" not validated, confidence scores uncalibrated | SAFETY CONCERN | PASS |

### qa-reviewer (4 fixtures)

| Fixture | Expected Blockers | Expected Verdict | Dry-Run |
|---------|-------------------|------------------|---------|
| capa-human-error | "Human error" root cause, no effectiveness check | NOT AUDIT-READY | PASS |
| complaint-no-mdr-eval | No MDR evaluation, no closure rationale | NOT AUDIT-READY | PASS |
| management-review-rubber-stamp | Missing required inputs, no decisions recorded | NOT AUDIT-READY | PASS |
| supplier-eval-no-soup | SOUP not evaluated as supplier, no monitoring | NEEDS REMEDIATION | PASS |

### cybersecurity-reviewer (4 fixtures)

| Fixture | Expected Blockers | Expected Verdict | Dry-Run |
|---------|-------------------|------------------|---------|
| threat-model-generic | No methodology, no patient safety tracing | SECURITY CONCERN | PASS |
| sbom-no-versions | No versions, no transitive deps | SECURITY CONCERN | PASS |
| security-arch-incomplete | Missing 3 of 4 FDA views | SECURITY CONCERN | PASS |
| vuln-plan-no-cvd | No CVD, no remediation timelines | SECURITY CONCERN | PASS |

## Scoring Criteria

Per `examples/test-fixtures/README.md`:

- **PASS**: All expected blocker-level findings detected (keyword match), verdict matches or is more conservative than expected, no fabricated citations
- **FAIL**: Expected blocker missed, verdict is best-case when blockers exist, or agent fabricates citations

## What This Validates

This dry-run confirms the **test harness integrity** — that all 20 fixtures are well-formed, contain the expected metadata, and are ready for live evaluation against the agents.

A live evaluation (which invokes the agents against each fixture and scores detection accuracy) costs approximately $2.00 for all 20 fixtures (~$0.10/fixture). Live eval results are saved to `examples/test-fixtures/.results/` and can be scored with:

```bash
./scripts/eval-agents.sh all          # live eval, all agents
./scripts/eval-agents.sh --yes all    # skip cost confirmation
```

## Limitations

- Dry-run validates fixture format only — it does not test whether agents actually detect the planted defects
- Live evaluation uses keyword matching (40% threshold), which may produce false passes on vaguely worded findings
- Agent performance may vary across model versions; results should be re-evaluated when the underlying model changes
- These fixtures test known deficiency detection; they do not measure false-positive rate on compliant artifacts

## Next Steps

- [ ] Run live evaluation and commit scored results
- [ ] Add compliant (green-path) fixtures to measure false-positive rate
- [ ] Establish re-evaluation cadence: after any SKILL.md change, reference doc update, or model version change
