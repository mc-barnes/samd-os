---
name: Deployment options when source code can't leave the customer environment
description: Talking points for customer/stakeholder questions about samd-os deployment in regulated or IP-sensitive environments
type: faq
status: draft
owner: @mccaybarnes
last-reviewed: 2026-05-11
---

# Deployment options when source code can't be in the public cloud

## The question
> "We can't put our source code in the public cloud. How would we use samd-os?"

## The short answer
samd-os's regulatory workflows run on documents, not source code. For the small subset of skills that touch code, we support deployment through AWS Bedrock or GCP Vertex AI so code never leaves the customer's cloud tenancy — or those skills can be skipped entirely.

## The framing

**Most of samd-os doesn't need source code at all.** The bulk of the value is in regulatory artifact workflows:

- PRDs (`prd-writer-samd`)
- Design controls / traceability (`design-controls`)
- Risk management / FMEA (`risk-management`)
- FHIR resources and bundles (`fhir-builder`)
- Design review packages — PDR / CDR / FDR (`design-review`)
- Change impact / re-verification scope (`change-impact`)
- AI/ML readiness and PCCP gap analysis (`aiml-readiness-assessor`)
- Clinical pathway design (`clinical-pathway-designer`)
- Launch readiness checklists (`launch-readiness`)

These operate on markdown specs, structured inputs, and XLSX outputs. A regulated organization can adopt samd-os for the entire DHF and submission workflow without a single line of source code leaving their environment.

## The exceptions — three reverse-engineering skills

These walk the source tree:

1. `code-to-design-inputs` — derives IEC 62304 Clause 5.2 design inputs from existing code
2. `code-to-soup-register` — parses dependency manifests for IEC 62304 §5.3.3 SOUP register
3. `code-to-hazard-candidates` — identifies safety-critical code regions for hazard analysis

For customers who can't send code to a public-cloud LLM, the options stack roughly in order of effort:

### Option 1 — Claude via AWS Bedrock or GCP Vertex AI
Same Claude model, running in the customer's cloud tenancy with their BAA and data controls. Most "no public cloud" policies actually mean "no shared-tenancy SaaS"; Bedrock and Vertex usually clear that bar.

### Option 2 — Anthropic Zero Data Retention (ZDR) tier
Enterprise contract where prompts and responses aren't stored. Satisfies most internal security review checklists without requiring a cloud migration.

### Option 3 — Run reverse-engineering skills on a sanitized subset
`code-to-soup-register` only needs dependency manifests (`package.json`, `requirements.txt`, `go.mod`, etc.). These don't expose business logic, so the SOUP register can be generated without exposing core IP. `code-to-design-inputs` and `code-to-hazard-candidates` can be run on a redacted or subset codebase.

### Option 4 — Skip the reverse-engineering skills entirely
They're optional. The forward-direction workflows (spec → design inputs → V&V → submission) work without ever ingesting code.

## Sales-ready one-liner
> "samd-os's regulatory workflows run on documents, not source code. For the three skills that touch code, we support deployment through AWS Bedrock or GCP Vertex AI so your code never leaves your cloud tenancy — or you can skip those skills and use the rest of the system."

## Related questions to anticipate
- **PHI / HIPAA?** — samd-os generates regulatory artifacts; it shouldn't be processing PHI. If a workflow accidentally needs PHI (e.g., complaint records), the same Bedrock / Vertex / ZDR options apply.
- **Air-gapped environment?** — Claude Code itself requires network access to Anthropic's API (or Bedrock / Vertex endpoints). Fully air-gapped deployment is not supported today.
- **Audit trail?** — Outputs are markdown / XLSX checked into the customer's own git repo. The DHF lives in their VCS, not ours.
