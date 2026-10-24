# HR operating design and implementation status

Proposed operating design, researched 2026-10-23 America/Toronto. Department
records and dashboards have not yet been created or activated. Initial jurisdiction
assumption: Ontario; configure the employer, worker category and applicable policy.

## HR functions

Small tenants can assign several functions to one person. These are configurable
responsibilities, not invented roles, permission keys or production department rows.

| Function | Responsibilities |
| --- | --- |
| HR operations | Employee lifecycle, restricted records, probation and offboarding |
| Recruitment | Approved vacancies, postings, applicants, interviews and offers |
| Onboarding and credentialing | Relevant eligibility, references, professional registration, evidence and expiry |
| Learning and development | Induction, role curricula, assessments and supervised competence |
| People support and safety | Accommodation requests, concerns, restricted investigations and incident follow-up |
| Workforce administration | Department membership, payroll handoff and workforce planning |

Map accountability to existing registered HR, hiring-manager, clinical, training
and finance roles after inventory review. Ordinary administration access must not
automatically expose accommodation, investigation, health, identity or payroll data.

## Recruitment dashboard and hiring process

Dashboard: vacancies, applicants by stage, interview calendar, pending reviews,
offers, time to fill, overdue candidate updates and communication delivery status.
Every metric needs a tenant, time window, denominator, freshness and drill-down
permission. No synthetic counts or guessed successful email receipts.

| Stage | Action | Exit evidence |
| --- | --- | --- |
| Requisition | Request department, essential duties, schedule and budget | Vacancy/budget approval |
| Posting | Review accessible description, pay information and applicable AI disclosure | Approved posting version and publication receipt |
| Application | Receive relevant qualifications and private attachments | Notice/authority or consent where required; accessible alternative |
| Review | Assess the same job-related criteria | Human reviewer, rubric version and factual evidence |
| Interview | Schedule consistently and offer accommodation | Approved questions, answer notes and independent panel assessments |
| Selection | Authorized humans compare evidence | Recorded decision/reasons and conflict review |
| Conditional offer | Present approved terms and outstanding checks | Authorized offer version and candidate response |
| Checks | Verify references, credentials and relevant eligibility | Source, reviewer, date, result and expiry; no assumed clearance |
| Hired | Human confirms conditions and start date | Approved conditions; employee created/linked through existing scoped API |
| Closed | Notify candidates and close vacancy | Required updates, delivery evidence and applicable retention schedule |

Withdrawal, rejection and reopening need explicit reasons and audit trails. Do not
send interviews, offers or rejection notices without a user action or an explicitly
authorized workflow defining recipients and scope.

## Interview and knowledge assessment

OHRC guidance supports predetermined job-related criteria, consistent assessment
and accommodation. Avoid irrelevant protected-ground questions and informal
"culture fit" judgments. Ask the same core questions for the same role.

| Example question for a care/support role | Evidence to look for |
| --- | --- |
| A client declines the planned service. What do you do? | Respect the decision, communicate, document and escalate within role |
| You notice an error in a record. What next? | Approved correction process and preserved audit trail |
| A task is outside your training or role. How do you respond? | Recognize scope, stop unsafe work and seek supervision |
| You cannot attend an assigned shift. What do you do? | Timely authorized notification and safe handover |
| Someone requests private client details without a work reason. What do you do? | Need-to-know access and appropriate escalation |

These are interview examples, not clinical protocols. Use a configurable 1–5
scale with written anchors and a separate "not assessed" state. Panel members
record evidence independently before combined review. Missing answers are not
silently scored as failure. Authorized humans make employment decisions.

AI may draft approved questions, retrieve permitted knowledge articles and prepare
source-linked transcript summaries for correction. Do not infer personality,
emotion, honesty, health, protected traits or suitability from voice, face, accent
or speech style. Sales-call script coverage is not a hiring score. Interview calls
need an approved workflow, appropriate notices, recording policy, alternative
participation and restricted transcript access. No autonomous hiring/rejection
tool is proposed.

## Onboarding and training

After an approved hire, assign a versioned checklist with item applicability,
owner, due date, evidence, reviewer and expiry. "Not applicable" requires an
approved reason and is distinct from "complete". Expired evidence needs renewal.

Before start: approved offer/conditions, relevant identity and eligibility checks,
role credentials/references, policy acknowledgements, payroll handoff and least
privilege account request. Keep banking/tax information in restricted payroll
processes, not general chats or knowledge articles.

Induction: confidentiality/privacy, accessibility, safety and harassment reporting,
emergency/escalation procedures, communication tools and role boundaries. Apply
the employer's safety program and instruction; a generic video is insufficient.

Training states: assigned, started, knowledge-assessed, supervised-competency-
assessed, reviewer-approved and expired. A passed quiz does not prove clinical
competence or professional registration. Configure pass marks and renewal dates
per approved curriculum rather than inventing universal thresholds.

Use staged access, review required conditions before operational access, and
include handover, equipment return, account/session revocation and retention/legal
holds in offboarding. Employee and contractor workflows may differ.

## Operational risk dashboard

Track process issues and controls, not a person's worth or predicted misconduct.
Each issue needs evidence, affected process, owner, assessment date, severity,
likelihood, control, residual assessment, due date and independent closure review.
Unknown evidence remains unknown.

| Risk area | Signal | Follow-up |
| --- | --- | --- |
| Credentials | Required verification missing, expired or approaching renewal | Current credentialing/eligibility review |
| Training | Applicable course overdue or competency review pending | Learning/supervision and evidence review |
| Staffing | Approved vacancy or coverage gap | Manager workforce plan |
| Recruitment | Missing approval/disclosure, inconsistent rubric, late update | Documented HR corrective action |
| Privacy/access | Overdue access review, unexplained export, incomplete offboarding | Restricted security investigation |
| Safety | Unresolved hazard/incident and overdue mitigation | Designated safety owner and escalation |
| Knowledge | Critical article overdue for review or superseded training | Content owner update and reassignment |

A severity × likelihood matrix can prioritize issues after its anchors and
escalations are approved. Missing documents or a complaint cannot automatically
decide employment. Restrict investigation details; executive aggregates need
appropriate small-group suppression to avoid identifying people.

## Knowledge base

Articles need tenant/audience, owner, version, sources, effective/review dates,
approval and supersedes links. States: draft, reviewed, published, withdrawn.
Acknowledgements bind to an exact version. Include approved hiring guides,
onboarding steps, curricula, incident escalation and communication instructions.

Search and AI retrieval enforce current access before fetching text and again
before responding. Cite article/version and decline unsupported answers. Candidate
records, medical details, identity documents and investigation evidence belong
outside the general knowledge base.

## Researched Ontario and privacy requirements

For covered Ontario employers, 2026 public job-posting rules include compensation
information, applicable AI disclosure, vacancy statements and no Canadian-experience
requirement in postings/application forms. Employers with fewer than 25 employees
are generally excluded and other exceptions apply. Determine applicability from
the employer's workforce, not app-account count.

Covered interviewed applicants need the required hiring-decision update within
45 days after the last interview. Covered posting/application-form copies are
retained for three years after public access is removed. Other records require
their own retention schedules and legal holds; do not apply universal deletion.

OPC guidance describes the specific scope of federal employee-privacy legislation.
Do not assume PIPEDA governs every Ontario clinic employee record. Determine
applicable obligations, minimize collection and apply need-to-know access.

Sources:

- [Ontario job posting guide](https://www.ontario.ca/document/your-guide-employment-standards-act-0/requirements-related-publicly-advertised-job)
- [Ontario Regulation 476/24](https://www.ontario.ca/laws/regulation/240476)
- [Ontario record keeping](https://www.ontario.ca/document/your-guide-employment-standards-act-0/record-keeping)
- [OHRC interviewing and hiring](https://www.ohrc.on.ca/en/iv-human-rights-issues-all-stages-employment/5-interviewing-and-making-hiring-decisions)
- [OPC workplace privacy](https://www.priv.gc.ca/en/privacy-topics/employers-and-employees/02_05_d_17/)
- [Ontario workplace violence and harassment](https://www.ontario.ca/page/understand-law-workplace-violence-and-harassment)

## Implementation and acceptance

`HrMetadataInventory` inherits `GovernedMetadataInventory`. It reads pinned metadata
only, includes generic APIs linked to HR screens, verifies workflow hashes and
reports missing schemas/grants. A match requires review: partner onboarding is
not employee onboarding, and a risk screen may serve another business domain.

Review the actual inventory, bind the correct existing department/recruitment APIs
and policies, register required changes, then implement governed service/controller/
UI bindings. Reuse inherited communication channels. Browser → API → server-owned
PostgreSQL remains the only business-data path.

Acceptance must cover HR/non-HR and tenant denial, limited interviewer scope,
private/scanned attachments, human decisions, concurrent version conflicts,
idempotency, audit rollback, expired credentials, withdrawals, curriculum changes,
due-date boundaries, ambiguous message acceptance, reload persistence,
accessibility and localization. Generated layouts and inventory entries alone
cannot establish completion.

### Verified production discovery

Run [40055570479](https://github.com/shaikhrais/primecare-platform/actions/runs/40055570479)
passed on `33655824f55c95b3b588e17aa911b9d874c6e1b3`. Four fixture tests and the
pinned production read passed. Artifact 12544634916 was downloaded and its SHA256
independently verified:
`c298a4a4aca0748b9a27df71deb5b25666b03252588cf403709854e38708c4b7`.
Candidate inventory: 91 screens, 75 APIs and 16 business-process definitions;
no grants or business records changed. The sole metadata-complete API in this
selection is `/v1/auth/register`, not a recruitment CRUD contract. No HR dashboard
or hiring workflow is established as live by these counts.

Existing active roles include `hr_director` (27), `hr_hiring` (45),
`training_director` (31) and `training_coordinator` (62). Existing surfaces include:

| ID | Screen | Route |
| --- | --- | --- |
| 310 | hr_director_hiring_pipeline | /executive/hr-director-hiring-pipeline |
| 490 | hiring_pipeline | /management/hiring-pipeline |
| 491 | employee_records | /management/employee-records |
| 520 | applicant_tracking | /staff/applicant-tracking |
| 521 | interview_scheduling | /staff/interview-scheduling |
| 468 | risk_management | /executive/risk-management |
| 728 | risk_register | /offices/corporate/roles/compliance_manager/risk-register |

The hiring/interview scan declarations such as API 1456
`POST /v1/hr-hiring-interviews/compliance/scan` have no permission key in the audit;
they are not substitute APIs for creating interviews or deciding employment.

The existing `platform.create-department` workflow does identify a real department
creation path: sign in, load `/v1/governance/platform`, select an authorized tenant,
then `POST /v1/governance/platform/tenants/{tenantId}/masters` with type department,
code and label. Source: `cloudflare/workers/src/platform-administration.ts`, which
persists `platform_master_records` with audit and idempotency. Its workflow remains
`not_run` in the catalog; live department creation still requires an authenticated
authorized app session and the intended tenant. Do not replace it with guessed
department routes or create department records in every tenant by default.

The codebase also has `care.staff.onboard-and-clear` for independently verified
clinical clearance. That is distinct from a full recruitment/employee onboarding
program and cannot be used to fabricate credentials or unlock retraining locks.
