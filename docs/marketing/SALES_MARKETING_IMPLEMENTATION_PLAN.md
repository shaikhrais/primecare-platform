# Sales and marketing operations delivery plan

Requested scope: a founder can manage partner recruitment and care enquiries, identify weak flow stages, assign work to telephone callers and digital/offline specialists, and track the actions that improve conversion.

## Functionality and current evidence

| Module | Required behavior | Current status |
|---|---|---|
| Founder dashboard | Targets, actual, expected pace, gaps, suggested investigations, overdue follow-ups | Implemented locally; not deployed |
| Lead inbox | Tenant/client pipelines, contact details, source evidence, deduplication, assignment | Manual intake implemented; website/QR/referral forms implemented; provider imports pending |
| Contact and duplicate management | Versioned correction, scoped search/filters, exact candidate review and history-preserving duplicate closure | Implemented locally; not deployed |
| Caller workspace | Due-first queue, manual call outcomes, requested callbacks, contact preference | Implemented locally; requires an existing authorized marketing account |
| Telephone integration | Provider calling, event ingestion, call delivery evidence | Pending provider selection and authorized credentials; no calls initiated |
| Team specialties | Caller, Google, Meta, SEO/content, offline partnerships, care handoff | CEO assigns operational specialty to existing active staff; no new account permissions granted |
| Appointment handoff | Future scheduling, owner/lead collision checks, cancelled/completed/no-show outcomes | Implemented locally; no attendee notifications or clinical-care linkage |
| Campaign tracking | Google/Facebook/Instagram/offline/referral/website attribution, budget/spend, cost per enquiry | Manual records implemented |
| Digital campaign planning | Owner, audience, offer, creative copy, landing-page URL, dates and planned lead goal | Versioned briefs and internal review implemented locally; experiments pending |
| Offline campaigns | References and QR campaign identifiers, follow-up tasks | Manual attribution implemented; QR landing page and event intake implemented locally |
| Partner recruitment | Discussion, demo, pilot and reported active milestone evidence | Implemented; manual business verification and tenant/admin provisioning implemented locally; clinical credential verification remains separate |
| Client conversion | Needs discussion, agreement, first visit and recurring milestones | Implemented as reported CRM evidence; does not prove completed clinical care |
| Corrective actions | Owner, due date, evidence to complete | Implemented; versioned reassignment, priority, reschedule and escalation implemented locally |
| Performance reporting | Funnel conversion, source enquiry totals, campaign CPL, call attempts, upcoming appointments | Implemented; source/current-owner/caller reports, manual acquisition metrics and PDF implemented; live controlled email needs setup |
| Google lead intake | Authenticated provider integration, normalized leads, dedup, retries, account ownership checks | Not connected |
| Meta lead intake | Authorized account connection, webhook/event verification, lead retrieval and attribution | Not connected |
| Public website intake | Consent/contact preferences, source capture, abuse controls and secure CRM handoff | Built locally, including QR and referral attribution |
| Staff permissions | Six dedicated staff roles, assigned-lead and source boundaries, CEO creation/management | Implemented locally; not deployed |
| Administration | Central Admin creates Platform Admin and Tenant Admin; scoped employee accounts | Distinct central/platform/tenant scopes implemented and tested locally |
| Operations/revenue | Staffing capacity, service-area fit, visits, invoicing and collected revenue | Existing visit status linkage and manual CAD ledger implemented; clinical scheduling and live payments require separate acceptance |
| Native applications | Equivalent Flutter workflow, platform verification | Pending; current website supports mobile–4K layouts |

## Sequence and estimates

These are engineering planning ranges, not measured delivery promises or background-task schedules. Account setup, decisions and acceptance testing can extend them. Do not add the estimates as if dependencies were independent.

1. **Core operations release, approximately 2–4 weeks:** complete manual intake and campaign briefs,  reporting and integration readiness; run real PostgreSQL CI; release API/schema before website; verify live authorized accounts. Existing local dashboard/caller/appointment work reduces the starting workload.
2. **Connected marketing release, approximately 6–10 weeks total from start:** configure and test Google/Meta/website intake and telephone provider; add attribution and employee reporting; harden retries, privacy boundaries and operational monitoring; verify deployment. This range includes the core release, not an additional 6–10 weeks.
3. **Wider care business and all native platforms:** estimate separately after defining tenant provisioning, staffing, clinical handoffs, billing, and platform acceptance criteria. They are substantial additional workflows, not marketing connectors.

## Daily operating loop

Founder saves period targets -> marketing records source-attributed enquiries -> caller reviews requested contact and queue -> caller logs an outcome and callback -> coordinator records an appointment/handoff -> authorized staff record conversion milestones with evidence -> founder reviews gaps -> named corrective task is assigned -> next review checks actual improvement.

A suggested fix is a hypothesis to investigate. Completing a task alone does not prove conversion improved. Lead targets should use measured stage rates: required leads = ceiling(desired acquired clients / measured lead-to-client conversion). Before sufficient data, label all scenario rates as assumptions.

## Dependencies required to finish live integrations

- Authorized Google Ads and Meta business accounts, lead-form configuration and credentials.
- Telephone provider/account, number and approved operational calling process.
- Chosen service areas, availability, prices, campaign budget and capacity limits.
- Named staff accounts and approved scope of client/contact information.
- A production release window and API/database deployment capability.

No advertisements, invitations, calls or messages are sent by this local build.

The authoritative numbered completion status and remaining blockers are in NUMBERED_TASK_CHECKLIST.md. Estimates above are planning ranges for live acceptance, not a promise that accounts, publishing or device access can be completed without their prerequisites.
