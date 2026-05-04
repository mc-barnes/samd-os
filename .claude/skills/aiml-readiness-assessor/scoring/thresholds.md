# Finding-Density Thresholds

## Overview

This document defines how raw findings (critical, major, minor) map to maturity levels for each axis. The decision tree runs once per axis, producing a Level 1-5 score.

Finding severities:
- **Critical** — Fundamental gap that would block a PCCP submission (e.g., no training data governance, no retraining protocol)
- **Major** — Significant deficiency requiring remediation before submission (e.g., no bias testing, no rollback plan)
- **Minor** — Improvement opportunity that does not block submission (e.g., documentation clarity, missing cross-reference)

---

## Decision Tree

First matching rule wins. Evaluate top to bottom.

```
Rule 1:  If no artifacts scanned for this axis           → Level 1
Rule 2:  If ≤1 applicable heuristic could run for axis   → Level 1
Rule 3:  If critical ≥ 1                                 → Level 2  (hard-cap)
Rule 4:  If major = 0  AND  minor = 0                    → Level 5
Rule 5:  If major = 0  AND  minor ≤ 2                    → Level 4
Rule 6:  If major ≤ 1  AND  minor ≤ 3                    → Level 3
Rule 7:  Otherwise                                       → Level 2  (catch-all)
```

---

## Rule Explanations

### Rules 1-2: Insufficient evidence

If the assessor could not scan any artifacts for an axis, or if the artifact coverage was so thin that only 0-1 heuristics could execute, the axis defaults to Level 1. This is not a penalty — it reflects that there is no evidence to assess. The report should include a `coverage_note` explaining which artifacts were missing.

### Rule 3: Hard-cap rule

**Any critical finding caps the axis at Level 2, regardless of how many majors or minors exist.** Rationale: a critical finding represents a fundamental gap (e.g., "no training data governance exists"). The presence of other well-documented elements cannot compensate for a foundational absence. The axis cannot score above Level 2 until all critical findings are resolved.

### Rules 4-7: Finding density

Once critical findings are eliminated (critical = 0), the level is determined by the count of major and minor findings:

| Major | Minor | Level | Rationale |
|:-----:|:-----:|:-----:|-----------|
| 0 | 0 | 5 | No findings — full compliance |
| 0 | 1-2 | 4 | Minor polish needed, fundamentals solid |
| 0-1 | 0-3 | 3 | At most one significant gap plus small issues |
| any other combination | | 2 | Multiple gaps require substantial work |

### Rule 7: Catch-all

Any combination not matched by Rules 1-6 falls to Level 2. This ensures the tree is exhaustive — no input can escape without a classification.

---

## Exhaustiveness Proof

<!--
The decision tree is exhaustive over all possible inputs (artifacts_scanned, heuristics_run, critical, major, minor):

1. artifacts_scanned = 0                    → Rule 1 fires
2. artifacts_scanned > 0, heuristics ≤ 1    → Rule 2 fires
3. artifacts_scanned > 0, heuristics > 1:
   a. critical ≥ 1                          → Rule 3 fires
   b. critical = 0:
      i.   major = 0, minor = 0             → Rule 4 fires
      ii.  major = 0, minor ∈ {1,2}         → Rule 5 fires
      iii. major = 0, minor = 3             → Rule 6 fires (major≤1, minor≤3)
      iv.  major = 0, minor ≥ 4             → Rule 7 fires (catch-all)
      v.   major = 1, minor ≤ 3             → Rule 6 fires
      vi.  major = 1, minor ≥ 4             → Rule 7 fires (catch-all)
      vii. major ≥ 2                        → Rule 7 fires (catch-all)

All branches terminate. No input can reach the end without matching a rule.
-->

All branches terminate. See HTML comment above for the full case analysis.

---

## Coverage Adjustment Rules

### `not_assessed` findings

Heuristics that could not execute (missing artifact, unsupported format, ambiguous scope) produce a `not_assessed` result. These do **not** count as findings (critical, major, or minor). They are reported separately and contribute to `coverage_note`.

### `coverage_note`

When more than 30% of applicable heuristics for an axis return `not_assessed`, the assessor must append a `coverage_note` to the axis result. Format:

```
coverage_note: "X of Y heuristics could not execute. Level score may understate
actual gaps. Missing coverage: [list of heuristic names]."
```

### Minimum viable scan

An axis requires **at least 2 applicable heuristics to execute** for the score to be meaningful (Rules 1-2 enforce this). If exactly 2 heuristics run and both pass, the axis scores Level 5 but the report should flag low coverage confidence.

---

## Edge Case Examples

### Example A: 0 critical, 1 major, 5 minors

```
Rule 1: artifacts scanned? Yes          → continue
Rule 2: heuristics > 1? Yes            → continue
Rule 3: critical ≥ 1? No (0)           → continue
Rule 4: major = 0? No (1)              → continue
Rule 5: major = 0? No (1)              → continue
Rule 6: major ≤ 1? Yes. minor ≤ 3? No (5) → continue
Rule 7: catch-all                       → Level 2
```

**Result: Level 2.** The 5 minors push it past Rule 6's threshold even though there is only 1 major.

### Example B: 0 critical, 3 majors, 0 minors

```
Rule 1: artifacts scanned? Yes          → continue
Rule 2: heuristics > 1? Yes            → continue
Rule 3: critical ≥ 1? No (0)           → continue
Rule 4: major = 0? No (3)              → continue
Rule 5: major = 0? No (3)              → continue
Rule 6: major ≤ 1? No (3)              → continue
Rule 7: catch-all                       → Level 2
```

**Result: Level 2.** Three majors exceed Rule 6's threshold of ≤1.

### Example C: 0 critical, 2 majors, 1 minor

```
Rule 1: artifacts scanned? Yes          → continue
Rule 2: heuristics > 1? Yes            → continue
Rule 3: critical ≥ 1? No (0)           → continue
Rule 4: major = 0? No (2)              → continue
Rule 5: major = 0? No (2)              → continue
Rule 6: major ≤ 1? No (2)              → continue
Rule 7: catch-all                       → Level 2
```

**Result: Level 2.** Two majors exceed Rule 6's threshold even with only 1 minor.

### Example D: 1 critical, 0 majors, 0 minors

```
Rule 1: artifacts scanned? Yes          → continue
Rule 2: heuristics > 1? Yes            → continue
Rule 3: critical ≥ 1? Yes (1)          → Level 2 (hard-cap)
```

**Result: Level 2.** A single critical finding hard-caps regardless of no other findings.

---

## Axis-Specific Calibration

Some axes have fewer applicable heuristics than others. For example, an axis with only 3-4 applicable heuristics produces fewer total findings, so the default thresholds may be too generous.

**Adjustment rule:** If an axis has ≤4 applicable heuristics, tighten the minor threshold for Level 4:

| Applicable heuristics | Level 4 minor threshold | Level 3 minor threshold |
|:---------------------:|:-----------------------:|:-----------------------:|
| ≥5 | ≤2 (default) | ≤3 (default) |
| 3-4 | ≤1 | ≤2 |

Major thresholds remain unchanged. This prevents a low-heuristic axis from scoring Level 4 when half its heuristics flagged minors.

The assessor should log the applicable heuristic count per axis and apply the adjusted thresholds automatically.

---

## Maintenance

- Recalibrate thresholds after accumulating ≥10 real assessments to check for score bunching
- If >60% of assessments cluster at Level 2, thresholds may be too strict — review Rule 6 boundaries
- If >40% score Level 4-5, thresholds may be too lenient — review minor thresholds
