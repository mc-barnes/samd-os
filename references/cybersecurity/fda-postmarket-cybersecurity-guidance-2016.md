# Postmarket Management of Cybersecurity in Medical Devices — FDA Guidance

**Source:** FDA Guidance for Industry and Food and Drug Administration Staff
**Issued:** December 28, 2016
**Document Number:** FDA-2015-D-5105
**Original:** Postmarket-Management-of-Cybersecurity-in-Medical-Devices---Guidance-for-Industry-and-Food-and-Drug-Administration-Staff.pdf

---

## I. Introduction & Scope

This guidance provides recommendations for managing cybersecurity vulnerabilities for marketed and distributed medical devices. It is intended for manufacturers (device and software), hospital and health care facility IT staff, and other servicing entities.

The FDA recognizes that the threat landscape evolves continuously and that effective cybersecurity management requires an ongoing, lifecycle approach.

## II. Key Definitions

| Term | Definition |
|------|-----------|
| **Compensating controls** | Safeguards or countermeasures employed in lieu of or absence of controls designed into the device to reduce vulnerability exploitation risk |
| **Controlled risk** | Residual risk of patient harm is sufficiently low due to existing mitigations and compensating controls |
| **Uncontrolled risk** | Unacceptable residual risk of patient harm due to insufficient mitigations and compensating controls |
| **Cybersecurity signal** | Any information that indicates a potential cybersecurity vulnerability or exploit — from complaints, service records, vulnerability databases, security researchers, ISAOs |
| **Exploit** | A defined way to breach the security of a system through a vulnerability |
| **Patient harm** | Physical injury or damage to the health of patients, including death |
| **Remediation** | Addressing a cybersecurity vulnerability through actions that reduce risk |
| **Threat** | A circumstance or event with the potential to exploit a vulnerability |
| **Threat modeling** | Analysis of device representations to highlight security concerns |
| **Vulnerability** | A weakness in a system that can be exploited by a threat source |
| **Essential performance** | Performance necessary to achieve freedom from unacceptable risk |
| **Cybersecurity routine updates and patches** | Updates or patches to address device vulnerabilities, including those related to controlled risks. These are a type of device enhancement and generally do not require reporting under 21 CFR part 806 |

## III. General Principles

### Premarket and Postmarket Considerations

- Premarket controls (design and development) establish the baseline cybersecurity posture
- Postmarket management must address the evolving threat landscape
- Manufacturers cannot simply design a secure device and walk away — ongoing monitoring and response is required

### Total Product Life Cycle (TPLC)

- Cybersecurity is a shared responsibility among stakeholders: manufacturers, healthcare facilities, patients, and providers
- NIST Cybersecurity Framework (Identify, Protect, Detect, Respond, Recover) provides the organizing structure
- Risk management per ISO 14971 applies to cybersecurity risks

## IV. Cybersecurity Risk Management

### Exploitability Assessment

The **Common Vulnerability Scoring System (CVSS)** provides a framework for assessing exploitability. Key factors:
- **Remote exploitability** — can the vulnerability be exploited without physical access?
- **Attack complexity** — how difficult is it to exploit?
- **Privileges required** — does the attacker need authentication?
- **User interaction** — does exploitation require a user action?
- **Exploit code maturity** — is exploit code publicly available?

### Severity of Patient Harm

Assess the potential severity if the vulnerability is exploited:
- **Negligible** — inconvenience or temporary discomfort
- **Minor** — results in temporary injury or impairment
- **Serious** — results in injury or impairment requiring medical intervention
- **Critical** — results in permanent impairment or life-threatening injury
- **Catastrophic** — results in patient death

### Risk Assessment Matrix

| | Negligible | Minor | Serious | Critical | Catastrophic |
|---|---|---|---|---|---|
| **High exploitability** | Controlled | Controlled | Uncontrolled | Uncontrolled | Uncontrolled |
| **Low exploitability** | Controlled | Controlled | Controlled | Uncontrolled | Uncontrolled |

*Note: This is the FDA's recommended framework. Manufacturers may use their own matrix if appropriately justified.*

## V. Controlled Risk — Management and Reporting

### When Risk is Controlled

- The device's safety and essential performance are not impacted, OR
- Risk mitigations and compensating controls adequately reduce residual risk to acceptable levels

### Manufacturer Actions for Controlled Risk

- Communicate with users on how to address the vulnerability
- Develop defense-in-depth strategies
- Deploy cybersecurity routine updates and patches
- These changes are typically **device enhancements, not recalls**
- Generally not required to be reported under 21 CFR part 806

### Examples of Controlled Risk Scenarios

1. **Malware on gas blood analyzer** — malware confirmed present but does not result in manipulation of unencrypted data. Safety and essential performance not impacted. Manufacturer communicates removal guidance and develops defense-in-depth patch.

2. **Database vulnerability in chemistry analyzer** — four-year-old vulnerability in OTS database software. Allows unauthorized viewing (not editing) of PHI. Manufacturer notifies customers, details secure configuration settings, documents effectiveness of configuration update.

3. **Open communication port** — ICS-CERT notification of unused port. Design features prevent unauthorized firmware download. Physical access required to exploit. Manufacturer closes ports via cybersecurity routine update.

4. **Browser-collecting malware on Class III device** — malware collects browsing information only. Safety and essential performance not impacted. Class III devices should report in periodic (annual) PMA report per 21 CFR 814.84.

## VI. Uncontrolled Risk — Management and Reporting

### When Risk is Uncontrolled

- Unacceptable residual risk of patient harm due to insufficient mitigations and compensating controls
- Exploitability of the vulnerability combined with severity of potential harm exceeds the acceptability threshold

### Manufacturer Actions for Uncontrolled Risk

Manufacturers should remediate uncontrolled risks **as quickly as possible**:

1. Remediate the vulnerabilities to reduce risk of patient harm to acceptable level
2. While fixing, identify and implement risk mitigations and compensating controls
3. Provide customers/community with information on recommended controls and residual risks
4. Report vulnerabilities to FDA per 21 CFR part 806 (unless reported under 21 CFR parts 803 or 1004)

### FDA Enforcement Discretion for Uncontrolled Risk

FDA does not intend to enforce 21 CFR part 806 reporting when ALL of the following are met:

1. No known serious adverse events or deaths associated with the vulnerability
2. Within **30 days** of learning of the vulnerability: communicate with customers and user community, identify interim compensating controls, develop a remediation plan. Customer communication must:
   - Describe the vulnerability with impact assessment
   - State efforts are underway to address risk
   - Describe compensating controls
   - State manufacturer is working on fix or defense-in-depth strategy
3. Within **60 days** of learning of the vulnerability: fix, validate, and distribute the deployable fix so residual risk is acceptable
4. Manufacturer actively participates as a member of an **ISAO** (e.g., NH-ISAC) and shares vulnerability information

### Examples of Uncontrolled Risk Scenarios

1. **Hardcoded password in implantable defibrillator** — exploitable vulnerability could allow reprogramming by unauthorized user, resulting in life-threatening injury or death. Emergency patch distributed within 60 days. Not an ISAO member, so reports under 21 CFR 806.10.

2. **Known vulnerability in Class II device** — vulnerability introduces new failure mode impacting essential performance. Design controls do not mitigate. Interim compensating control: disconnect from hospital network. Permanent patch within 60 days. ISAO member gets enforcement discretion.

3. **Previously unknown vulnerability causes patient death** — medical device malfunction from exploitation of unknown vulnerability. Manufacturer files MDR under 21 CFR 803, notifies customers, develops emergency patch, files 806 report.

## VII. Reporting

### Cybersecurity Routine Updates and Patches

- Changes made solely to strengthen cybersecurity are **device enhancements**
- Generally **not required to be reported** under 21 CFR part 806
- For PMA devices with 21 CFR 814.84 periodic reporting requirements: report cybersecurity changes in periodic (annual) report

### When FDA Reporting IS Required

- When the risk of patient harm is **uncontrolled** AND the manufacturer does not meet all four criteria for enforcement discretion (especially ISAO participation)
- When the vulnerability results in a reportable adverse event under 21 CFR part 803
- When device changes require a new premarket submission (PMA supplement, 510(k), etc.)

## VIII. Recommended Content for PMA Periodic Reports

For PMA devices under 21 CFR 814.84, include:

- Brief description of vulnerability and how it was discovered
- Risk assessment summary — controlled vs. uncontrolled determination
- Description of changes made, compared to previously approved version
- Rationale for the change
- Related submissions/devices modified for the same vulnerability
- Event references (MDR numbers, recall numbers)
- UDI (if available)
- Link to ICS-CERT advisory or ISAO alert (if applicable)
- All distributed customer notifications
- ISAO reporting date and name
- References to related submissions, or regulatory basis for no submission required

## IX. ISAO Active Participation Criteria

FDA considers a manufacturer an active participant in an ISAO when:

1. The manufacturer is a member of an ISAO that shares vulnerabilities and threats impacting medical devices
2. The ISAO has documented policies for participant agreements, business processes, operating procedures, and privacy protections
3. The manufacturer shares vulnerability information with the ISAO, including customer communications
4. The manufacturer has documented processes for assessing and responding to vulnerability and threat intelligence received from the ISAO, traceable to medical device risk assessments, countermeasures, and mitigations

Manufacturers should maintain objective evidence documenting that they meet all four criteria.

## X. Appendix: Elements of an Effective Postmarket Cybersecurity Program

Organized per the **NIST Cybersecurity Framework** (Identify, Protect, Detect, Respond, Recover):

### A. Identify

- **Maintaining safety and essential performance** — define safety and essential performance of the device, severity of harm if compromised, and risk acceptance criteria
- **Identification of cybersecurity signals** — monitor complaints, service records, NVD, ICS-CERT, ISAOs, security researchers, and other critical infrastructure sectors
- **Vulnerability intake process** — clear, consistent, reproducible process per ISO/IEC 29147:2014 and ISO/IEC 30111:2013

### B. Protect/Detect

- **Vulnerability characterization and assessment** — use CVSS for consistent exploitability scoring; consider remote exploitability, attack complexity, privileges required, exploit code maturity
- **Risk analysis and threat modeling** — conduct cybersecurity risk analyses including threat modeling for each device; update cyclically; produce summary reports traceable to related documentation
- **Analysis of threat sources** — characterize intent and method of adversaries; covers risks not addressed by traditional FMEA
- **Threat detection capabilities** — incorporate design features for detecting and forensically capturing evidence of attacks
- **Impact assessment on all devices** — assess signals horizontally (across product portfolio) and vertically (within specific device components)

### C. Protect/Respond/Recover

- **Compensating controls assessment** — device-based design controls are primary; compensating controls provide defense-in-depth
- **Coordinated vulnerability disclosure** — adopt policy including acknowledgment within specified timeframe per ISO/IEC 29147:2014
- **Risk mitigation of safety and essential performance** — determine if risk is adequately controlled; actions should reflect magnitude of risk; include evaluation of residual risk, benefit/risk, and risk introduced by remediation; validate remediation adequacy
- **Cybersecurity routine updates and patches** — generally considered device enhancements, not recalls
