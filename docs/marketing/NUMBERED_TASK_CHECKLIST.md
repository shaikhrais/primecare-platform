# Numbered sales and marketing task checklist

Current operating guidance and the 2026-10-28 CEO fixes are in [CEO marketing and business readiness](CEO_MARKETING_READINESS.md). The dated local-only, publication and CI limitations below are historical snapshots; current test and release evidence is recorded in that guide and the [continued workflow audit](../workflows/CONTINUED_WORKFLOW_AUDIT.md).

Built locally means implemented and locally tested; deployment and live validation remain task 28. Local PostgreSQL-compatible SQL checks use PGlite; CI must still run standard PostgreSQL 16. No advertisements, messages, invitations or calls have been sent.

| No. | Task | Status |
|---:|---|---|
| 1 | Founder targets, progress, gaps and weak stages | Built locally |
| 2 | Client and tenant lead pipelines | Built locally |
| 3 | Campaign sources, budgets, spending and lead costs | Built locally |
| 4 | Corrective tasks with owners, deadlines and evidence | Built locally |
| 5 | Caller queue, outcomes and callbacks | Built locally |
| 6 | Do-not-contact enforcement | Built locally |
| 7 | Marketing staff specialties | Built locally |
| 8 | Appointment booking and handoffs | Built locally |
| 9 | Dedicated staff permissions and assigned-lead access | Built locally; permission, SQL and browser tests passed |
| 10 | Contact editing, lead search/filters and duplicate management | Built locally; SQL, permission and browser checks passed |
| 11 | Campaign briefs: owner, audience, offer, creative and landing page | Built locally; SQL, source/owner permission and browser checks passed |
| 12 | Campaign review and approval | Built locally; version, role, rollback and EN/FR/ES browser checks passed |
| 13 | Task reassignment, priorities and escalation | Built locally; validation, scope/revocation, rollback and browser checks passed |
| 14 | Website enquiry forms connected to lead inbox | Built locally; anonymous intake, consent, gateway/service, SQL and browser checks passed |
| 15 | Offline QR codes, event intake and referrals | Built locally; source, first-touch, QR decoding/download and browser checks passed |
| 16 | Google lead integration | Needs authorized account connection |
| 17 | Facebook/Instagram lead integration | Needs authorized account connection |
| 18 | Telephone provider integration | Needs provider selection/access |
| 19 | Appointment reminders and notifications | In-app due/overdue reminders built and scoped; automated outbound reminders blocked by provider setup |
| 20 | Employee/source-to-client performance reports | Built locally; source/cohort and current-owner/caller activity reports tested |
| 21 | PDF downloads and controlled email sharing | PDF downloads built and tested; controlled email/review code tested with mock binding; live delivery needs setup |
| 22 | Central, platform and tenant admin hierarchy | Built locally; central/global/own-tenant API and browser boundaries tested |
| 23 | Tenant verification, onboarding and account activation | Manual verification and atomic tenant/admin activation built locally; no real invitations sent |
| 24 | Client handoff to staffing, scheduling and care delivery | Existing-visit linkage and current care-status visibility built locally; care scheduling/delivery acceptance remains pending |
| 25 | Revenue, billing and acquisition cost | Manual CAD invoices, receipts, refunds, costs and acquisition metrics built locally; bank/payment integrations pending |
| 26 | Equivalent native application workflows | Blocked: Flutter/Dart SDK and physical devices unavailable |
| 27 | Full integration, permission, accessibility and platform tests | Local integration/permission/browser checks passed; PostgreSQL 16 CI, Cypress, full accessibility and device acceptance pending |
| 28 | Deployment and live end-to-end validation | Blocked: production credentials, release access and approved source publication unavailable |
| 29 | Tenant launch checklist and human approval | Built locally; prerequisites, stale approval and browser workflows tested |
| 30 | Tenant documents and renewals | Built locally; versioned upload/download/review, expiry and scoped access tested; outbound notices pending |
| 31 | Tenant support desk | Built locally; owners, response/resolution deadlines, evidence, reopen and history tested |
| 32 | Territory enquiry routing | Built locally for the enquiry desk/API and new territory-mode public links; legacy links retain direct routing |
| 33 | Public marketing forms connected to territory matching | Built locally; explicit sharing consent, anonymous immutable receipts, protected source counts and recipient acceptance tested in EN/FR/ES |
| 34 | Administrative attention queue | Built locally; scoped overdue support, latest-document actions, expired/unmatched offers and launch reviews with correction navigation |
| 35 | Bounded previews and paginated administrative histories | Built locally; document revisions, support messages, deadline events and launch decisions through scoped APIs |
| 36 | Automated admin/growth accessibility and keyboard checks | Local automated checks and corrections; full human, screen-reader and physical-device acceptance remain pending |
| 37 | Territory map label readability and selected-area targets | Local visual correction; readable city names, collision avoidance, resize cleanup and larger service checkboxes; human acceptance pending |
| 38 | Franchise owner, tenant administrator and growth role separation | Built locally; owner authority, own-console scope, protected accounts and restricted finance enforced by APIs; release acceptance pending |
| 39 | Central marketing proposal and budget review | Local 5% preview with advertising/management split and monthly tenant-ledger basis; budget snapshots and fresh approval after budget changes; fee activation/provider publishing pending |
| 40 | Monthly marketing proposal statement and PDF | Month selection, localized tenant-scoped reports, PDF and read/download audit built locally; no fee collection or frozen financial close |
| 41 | Campaign readiness and owner capacity confirmation | Local versioned, expiring owner evidence and five preparation checks; immutable history and audited writes; provider launch remains unavailable |

Task 9 evidence: six governed account roles; current CEO may create/manage them in the same tenant. Callers/coordinators are restricted to assigned leads and own appointments; specialists are restricted to their campaign sources and own tasks without individual client contacts. Broad existing CEO/marketing roles are preserved. Tests exercise direct API denial, reassignment revocation, source restriction and all six staff browser workflows. No live staff accounts were created.

Task 10 evidence: optimistic contact corrections preserve preferences; search/filter queries retain assignment scope; duplicate decisions are versioned and audited. Confirmation retains history, closes only the selected redundant record, carries opt-outs forward and excludes duplicates from acquisition aggregates. No production records changed.

Task 11 evidence: separately versioned draft briefs, eligible owners, audience/offer/creative fields, optional HTTPS URL, dates and planned lead goal. Managers assign eligible owners; source specialists may edit their own briefs. Saving does not launch advertisements, build pages or grant approval. Local SQL tests include rate-limit protection and rollback; browser tests cover three languages and the four source-specialist roles.

User-requested UI refresh: implemented a light Daylight default, white sidebar, section navigation/icons, and care/marketing illustrations. Existing Theme Center preferences and unfinished forms are retained. This is an additional visual update; task 12 was the next business workflow and is now implemented below.

Task 12 evidence: submit, withdraw, approve, request changes and reject; frozen pending briefs; editing resets approval. Decisions retain immutable versioned snapshots and evidence. CEO/marketing review, with recorded CEO self-review for the one-person model. No campaigns are launched or spending authorized. Task 13 is implemented below.

Task 13 evidence: managers reassign open tasks, set low/normal/high/urgent priorities, change deadlines and resolve blockers. Assigned staff can escalate only their own tasks. Every action requires evidence and a current version, supports safe retries, and writes transactional audit. Reassignment immediately revokes former-owner access. Overdue/escalated work is shown first; escalation sends no notifications.

Task 14 evidence: managers create client/partner links tied to an active owner and optional website campaign. Anonymous contact-only forms require response consent and deliver a new website lead to the assigned inbox. Generic receipts, exact-contact deduplication, immutable consent receipts, rate limits, safe retries and disable controls are tested. No live links were published, and no messages were sent. Next: task 15.

Task 15 evidence: website, offline-event and referral-organization links use fixed sources and matching campaigns. Offline/referral attribution is required. Local QR generation and SVG download work without a third-party QR service. New acquisitions and repeat contacts are counted separately; old receipt classifications remain unknown. Repeat enquiries preserve original lead source and opt-outs. Google integration requires an authorized account connection.

Tasks 19–21: computed alerts cover due callbacks, scheduled appointments within 24 hours and overdue/escalated tasks, with 50 per category. Reports cap current owner rows at 200 and periods at 365 days. They include no clinical or client contact fields. Unknown email outcomes require actor-owned, versioned manual reconciliation before retry; provider acceptance is not recipient delivery.

Tasks 22–23: central administrators manage global platform/tenant provisioning; platform administrators cannot create or modify global peers; tenant administrators manage eligible accounts and reference records only in their own active tenant. Central peers require protected bootstrap. CEO/tenant owner verification records identity, agreement and insurance review evidence; changing contact details invalidates verification. Global activation creates one active tenant and one tenant administrator using the reviewed lead email in a single audited transaction. Nurse/retired nurse background does not grant clinical credentials.

Tasks 24–25: CEO/tenant owner can link a nonduplicate, agreed client lead to an existing same-tenant visit whose active client account email matches. Visit status and assignment are read from care tables; marketing does not create visits, assign clinical staff, or prove delivered care. Finance records are append-only manual CAD entries. Invoice payment/refund limits, unique references, chronological receipts, retries and audit rollback are enforced. Campaign spend is separate from operating costs. Paying-client counts mean CRM lead records with positive net receipts, not verified unique patients; no profit or independence date is claimed.

Verification on 2026-10-14: 103 unit/auth/report/legacy-route/bootstrap checks; eight local PGlite SQL scenarios plus two hierarchy SQL scenarios (the local hierarchy retry run is sequential; actual concurrency remains in PostgreSQL CI); 34 founder browser workflows and six admin activation/scope workflows. All use synthetic records. TypeScript checks and nine website bundles pass locally. This is not a production or full WCAG acceptance claim.

Publication: an earlier automatic approval review rejected pushing the private source repository to GitHub. The work is retained in local commits; no push, deployment or real provider action is claimed. No further “Continue” prompt is needed.

Tenant administrators receive the growth dashboard in their own active tenant, including target visibility, marketing/caller coordination, partner workflows, care links and permitted ledger operations. Task 38 restricts target changes, campaign decisions/money and refund/expense entries to the owner/CEO. Their admin console links to it. This does not add them to the CEO account-creation allowlist or grant global tenant provisioning.

Platform admin and growth remain the current priority; workforce implementation is paused. The [closeout checklist](../appearance/ADMIN_GROWTH_CLOSEOUT.md) records the latest row-draft fixes and 8 admin/34 growth browser checks, plus 25 local unit/API cases. These local results do not close provider connections, publication, real PostgreSQL concurrency or production acceptance.

First selected platform bundle (2026-10-16): see [implementation and operating guide](../platform-bundle/README.md). Local results: 25 new checks passed (including six EN/FR/ES browser cases at 320/1440 CSS pixels), 32 tenant/territory regressions passed, and 112 auth/bootstrap regressions passed. Two independent-connection cases remain skipped locally and are wired to PostgreSQL CI. No live deployment or production records were created.

Public territory intake continuation (2026-10-16): [operating guide and boundaries](TERRITORY_PUBLIC_INTAKE.md). New links can select direct or territorial delivery; legacy links stay direct. Local verification: 36 public-intake checks across UUID/text variants, 25 first-bundle checks and two legacy intake scenarios passed. Three real PostgreSQL contention checks remain pending locally. No public link, invitation, campaign or production record was published.

Support/routing navigation correction (2026-10-16): workflow filter, active tab, records and pagination now stay aligned. Applying a different workflow resets to page one; tab changes discard the previous workflow selector while unchanged-workflow language changes retain search drafts. Six new EN/FR/ES browser regressions at 320/1440 CSS pixels reproduced the original mismatch before the correction.

Launch-review correction (2026-10-16): central/platform administrators can request changes with a recorded reason. The tenant sees feedback, corrects setup/training and resubmits; a new explicit human approval remains required. Returning a review does not approve launch or enable lead delivery.

Tasks 35–36 verification (2026-10-16): 12 history checks and 38 admin/growth role-language-size checks passed; 34 bundle, 13 attention and 18 public intake/routing regressions passed, for 115 unique local passing checks. Automated accessibility evidence records 204 scans with zero violations; incomplete contrast checks remain for manual review. Two real PostgreSQL contention cases and the external/human release gates remain pending. See [history and accessibility guide](../platform-bundle/HISTORIES_AND_ACCESSIBILITY.md).

Task 36 contrast continuation (2026-10-16): all 50 targeted checks passed with visible-state contrast review enabled. Across 204 states and 1,143 flagged occurrences: 506 engine passes after scrolling, 167 supplemental passing measurements (including 62 filled-control probes), 470 unresolved and zero confirmed contrast failures. Original findings remain recorded; manual acceptance remains pending. [Review method and results](../platform-bundle/CONTRAST_REVIEW.md).

Task 37 continuation (2026-10-16): reviewed the actual map screenshots, corrected city-name sizing/collisions and enlarged selected-area service checkboxes after an automated target-size failure. Six EN/FR/ES cases cover overview, zoom and resize at 320/1440 CSS pixels (18 final states, zero automated accessibility violations); the broader 44-case admin/growth run also passed. [Changes, reproduction and evidence](../platform-bundle/MAP_READABILITY.md). Human review, unresolved contrast and release gates remain open.

Task 38 (2026-10-17): [role matrix, operating workflow and enforcement](ROLE_BOUNDARIES.md). Explicit franchise owners now receive their governed growth landing and own-tenant administration. Tenant administrators retain operational team access without owner promotion, plan/money decisions or campaign approval. Current authority is checked before privileged retry replay. Protected administrator API behavior matches the UI. Historical task evidence above describes the policies at that time; task 38 supersedes its broader tenant-admin/reviewer permissions. Local browser, API, policy and SQL-compatible regressions are recorded in the role review; deployment and independent acceptance remain pending.

Task 39: [central marketing model](CENTRAL_MARKETING_MODEL.md). The UI displays a nonbillable proposal using recorded monthly payments less refunds, with exact-cent allocation and EN/FR/ES role-scoped rendering. Review history now captures budget/version/currency; changing budget resets the brief for fresh owner approval. No fee, invoice, provider spend or global agency access was activated.

Task 41: [campaign readiness and capacity operating guide](CAMPAIGN_READINESS.md). Current owner budget review, unspent budget, campaign dates and expiring capacity are checked by APIs. Zero slots, changed briefs, expired evidence and revoked confirmer authority block preparation readiness. Provider launch stays disabled. Apply the additive capacity migration before enabling confirmation writes; other views fail closed when it is absent.
