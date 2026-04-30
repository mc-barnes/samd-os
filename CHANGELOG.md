# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-04-30

### Added

- regulatory-reviewer agent persona (`.claude/skills/agents/regulatory-reviewer/`) — FDA SaMD artifact reviewer with two-tier review model, 8 evaluation dimensions, and reference index mapping to 28 docs
- qa-reviewer agent persona (`.claude/skills/agents/qa-reviewer/`) — ISO 13485 QMS compliance reviewer with 8 evaluation dimensions
- Cybersecurity section in regulatory-reviewer covering FDA Premarket Cybersecurity Guidance (2023), SBOM, AAMI TIR57, IEC 81001-5-1
- AI disclaimer on all agent review outputs
- Jurisdiction statement (FDA only) on all regulatory-reviewer outputs
- CHANGELOG.md (this file)
- Risk acceptability matrix extracted to `regulatory/risk-management/risk-acceptability-matrix-v1.md`

### Changed

- ALARP → AFAP rename in risk-management skill (ISO 14971:2019 alignment)
- Standards editions pinned in root CLAUDE.md (IEC 62304:2006+A1:2015, ISO 14971:2019/EN, etc.)
- FMEA/RPN explicitly scoped as process FMEA with ISO 14971:2019 Annex G citation
- Clinical-reviewer reframed away from named-person impersonation to RPM pattern
- Regulatory-reviewer citation accuracy: "six traceability chains" reframed as industry best practice; software hazard probability softened from universal rule to common approach
- `status.sh` simplified: frontmatter-based filtering replaces hardcoded filename exclusions

### Fixed

- Mermaid block rendering in README

## [1.0.0] - 2025-04-28

### Added

- Initial repository structure: 7 content folders with CLAUDE.md nav maps and `_TEMPLATE.md` files
- 14 shared skills in `.claude/skills/`
- clinical-reviewer agent persona
- CONTRIBUTING.md routing guide
- Frontmatter schema documented in root CLAUDE.md
- `sources-of-truth.md` and `team/decisions/` structure
- SOUP register template in `engineering/sdlc/`
- CER folder staged in `clinical/`
- 6 example artifacts in `examples/`
- `scripts/status.sh` for frontmatter-based status reporting
