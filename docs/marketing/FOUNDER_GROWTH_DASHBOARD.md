# Founder growth and marketing workflow

The founder can see which partner/client acquisition stage is behind plan and assign a named person and deadline to corrective work. Marketing staff record Google search research, Google Ads enquiries, Facebook, Instagram, offline, referral and website sources against campaigns. This delivery provides an authenticated website at `/growth?enable-semantics=true`; the website layout supports mobile through 4K desktop widths.

| Role | Authority |
|---|---|
| CEO / founder | Own-tenant dashboard, leads, campaigns, tasks and plan targets |
| Head of Marketing / Local Marketing Manager | Own-tenant dashboard, leads, campaigns and tasks; cannot change founder targets |
| Telephone Caller / Care Handoff Coordinator | Assigned leads, call queue, calls and own appointments; complete own tasks; no lead reassignment or campaign writes |
| Google / Meta / SEO / Offline specialists | Only matching campaign sources and own tasks; no client contacts, calls or appointments |
| Other roles | Denied by server policy |

The proposed Central Admin / Platform Admin / Tenant Admin account-creation hierarchy remains a separate pending work package. This feature does not assign roles or grant cross-tenant access.

## Daily use

1. Open **Growth and marketing** from an authorized workspace, or open `/growth` directly after login.
2. The founder saves the plan dates and stage targets. Unsaved targets are monthly planning assumptions; they do not reset every day.
3. Marketing creates a campaign with source, campaign/QR reference, recorded CAD budget and spend.
4. Record an enquiry or public business prospect, its source evidence and contact basis. A family enquiry cannot use the public-business contact basis.
5. Assign an active CEO or marketing-team account in the same tenant and a follow-up time. Review overdue follow-ups.
6. Record the next milestone with supporting evidence. The server allows sequential stages; closing a lead retains historical milestone evidence.
7. Use the suggested investigation for the earliest stage behind plan. Create a corrective action with owner and due date; completing it requires evidence.
8. Refresh and review changes. A completed action alone does not prove that conversion improved.

## What the dashboard means

Partner stages: new prospect -> discussion -> demo -> pilot agreed -> operating partner reported.

Family stages: new enquiry -> needs discussion -> care agreement reported -> first visit reported -> recurring family reported.

Funnel counts use unique lead milestones within a plan-period lead cohort, capped at the period end. Historical achievements remain when a lead closes. They are CRM-reported milestones, not proof of tenant provisioning, client enrolment, clinical assessment, completed care or payment collection.

Expected by today = ceiling(target x elapsed fraction of the plan period). Gap = max(0, expected - actual). Stage conversion uses the preceding stage; a zero denominator displays unavailable rather than a fabricated 0% conversion. Suggested fixes are investigation steps, not confirmed causes.

Work queues, recorded campaign spend and per-campaign enquiry counts cover all recorded history. Source enquiry counts and funnel cards cover the selected plan period. Cost per enquiry = recorded campaign spend / attributed enquiries; with no enquiries it is unavailable. Staffing, completed visits and collected revenue explicitly remain unconnected.

The first 100 leads are paginated. Campaign, task and owner pickers show up to 100 records. Full aggregate funnel and lead counts are calculated in SQL, independently of lead pagination. Larger campaign/task/owner navigation remains an extension requirement.

## Marketing connection status

Manual source attribution and campaign tracking work for Google, Facebook and offline activity. This change does not launch advertisements, send messages, scrape private profiles or automatically import leads. Google Ads and Meta automatic import remain **not connected**. Google documents a lead-form webhook URL and validation key; Meta requires an authorized lead-retrieval integration and account permissions. Connections must be configured and tested before they can be labelled connected.

- Google lead webhook documentation: https://developers.google.com/google-ads/webhook/docs/implementation
- Meta official lead-retrieval guide: https://developers.facebook.com/docs/marketing-api/guides/lead-ads/retrieving/

## Architecture and persistence

The governed seed registers two screens, governed founder/business/reporting sections and one public form section, approved control mappings, three broad, six dedicated staff and one tenant administrator growth grants, twenty-nine growth API operations and EN/FR/ES text in governance.db before generating `packages/shared/src/growth/registry.json`. The migrations create twenty-one isolated growth tables for plans, campaigns, leads, milestone evidence, tasks, audit, request replay and rate limits. Text and UUID tenant identities are supported.

Shared GrowthPolicy and GrowthAnalytics contain authority, transition and calculation rules. GrowthRepository and GrowthCommands handle SQL and mutations. The website uses the same registry, displays server calculations and sends commands through GrowthClient. It stores no business records in browser local storage or offline JSON.

Every operation validates a current active session and tenant; owner/campaign references are checked in that tenant and owner pickers exclude client and unrelated-role accounts. Writes use idempotency keys, per-actor limits, optimistic record versions and transactional audit. Failed audit or persistence rolls back the business mutation. Integration secrets are not accepted by this initial workflow.

OpenAPI: `docs/marketing/growth.openapi.json`. These are twenty-nine growth operations (plus two new global partner-provisioning operations); no legacy API completion credits or denominators are changed. The additive module registry fingerprint is reconciled with its reviewed evidence; existing blocked methods and handler order are regression-tested.

## Release and verification

Apply `20261013_growth_marketing.sql` using the authorized TypeScript Worker deployment workflow. `scripts/apply-growth-schema.mjs` verifies the twenty-one growth tables and required administration tables before publication. Then deploy APIs/gateway before websites, following the existing release process. A source-only PR or browser fixture is not evidence of production deployment.

Tests cover calculations, monthly cohort stability, input and role policy, persistence, duplicate/retry handling, stale versions, tenant isolation, audit rollback and EN/FR/ES browser flows. Local SQL checks use a PGlite engine adapter; CI uses PostgreSQL 16 and the actual pg driver. Screenshots contain synthetic fixture records. They are browser evidence, not physical-device tests. Native Flutter growth UI and Google/Meta automatic ingestion remain pending.

## Caller, team and appointment extension

The CEO can assign one operational specialty to each existing authorized team member: telephone caller, Google specialist, Meta specialist, SEO/content, offline partnerships or care handoff. A specialty does not change account authorization. Six dedicated account roles now enforce these boundaries on the server. Existing broad marketing roles retain their tenant-wide access; assigning an operational specialty does not narrow or expand their authority. Use the dedicated account role when onboarding restricted staff.

The caller workspace lists the first 100 requested-contact leads with phone numbers, ordered by follow-up time. Call logs record manual outcomes and evidence. A callback requires a future time. A do-not-contact outcome blocks later call logging and new appointment scheduling; there is no automatic reactivation. Public business prospects and unrequested contacts cannot be logged as contacted through this initial caller workflow. Call logs are activity records, not provider-confirmed telephone events. Wrong-number outcomes clear the callback; Use the versioned contact-correction form to fix details; it does not clear an opt-out.

Appointments require requested contact, an active owner, a future start and 15–180 minutes. Owner and lead scheduling collisions are rejected. A future appointment can be cancelled; completion/no-show cannot be recorded before its start. Completion does not advance a CRM stage, notify attendees, provision care or verify service delivery. Existing appointments survive a contact opt-out and must be reviewed/cancelled explicitly by staff. Histories display the first 100 records; aggregates cover all history.

Apply the base growth migration followed by `20261013_growth_operations.sql`. Both are additive and repeatable. All operations inherit active tenant/session checks, write limits, idempotency, audit rollback and no-store responses. Team changes are restricted to CEO/tenant administrator and versioned. Call writes lock/version the lead; appointment writes lock the lead and owner scheduling key.

See `SALES_MARKETING_IMPLEMENTATION_PLAN.md` for the full requested scope, remaining dependencies and planning estimates.

## Task 9: dedicated account permissions

The governed roles are `growth_caller`, `growth_coordinator`, `growth_google`, `growth_meta`, `growth_seo`, and `growth_offline`. The existing CEO account-creation and account-management policy permits these roles within the CEO tenant. Existing HR grants remain unchanged. No staff creation authority is granted to the new roles; no production staff accounts are created by this change.

Caller/coordinator reads use owner-filtered SQL before returning data, including counts, historical calls, tasks and appointments. Appointment access requires both current lead assignment and appointment ownership. Reassignment removes access on the next request. Callers cannot edit lead assignment or milestones. Digital/offline specialists receive source-restricted campaign records and aggregate CPL counts, without individual leads, call notes or appointment records. All staff see only their own task records and owner picker entry. Campaign source restrictions and assignment/ownership checks are enforced on writes, in addition to the existing active-session, tenant, audit, version and replay protections.

The source mapping is Google -> Google Ads/Search; Meta -> Facebook/Instagram; SEO -> Website; Offline -> Offline/Referral. Shared sources are intentional; finer campaign ownership is a separate extension. Global founder funnels and target editing are hidden for staff rather than presenting assigned-lead counts as tenant-wide results. New permissions are exported from governance before bundling. Local tests cover assignment revocation, same-tenant unauthorized access, source boundaries, account creation authority and six staff browser workflows.

## Task 10: contact correction, filtering and duplicate review

The lead list accepts name/email/phone search, pipeline, stage, source and owner filters with matching paginated totals. Search is case-insensitive and treats wildcard characters literally; phone searches also compare normalized digits. Filtering affects the lead list/count, not the founder's full-period funnel or caller's full follow-up queue. Caller/coordinator queries always retain the mandatory assigned-owner restriction; selecting another owner cannot broaden it. Campaign specialists do not gain contact access through filtering.

Contact corrections require current lead version and business evidence. Existing managers may edit their tenant leads; dedicated callers/coordinators may edit assigned leads only. Names, email and phone can change; pipeline, source, contact basis, owner and opt-out flags cannot be changed through this endpoint. Exact identity collisions return a sanitized conflict. Archived duplicate records cannot be edited. Successful corrections increment the contact revision and lead version, audit the change, and preserve source/milestone records. They do not send any communication.

Managers review the first 50 unresolved exact shared-email/shared-phone candidates within the same pipeline and tenant. Empty contacts do not match. A 'different people' decision suppresses that candidate until contact details change. A review requires both current lead versions, current review version and evidence. Confirming a duplicate explicitly selects the retained lead, closes the redundant record, blocks contact and clears its callback. An existing opt-out propagates to the retained record; contact permission is never upgraded automatically. Histories remain separate. Existing appointments are not cancelled automatically and require staff review. Duplicate chains and nonmatching/cross-pipeline candidates are rejected. There is no automatic fuzzy matching, deletion, unmerge or history transfer.

Retained duplicate records remain searchable but are excluded from funnel milestones, source enquiry counts and campaign enquiry/CPL denominators. Overall lead-list counts include retained records so pagination stays accurate. Previously confirmed duplicate identities continue to reserve their original uniqueness key; choosing the appropriate canonical record matters when correcting contact information.

Apply the base growth schema, operations schema, then `20261013_growth_contacts.sql`. The deployment guard verifies twelve tables. Tests cover literal/normalized search, scoped filters, correction conflicts and replay, opt-out preservation, candidate invalidation, explicit duplicate closure, aggregate exclusion, and contact/duplicate rollback when audit fails. Standard PostgreSQL CI and live deployment are still pending.

## Task 11: versioned campaign briefs

Each campaign can have a separately versioned draft brief: active owner, audience/service area, offer/call to action, creative copy/asset instructions, optional HTTPS landing-page URL, client or partner pipeline, planned lead target, and start/end dates. Target must be 1–1,000,000 and the period is at most 366 calendar days. Planning text supports line breaks; displayed text is escaped. URLs cannot contain credentials or use non-HTTPS schemes. They are stored as planning references and are never fetched or opened by saving.

Managers assign active same-tenant owners who can edit the campaign's source. Google, Meta, SEO and offline specialists can create briefs owned by themselves and edit only their own briefs within permitted sources. They may read briefs for their permitted source as planning collaboration, without employee email lists or individual client contacts. Another specialist cannot take over an assigned brief. Callers/coordinators cannot access campaign briefs. Operational specialty tags do not change these account permissions.

The brief's owner choices are source-compatible and drawn from the existing first-100 active owner picker. Campaign budget/spend versions remain separate from brief versions. Saving a brief does not build a landing page, upload creative assets, launch ads, spend a budget, connect lead intake, or approve a campaign. Internal review/approval is implemented in task 12 below. Brief goals are planning inputs rather than measured acquisition forecasts; campaign enquiry totals remain the previously defined aggregate, not a new per-brief goal-attainment calculation.

Apply `20261013_growth_briefs.sql` after the three preceding growth migrations. The current deployment guard verifies seventeen tables after all intake migrations. Brief writes inherit current tenant/session checks, permitted source checks, per-actor write limits, stable idempotency keys, version conflict detection and transactional audit. A campaign-scoped transaction key serializes initial brief inserts. Tests cover URL/date/text bounds, eligible owners, source and ownership denial, retries, stale versions, audit rollback, and browser save/reload in EN/FR/ES plus owned specialist workflows.

## Growth dashboard visual refresh

The growth screen uses a governed Daylight palette with a white sidebar, teal actions, light surfaces, section/metric icons, section jump links and two generated editorial illustrations. Illustrations are decorative scenes, not evidence of actual staff, clients or care delivery. All nine website builds include the static assets. Source values live in the growth policy and `theme_design_tokens`, with icon/image adapters registered before rendering.

The existing Theme Center remains available. A screen default is applied through the shared theme/layout manager; saved light/dark and personal preferences take precedence. Leaving the screen restores the next screen's default rather than leaking the growth palette. Section links scroll within the existing screen and retain unfinished forms. Business permissions, counters and mutation workflows are unchanged. Desktop/mobile/4K checks and existing layout/37-palette theme regression suites passed locally. This refresh does not complete task 12 or publish the application.


## Task 12: internal campaign review

Owners and CEO/marketing reviewers can submit a saved draft or withdraw a pending brief. Only CEO/marketing decide: approve, request changes, or reject. Marketing managers cannot decide on their own briefs; CEO self-review is allowed for the one-person founder model and explicitly recorded. Local managers and source specialists cannot approve. Specialists can only submit/withdraw their own source-compatible briefs. All checks use the current authenticated role and tenant. Unrelated roles and foreign campaigns are denied.

Pending review freezes editing. Withdrawal returns to draft. Editing approved, rejected, or changes-requested content resets the status to draft; resubmission is required. Every content edit and review action increments the brief version, so two decisions based on the same version cannot both succeed. Budget and spend records remain separate; this is internal planning approval, not approval to spend money or publish advertisements.

POST `/v1/governance/growth/reviews/{id}` accepts action, version and required evidence (1–1,000 characters). It inherits bearer/current-session checks, 90 write attempts/minute, idempotency fingerprints, sanitized errors and transactional audit. Actions are serialized using the same campaign advisory lock as brief saves. History records actor identity/role, action, exact prior brief snapshot, prior/result versions, evidence, timestamp and founder self-review. The API exposes no history mutation; a database trigger also rejects updates/deletes. History remains after later edits.

Apply `20261013_growth_reviews.sql` after `20261013_growth_briefs.sql`. Existing briefs become drafts; no historical approvals are invented. Repeated migration application is supported for text and UUID tenant identities. The review migration brings the count to fourteen; the current deployment script checks seventeen including intake. No standard PostgreSQL 16 CI or live deployment is claimed: local SQL validation uses the documented PGlite adapter.

Validation: 76 shared/auth/route regression checks; two SQL identity suites covering approval, changes/rejection/withdrawal, own-role restrictions, source/tenant boundaries, stale versions, replay, frozen editing, approval invalidation, immutable history and rollback on audit failure; sixteen browser scenarios including approval/edit invalidation in EN/FR/ES at 320px and 1440px plus other layout/staff regressions. TypeScript and all nine website builds passed. Full accessibility/native/live-account checks remain tasks 26–28. Screen and control governance tags remain partial/test_pending; Playwright fixtures are not Cypress production evidence. Synthetic screenshot: `images/campaign-review-preview.png`.


## Task 13: task ownership, priority and blockers

CEO, marketing and local marketing managers can reassign an open task to an active same-tenant growth user, change its deadline or priority (low, normal, high, urgent), record an escalation, and resolve one. Staff can only record blockers on their currently assigned open tasks. Reassignment immediately removes the task from the former owner's list and denies their subsequent writes. Completed tasks cannot be changed through task actions; existing evidence-based completion remains available.

POST `/v1/governance/growth/task-actions/{id}` requires action, current version and evidence (1–500 characters). Reassignment additionally requires ownerId, rescheduling dueAt, and priority changes priority. Unexpected or action-incompatible fields are rejected. The server locks the task row, validates owner eligibility and current authorization, increments the version, and commits the mutation together with audit and idempotency replay. Failed audit rolls back; stale versions return conflict. Existing session, tenant and actor rate checks apply. Deadlines may reflect overdue work; rescheduling does not silently force a future date.

The first 100 tasks are ordered open before done, then escalated, overdue, priority and deadline. Each row shows priority, overdue status and the latest unresolved blocker. A manager resolves blockers explicitly; no messages or notifications are sent. The audit keeps action evidence; this release does not add a separate task-history viewer or automatic escalation timer. Notifications remain task 19.

Apply additive, repeatable `20261014_growth_tasks.sql` after the review migration. It adds priority, escalation timestamp and reason to the existing task table; existing tasks default to normal priority. Task 13 leaves fourteen tables before the intake migration. Governance registration adds the endpoint, role policy, controls and EN/FR/ES resources before code; partial/test_pending tags remain honest about Cypress/native/live checks.

Validation: 77 shared/auth/route regression tests, two PGlite-backed SQL identity suites including action-specific validation, safe retry, stale versions, foreign/ineligible owners, staff denial, reassignment revocation, closed tasks and audit rollback; sixteen browser scenarios including priority/escalate/resolve in EN/FR/ES at 320/1440px. TypeScript and nine website builds passed locally. Standard PostgreSQL CI and deployment remain pending. Synthetic screenshot: `images/task-management-preview.png`. Next: task 14, website enquiry intake.


## Task 14: website enquiry intake

Managers (CEO, marketing, local marketing) create a public enquiry link in the growth dashboard. The title is public-facing. Each link fixes the tenant, client/partner pipeline, active owner with lead-inbox access and optional campaign matching the source (website by default; offline/referral extensions below). Links use a shareable 64-character key with 244 random bits; they are not user sessions. The manager can disable/re-enable a link with versioned, audited commands. Staff cannot create/manage links or see the private link list.

Public route `/enquire/{key}?enable-semantics=true` renders a contact-only form in EN/FR/ES, preserving draft fields and consent across language changes. It requires a name, at least one valid email/phone, explicit permission to respond to this enquiry, consent text version `contact-response-v1`, and an empty honeypot. It asks visitors not to provide health information and has no free-text health field. Response permission is distinct from general advertising permission. Contact and identity remain unverified until staff qualification; this does not book care or verify partner credentials.

GET `/v1/governance/growth/enquiries/{key}` exposes only the public title, pipeline and consent version. POST requires a stable idempotency key and returns only `{accepted:true}` with status 202, including duplicate enquiries; it never exposes lead IDs or existing-contact status. The caller cannot choose tenant, source, owner, campaign, stage, due date, or consent basis. Active link, tenant and receiving owner are checked inside the transaction. Campaign-only specialists cannot receive intake leads. A receiving-owner role change that removes inbox access disables intake at request time. Inactive/disabled/unavailable configurations share the same not-found response. Website-link contacts enter stage new, source website, requested contact basis, and an initial one-day follow-up deadline.

Exact shared email or normalized telephone matches reuse the existing lead and store a new receipt instead of creating another lead. Existing contact fields, ownership, stages and opt-outs are never overwritten or upgraded. Shared-contact submissions can represent different people; this release deduplicates them conservatively and does not verify identity or provide a receipt-detail review screen. Existing Task 10 manual duplicate review remains available for separate lead records. Receipts store link/lead IDs, canonical request hash, consent version and timestamp, without another copy of contact details. They form the immutable anonymous audit trail; no human account is falsely recorded as the submitting visitor.

Rate limiting persists outside the business transaction: 20 valid parsed requests per source IP per minute across links and 100 per known link, including configuration reads and retries; 429 supplies retry-after 60. The trusted Cloudflare source-IP header is preserved through the existing gateway; absent IPs share the conservative unknown-source bucket. Random invalid keys do not generate per-link buckets. Malformed input fails validation before rate storage. The shared parser limits bodies to 50,000 bytes. A honeypot and rate limits provide basic abuse controls, not identity verification or a CAPTCHA service. Traffic/edge validation, retention cleanup for receipts/rate rows, CAPTCHA/provider choices if needed, and live rollout remain task 28; no live form or channel has been deployed.

Public mutations serialize same-tenant/pipeline duplicate checks and commit lead, milestone and consent receipt together. Reusing an idempotency key with different content conflicts; repeating the same accepted submission creates no second receipt. Failed receipt persistence rolls back new lead and milestone. The database rejects receipt updates/deletes. Disabling a link blocks future configuration/submissions including retries. POST `/growth/intake-links` and PATCH `/growth/intake-links/{id}` use existing current-session, manager scope, version, 90/minute actor rate, audit and replay controls.

Apply additive repeatable `20261014_growth_intake.sql` after the task migration. It adds intake links, immutable receipts and public rate buckets, bringing the deployment guard to seventeen tables. Governance registration covers the public screen, approved checkbox adapter, manager controls, public/manager API permissions and translations before code; tags remain partial/test_pending for unrun Cypress/native/live checks. OpenAPI now describes 21 additive growth operations; the legacy API denominator is unchanged.

Validation: 78 shared/auth/route checks; four SQL identity suites (core and intake, text/UUID tenants) covering consent, tenant/owner injection, duplicate/opt-out preservation, rollback, immutable receipts, rate limits, disabled/inactive configurations, staff denial and actual ServiceWorker/GatewayWorker anonymous routing/CORS; 22 browser scenarios including six public-form-to-assigned-inbox journeys across EN/FR/ES at 320/1440px. TypeScript and nine website builds passed locally. SQL uses PGlite locally; standard PostgreSQL CI remains pending. The browser test exposed a retained topbar refresh button staying disabled after save; transient button states now restore while preserving originally disabled controls. Screenshots: `images/public-enquiry-preview.png` and `images/enquiry-inbox-preview.png`.


## Task 15: offline events, referrals and QR codes

Managers create a client or partner intake link with website, offline or referral source. Offline links require an event/printed-campaign label; referral links require a referring-organization label, up to 200 characters. An optional campaign must belong to the same tenant and match that source. Attribution and source are fixed when the link is created; only enable/disable can be changed. Existing website links retain their source. Visitors still use the contact-only consent form and cannot override source, campaign, owner, tenant or attribution.

Each link displays a locally generated QR code for the current website origin and exact public enquiry URL, including enable-semantics=true. The downloadable SVG is a vector symbol suitable for resizing. Encoding uses a vendored QRCode encoder (qrcode-terminal 0.12.0 vendor files; original Arase MIT copyright and package Apache 2.0 notices retained), automatic version selection, error correction M, a four-module quiet zone and governed black/white colors. URLs are bounded to 512 ASCII characters. No session token or contact data is encoded, and no third-party QR service receives the link. The QR shares a public route key; disabling that link makes the printed code's destination unavailable too.

Lead source, matching campaign and the event/referring-organization attribution are stored at first acquisition. Repeated shared-contact submissions do not replace the original source, ownership or contact preferences. Link cards show received enquiries, new leads and repeat contacts; these are acquisition measures, not client conversions. A consent receipt now records whether it created a lead. Existing receipts retain null classification and are shown separately rather than being given invented historical counts. Retries using the same idempotency key do not inflate metrics. Receipt immutability, caller scope, consent, rate limits and disable controls from task 14 remain enforced.

Apply repeatable additive `20261014_growth_offline.sql` after the intake migration. It adds source/attribution to links and nullable new_lead classification to receipts; table count remains seventeen. The existing POST intake-link schema adds optional source/attribution with backward-compatible website defaults. The API operation count stays 21; these field/workflow additions are not additional completed APIs. Native QR camera scanning, printed-device quality checks and live Pages-origin validation remain rollout/platform work; no live event or referral link has been distributed, and no invitations were sent.

Validation: 80 shared/auth/route checks, four PGlite SQL identity suites, TypeScript and nine website builds. SQL tests cover required attribution, matching campaigns, injected public source denial, original-source/opt-out preservation and new-versus-repeat counts. Twenty-two browser scenarios include offline/referral intake in EN/FR/ES at 320/1440px, independent jsQR decoding of rendered SVGs to the exact URL, and assigned-inbox delivery. Download tests verify the browser saves the expected SVG filename/content. Additional shared tests independently decode short and long-origin QR symbols and reject credential-bearing/non-HTTP(S)/oversized payloads. Standard PostgreSQL CI and physical-device checks remain pending. Screenshot: `images/offline-referral-qr-preview.png`.

Next is task 16, Google lead integration. An authorized Google account/provider connection is required for live imports; no Google integration is claimed here.

## Reporting, business onboarding and finance extension (2026-10-14)

Tasks 19–25 are governed by `reportPolicy`, `alertPolicy`, `businessPolicy` and the administrator hierarchy export. Reminders are internal computed lists. Source reports use acquisition cohorts; client/partner milestones are CRM evidence. Owner reports use current assignment and separately count recorded caller activity; they do not establish causal sales attribution. Unknown mail attempts are blocked across refreshed retry keys until reviewed with version and evidence.

Partner verification is restricted to CEO/tenant administrator in the source tenant. Eligible partner stages are demo/pilot/active; contact version is bound to the review. `/v1/governance/platform/onboarding` lists verified records to global central/platform administrators. POST `/onboarding/{id}/activate` creates the tenant, hashes a supplied password, creates a tenant administrator and audits both operations atomically. Central administrators are created only through protected operator bootstrap; no live bootstrap ran. Existing Administrative Assistant (`admin`) remains distinct from `tenant_admin`.

Care links require agreed/started/recurring client leads, an existing visit, an active matching-email client account and an exact tenant match. The source schema is the mapped ClientProfile/Visit model. No clinical fields are copied and no scheduling or provider assignment is synthesized. These capabilities require `client_profiles` and `visits` tables; absent care tables leave the intake/marketing dashboard usable.

The manual CAD ledger accepts invoices, received payments, recorded refunds and care-delivery/overhead expenses. Entries have unique tenant accounting references and immutable evidence. Invoice locks serialize payments/refunds; net paid cannot exceed invoiced and refunds cannot exceed net paid. Payment/refund dates cannot precede the invoice or an earlier receipt entry. Outstanding equals invoices minus receipts plus refunds. Recorded cash equals receipts minus refunds, operating costs and separately recorded campaign spend. Cost per paying CRM lead uses lifetime campaign spend and positive-net-paid lead records; it is not bank reconciliation, clinical billing, full CAC, or profit.

OpenAPI: growth spec plus `admin-hierarchy.openapi.json`. Required migrations add reporting (18 tables) then business records (21); platform administration uses its existing four tables. Do not infer completed legacy APIs from these additions. Browser screenshots and assertions use synthetic data. Full Cypress/WCAG/native/production acceptance is still pending.
