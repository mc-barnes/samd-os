# FDA Cybersecurity Select Updates — Section 524B (April 2024)

**Source:** FDA webinar slides — "Cybersecurity Select Updates" by Matthew Hazelett, OPEQ Digital Health Staff
**Date:** April 30, 2024
**Original:** printable-slides_cybersecurity_select_updates_april_2024.pdf

---

## Overview

FDA presentation covering proposed interpretations of key terms in Section 524B of the FD&C Act, coordinated vulnerability disclosure (CVD) procedures, documentation recommendations, and guidance on device modifications.

## Key Statutory Background

- **Consolidated Appropriations Act, 2023 (Omnibus)** signed December 29, 2022
- Section 3305 — "Ensuring Cybersecurity of Medical Devices" — added **Section 524B** to FD&C Act
- Requirements effective for submissions filed on or after **March 29, 2023**
- RTA policy expired **October 1, 2023** — all cyber device submissions must now include 524B information

## Proposed Interpretations of Key Terms

### Cyber Device (Section 524B(c))

A device that:
1. Includes software validated, installed, or authorized by the sponsor as a device or in a device
2. Has the ability to connect to the internet
3. Contains technological characteristics that could be vulnerable to cybersecurity threats

**"Ability to connect to the internet"** — Proposed interpretation: the device's *designed capability* to connect, not whether it is *currently connected*. Includes devices with WiFi, Bluetooth (if bridgeable to internet), Ethernet, cellular, or any protocol that could route to internet.

**"Could be vulnerable to cybersecurity threats"** — Proposed interpretation: virtually all software-containing, internet-connectable devices meet this criterion. FDA does not expect manufacturers to prove invulnerability to satisfy this prong.

### Related Systems

- Section 524B references "the device and related systems"
- **Proposed interpretation:** systems that interact with or connect to the cyber device and could impact its cybersecurity posture
- Includes: hospital network infrastructure, cloud services, companion apps, gateways, other connected devices in the ecosystem

## Section 524B(b)(1): Postmarket Vulnerability Management

Manufacturers must submit a plan to monitor, identify, and address postmarket cybersecurity vulnerabilities and exploits, including:

- **Coordinated Vulnerability Disclosure (CVD) procedures**
  - Process for receiving vulnerability reports from external researchers
  - Timelines for acknowledgment, investigation, and remediation
  - Communication plan for affected users/customers
  - Alignment with ISO/IEC 29147:2018 (Vulnerability Disclosure) and ISO/IEC 30111:2019 (Vulnerability Handling)

- **Postmarket monitoring plan**
  - Sources monitored (NVD, ICS-CERT, ISAOs, vendor advisories)
  - Frequency of monitoring
  - Triage and severity assessment process
  - Escalation criteria

## Section 524B(b)(2): Design, Development, and Maintenance

Manufacturers must demonstrate processes providing reasonable assurance of cybersecurity:

- Secure Product Development Framework (SPDF) aligned with recognized standards
- Threat modeling performed and documented
- Security architecture documented
- Security testing (penetration testing, fuzz testing, static analysis, dynamic analysis)
- Patch management — ability to deploy updates in a timely manner
- End-of-life / end-of-support planning

## Section 524B(b)(3): Software Bill of Materials (SBOM)

- Must include commercial, open-source, and off-the-shelf components
- NTIA minimum elements recommended
- Machine-readable format preferred (SPDX, CycloneDX)
- Must be maintained and updated throughout product lifecycle

## Documentation Recommendations by Submission Type

### Full Premarket Submission (new device)
- Complete cybersecurity documentation per guidance Section V
- Threat model, security risk assessment, SBOM, architecture views
- Security testing results
- Postmarket management plan including CVD

### Modifications to Previously Cleared/Approved Devices

**Changes likely to impact cybersecurity:**
- New/changed network connectivity
- New/changed encryption or authentication
- Changes to SOUP/OTS software components with known vulnerabilities
- New data flows or interfaces
- Changes to update/patch mechanisms

**Changes unlikely to impact cybersecurity:**
- UI-only changes with no security implications
- Bug fixes that do not affect security controls
- Label-only changes
- Changes to non-connected components

For changes likely to impact cybersecurity: submit updated cybersecurity documentation for the changed aspects. For changes unlikely to impact: provide rationale for why cybersecurity is not impacted.

## Key Takeaways from FDA Presentation

1. **Section 524B is law, not guidance** — compliance is mandatory for cyber devices
2. **Broad interpretation of "cyber device"** — most software-containing connected devices qualify
3. **CVD is required** — not optional; must have documented process for receiving and handling vulnerability reports
4. **SBOM is required** — must be maintained throughout TPLC
5. **Modification submissions** must address cybersecurity impact even if the primary change is not cybersecurity-related
6. **ISAO participation** strongly encouraged but not mandated by statute
7. **eSTAR cybersecurity section** must be completed accurately — incomplete submissions placed on Technical Screening hold
