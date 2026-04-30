# imdrf-tech-170921-samd-n41-clinical-evaluation_1

**Pages**: 1-30

---

**📄 Source: PDF Page 1**

IMDRF/SaMD WG/N41FINAL:2017 
 
 
 
 
Final Document 
 
   Title:   Software as a Medical Device (SaMD): Clinical Evaluation 
   Authoring Group:  Software as a Medical Device Working Group 
 
   Date:   21 September 2017 
 
 
 
 
 
 
J. Patrick Stewart, IMDRF Chair 
 
This document was produced by the International Medical Device Regulators Forum. There are 
no restrictions on the reproduction or use of this document; however, incorporation of this 
document, in part or in whole, into another document, or its translation into languages other than 
English, does not convey or represent an endorsement of any kind by the International Medical 
Device Regulators Forum. 
 
Copyright © 2017 by the International Medical Device Regulators Forum.

### Code Examples

```elixir
use of this document; however, incorporation of this
```

---

---

**📄 Source: PDF Page 2**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 2 of 30 
 
Table of Contents 
1.0 
Executive Summary .......................................................................................................4 
2.0 
Background ....................................................................................................................6 
3.0 
Introduction ....................................................................................................................7 
4.0 
Scope ...............................................................................................................................8 
5.0 
Definitions .......................................................................................................................9 
5.1 Clinical Evaluation of a SaMD .........................................................................................9 
5.2 Valid Clinical Association of a SaMD ..............................................................................9 
5.3 Analytical / Technical Validation of a SaMD ...................................................................9 
5.4 Clinical Validation of a SaMD ....................................................................................... 10 
6.0 
General Principles and Context of SaMD Clinical Evaluation Process ..................... 11 
6.1 SaMD Definition Statement and SaMD Category ........................................................... 11 
6.2 Clinical Evaluation Processes ......................................................................................... 12 
7.0 
SaMD Clinical Evaluation Process Flow Chart .......................................................... 13 
7.1 Considerations for Generating and Assessing Evidence .................................................. 15 
8.0 
Importance of Independent Review of a SaMD’s Clinical Evaluation ....................... 16 
9.0 
Pathway for Continuous Learning Leveraging Real World Performance Data ....... 18 
9.1 Considerations for Continuous Learning Leveraging Real World Performance Data ...... 19 
Appendix – Comparison of SaMD Clinical Evaluation Process to Process for Generating 
Clinical Evidence for IVD Medical Devices in GHTF/SG5/N7:2012[13] ................................ 21 
References................................................................................................................................ 22 
Glossary ................................................................................................................................... 24

---

---

**📄 Source: PDF Page 3**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 3 of 30 
 
Preface 
The document herein was produced by the International Medical Device Regulators Forum 
(IMDRF), a voluntary group of medical device regulators from around the world.  The document 
has been subject to consultation throughout its development. 
There are no restrictions on the reproduction, distribution or use of this document; however, 
incorporation of this document, in part or in whole, into any other document, or its translation 
into languages other than English, does not convey or represent an endorsement of any kind by 
the International Medical Device Regulators Forum.

### Code Examples

```elixir
use of this document; however,
```

---

---

**📄 Source: PDF Page 4**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 4 of 30 
 
1.0 Executive Summary 
This document is the fourth issued by the International Medical Device Regulatory Forum 
(IMDRF) that provides a path for global regulators to converge on terminology, a risk-based 
framework, an understanding of quality management system principles, and in this document, an 
approach to making Software as a Medical Device (SaMD) clinically meaningful to users1. This 
document focuses on the activities needed to clinically evaluate SaMD -- and relies on the reader 
to gain knowledge from the previous documents as a pre-requisite to this document. 
This document, and previous documents, provides harmonized principles for individual 
jurisdictions to adopt based on their own regulatory framework. They are not regulations. 
This document describes a converged approach for planning the process for clinical evaluation of 
a SaMD (software with a medical purpose as defined in SaMD N10[1]2), as illustrated in Figure 1, 
to establish that: 
 There is a valid clinical association between the output of a SaMD and the targeted 
clinical condition (to include pathological process or state); and  
 That the SaMD provides the expected technical and clinical data.  
 
Clinical Evaluation 
 
Valid Clinical Association 
 
Analytical Validation 
 
Clinical Validation 
 
 
 
Is there a valid clinical 
association between your 
SaMD output and your 
SaMD’s targeted clinical 
condition? 
Does your SaMD correctly 
process input data to generate 
accurate, reliable, and precise 
output data? 
Does use of your SaMD’s 
accurate, reliable, and precise 
output data achieve your intended 
purpose in your target population 
in the context of clinical care? 
Figure 1 - Clinical Evaluation Process 
The knowledge gained from previous documents is critical to the understanding of information 
in this document. This document builds on previously introduced vocabulary, risk-based 
considerations, and SaMD lifecycle processes and activities to help emphasize the clinical 
considerations essential to the success and adoption of SaMD as illustrated in Figure 2.  
                                               
1 Users include patients, healthcare providers, specialized professionals, lay users, consumers. 
2 Internet addresses (URLs) can be found in the References section.

### Code Examples

```unknown
uses on the activities needed to clinically evaluate SaMD -- and relies on the reader
```

```unknown
include pathological process or state); and
```

```unknown
include patients, healthcare providers, specialized professionals, lay users, consumers.
```

```elixir
use of your SaMD’s
```

---

---

**📄 Source: PDF Page 5**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 5 of 30 
 
 
 
Figure 2- SaMD Landscape

---

---

**📄 Source: PDF Page 6**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 6 of 30 
 
2.0 Background 
The IMDRF has acknowledged that software is an increasingly critical area of healthcare product 
development and has developed a series of documents concerning the definition, the 
categorization, and the application of quality systems principles of SaMD.  
In 2013, IMDRF’s SaMD Working Group released SaMD N10[1] Software as a Medical Device 
(SaMD): Key Definitions to create a standard terminology for SaMD. The following year, 
IMDRF adopted SaMD N12[2] Software as a Medical Device: Possible Framework for Risk 
Categorization and Corresponding Considerations which proposes a method for categorizing 
SaMD based on the seriousness of the condition the SaMD is intended to address. In 2015, the 
SaMD Working Group published SaMD N23[3] Software as a Medical Device (SaMD): 
Application of Quality Management System, outlining how manufacturers should follow Quality 
Management System (QMS) Principles for medical devices as well as good software engineering 
practices.  
Knowledge of the previous three IMDRF SaMD documents is a prerequisite for readers of this 
document. 
This document, and previous documents, provides harmonized principles for individual 
jurisdictions to adopt based on their own regulatory framework. They are not regulations. 
The goal, strategy, principles and concepts, and implementation pathway for a harmonized 
SaMD framework are illustrated below in Figure 3. 
 
 
Figure 3 - SaMD Regulatory Pathway

---

---

**📄 Source: PDF Page 7**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 7 of 30 
 
3.0 Introduction 
The International Medical Device Regulators Forum (IMDRF) seeks to establish a common and 
converged understanding of clinical evaluation and principles for demonstrating the safety, 
effectiveness and performance of SaMD.  
As illustrated in Figure 4, this document represents a global harmonization effort to articulate 
this process. 
Clinical Evaluation 
 
Valid Clinical Association 
 
Analytical Validation 
 
Clinical Validation 
 
 
 
Is there a valid clinical 
association between your 
SaMD output and your 
SaMD’s targeted clinical 
condition? 
Does your SaMD correctly 
process input data to generate 
accurate, reliable, and precise 
output data? 
Does use of your SaMD’s 
accurate, reliable, and precise 
output data achieve your intended 
purpose in your target population 
in the context of clinical care? 
Figure 4- Clinical Evaluation Process 
The document further explains that: 
 Clinical evaluation should be an iterative and continuous process as part of the quality 
management system for medical devices (See SaMD N23[3] for more information);  
 Certain SaMD may require independent review of the results of the clinical evaluation, 
akin to peer review or design review, to ensure that the SaMD is clinically meaningful to 
users.  The level of evaluation and independent review should be commensurate with the 
risk posed by the specific SaMD (See SaMD N12[2] for more information); and 
 Software is unique in its level of connectivity, which may allow the continuous 
monitoring of the safety, effectiveness, and performance of SaMD. This document 
encourages manufacturers to use this feature to understand and modify software based 
on real-world performance. (See 9.0 Pathway for Continuous Learning Leveraging Real 
World Performance Data for more information). 
Healthcare decisions increasingly rely on information provided by the output of SaMD where 
these decisions can impact clinical outcomes and patient care. As such, global regulators expect 
that performance metrics for a SaMD have a scientific level of rigor that is commensurate with 
the risk and impact of the SaMD to demonstrate assurance of safety, effectiveness, and 
performance.

### Code Examples

```elixir
use this feature to understand and modify software based
```

```unknown
require independent review of the results of the clinical evaluation,
```

```unknown
users.  The level of evaluation and independent review should be commensurate with the
```

```elixir
use of your SaMD’s
```

---

---

**📄 Source: PDF Page 8**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 8 of 30 
 
4.0 Scope 
This document focuses on the activities needed to clinically evaluate SaMD -- and relies on the 
reader to gain knowledge from the previous documents as a pre-requisite to this document. 
Specifically, this document: 
 Expects readers to have knowledge of the vocabulary, approach, and common thinking 
of previous IMDRF SaMD documents; 
 Expects readers to understand that the concepts are limited to SaMD, as defined in 
SaMD N10[1], which focuses on software with a medical purpose; and 
 Refers to – and paraphrases as needed -- previous Global Harmonization Task Force 
(GHTF3) and IMDRF documents that provide a common understanding and application 
of terminology, concepts and principles for a clinical evaluation that demonstrates the 
performance metrics of a SaMD. 
This document does NOT exhaustively address all regulatory requirements relevant to SaMD, 
which may vary by jurisdiction (e.g., informed consent, pre-market regulatory review). In 
addition, this document does not repeat the following concepts from previous SaMD documents: 
 The definition of a SaMD (SaMD N10[1]); 
 Examples of SaMD (SaMD N12[2]); 
 Where a SaMD fits in the risk categorization and the descriptions of the risk categories 
(SaMD N12[2]); and  
 Which Quality Management principles are appropriate for SaMD (SaMD N23[3]).  
                                               
3 GHTF was a voluntary group of representatives from national medical device regulatory authorities and industry 
representatives. GHTF was disbanded in 2012 and its mission has been taken over by the IMDRF.

### Code Examples

```unknown
uses on the activities needed to clinically evaluate SaMD -- and relies on the
```

```unknown
uses on software with a medical purpose; and
```

```unknown
requirements relevant to SaMD,
```

---

---

**📄 Source: PDF Page 9**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 9 of 30 
 
5.0 Definitions 
5.1 
Clinical Evaluation of a SaMD 
For purposes of this document “Clinical evaluation of a 
SaMD” is defined as a set of ongoing activities 
conducted in the assessment and analysis of a SaMD’s 
clinical safety, effectiveness and performance as intended 
by the manufacturer in the SaMD’s definition statement. 
This definition is consistent with prior SaMD documents 
and is adapted from GHTF SG5 N2R8:2007[8].  
 
Clinical Evaluation see GHTF SG5 N2R8:2007[8] 
5.2 Valid Clinical Association of a SaMD 
For purposes of this document, valid clinical association, 
also known as scientific validity, is used to refer to the 
extent to which the SaMD’s output (concept, conclusion, 
measurements) is clinically accepted or well-founded 
(based on an established scientific framework or body of 
evidence4), and corresponds accurately in the real world 
to the healthcare situation and condition identified in the 
SaMD definition statement.   
A valid clinical association is an indicator of the level of clinical acceptance and how much 
meaning and confidence can be assigned to the clinical significance of the SaMD’s output in the 
intended healthcare situation and the clinical condition/physiological state. 5 
  
 
SaMD Definition Statement see Section 6.0 in SaMD N12[2] 
SaMD Clinical Considerations see Section 9.1 in SaMD N12[2] 
5.3 Analytical / Technical Validation of a SaMD 
Analytical validation measures the ability of a SaMD to 
accurately, reliably and precisely generate the intended 
technical output from the input data.  Said differently, 
analytical validation: 
 Confirms and provides objective evidence that 
                                               
4 https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3261486/ 
5 https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2993536/  
Does your SaMD correctly process 
input data to generate accurate, reliable, 
and precise output data? 
 
Analytical Validation 
The assessment and analysis of clinical 
data pertaining to a medical device to 
verify the clinical safety, performance 
and effectiveness of the device when 
used as intended by the manufacturer. 
Clinical Evaluation 
Valid Clinical Association 
Is there a valid clinical association 
between your SaMD output and your 
SaMD’s targeted clinical condition? 
Figure 5- Clinical Evaluation 
Figure 6- Valid Clinical Association 
Figure 7-Analytical Validation

### Code Examples

```typescript
used as intended by the manufacturer.
```

```unknown
used to refer to the
```

---

---

**📄 Source: PDF Page 10**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 10 of 30 
 
the software was correctly constructed – namely, correctly and reliably processes input 
data and generates output data with the appropriate level of accuracy, and repeatability 
and reproducibility (i.e., precision); and 
 Demonstrates that (a) the software meets its specifications and (b) the software 
specifications conform to user needs and intended uses. 
The analytical validation is generally evaluated and determined by the manufacturer during the 
verification and validation phase of the software development lifecycle using a QMS.   
Analytical validation is necessary for any SaMD.  
 
SaMD Verification and Validation see Section 8.4 in SaMD N23[3]  
5.4 Clinical Validation of a SaMD 
Clinical validation measures the ability of a SaMD to yield 
a clinically meaningful output associated to the target use 
of SaMD output in the target health care situation or 
condition identified in the SaMD definition statement. 
Clinically meaningful means the positive impact of a 
SaMD on the health of an individual or population, to be 
specified as meaningful, measurable, patient-relevant 
clinical outcome(s), including outcome(s) related to the function of the SaMD (e.g., diagnosis, 
treatment, prediction of risk, prediction of treatment response), or a positive impact on individual 
or public health. 
Clinical validity is evaluated and determined by the manufacturer during the development of a 
SaMD before it is distributed for use (pre-market) and after distribution while the SaMD is in use 
(post-market).  
Clinical validation of a SaMD can also be viewed as the relationship between the verification 
and validation results of the SaMD algorithm and the clinical conditions of interest.  Clinical 
validation is a necessary component of clinical evaluation for all SaMD and can be demonstrated 
by either: 
 Referencing existing data from studies conducted for the same intended use; 
 Referencing existing data from studies conducted for a different intended use, where 
extrapolation of such data can be justified; or 
 Generating new clinical data for a specific intended use. 
Clinical validation is necessary for any SaMD. 
 
SaMD Verification and Validation see Section 8.4 in SaMD N23[3]  
 
Does use of your SaMD’s accurate, 
reliable, and precise output data 
achieve your intended purpose in 
your target population in the 
context of clinical care? 
Clinical Validation 
Figure 8-Clinical Validation

### Code Examples

```elixir
use of your SaMD’s accurate,
```

```unknown
user needs and intended uses.
```

```unknown
use (pre-market) and after distribution while the SaMD is in use
```

---

---

**📄 Source: PDF Page 11**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 11 of 30 
 
6.0 General Principles and Context of SaMD Clinical Evaluation Process 
A SaMD can best be described as software that utilizes an algorithm (logic, set of rules, or 
model) that operates on data input (digitized content) to produce an output that is intended for 
medical purposes as defined by the SaMD manufacturer (Figure 9). The risks and benefits posed 
by SaMD outputs are largely related to the risk of inaccurate or incorrect output of the SaMD, 
which may impact the clinical management of a patient.  
 
Figure 9 - SaMD Basic Programming Model 
6.1 SaMD Definition Statement and SaMD Category  
The SaMD definition statement, as defined in SaMD N12[2], is used by the SaMD manufacturer 
to identify the intended medical purpose of the SaMD (treat, diagnose, drive clinical 
management, inform clinical management), to state the healthcare situation or condition that the 
SaMD is intended for (critical, serious, non-serious), and to describe the core functionality of the 
SaMD.  
The SaMD manufacturer will use the factors identified in the SaMD definition statement to 
determine the category of a SaMD in the SaMD categorization framework as illustrated in Figure 
10. 
State of Healthcare 
Situation or Condition 
Significance of information provided by SaMD to the healthcare decision 
Treat or Diagnose 
Drive Clinical 
Management 
Inform Clinical 
Management 
Critical 
IV 
III 
II 
Serious 
III 
II 
I 
Non-Serious 
II 
I 
I 
Figure 10 - SaMD N12[2] Framework 
 
SaMD Definition Statement see Section 6.0 in SaMD N12[2] 
SaMD Risk Categorization Framework see Section 7.0 in SaMD N12[2] 
Algorithm, Inference 
engine, 
Equations, 
Analysis engine 
Model based logic, etc. 
SaMD defined 
outputs 
(Inform, Drive, 
Diagnose, Treat) 
Patient data 
(Lab results, Image 
medical device data, 
Physiological status, 
Symptoms, etc.) 
Reference data, 
Knowledge base, 
Rules, 
Criteria, etc. 
SaMD inputs 
SaMD outputs 
SaMD Algorithm

### Code Examples

```elixir
use the factors identified in the SaMD definition statement to
```

```unknown
used by the SaMD manufacturer
```

---

---

**📄 Source: PDF Page 12**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 12 of 30 
 
6.2 Clinical Evaluation Processes 
A SaMD manufacturer is expected to implement on-going lifecycle processes to thoroughly 
evaluate the product’s performance in its intended market.  As part of normal new product 
introduction processes, prior to product launch (pre-market) the manufacturer generates evidence  
of the product’s accuracy, specificity, sensitivity, reliability, limitations, and scope of use in the 
intended use environment with the intended user, and generates a SaMD definition statement. 
Once the product is on the market (post-market), as part of normal lifecycle management 
processes, the manufacturer continues to collect real world performance data (e.g., complaints, 
safety data), to further understand the customer’s needs to ensure the product is meeting those 
needs, and to monitor the product’s continued safety, effectiveness and performance in real-
world use. This real world performance data allows the manufacturer to identify and correct any 
problems, support future expansions in functionality, meet anticipated user demands, or improve 
the effectiveness of the device. 
Product lifecycle activities, which include clinical evaluation activities as illustrated in Figure 11, 
should follow 
appropriate 
planning processes 
as part of an 
organization’s 
lifecycle activities 
and processes, as 
described in SaMD 
N23[3].  
Risk assessment 
done as part of the 
SaMD’s lifecycle 
activities and 
processes should 
also be considered 
when conducting 
clinical evaluation.  
 
 
 
 
Pre-market see GHTF Study Group 1 documents[4] 
Post-market see GHTF Study Group 2 documents[5] 
SaMD Considerations for Risk Management see Section 7.2 in SaMD N23[3]  
SaMD User Needs Intended Use see Section 8.3 of SaMD N23[3]  
SaMD Clinical Evidence see Section 8.4 in SaMD N23[3]  
Figure 11 - SaMD Clinical Evaluation Landscape

### Code Examples

```elixir
use environment with the intended user, and generates a SaMD definition statement.
```

```typescript
include clinical evaluation activities as illustrated in Figure 11,
```

```unknown
use. This real world performance data allows the manufacturer to identify and correct any
```

```unknown
user demands, or improve
used reliably and predictably.
```

---

---

**📄 Source: PDF Page 13**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 13 of 30 
 
7.0 SaMD Clinical Evaluation Process Flow Chart  
Clinical evaluation is a systematic and planned process to continuously generate, collect, 
analyze, and assess the clinical data6 pertaining to a SaMD in order to generate clinical evidence 
verifying  the clinical association and the performance metrics of a SaMD when used as intended 
by the manufacturer. The quality and breadth of the clinical evaluation is determined by the role 
of the SaMD for the target clinical condition, and assures that the output of the SaMD is 
clinically valid and can be used reliably and predictably. 
This section uses simple steps to help SaMD manufacturers through the approach to generating 
evidence for the clinical evaluation of a SaMD and provides links to techniques, definitions and 
sources that are available to help a SaMD manufacturer generate appropriate evidence. 
Note: The examples used are not intended to be comprehensive.  All data sources and statistical 
methods should be tailored to the specific SaMD and its intended use. 
Clinical Evaluation 
 
① Valid Clinical Association  
② Analytical Validation 
 
③ Clinical Validation 
 
 
 
Is there a valid clinical 
association between your 
SaMD output and your 
SaMD’s targeted clinical 
condition? 
Does your SaMD correctly 
process input data to generate 
accurate, reliable, and precise 
output data? 
Does use of your SaMD’s 
accurate, reliable, and precise 
output data achieve your intended 
purpose in your target population 
in the context of clinical care? 
Figure 12 - Clinical Evaluation 
① Valid Clinical Association: 
Is there a valid clinical association between 
your SaMD output, based on the inputs and 
algorithms selected, and your SaMD’s 
targeted clinical condition? 
Step 1: Verify that the association between 
the SaMD output and the targeted clinical 
condition is supported by evidence.  
Note: All SaMD should demonstrate a valid clinical association. 
Question: How do I “generate evidence”? 
You can verify by using existing evidence or you can verify by generating new evidence. 
                                               
6 Clinical data is defined as safety and/or performance information that are generated from the clinical use of a 
medical device. Source: GHTF SG5 N1R8:2007[7] 
 
Examples of existing evidence 
 Literature searches  
 Original clinical research 
 Professional society guidelines 
Examples of generating new evidence 
 Secondary data analysis 
 Perform clinical trials

### Code Examples

```unknown
uses simple steps to help SaMD manufacturers through the approach to generating
```

```unknown
used are not intended to be comprehensive.  All data sources and statistical
```

```elixir
use of your SaMD’s
```

```typescript
used as intended
```

---

---

**📄 Source: PDF Page 14**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 14 of 30 
 
② Analytical Validation: 
Does your SaMD meet technical 
requirements? 
Step 1: Generate evidence that shows that 
the output of your SaMD is technically 
what you expected.  
Note: All SaMD should demonstrate 
analytical validation. 
Question: How do I “generate 
evidence”? 
You can generate evidence during 
verification and validation activities as part of your quality management system or as part of 
your good software engineering practices, or by generating new evidence through use of curated 
databases or use of previously collected patient data.  
③ Clinical Validation: 
Does your SaMD generate clinically 
relevant outputs? 
Step 1: Generate evidence that shows 
your: 
 SaMD has been tested in your 
target population and for your 
intended use; and that 
 Users can achieve clinically 
meaningful outcomes through 
predictable and reliable use. 
Note: All SaMD should demonstrate 
clinical validation. 
 
Question: How do I “generate evidence”? 
You can generate evidence to validate clinical significance during verification and validation 
activities as part of your quality management system or as part of your good software 
engineering practices, referencing existing data sources from studies conducted for the same 
intended use.  Where available data references studies conducted for a different intended use, 
extrapolation or generation of new clinical data may be required.  
 
 
Verification – confirmation through 
provision of objective evidence that 
specified requirements have been fulfilled. 
Source: GHTF SG3 N18:2010[6] Section 2.7 
Validation – confirmation through 
provision of objective evidence that the 
requirements for a specific intended use or 
application have been fulfilled. Source: 
GHTF SG3 N18:2010[6] Section 2.8 
              Examples of measures of clinical validation 
 
 Sensitivity 
 Specificity 
 Positive predictive value (PPV) 
 Negative predictive value (NPV)  
 Number needed to treat (NNT) 
 Number needed to harm (NNH) 
 Likelihood ratio negative (LR-) 
 Likelihood ratio positive (LR+) 
 Odds ratio (OR) 
 Clinical usability / User Interface 
 Confidence interval

### Code Examples

```elixir
use of previously collected patient data.
```

```elixir
requirements for a specific intended use or
```

```sql
use.  Where available data references studies conducted for a different intended use,
```

```unknown
requirements have been fulfilled.
```

---

---

**📄 Source: PDF Page 15**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 15 of 30 
 
7.1 
Considerations for Generating and Assessing Evidence 
Being able to generate evidence to demonstrate the valid clinical association, analytical 
validation and clinical validation of a SaMD is essential to establishing the SaMD’s value for 
users. The degree of evidence generation needed for a given SaMD will depend on parameters 
including but not necessarily limited to the:  
 Maturity of evidence underlying the clinical association; and 
 Confidence in the evidence, as applied to a specific SaMD. 
The purpose of the assessment of the evidence is to select information based on its merits and 
limitations to demonstrate that the clinical evaluation evidence is high-quality, relevant, and 
supportive of the SaMD intended use.  
For example, an assessment of clinical association would classify a SaMD as having either a: 
a) Well-established clinical association: These SaMD have outputs with well-documented 
association as identified in sources such as clinical guidelines, clinical studies in peer 
reviewed journals, consensus for the use of the SaMD, international reference materials 
or other similar well-established comparators in terms of previously marketed devices / 
SaMD; or a  
b) Novel clinical association: These SaMD may involve new inputs, algorithms or outputs, 
new intended target population, or new intended use. An example may include the 
combination of non-standard inputs such as mood or pollen count, with standard inputs 
such as gait, blood pressure or other physiological and environmental signals using novel 
algorithms to detect early onset of a deterioration of health or diagnosis of a disease. 
What if I can’t generate evidence to demonstrate ①, ②, or ③? 
 Perform ongoing data analysis  
 Modify your intended use to one that can be supported by available evidence 
 Modify the target clinical association 
 Make changes to the software

### Code Examples

```elixir
use of the SaMD, international reference materials
```

```elixir
use to one that can be supported by available evidence
```

```unknown
users. The degree of evidence generation needed for a given SaMD will depend on parameters
```

```unknown
use. An example may include the
```

---

---

**📄 Source: PDF Page 16**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 16 of 30 
 
8.0 Importance of Independent Review of a SaMD’s Clinical Evaluation  
SaMD categories are based on the levels of impact on the patient or public health where accurate 
information provided by the SaMD is important to treat or diagnose, drive clinical management 
or inform clinical management. For additional information on SaMD categorization, please see 
Section 7.0 in SaMD N12[2]. As part of the risk-based approach, and subject to individual 
jurisdiction’s laws, independent review of clinical evidence of certain low-risk SaMD may be 
less important and the manufacturer may ‘self-declare’ the appropriateness of the evidence. 
Again, subject to individual jurisdiction’s laws, independent review of clinical evidence of more 
high-risk SaMD is more important in providing users the confidence in the SaMD’s performance 
metrics, including but not limited to, identification of design errors or limitation, broadening 
technical competence, testing the appropriateness of assumptions, and management of bias.  
The recommendation for independent review highlights where the evidence generated from the 
clinical evaluation of the SaMD should be reviewed by someone who has not been significantly 
involved in the development of the SaMD, and who does not have anything to gain from the 
SaMD, and who can objectively assess the SaMD’s intended purpose and the conformity with 
the overall clinical evaluation evidence. The level of clinical evaluation and importance of 
independent review should be commensurate with the risk posed by the SaMD. This document 
recommends where independent review is more or less important. 
 
Figure 13 - Risk Based Approach to Importance of Independent Review 
Figure 13 illustrates where independent review is more or less important. In the figure, the red, 
vertical dividing line differentiates where independent review is less important and where 
independent review is more important for different SaMD categories. Independent review is 
more important for SaMD that ‘Treats/Diagnoses Serious and Critical’ health care situations and

### Code Examples

```swift
important and the manufacturer may ‘self-declare’ the appropriateness of the evidence.
```

```unknown
important to treat or diagnose, drive clinical management
```

```unknown
important in providing users the confidence in the SaMD’s performance
```

```unknown
important. In the figure, the red,
```

```unknown
important for different SaMD categories. Independent review is
```

```unknown
important for SaMD that ‘Treats/Diagnoses Serious and Critical’ health care situations and
```

```unknown
important and where
important’ independent review is analogous to the concept of
```

---

---

**📄 Source: PDF Page 17**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 17 of 30 
 
conditions and SaMD that ‘Drives Critical’ health care situations and conditions. Independent 
review in this document does not necessarily imply regulatory review but instead demonstrates 
the concept where independence in review of the results is important.  
For purposes of this document ‘less important’ independent review is analogous to the concept of 
design review performed in the QMS system.  Less important independent reviews can be 
conducted by individuals within the company or by utilizing outside experts.  
For purposes of this document ‘more important’ independent review may be conducted by 
outside experts such as formal consultation with regulators, third parties on behalf of regulators, 
or the editorial board of a peer-reviewed journal, but may also be conducted by “non-conflicted” 
internal expert reviewers without significant involvement in the development of the SaMD.

### Code Examples

```unknown
important independent reviews can be
```

```unknown
important’ independent review may be conducted by
```

---

---

**📄 Source: PDF Page 18**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 18 of 30 
 
9.0 Pathway for Continuous Learning Leveraging Real World Performance 
Data  
SaMD may leverage connectivity between devices, and people to continuously monitor the 
safety, effectiveness and performance of the SaMD.  
A SaMD manufacturer may have a hypothesis about future functionality and intended use of a 
SaMD that may be informed by continuously collecting and analyzing data on use of the SaMD 
in a post-market setting. Monitoring real world performance data can help the SaMD 
functionality and intended use evolve after initial introduction into the market. Such data may 
include post-market information such as safety data, results from performance studies, on-going 
clinical evidence generation for medical devices, new research publications / results that support 
or strengthen the clinical association of the SaMD output to a clinical condition, or direct end-
user feedback, that can help the SaMD manufacturer understand the real world performance of 
the SaMD. This may lead to a change to the SaMD definition statement if supported by the 
clinical evidence generated through clinical evaluation leveraging real world performance data 
from the continuous monitoring as illustrated in Figure 14. 
 
Figure 14 - Pathway for Continuous Learning - Use of Real World SaMD Performance Data in Ongoing SaMD Clinical 
Evaluation 
Learning may impact the original category of a SaMD in the following ways:  
 Real world performance data may provide evidence that the analytical or clinical validity 
of a SaMD is superior to the performance measures initially evaluated by the SaMD 
manufacturer, or

### Code Examples

```elixir
use evolve after initial introduction into the market. Such data may 
include post-market information such as safety data, results from performance studies, on-going
```

```unknown
user feedback, that can help the SaMD manufacturer understand the real world performance of
```

---

---

**📄 Source: PDF Page 19**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 19 of 30 
 
 Real world performance data may provide evidence that analytical or clinical validity of a 
SaMD is inferior to the performance measures initially evaluated by the SaMD 
manufacturer.  
As additional clinical evidence is gathered to confirm the hypothesis and create and support new 
intended use, the SaMD manufacturer will update the clinical evaluation and generate a new 
definition statement. Then the cycle repeats.  
This document encourages SaMD manufacturers to leverage SaMD’s capability to capture real-
world performance data to understand user interactions with the SaMD, and conduct ongoing 
monitoring of analytical and technical performance to support future intended uses.  
9.1 
Considerations for Continuous Learning Leveraging Real World Performance Data 
 SaMD should facilitate post-market information gathering to allow for disablement of 
existing or enablement of new functionality within the SaMD. 
 It is not necessary for the collection of real world performance data by the SaMD 
manufacturer to rely on the active involvement of the end user. The SaMD manufacturer 
should aim to impose the least burdensome approach possible in its data collection and 
leverage the capability of SaMD to collect clinical evidence. 
 With ongoing clinical evaluation the risk categorisation may potentially change, 
necessitating a change in the SaMD definition statement.  
 
Figure 15 - Change to SaMD category from continuous learning 
 Real world performance data including post-market information may not be sufficient to 
generate complete clinical evidence necessary for a change to the SaMD definition 
statement; as such the SaMD manufacturer should appropriately take into account other 
clinical evaluation steps required to support the change in SaMD definition statement.

### Code Examples

```sql
use, the SaMD manufacturer will update the clinical evaluation and generate a new
```

```unknown
user interactions with the SaMD, and conduct ongoing
```

```unknown
user. The SaMD manufacturer
```

```unknown
required to support the change in SaMD definition statement.
use. The labeling should identify limitations of the SaMD relevant to its clinical
```

---

---

**📄 Source: PDF Page 20**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 20 of 30 
 
 During the continuous learning across the life cycle, SaMD manufacturers should 
consider the recommendations in the previous section on independent review when new 
information changes the category of the SaMD as illustrated in Figure 15.  
 The “continuous learning” referred to here is not “machine learning software” (i.e., where 
software device keeps learning automatically after it has been released into the market); 
rather it refers to collecting post-market information.  
 Manufacturers should appropriately review the post-market information collected to 
determine if there are any changes to the safety, effectiveness or performance, or possible 
impact on benefits and risks of the SaMD that would indicate a need for a design change 
or a labeling change regarding contraindications, warnings, precautions or instructions for 
use. The labeling should identify limitations of the SaMD relevant to its clinical 
performance and interpretation of its output in a way that is understood by end users. The 
assessment of post-market information may also lead to a change of intended use (e.g., 
expansion, modification, or restriction). 
NOTE: A change to the SaMD definition statement may be subject to regulatory requirements in 
the individual jurisdiction and a SaMD manufacturer should consult with the regulatory 
authorities in their jurisdiction. 
 
 
SaMD Software Changes see Section 7.5 in SaMD N23[3]  
SaMD Continuous Improvement see Section 7.5 in SaMD N23[3]  
Medical Devices Post Market see GHTF SG3 N79R11:2009[15] 
Medical Devices Observation Studies see Section 6.1 in GHTF SG5 N8:2012[16]

---

---

**📄 Source: PDF Page 21**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 21 of 30 
 
Appendix – Comparison of SaMD Clinical Evaluation Process to Process for 
Generating Clinical Evidence for IVD Medical Devices in GHTF/SG5/N7:2012[13] 
 
Analogous to 
SaMD Valid 
Clinical 
Association 
Analogous to 
SaMD Analytical 
Validation 
Analogous to 
SaMD Clinical 
Validation

---

---

**📄 Source: PDF Page 22**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 22 of 30 
 
References 
IMDRF Documents: 
1. SaMD N10: Software as a Medical Device (SaMD):  Key Definitions -- 
http://www.imdrf.org/docs/imdrf/final/technical/imdrf-tech-131209-samd-key-definitions-
140901.pdf  
 
2. SaMD N12: Software as a Medical Device (SaMD): Possible Framework for Risk 
Categorization and Corresponding Considerations -- 
http://www.imdrf.org/docs/imdrf/final/technical/imdrf-tech-140918-samd-framework-risk-
categorization-141013.pdf  
 
3. SaMD N23: Software as a Medical Device (SaMD): Application of Quality Management 
System -- http://www.imdrf.org/docs/imdrf/final/technical/imdrf-tech-151002-samd-qms.pdf 
 
GHTF Documents: 
4. GHTF Pre-market: GHTF Study Group 1 documents -- http://www.imdrf.org/documents/doc-
ghtf-sg1.asp 
 
5. GHTF Post-market: GHTF Study Group 2 documents--http://www.imdrf.org/documents/doc-
ghtf-sg2.asp 
 
6. GHTF SG3 N18:2010: Quality management system –Medical Devices – Guidance on 
corrective action and preventive action and related QMS processes -- 
http://www.imdrf.org/docs/ghtf/final/sg3/technical-docs/ghtf-sg3-n18-2010-qms-guidance-
on-corrective-preventative-action-101104.pdf 
 
7. GHTF SG5 N1R8:2007: Clinical Evidence – Key Definitions and Concepts-- 
http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n1r8-clinical-evaluation-
key-definitions-070501.pdf 
 
8. GHTF SG5 N2R8:2007: Clinical Evaluation -- 
http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n2r8-2007-clinical-
evaluation-070501.pdf 
 
9. GHTF SG5 N3:2010: Clinical Investigations -- 
http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n3-clinical-investigations-
100212.pdf 
 
10. GHTF SG5 N4: Post-Market Clinical Follow-up Studies -- 
http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n4-post-market-clinical-
studies-100218.pdf 
 
11. GHTF SG5 N6:2012: Clinical Evidence for IVD medical devices – Key Definitions and 
Concepts -- http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n6-2012-
clinical-evidence-ivd-medical-devices-121102.pdf

---

---

**📄 Source: PDF Page 23**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 23 of 30 
 
12. GHTF SG1 N68:2012: Essential Principles of Safety and Performance of Medical Devices -- 
http://www.imdrf.org/docs/ghtf/final/sg1/technical-docs/ghtf-sg1-n68-2012-safety-
performance-medical-devices-121102.pdf 
 
13. GHTF SG5 N7:2012: Clinical Evidence for IVD medical devices - Scientific Validity 
Determination and Performance Evaluation-- 
http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n7-2012-scientific-validity-
determination-evaluation-121102.pdf 
 
14. GHTF SG1 N70:2011: Label and Instructions for Use for Medical Devices-- 
http://www.imdrf.org/docs/ghtf/final/sg1/technical-docs/ghtf-sg1-n70-2011-label-instruction-
use-medical-devices-110916.pdf 
 
15. GHTF SG2 N79R11:2009: Medical Devices: Post Market Surveillance: National Competent 
Authority Report Exchange Criteria and Report Form -- 
http://www.imdrf.org/docs/ghtf/final/sg2/technical-docs/ghtf-sg2-n79r11-medical-devices-
post-market-surveillance-090217.pdf 
 
16. GHTF SG5 N8:2012: Clinical Evidence for IVD Medical Devices - Clinical Performance 
Studies for In Vitro Diagnostic Medical Devices -- 
http://www.imdrf.org/docs/ghtf/final/sg5/technical-docs/ghtf-sg5-n8-2012-clinical-
performance-studies-ivd-medical-devices-121102.pdf 
 
International Standards: 
17. ISO 14155:2011: Clinical investigation of medical devices for human subjects -- Good 
clinical practice -- 
http://www.iso.org/iso/home/store/catalogue_ics/catalogue_detail_ics.htm?csnumber=45557 
 
18. ISO 14971:2007: Application of risk management to medical devices -- 
http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=31550&ICS
1=11&ICS2=40&ICS3=1 
 
19. ISO 62304/A1: 2015: Medical device software – Software life-cycle processes -- 
https://www.iso.org/standard/64686.html 
 
20. IEC 62366-1:2015: Medical Devices – Part 1: Application of usability engineering to 
medical devices -- https://www.iso.org/standard/63179.html 
 
21. IEC 80002-1:2009: Medical device software -- Part 1: Guidance on the application of ISO 
14971 to medical device software -- 
http://www.iso.org/iso/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=54146 
 
22. ISO 82304-1:2016: Health software – Part 1: General requirements for product safety -- 
https://www.iso.org/standard/59543.html

### Code Examples

```unknown
use-medical-devices-110916.pdf
```

```unknown
requirements for product safety --
```

---

---

**📄 Source: PDF Page 24**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 24 of 30 
 
Glossary 
Algorithm -- a finite set of instructions (or rules) that defines a sequence of operations for 
solving a particular computational problem for all problem instances for a problem set. 
Analytical Validation -- measures the ability of a SaMD to accurately and reliably generate the 
intended technical output, from the input data. 
Basic Programming -- problem-solving process used to create a computer program. 
Claim -- the objective intent of the manufacturer regarding the use of a product, process or 
service as reflected in the specifications, instructions and information provided by the 
manufacturer. 
 
 (Also see Intended Use / Purpose) 
Additional resources: see Section 4.0 in GHTF SG1 N68:2012[12] 
Clinical Association -- refers to the extent to which the SaMD’s output (concept, conclusion, 
measurements) is clinically accepted or well founded (existence of an established 
scientific framework or body of evidence) that corresponds accurately in the real world to 
the healthcare situation and condition identified in the SaMD definition statement. 
(Also see Scientific Validity) 
Clinical Considerations -- aspects that can raise or lower the potential to create hazardous 
situations to patients. 
Additional resources: see Sections 4.0 and 9.1 in SaMD N12[2] 
Clinical Data -- defined as safety and/or performance information that is generated from the 
clinical use of a medical device. 
Additional resources: see GHTF SG5 N1R8:2007[7] 
Clinical Evaluation -- the assessment and analysis of clinical data pertaining to a medical device 
to verify the clinical safety, performance and effectiveness of the device when used as 
intended by the manufacturer. 
Additional resources: see GHTF N2R8:2007[8] 
Clinical Evidence -- an important component of the technical documentation of a medical 
device, which along with other design verification and validation documentation, device 
description, labelling, risk analysis and manufacturing information, is needed to allow a 
manufacturer to demonstrate conformity with the Essential Principles. 
Additional resources: see Section 7.5 in SaMD N23[3] , and GHTF SG5 N8:2012[16], 
GHTF SG5 N6:2012[11], GHTF SG5 N1R8:2007[7] 
Clinical Performance -- the ability of a device to yield results that are correlated with a 
particular clinical condition/physiological state in accordance with target population and 
intended user. 
(Also see Clinical Validation)  
Additional resources: see Section 4.0 in GHTF SG1 N68:2012[12] 
Clinical Research -- use of clinical data generated through clinical use.

### Code Examples

```elixir
use of a product, process or
```

```elixir
use of a medical device.
```

```elixir
use of clinical data generated through clinical use.
```

```unknown
used to create a computer program.
```

```unknown
important component of the technical documentation of a medical
```

---

---

**📄 Source: PDF Page 25**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 25 of 30 
 
Additional resources: see Section 6.2 in GHTF G5 N2R8:2007[8] 
Clinical Trials -- A properly conducted clinical investigation, including compliance to the 
clinical investigation plan and local laws and regulations, ensures the protection of 
human subjects, the integrity of the data and that the data obtained is acceptable for the 
purpose of demonstrating conformity to the Essential Principles. 
Additional resources: see Section 6 in GHTF SG5 N3:2010[9] 
Clinical Usability -- the means by which the user and a computer system interact, in particular 
the use of input devices and software and the evaluation of safety considerations for 
device users, use environments and user interfaces.  
Additional resources see ISO/IEC 62366-1:2015[20], SaMD N12[2]Section 4.0, SaMD 
N23[3] Section 7.2 and 8.4  
(Also see Usability, User Interface) 
Clinical Validation -- measures the ability of a SaMD to yield a clinically meaningful output 
associated to the target use of SaMD output in with the target health care situation or 
condition identified in the SaMD definition statement.  
(Also see Clinical Performance) 
Continuous Monitoring -- collecting post-market information. 
Additional resources: see Section 7.5 in SaMD N23[3]  
Confidence Interval -- An interval about a point estimate that quantifies the statistical 
uncertainty in the true value being estimated (e.g. an accuracy metric) due to variability 
in the subject/sample selection process. A 1 – α level confidence interval contains the true 
value in 100(1 – α) % of applications, but in any given application either contains it or 
does not. 
Additional resources: see Section 7.4 in GHTF SG5 N8:2012[16] 
Critical (situation or condition) -- situations or conditions where accurate and/or timely 
diagnosis or treatment action is vital to avoid death, long-term disability or other serious 
deterioration of health of an individual patient or to mitigating impact to public health. 
Additional resources: see Section 5.2.1 in in SaMD N12[2] 
Definition Statement -- clear and strong statement about intended use that explains how the 
SaMD meets one or more of the purposes described in the definition of a medical device 
and describes the SaMD's core functionality.  
Additional resources: see Section 6.0 in in SaMD N12[2] 
Diagnose (SaMD output to) -- information provided by the SaMD will be used to take an 
immediate or near term action. 
(Also see Treat (SaMD output to)) 
Additional resources: see Section 5.1.1 in in SaMD N12[2] 
Drive Clinical Management (SaMD output to) -- the information provided by the SaMD will be 
used to aid in treatment, aid in diagnoses, to triage or identify early signs of a disease or 
condition will be used to guide next diagnostics or next treatment interventions. 
Additional resources: see Section 5.1.2 in SaMD N12[2]

### Code Examples

```elixir
use of input devices and software and the evaluation of safety considerations for
```

```elixir
users, use environments and user interfaces.
```

```elixir
use of SaMD output in with the target health care situation or
```

```elixir
use that explains how the
```

```unknown
user and a computer system interact, in particular
```

```unknown
used to aid in treatment, aid in diagnoses, to triage or identify early signs of a disease or
```

```unknown
used to guide next diagnostics or next treatment interventions.
```

---

---

**📄 Source: PDF Page 26**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 26 of 30 
 
Effectiveness -- when it can be determined that a device, based upon valid scientific evidence, 
that in a significant portion of the target population, the use of the device for its intended 
uses and conditions of use, when accompanied by adequate directions for use and 
warnings against unsafe use, will provide clinically significant results.  
(Also see Safety, Performance) 
Functionality -- identifies the critical features/functions of the SaMD that are essential to the 
intended significance of the information provided by the SaMD to the healthcare decision 
in the intended healthcare situation or condition. 
Additional resources: see Sections 6.0, 7.3, 8.2, 9.1, and 10.1 in SaMD N12[2] 
Global Harmonization Task Force -- was a voluntary group of representatives from national 
medical device regulatory authorities and industry representatives. GHTF was disbanded 
in 2012 and its mission has been taken over by the IMDRF. 
Hypothesis -- a supposition or proposed explanation made as a starting point for further 
investigation. Evidence is not necessary to form a hypothesis. 
Independent Review -- the process of subjecting a work, research, or ideas to the scrutiny of 
others who are experts in the same field. 
Inform Clinical Management (SaMD output to) -- Informing clinical management infers that 
the information provided by the SaMD will not trigger an immediate or near term action. 
Additional resources: see Section 5.1.3 in in SaMD N12[2] 
Input (SaMD) -- one or several defined numeric tables or models accepted by an algorithm.  
(Also see Basic Programming Model, Outputs) 
 
 
Intended (Medical, Purpose, Use) -- the objective intent of the manufacturer regarding the use 
of a product, process or service as reflected in the specifications, instructions and 
information provided by the manufacturer.  
(Also see Claim) 
 
International Medical Device Regulatory Forum -- a voluntary group of medical device 
regulators from around the world who have come together to build on the strong 
foundational work of the Global Harmonization Task Force on Medical Devices (GHTF), 
and to accelerate international medical device regulatory harmonization and convergence. 
Labeling -- the label, instructions for use, and any other information that is related to 
identification, technical description, intended purpose and proper use of the medical 
device, but excluding shipping documents. 
Additional resources: see Section 4.0 in GHTF SG1 N70:2011[14] 
Least Burdensome -- addressing a premarket issue that involves the most appropriate investment 
of time, effort, and resources. 
Likelihood Ratio Negative (LR-) -- (1 – sensitivity) / specificity = ratio of the probabilities of 
testing negative in patients with and without disease or clinical condition.  It can be

### Code Examples

```elixir
use of the device for its intended 
uses and conditions of use, when accompanied by adequate directions for use and
```

```unknown
use, will provide clinically significant results.
```

```unknown
use, and any other information that is related to
```

```elixir
use of the medical
use of published clinical data that establishes a valid clinical association.
```

---

---

**📄 Source: PDF Page 27**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 27 of 30 
 
interpreted as the increase in the odds of disease given a test negative result relative to the 
pretest odds. 
Additional resources: see Section 7.2 in GHTF SG5 N7:2012[13] 
Likelihood Ratio Positive (LR+) -- sensitivity / (1 – specificity) = ratio of the probabilities of 
testing positive in patients with and without disease or clinical condition.  It can be 
interpreted as the increase in the odds of disease given a test positive result relative to the 
pretest odds. 
Additional resources: see Section 7.2 in GHTF SG5 N7:2012[13] 
Literature Search -- use of published clinical data that establishes a valid clinical association. 
 
Additional resources: see Section 6.1 in GHTF SG5 N2R8:2007[8] 
Machine Learning Software (Incremental) -- software device for which input data is 
continuously used to automatically extend the existing device's knowledge i.e. to further 
train the device after it has been released into the market. 
Negative Predictive Value (NPV) -- proportion of test negative patients who do not have the 
disease or clinical condition. 
Additional resources: see Section 7.2 in GHTF SG5 N7:2012[13] 
Non-Serious (situation or condition) -- situations or conditions where an accurate diagnosis and 
treatment is important but not critical for interventions to mitigate long term irreversible 
consequences on an individual patient's health condition or public health. 
Additional resources: see Section 5.2.3 in SaMD N12[2] 
Number Needed To Harm (NNH) -- number of patients that need to be treated in order have an 
adverse effect on one patient. 
Number Needed To Treat (NNT) -- average number of patients that need to be treated in order 
to have an impact on one person. 
Odds Ratio (OR) -- ratio of the odds of disease or clinical condition given the SaMD test result is 
S to the odds of disease given the SaMD test result is not S.  OR is equivalent to ratio of 
likelihood ratio positive to likelihood ratio negative. 
Output  -- results obtained from an algorithm. 
Performance (Essential Principles) -- a product’s behavior must not cause harm to a person, 
place or thing if something goes wrong 
(Also see Effectiveness, Safety) 
Performance (Metrics) -- measures behaviors, activities and performance. 
Performance (Real World) -- information on real-world device use and performance from a 
wider patient population than a more controlled study or pertinent literature, and thus 
provide information that cannot be obtained through such studies. 
(Also see Real World Performance)

### Code Examples

```elixir
use harm to a person,
```

```elixir
use and performance from a
```

```unknown
used to automatically extend the existing device's knowledge i.e. to further
```

```unknown
important but not critical for interventions to mitigate long term irreversible
```

---

---

**📄 Source: PDF Page 28**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 28 of 30 
 
Performance (Studies) -- establish or confirm aspects of device performance which cannot be 
determined by analytical validation, literature and/or previous experience gained by 
routine testing. 
Additional resources: see Section 5.0 in GHTF SG5 N8:2012[16] 
Positive Predictive Value (PPV) -- proportion of test positive patients who have the disease or 
clinical condition. 
Additional resources: see Section 7.2 in GHTF SG5  N7:2012[13] 
Post-market Surveillance -- the practice of monitoring the safety of a medical device after it has 
been released on the market.  
Additional resources: see GHTF Study Group 2[5] documents; GHTF SG2 
N79R11:2009[15] 
Pre-market -- the period prior to a product being available for purchase. 
Additional resources: see GHTF Study Group 1[4] documents 
Professional Society Guidelines -- practices and documents recommended by leading 
authorities; use of existing, well-established standards and/or clinical data. 
Additional resources: see Section 9 in GHTF SG5 N2R8:2007[8] 
Real World (SaMD) Evidence -- evidence derived from aggregation and analysis of real world 
data elements. 
Real World Data -- product information generated after a product has been released to the 
market that can provide insight into the performance of the product used in actual clinical 
settings, in routine medical practice, and by regular use by consumers. 
Real World Performance -- information on real-world device use and performance from a wider 
patient population than a more controlled study or pertinent literature, and thus provide 
information that cannot be obtained through such studies. 
(Also see Performance (Real World)) 
Risk Categorization Framework (SaMD) -- a framework to determine the category of a SaMD 
based on the significance of the information provided to the healthcare decision and on 
the state of the healthcare situation or condition that the SaMD is intended for. 
Additional resources: see Section 7.0 in in SaMD N12[2] 
Safety -- a product should be designed and manufactured in such a way that, when used under 
the conditions and for the purposes intended and, where applicable, by virtue of the 
technical knowledge, experience, education or training, and the medical and physical 
conditions of intended users, they will perform as intended.  
(Also see Effectiveness, Performance) 
Safety Data -- adverse events and other problems with medical devices that impact the health 
and safety of patients; safety data may be collected in the same activity as performance 
data; absence of safety issues during clinical performance testing is an indicator of safety.

### Code Examples

```elixir
use of existing, well-established standards and/or clinical data.
```

```elixir
use and performance from a wider
```

```typescript
users, they will perform as intended.
```

```unknown
used in actual clinical
```

```elixir
use by consumers.
users, 
use environments and user interfaces.
```

---

---

**📄 Source: PDF Page 29**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 29 of 30 
 
Scientific Validity -- refers to the extent to which the SaMD’s output (concept, conclusion, 
measurements) is clinically accepted or well founded (existence of an established 
scientific framework or body of evidence) that corresponds accurately in the real world to 
the healthcare situation and condition identified in the SaMD definition statement.  
(Also see Clinical Association) 
Secondary Data Analysis -- use of analyzed data collected for another purpose. 
Sensitivity -- effectiveness of a SaMD to correctly identifies patients with the intended clinical 
disease or condition.  
Additional resources: see Section 4.0 in GHTF SG5 N7:2012[13] 
Serious (situation or condition) -- situations or conditions where accurate diagnosis or treatment 
is of vital importance to avoid unnecessary interventions (e.g., biopsy) or timely 
interventions are important to mitigate long term irreversible consequences on an 
individual patient’s health condition or public health. 
Additional resources: see Section 5.2.2 in SaMD N12[2] 
Specificity -- correctly identifies across a range of available measurements patients that do not 
have the intended disease or condition. 
Additional resources: see Section 4.0 in GHTF SG5 N7:2012[13] 
Treat (SaMD output to) -- information provided by the SaMD will be used to take an immediate 
or near term action. 
Additional resources: see Section 5.1.1 in in SaMD N12[2] 
Usability -- the means by which the user and a computer system interact, in particular the use of 
input devices and software and the evaluation of safety considerations for device users, 
use environments and user interfaces.  
Additional resources see ISO/IEC 62366-1:2015 [20],  SaMD N12[2] Section 4.0, SaMD 
N23[3] Section 7.2 and 8.4 
(Also see Clinical Usability, User Interface) 
User Interface -- the means by which the user and a computer system interact, in particular the 
use of input devices and software and the evaluation of safety considerations for device 
users, use environments and user interfaces.  
Additional resources see ISO/IEC 62366-1:2015[20],  SaMD N12[2] Section 4.0, SaMD 
N23[3] Section 7.2 and 8.4  
(Also see Clinical Usability, Usability) 
User(s) - includes patients, healthcare providers, specialized professionals, lay users, consumers. 
Validation -- confirmation through provision of objective evidence that the requirements for a 
specific intended use or application have been fulfilled. 
 Additional resources: see Section 2.8 in GHTF SG3 N18:2010[6] 
Verification -- confirmation through provision of objective evidence that specified requirements 
have been fulfilled.

### Code Examples

```elixir
user and a computer system interact, in particular the 
use of input devices and software and the evaluation of safety considerations for device 
users, use environments and user interfaces.
```

```elixir
use of analyzed data collected for another purpose.
```

```elixir
user and a computer system interact, in particular the use of
```

```elixir
use or application have been fulfilled.
```

```unknown
importance to avoid unnecessary interventions (e.g., biopsy) or timely
```

```unknown
important to mitigate long term irreversible consequences on an
```

```unknown
used to take an immediate
```

```unknown
includes patients, healthcare providers, specialized professionals, lay users, consumers.
```

```unknown
requirements for a
```

---

---

**📄 Source: PDF Page 30**

IMDRF/SaMD WG/N41FINAL:2017 
_____________________________________________________________________________________________ 
21 September 2017 
Page 30 of 30 
 
Additional resources: see Section 2.7 in GHTF SG3 N18:2010[6]

---

