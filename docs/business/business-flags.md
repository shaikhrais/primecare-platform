# Business flags: sales, operations and people
Date: 2026-10-22. Owner: business leadership; technical delivery: platform team.
Status: requirements drafted; shared domain base classes tested; live business-flag integrations not production registered, implemented or deployed.
This is an internal business policy proposal, not a Google policy or a clinical triage protocol.

## Sell and measure the business
The sales journey is enquiry → qualification → proposal → agreement review → verified close → tenant provisioning → territory allocation → launch handover → ongoing service and renewal.
Each opportunity has a tenant scope, accountable sales manager, source, territory interest, expected value/currency, next action/date and stage history.
Record lost opportunities and a reason. Reopening preserves history. Qualification and an agreement reference must not be displayed as collected money.
Existing territory allocation records an externally approved agreement; it does not execute signatures or payments. Do not add an automatic dependency between payment and allocation without an approved contract change.

Before a reporting period starts, assign the manager an approved target with metric, amount, currency where applicable, period/timezone, manager and approver, effective date and version.
Targets and actuals must use the same definition. Separate signed contract value, net collected cash, activated tenants, allocated territories and service revenue; never sum different units or currencies.
A changed target requires a reason, approval and preserved prior version. Reports show the version used; changing ownership does not rewrite historical credit. Split credit must total 100%.

A closed/won record requires the accepted agreement reference, verified acceptance date, customer/tenant link, assigned manager and reviewer, agreed value/currency and evidence reference.
Label it contracted, invoiced, paid and activated separately. Paid requires reconciled payment evidence. Count net cash after refunds; unpaid invoices are not cash.
Exclude duplicate, test, cancelled and superseded records. Preserve reversals and corrections in the audit history. Count each deal once; allocate partial receipts and refunds by their recorded dates.
Manager attainment = eligible actual / approved target × 100. Show actual, target, gap, period, cutoff, freshness and evidence drilldown.
A missing/unapproved target or incomplete source produces Unknown, not 0% or Green. A zero target is displayed as No target; do not divide by zero.
Show period-to-date pace only against an approved cumulative milestone schedule; no assumed straight-line forecast. Before period end label achievement as provisional.

## Flag meanings
| Flag | Meaning | Required response |
| --- | --- | --- |
| Green | Complete, current evidence meets the approved rule | Continue monitoring |
| Amber | Recorded risk, missed interim milestone or approaching deadline | Owner records corrective action and due date |
| Red / Code Red | Verified critical incident, breached critical deadline or failed final commitment | Accountable lead acknowledges and coordinates recovery |
| Unknown | Missing, stale, invalid or inaccessible required evidence | Assign data owner and recover evidence |
| Closed | Resolution independently verified where required | Preserve history and monitor recurrence |

Thresholds, freshness windows, working calendar and response deadlines must be versioned and approved before automation. Do not invent percentages, emergency response times or legal deadlines.
Red is an internal escalation label, not a feature toggle or an automatic shutdown instruction.
At period close, a missed approved sales target is Red; meeting it is Green only when records are complete and current.
During the period, compare with approved milestones: a miss is Amber unless an approved policy establishes a critical breach.
A verified critical Red remains visible even if other feeds are Unknown. Show Unknown coverage separately. Never average an emergency away or let strong sales hide an HR/operations incident.

## Coverage and accountability
| Area | Evidence and triggers | Accountable function | Management view |
| --- | --- | --- | --- |
| Sales | Approved targets, verified closes, overdue follow-ups, stage ageing, lost reasons | Sales lead | Manager attainment, gap and recovery actions |
| Cash and finance | Reconciled receipts, refunds, overdue invoices, approved liquidity limits | Finance lead | Contracted versus invoiced versus net paid |
| Tenant and territory | Active tenant, approved allocation, conflicting ownership, launch prerequisites | Platform operations | Allocation and launch blockers |
| Service operations | Uncovered visits, failed handovers, missed service commitments, capacity | Operations lead | Open incidents, service impact, next action |
| Safety and emergency | Reported safety event and verified urgency; existing emergency procedures take precedence | Designated safety lead | Restricted incident reference and escalation state |
| People / HR | Staffing gaps, expiring required credentials, payroll exceptions, restricted employee cases | HR lead | Authorized aggregate counts and deadlines only |
| Security and privacy | Reported incident, confirmed access exposure, unresolved containment | Security/privacy lead | Impact class and containment status |
| Technology | Availability, failed critical jobs, stale sources, recovery verification | Technical lead | Outage state, impact and recovery owner |
| Compliance and documents | Required document review/expiry and unresolved mandatory controls | Compliance lead | Due items and blocked approvals |
| Customer quality | Complaints, repeat failures, unresolved commitments and renewal risk | Service quality lead | Trend, owner and corrective action |

Do not infer misconduct, medical conditions or employment decisions from a metric. No automated dismissal, suspension, privilege grant or customer communication.
HR case details, employee names, allegations, medical information and payroll detail stay in restricted case access. Broad executive views contain policy-permitted aggregates only; small-group disclosure rules need approval.
Tenant isolation applies to every query, export, evidence link and audit read. An executive title alone must not grant unrestricted HR access.

## Incident lifecycle
Open → triaged → assigned → acknowledged → action in progress → resolution proposed → verified closed.
Every flag carries a stable reference, scope, area, rule/version, severity, reason code, source reference, observed time, evidence cutoff, owner, response deadline, next action and audit version.
Triage cannot delay a credible critical escalation. Reopening preserves earlier closure and records recurrence.
Acknowledgement does not mean resolved. A due-date change or severity downgrade needs a recorded reason and appropriate authority; it cannot erase the breach.
Unassigned or overdue flags escalate to the approved backup owner. A critical flag remains active until resolution evidence and authorized verification exist.
Notifications require a registered delivery policy, destination, retry/deduplication and delivery evidence. Existing growth alerts are in-app; this proposal sends no messages.
Use an approved on-call/emergency procedure for immediate danger; this dashboard must not be the sole emergency channel.

## Registration and delivery contract
Do not invent new live routes, widgets, roles or permission grants. Map or register each item in pinned PostgreSQL governance before implementing it:
1. Business processes for target approval, opportunity close/reversal, flag triage/escalation and restricted HR handling.
2. Data definitions for versioned targets, evidenced closes, metric snapshots, rule versions, flags, actions and audit records; retention and deletion policies.
3. Existing-role permission mappings for scoped read, target approval, close verification, flag assignment, acknowledgement, downgrade and closure; separation of duties.
4. API specifications with schemas, tenant scope, validation, idempotency, concurrency, audit, rate limits and error contracts.
5. Screen, sections, controls and source bindings using approved components, theme tokens, localization EN/FR/ES, accessibility semantics and stable test identifiers.
6. Rule ownership, review evidence, tests and implementation tags. Keep incomplete and unverified statuses honest.

Existing source to assess for reuse:
- packages/shared/src/growth/registry.json: planning targets and business policy.
- cloudflare/workers/src/growth/performance.ts: owner/source acquisition and activity, not a paid-sales target ledger.
- packages/shared/src/growth/business.ts: invoice/payment/refund/expense validation and evidence.
- cloudflare/workers/src/growth/alerts.ts: in-app due callbacks, appointments and tasks.
- cloudflare/workers/src/platform-bundle/attention.ts: scoped support, document, routing and launch attention.
- cloudflare/workers/src/territories/service.ts: allocation, not checkout/signature.
Production registration for this new framework has not been established. Prior territory audit also found missing sale-allocation registration; do not treat this document as registration.

## Acceptance scenarios before release
| Scenario | Expected proof |
| --- | --- |
| Manager meets target with eligible, verified deals | Exact attainment with evidence and target version |
| Lead marked active but no agreement/payment | No invented contracted or paid amount |
| Missing/zero/unapproved target or stale feed | Unknown/No target; no false healthy score |
| Mid-period target/owner change | Approval and immutable prior attribution |
| Duplicate event, retry or concurrent close | One close/credit and atomic audit |
| Partial payment, refund, cancellation, reopen | Correct separate totals, dates and preserved reversal history |
| Currency or unit mismatch | Reject aggregate; no silent conversion |
| Period cutoff, timezone boundary, backdated correction | Reproducible snapshot and correction audit |
| Critical operations incident plus excellent sales | Red remains visible |
| Critical incident plus unavailable HR feed | Red plus explicit Unknown coverage |
| Overdue/unassigned incident or failed notification | Escalation/delivery state visible; no false acknowledgement |
| Attempted unsupported downgrade/closure | Denied; original flag and audit retained |
| Restricted HR case viewed/exported by sales user | Denied without leaking case existence/details |
| Tenant A queries tenant B identifiers | Denied across read, actions, export and evidence |
| Mobile, keyboard, screen reader and translations | Real current-client evidence with data/API persistence |

## Current delivery evidence
Shared domain classes now live in packages/shared/src/business/base.ts, with usage and extension guidance in that directory's README.md. GrowthAnalytics inherits existing campaign arithmetic from BusinessMetricsBase, preserving its public API. SalesTargetRule and IncidentFlagRule share the BusinessFlagRule contract; neither has a live evidence adapter yet. No new runtime API, screen, automatic escalation, message or business record was created.
No completion, architecture approval, security approval or deployed screenshot is claimed.
Next delivery step: production registration mapping and required reviews, followed by implementation and the acceptance scenarios above.
