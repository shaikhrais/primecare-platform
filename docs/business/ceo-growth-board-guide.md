# CEO dashboard and operating guide

Interpretation: "code dashboard" in the request is treated as CEO/company-leadership
dashboard because the request concerns company growth and board duties. Code Admin
remains a technical governance role; it is not automatically the CEO, a director,
shareholder or authorized corporate signatory.

Research date: 2026-10-23 America/Toronto. The existing CEO, HR Director and Hiring
dashboard routes use a shared authorized workspace renderer. Available account,
session and organizational activity metrics are API-backed. This is not yet a
financial, recruitment or board-management system. Domain data without a verified
source remains unavailable; no revenue, profit, hiring or risk values are invented.

## How a CEO is chosen

In the federal business-corporation framework, shareholders ordinarily elect
directors and directors appoint officers. CEO appointment, powers and removal
must follow the applicable statute, articles, bylaws and any governing shareholder
agreement. Ontario corporations have their own Business Corporations Act. Do not
treat an app-role assignment as a legal corporate appointment. Record the
authorized decision and delegation before separately provisioning app access.

A practical selection process is to define the company mandate, required
experience and conflicts; use consistent interviews and reference checks; obtain
the proper human appointment approval; agree objectives, compensation and
delegated limits; and establish regular performance reviews. This process does
not automatically select or reject a real person.

| Role | Main responsibility | Important boundary |
| --- | --- | --- |
| Shareholders/owners | Ownership decisions and applicable elections/approvals | Ownership is not unrestricted access to every employee or patient record |
| Board of directors | Oversight, strategy and reserved decisions | Operates under applicable corporate duties and formal authority |
| CEO | Execute approved strategy, lead management and report accurately | Cannot bypass reserved approvals, clinical authority or privacy restrictions |
| CFO/finance lead | Financial statements, cash planning and controls | No fabricated numbers or unauthorized payments |
| HR lead | Hiring process, workforce support and records | Human decisions and restricted personal data |
| Clinical/operations lead | Safe service delivery, capacity and quality | Growth targets do not override qualifications or client safety |
| Code Admin | Technical governance and controlled platform administration | Technical access does not appoint corporate officers |

An advisory board supplies advice; it is different from a statutory board of
directors and does not acquire formal corporate decision powers merely by being
called a board. Configure the actual body and authority before recording votes.

## CEO dashboard specification

| Area | Questions the dashboard should answer | Required source and controls |
| --- | --- | --- |
| Company priorities | Which approved objectives are on track? | Versioned goals, accountable owners, dates and evidence |
| Finance | How do actual revenue, costs and cash compare with plan? | Authorized finance period, currency, reconciliation and freshness |
| Growth | Which channels generate qualified enquiries and completed services? | Defined funnel and attribution; do not count leads as revenue |
| Operations | Can staff and facilities deliver the promised services? | Current capacity, credentials, schedules and quality indicators |
| People | Which approved vacancies and training gaps need action? | Restricted HR drill-down; aggregate executive view |
| Risk | Which material issues are overdue or above tolerance? | Risk owner, evidence, controls and human review |
| Board | Which decisions, minutes and follow-up tasks are due? | Authorized meeting, agenda, decision authority and audit |

Each metric needs company/tenant scope, unit, time window, denominator, source,
freshness, owner and an explicit unavailable state. A zero must mean a verified
zero. Distinguish forecast from actual, pipeline from booked work, and bookings
from completed or paid services. Do not display account counts as customer growth.

The current shared workspace may display permitted organizational account and
session counts. The other rows above are implementation requirements until their
registered domain contracts, data and acceptance checks are connected.

## How to grow the company

Use a repeatable decision cycle rather than promise a fixed growth percentage:

1. Establish a baseline: services, customer needs, quality, capacity, costs and
   cash. Record missing data and uncertainty.
2. Pick a small set of measurable priorities, approved by the appropriate people.
3. Identify the bottleneck: demand, enquiry response, conversion, staff capacity,
   retention, service quality or collection.
4. Propose a bounded experiment: owner, budget cap, target audience, expected
   outcome, start/end date, assumptions and stop conditions.
5. Obtain required approval, run the experiment and capture evidence.
6. Compare results with the baseline, including costs, safety and capacity.
7. Continue, change or stop; record the decision and assign follow-up work.

Potential initiatives include faster enquiry handling, appropriate referral
relationships, better service availability, staff development and reducing
avoidable scheduling errors. Select initiatives using the company's evidence;
none is a guaranteed growth outcome or authorization to send marketing messages.
Assess legal, consent, staffing and clinical boundaries for the chosen service.

## Operating rhythm

Suggested cadence, configurable rather than a statutory meeting schedule:

| Cadence | CEO work | Output |
| --- | --- | --- |
| Daily | Review urgent safety, service, staffing and cash exceptions | Named owner and next step |
| Weekly | Review priorities, funnel, capacity and overdue work with leaders | Decisions, actions and updated forecast assumptions |
| Monthly | Review reconciled results, costs, cash, people and risk | Management pack and corrective actions |
| Board cycle | Prepare the approved agenda and decision papers | Board pack, reviewed minutes and authorized action log |
| Quarterly strategy review | Reassess objectives, assumptions and investment | Approved priorities and explicit trade-offs |

Meeting notice, quorum, voting, conflicts, approval and record-retention rules must
come from the actual corporate framework and documents. Do not hardcode a
universal quorum, meeting interval or threshold into the product.

## Board-meeting preparation and questions

Before the meeting, confirm its purpose and authority, invite authorized attendees,
identify conflicts, circulate a controlled board pack, distinguish discussion
from approval items, and specify the decision requested. The chair manages the
meeting. Record dissent, deferrals and conditions where required by the applicable
process. AI-drafted minutes require human review before approval.

| Board question | Evidence-backed answer template | Follow-up |
| --- | --- | --- |
| Are we achieving the plan? | "For [period], [approved metric] was [verified actual] against [approved plan], a variance of [calculated difference]. Source: [report/version/date]." | Explain the main causes and propose a response |
| Do we have enough cash? | "Finance's forecast dated [date] shows [verified position] under [assumptions]; downside scenario is [reviewed result]." | CFO validates assumptions; obtain any required approval |
| Why did performance change? | "The supported drivers are [evidence]; [other factor] remains unverified." | Assign investigation with due date |
| Can we safely serve more clients? | "Current verified capacity is [source]; constraints are [staffing/credential/quality evidence]." | Operations/clinical review before expansion |
| Which risks need our decision? | "Risk [reference] has [assessment], controls [references], owner [person] and proposed action [proposal]." | Board decides within its authority |
| What is the hiring plan? | "Approved vacancies are [source], with current stages [summary] and cost assumptions [finance review]." | HR and hiring manager remain accountable |
| How effective is marketing? | "For [cohort/period], [verified spend] produced [defined outcomes] under [attribution method]." | Review cost and service capacity before scaling |
| What approval do you need? | "Approve/decline/defer [precise proposal], capped at [reviewed limit], subject to [conditions]." | Authorized decision, recorded rationale and task |
| What did we fail to complete? | "Actions [references] are overdue for [documented reason]; recovery owner/date are [values]." | Escalate or revise by authorized decision |
| What do we not know? | "[Metric or issue] has no verified source yet. [Owner] will report by [date]." | Keep status unknown; do not substitute an AI estimate |

These are templates. Bracketed fields must come from current authorized records.
Never present sample answers, fabricated minutes, assumed approvals or invented
financial figures as the company's actual position.

## Turn decisions into duties and tasks

Each action should have an existing authorized task ID, company/tenant, originating
decision, precise deliverable, accountable owner, due date/timezone, priority,
dependencies, required approval and completion evidence. States should distinguish
proposed, assigned, in progress, blocked, submitted for review and approved closed.
The accountable reviewer confirms completion; a checkbox alone is insufficient.

Use the inherited communication core for permitted discussion, attachments and
notifications. Board materials require separate access from ordinary messaging.
Do not automatically invite people, email a pack, assign a task or execute a
payment because an AI summary suggested it. Use existing registered workflows,
current permissions and the appropriate explicit confirmation.

## Knowledge and leadership development

Maintain approved articles for the CEO mandate, delegation matrix, company
strategy, finance definitions, service-quality standards, hiring procedures,
board preparation and escalation. Version articles and assign an owner/review
date. Training should test understanding using scenarios, followed by authorized
human review of actual responsibilities. A training quiz does not grant access
or corporate authority.

AI can retrieve approved guidance, explain definitions and draft a meeting pack
or action list. It must cite the permitted source/version, identify missing
information and leave decisions to authorized people. No voice-match authority
or automatic employment/financial decision is introduced.

## Implementation, isolation and remaining work

CEO, HR Director and Hiring now inherit `GovernedWorkspaceEntry`, which uses the
existing workspace API. The renderer presents only pages the current server
response permits. Changing account, tenant, token or role creates a fresh scoped
workspace state, discards cached private data and prevents late responses from a
disposed session from restoring it. Diagnostic keys redact the token.

Remaining domain implementation: registered financial/growth/HR/board contracts,
approved task and decision policies, private board material handling, current
grants, localization and complete browser/API/database acceptance. The shared
dashboard does not claim those domain workflows are finished.

### Verification evidence

Source `1a1d61a42e347092d1c49e8c20f2760fc3326b46` passed all ten communication CI
jobs in [40056624268](https://github.com/shaikhrais/primecare-platform/actions/runs/40056624268).
The Flutter workspace job 120760909250 passed 119 tests, including six new checks:
common inherited CEO/HR entries; cached data reset and late-response denial for
user, tenant, role and token changes; and denial of a page absent from the current
server list. These are fixture-backed widget/transport checks, not deployed CEO
financial or recruitment/board transaction acceptance. Broader monorepo build
and non-blocking Dart aggregate runs were still in progress at this readback.

References:

- [Corporations Canada glossary: directors and officers](https://ised-isde.canada.ca/site/corporations-canada/en/glossary-canada-business-corporations-act)
- [Federal post-incorporation steps](https://ised-isde.canada.ca/site/corporations-canada/en/business-corporations/next-steps-following-incorporation-your-business)
- [Ontario Business Corporations Act](https://www.ontario.ca/laws/statute/90b16)
- [BDC: advisory boards and governance preparation](https://www.bdc.ca/en/articles-tools/business-strategy-planning/manage-business/how-set-up-advisory-board-business)
