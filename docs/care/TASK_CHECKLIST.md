# Numbered care task functionality

Scope: routine, non-controlled support visits using existing staff/client accounts and source visits, with bounded recurring visit creation. “Implemented” below means API and website behavior exists and is exercised locally; it does not mean deployed or human-approved for care use.

| No. | Duty / function | Who performs it | Status and completion evidence |
| --- | --- | --- | --- |
| 1 | Verify staff independently | Clinical director / eligible RN field supervisor | Implemented: manual evidence, expiry, role binding and immutable verification; self-verification denied. |
| 2 | Create/approve provider profile and confirm induction | Same verifier | Implemented for existing employee accounts; cannot override a retraining lock. |
| 3 | Select existing client visit | Scheduler / tenant admin / clinical operations | Implemented through scoped API; client/visit account creation remains in the existing platform workflows. |
| 4 | Assign nurse, independent supervisor and support worker | Scheduling / clinical operations | Implemented: three distinct current eligible people, tenant isolation, atomic source-visit assignment. |
| 5 | Review client support needs and risks | Assigned RN/RPN | Implemented: recorded assessment, precautions and escalation instructions. Human clinical judgment is required. |
| 6 | Record consent and assess worker competence | Assigned nurse | Implemented: explicit confirmation and evidence before plan submission. |
| 7 | Define individual support activities | Assigned nurse | Implemented: governed activity catalog, client-specific instructions and bounded plan validity. |
| 8 | Independently approve or return plan | Assigned clinical supervisor | Implemented: author cannot approve their own plan; correction and resubmission supported. |
| 9 | Acknowledge assignment | Assigned PSW/HSW | Implemented: current eligibility and plan rechecked. |
| 10 | Confirm current consent and start visit | Assigned PSW/HSW | Implemented: timing gate, current team checks and start evidence. No GPS presence or payroll certification is implied. |
| 11 | Perform support activity and record factual result | Assigned PSW/HSW | Implemented: done/refused/not done/concern, instructions, notes and preserved change history. Unrecorded outcomes are labelled separately. |
| 12 | Report care concern | Assigned care staff | Implemented: concern queue and immutable note. No automatic emergency notification. |
| 13 | Follow up concern | Assigned qualified nurse/supervisor | Implemented: references the actual concern; open concerns block final review. |
| 14 | Submit visit documentation | Assigned PSW/HSW | Implemented: every planned activity requires an outcome; refusal does not need to become “done.” |
| 15 | Review submitted visit | Assigned independent supervisor | Implemented: original source visit completed only when safe to update; historical start/qualification evidence retained. |
| 16 | Return notes for correction | Assigned independent supervisor | Implemented: specific signed request; returned state does not authorize care to be repeated. |
| 17 | Correct and resubmit returned notes | Assigned PSW/HSW | Implemented: new worker-signed addendum after latest request required, including when current clearance has expired. |
| 18 | Report inability to attend / no access / missing consent | Assigned PSW/HSW before start | Implemented: structured exception blocks care; unqualified workers can still report a problem. |
| 19 | Resolve coverage exception | Scheduling / clinical operations | Implemented: reason/time visible without private narrative; reassign with fresh plan or cancel. External contact follows organization procedures. |
| 20 | Cancel or change pre-start assignment | Scheduling / clinical operations | Implemented: signed reason, new eligible team, plan invalidation and former-worker access removal. |
| 21 | Add signed correction after review | Assigned care staff | Implemented: append-only addendum; original history cannot be edited or deleted. |
| 22 | Identify who needs to act next | Every authorized care role | Implemented: server-derived stage, responsible person/team and next task per authorized visit. |
| 23 | Find late work and follow up | Supervisors / operations / assigned staff | Implemented: governed targets, late minutes, server-filtered queues before pagination. Timing alone does not establish fault. |
| 24 | Find personal work, concerns and coverage gaps | Every authorized role | Implemented: five queue filters; no organization-wide access for support staff. |
| 25 | Protect chart access and keep an audit | System | Implemented: API-only DB access, current session/tenant/assignment checks, strict payloads, versions, idempotency and immutable access records. |
| 26 | Use translated, responsive screens | Every care role | Implemented: EN/FR/ES, 320/1440 CSS-pixel checks, keyboard and automated accessibility testing. Physical-device/human acceptance pending. |
| 27 | Apply migrations and release to live environment | Release operator | Pending deployment; no live migration or production approval is claimed. |
| 28 | Approve actual clinical/privacy/accessibility operation | Designated human reviewers | Pending. Human qualifications and decisions cannot be supplied by automated tests. |
| 29 | Confirm true PostgreSQL race behavior | CI / release operator | Dedicated PostgreSQL 16 workflow supplied; twenty concurrent scenarios remain pending native CI. Local startup is blocked by the sandbox’s UID restrictions. |
| 30 | Production rollout and staff training | Tenant clinical/operations leadership | Pending real credentials, consent, release validation and organization-specific escalation procedures. |
| 31 | Declare working availability | Care employee / operations | Implemented: explicit UTC windows, whole-visit coverage and withdrawal evidence. Availability grants no clinical authority. |
| 32 | Request and withdraw pending time off | Care employee / operations | Implemented: own records, pending request and withdrawal; no medical details required. |
| 33 | Independently decide leave requests | Operations for another employee | Implemented: approve/decline, version checks, immutable decision history and no self-approval. |
| 34 | Record agreed changes to approved leave | Operations for another employee | Implemented: revoke with evidence; original approval retained. No automatic payroll/entitlement decision. |
| 35 | Prevent overlapping support-worker visits | Care assignment API | Implemented: schedule checks at assignment/reassignment/start, half-open interval boundaries and per-staff transactional locks. Includes active legacy source visits. |
| 36 | Detect staffing changes requiring coverage | Scheduling / assigned staff | Implemented: approved team leave, missing worker availability and source-visit conflicts route pre-start cases to scheduling. |
| 37 | Review staffing history at organization scale | Authorized operations | Implemented: staff filter and 25-record pages, scoped request/decision history. Staff roster selection remains bounded at 200. |
| 38 | Preview recurring visits and confirm client agreement | Scheduling / clinical operations | Implemented: client, service, address, skills, all dates and UTC equivalents; fresh operator-specific preview required. |
| 39 | Create a recurring visit series | Same operator | Implemented: bounded weekly recurrence, Toronto/UTC and daylight-saving validation; all-or-nothing creation without copied staff/plans/billing links. |
| 40 | Reschedule pre-start care | Scheduling / clinical operations | Implemented: client/staff conflicts checked atomically, fresh plan/approval/acknowledgement required and old evidence preserved. |
| 41 | Cancel a future unassigned series occurrence | Scheduling / clinical operations | Implemented: update timestamp checked, assigned or started cases excluded, other occurrences preserved. |
| 42 | Attest actual support-visit work time | Assigned PSW/HSW | Implemented after care-record submission: actual timestamps, breaks, evidence and electronic-start discrepancy flag. |
| 43 | Independently review reported time | Another operations person | Implemented: evidence confirmation, no self-approval and clinical-status context. No wage/payment determination. |
| 44 | Return, correct and resubmit work time | Reviewer / assigned worker | Implemented: versioned corrections and original signed values retained. |
| 45 | Reopen previously verified time | Independent operations | Implemented with signed evidence; old verification remains visible. No automatic payroll changes. |
| 46 | Find time submissions and reviews needing action | Assigned worker / operations | Implemented: personal queue includes missing/returned worker records and pending independent reviews. |
| 47 | Review time records and signed history | Assigned worker / operations | Implemented: tenant/worker-scoped 25-record list and per-record history, separate from clinical charts. |
| 48 | Cancel an assigned client appointment before care starts | Scheduling / clinical operations | Implemented: explicit confirmation and evidence, source appointment cancelled, source cannot restart through reassignment. Separate from assignment-only cancellation. |
| 49 | Prepare a same-client shift handover | Assigned source care staff | Implemented: started source visit, later pre-start receiving visit, factual summary, outstanding work and precautions; draft content hidden from recipients. |
| 50 | Independently review, return or withdraw handover | Another eligible source nurse / supervisor | Implemented: author cannot review; immutable signed versions and reasons. Approval invalidates any previous receiving plan approval. |
| 51 | Correct a returned or approved handover | Original source author | Implemented before receiving care starts: new pending version, new review and receipts required; old evidence retained. |
| 52 | Read and acknowledge approved incoming handover | Current receiving nurse / supervisor and support worker | Implemented: clinical receipt before plan approval, worker receipt before start; reassignment/rescheduling invalidates prior receipts. |
| 53 | Track handover status without private narrative | Scheduling / operations | Implemented: paginated metadata inbox; operations receive no clinical text or draft history. |
| 54 | Assign an operational follow-up with a deadline | Scheduling / clinical operations | Implemented: active same-tenant owner, source care record, category, due date and signed instructions. No clinical notes in task instructions. |
| 55 | Start, report a blocker and submit completion evidence | Task owner | Implemented: immutable evidence and status; former care assignees retain their own operational task access without chart access. |
| 56 | Independently verify or return submitted follow-up | Another authorized operations person | Implemented: source-workflow evidence required for governed categories; self-verification denied. Generic operational work requires independent evidence review. |
| 57 | Reassign or cancel follow-up | Operations | Implemented: signed reason, new active owner/deadline, original ownership and evidence preserved. Another operations person must reassign an operations employee’s own task. |
| 58 | Identify overdue work and outstanding reviews | Task owner / authorized operations | Implemented: server-filtered all/mine/late/review queues, counts and 25-record pages. Deadline status is not a finding of employee fault. |
| 59 | Preserve verified operational completion | System / independent reviewer | Implemented: verification records contemporaneous source state; later schedule changes do not rewrite historical completion evidence. |
| 60 | Request a later operational deadline | Task owner | Implemented: one pending request, proposed future deadline within 30 days, reason and original deadline preserved. Request alone changes no deadline or work status. |
| 61 | Independently approve or decline a deadline request | Another operations person | Implemented: no self-decision, explicit evidence review for approval, stale versions rejected. Approval preserves work status and records old/new deadlines. |
| 62 | Withdraw an unnecessary deadline request | Task owner | Implemented: signed withdrawal; current work and deadline remain intact. Expired proposals must be withdrawn/declined before a new request. |
| 63 | Find pending deadline decisions | Operations / task owner | Implemented: scoped counts and a separate server-filtered, 25-record deadline-request queue. |
| 64 | Review deadline and ownership history | Task owner / operations | Implemented: signed requests/decisions, previous/proposed/effective deadlines, ownership and request-closure evidence visible in UI. |
| 65 | Close pending deadline requests when work ends or changes owner | System / operations | Implemented: verification, cancellation and reassignment atomically close the request and preserve its evidence; late status alone never establishes employee fault. |
| 66 | Review unfinished task workload by employee | Scheduling / clinical operations | Implemented: open, blocked, overdue, submitted-review and deadline-request totals; earliest unfinished deadline. Counts exclude completed/cancelled tasks. |
| 67 | Search employees with unfinished work | Authorized operations | Implemented: literal, case-insensitive email/account-ID search, server filtering and 25-owner pages independent of the bounded staff picker. |
| 68 | Open one employee’s task records | Operations / employee for their own records | Implemented: scoped owner filter, status queues and counts; clearing the owner filter restores the authorized list. No new chart access. |
| 69 | Find and resolve blocked operational work | Task owner / independent operations | Implemented: blocked queue, signed blocker evidence, deadline decisions, reassignment and existing independent completion review. A deadline extension does not unblock work. |
| 70 | Detect unfinished tasks stranded on unavailable accounts | Operations | Implemented: inactive or unsupported-role owners remain visible with a reassignment warning; no automatic transfer or clinical authorization. |
| 71 | Keep workload oversight separate from performance/pay decisions | System / operations | Implemented: metadata aggregates only; no client names, clinical narrative, wage calculations, automatic fault score or disciplinary findings in this report. |
| 72 | Define the order of related operational duties | Operations creating a task | Implemented: up to five existing prerequisites from the same care visit, chosen only at creation. API cannot rewire existing tasks into a cycle. |
| 73 | See which prerequisite and owner is holding up work | Task owner / authorized operations | Implemented: related task reference, category, status and responsible account ID; predecessor instructions/history are not copied to another owner. |
| 74 | Enforce prerequisites before operational progress | System / task owner / independent reviewer | Implemented: start, submission and verification are blocked until every prerequisite is independently completed or validly released. A submitted predecessor is still unfinished. |
| 75 | Handle a cancelled prerequisite without false completion | Independent operations | Implemented: cancellation leaves dependents waiting; manager may arrange replacement work, cancel dependent work or justify a signed release. |
| 76 | Independently release an operational prerequisite | Operations independent of both task owners | Implemented: explicit confirmation and reason; no self-release, immutable decision, preserved task status/deadline and predecessor status. |
| 77 | Find waiting work across employees | Task owner / operations | Implemented: server-filtered waiting queue, 25-record task pages and waiting counts in employee workload. Counts are separate from an employee-reported blocker. |
| 78 | Preserve and review dependency evidence | System / authorized staff | Implemented: immutable links/releases, same-case database constraints, task references and signed history. Picker lists latest 100 eligible records with a truncation warning. |
| 79 | Keep clinical checks independent of task exceptions | System / clinical and operations reviewers | Implemented: a release does not complete the prerequisite, approve care or waive source-workflow checks, consent, qualifications or payroll review. |
| 80 | Find active staff beyond the initial roster | Scheduling / clinical operations | API and UI implemented: literal email/account-ID search, tenant isolation, 100-character query bound, translated controls and retained selections. Database and browser checks pass, including retained assignment selections and translated controls. |
| 81 | Find staff for availability, leave and follow-up ownership beyond the initial roster | Scheduling / clinical operations | API and UI wired to shared staff search; follow-up options retain active care-team members and enforce owner eligibility. API and browser checks pass, including staffing search and eligible owner selection. |
| 82 | Search and page eligible unassigned appointments | Scheduling / clinical operations | API and UI implemented: case-insensitive literal client-name/appointment-ID search, 25-record server pages, stable ordering and filtered totals. Cross-tenant, inactive-client, terminal and assigned visits excluded. Database/API and browser checks pass, including 320-pixel search/paging, retained evidence and EN/FR/ES. |

| 83 | Find recurring-visit source appointments beyond the initial list | Scheduling / clinical operations | Search/paging implemented using shared appointment query, including active service/skills checks; ten focused picker checks, full API regression and the browser preview/create/cancel workflow pass. |

| 84 | Keep all prerequisite choices when switching language or restoring a form | Operations creating follow-up work | Implemented: all selected eligible IDs, evidence and checkbox state retained; removed options are not recreated. Four focused browser checks and a real two-prerequisite FR/ES submission pass. |

| 85 | Include care governance in the complete website build | Build / release operator | Implemented: registration runs after the other feature registrars; all nine website builds pass and care exports reproduce. Deployment remains pending. |

Outside this routine-support bundle: medication/controlled-act authority, live professional-register verification, indefinite recurrence automation and bulk series editing, travel/overrun optimization, maximum-hours calculations, emergency dispatch, offline/native applications, payroll and discipline decisions. These require separate governed workflows; no placeholder buttons or fabricated approvals represent them as complete.

The shared roster search and unassigned-appointment search/page controls remove the initial-selector reachability limits. Other bounded histories and source pickers still require capacity review and further pagination before large-scale rollout. See [the operating guide](README.md) for exact limits and release steps.

Latest native CI result: **216 cases, 216 passed, zero failures and zero skips**, including all 20 PostgreSQL 16 concurrency cases. [Care acceptance run](https://github.com/shaikhrais/primecare-platform/actions/runs/39053057756). API/UI types and all 48 browser role/language/viewport combinations pass. An additional 31 method-capture governance/route checks pass. Source and required operations foundations are committed in [PR #201 (ready for code review)](https://github.com/shaikhrais/primecare-platform/pull/201). All 17 workflows passed at runtime commit `890e20abed3a833ecd8963024794200e5e6467bc`. Human/device acceptance, clinical/privacy review and production migration/deployment remain pending; no release approval is inferred.
