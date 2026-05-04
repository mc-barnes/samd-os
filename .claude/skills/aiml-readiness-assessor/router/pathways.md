# Pathway Router Decision Tree

## Purpose

Translates a maturity profile (4-axis levels + intake metadata) into a concrete next-step recommendation. The router fires the **first matching rule** and then appends any applicable modifiers.

---

## Inputs

| Input | Source | Type |
|-------|--------|------|
| `min_level` | Minimum level across all 4 axes | Integer 1–5 |
| `max_level` | Maximum level across all 4 axes | Integer 1–5 |
| `has_critical_cap` | Any axis is Level 2 due to the hard-cap rule (≥1 critical finding) | Boolean |
| `learning_type` | From intake questionnaire | Enum: `locked`, `batch-retrained`, `continuous` |
| `regulatory_status` | From intake questionnaire | Enum: `pre-submission`, `post-510k`, `post-de-novo`, `post-pma` |
| `modification_pending` | From intake questionnaire | Boolean |

---

## Decision Tree (first match wins)

### Step 1 — Foundation missing

**Condition:** `min_level = 1`

> Foundation work needed. Run `design-controls` skill to establish baseline, then re-assess.

### Step 2 — Critical cap active

**Condition:** `has_critical_cap = true`

> Critical gaps blocking submission. Address critical findings first, then re-assess.

### Step 3 — Significant gaps

**Condition:** `min_level = 2` (no critical cap — reached only if Step 2 did not fire)

> Significant gaps. Run `roadmap-planning` skill with remediation tasks as input.

### Step 4 — Near-ready

**Condition:** `min_level = 3`

> Near-ready. Targeted remediation needed (see roadmap). Estimate 4–8 weeks to PCCP readiness.

### Step 5 — Ready for PCCP

**Condition:** `min_level ≥ 4` AND `learning_type ∈ {batch-retrained, continuous}`

> Ready for PCCP submission. Recommend pre-submission (Q-Sub) to validate approach with FDA.

### Step 6 — Standard pathway (locked model)

**Condition:** `min_level ≥ 4` AND `learning_type = locked`

> Standard submission pathway. No PCCP needed — model is locked post-deployment.

### Step 7 — Default (unreachable guard)

**Condition:** No prior step matched.

> Unable to determine pathway. Review maturity profile and intake fields manually.

---

## Totality Guarantee

Steps 1–3 cover every case where any axis is ≤2:

- Step 1 catches `min_level = 1`.
- Step 2 catches any critical-cap scenario (axis forced to Level 2 by ≥1 critical finding).
- Step 3 catches the remaining `min_level = 2` cases where no critical cap exists.

Step 4 covers `min_level = 3`. Steps 5–6 partition `min_level ≥ 4` by `learning_type`. Because the `learning_type` enum is exhaustive over `{locked, batch-retrained, continuous}`, Steps 5–6 are collectively exhaustive for `min_level ≥ 4`.

Step 7 is unreachable under the current enum definition but guards against future enum extension.

---

## Modifiers

Modifiers are appended to the primary recommendation as separate paragraphs. Evaluate each condition independently and append all that match, in the order listed below.

| # | Condition | Appended text |
|---|-----------|---------------|
| M1 | `modification_pending = true` AND `regulatory_status ∈ {post-510k, post-de-novo}` | Evaluate whether modifications trigger new 510(k) per `change-impact` skill before PCCP path. |
| M2 | `modification_pending = true` AND `regulatory_status = post-pma` | PMA supplement pathway may apply. Consult RA for supplement type determination. |
| M3 | `regulatory_status = pre-submission` | Consider Type C pre-submission meeting to discuss AI/ML approach with FDA. |

### Modifier exclusivity (v1)

In v1, modifier conditions are mutually exclusive: M1 requires `regulatory_status ∈ {post-510k, post-de-novo}`, M2 requires `post-pma`, and M3 requires `pre-submission`. Since `regulatory_status` is single-valued, at most one modifier fires per assessment. The evaluation logic supports stacking (evaluate each independently, append all that match) to accommodate future `regulatory_status` extensions, but in the current enum no combination produces multiple modifiers.

---

## Worked Examples

### Example 1 — Significant gaps, no critical cap

**Inputs:**
- Profile: `[2, 3, 4, 3]`
- `min_level = 2`, `max_level = 4`
- `has_critical_cap = false`
- `learning_type = batch-retrained`

**Evaluation:**
1. Step 1: `min_level = 2` ≠ 1 → skip.
2. Step 2: `has_critical_cap = false` → skip.
3. Step 3: `min_level = 2` → **match**.

**Output:**

> Significant gaps. Run `roadmap-planning` skill with remediation tasks as input.

No modifiers apply (no `modification_pending` or `pre-submission` status specified).

---

### Example 2 — PCCP-ready with pre-submission modifier

**Inputs:**
- Profile: `[4, 4, 5, 4]`
- `min_level = 4`, `max_level = 5`
- `has_critical_cap = false`
- `learning_type = continuous`
- `regulatory_status = pre-submission`

**Evaluation:**
1. Step 1: `min_level = 4` ≠ 1 → skip.
2. Step 2: `has_critical_cap = false` → skip.
3. Step 3: `min_level = 4` ≠ 2 → skip.
4. Step 4: `min_level = 4` ≠ 3 → skip.
5. Step 5: `min_level ≥ 4` AND `learning_type = continuous` → **match**.

**Modifier evaluation:**
- M1: `regulatory_status = pre-submission` ∉ `{post-510k, post-de-novo}` → skip.
- M2: `regulatory_status ≠ post-pma` → skip.
- M3: `regulatory_status = pre-submission` → **append**.

**Output:**

> Ready for PCCP submission. Recommend pre-submission (Q-Sub) to validate approach with FDA.
>
> Consider Type C pre-submission meeting to discuss AI/ML approach with FDA.

---

### Example 3 — Critical cap blocks submission

**Inputs:**
- Profile: `[2, 3, 3, 3]` (Data Management axis capped at Level 2 due to critical finding)
- `min_level = 2`, `max_level = 3`
- `has_critical_cap = true`
- `learning_type = batch-retrained`

**Evaluation:**
1. Step 1: `min_level = 2` ≠ 1 → skip.
2. Step 2: `has_critical_cap = true` → **match**.

**Output:**

> Critical gaps blocking submission. Address critical findings first, then re-assess.

Note: Even though `min_level = 2` would also match Step 3, Step 2 fires first because the critical cap takes priority. The critical finding on the Data Management axis must be resolved before any roadmap planning is meaningful.
