# First platform bundle — local implementation

Owner: platform operations. User-selected scope: tenant launch checklist, document renewals, support tickets, and territory lead routing. Navigation: **Platform administration → Tenant launch & support**. Four workflow buttons keep forms separate. A tenant is selected with the existing top bar; tenant administrators are automatically restricted to their own organization.

This is an administrative workflow, not clinical clearance, a staffing guarantee, or a licence to deliver regulated care. It does not change existing tenant activation or the existing partner verification process.

The [attention queue](ATTENTION_QUEUE.md) provides a scoped, searchable work list and direct navigation to these workflows.

## Administrator workflow

1. Select a tenant and open **Launch checklist**. Resolve missing tenant administrator, active location/service category, and sold territory through the existing administration screens. Record training and operating handover evidence. These checks are recomputed by the API.
2. Open **Documents and renewals**. Upload the tenant agreement and business insurance with expiration dates. Supported files: PDF, PNG and JPEG, maximum 2 MiB each. Global administrators download and inspect files, then record approval or rejection evidence. Renewals create new revisions; previous files and decisions remain accessible.
3. Return to the launch checklist. Submit evidence for review. A central/platform administrator can **Request changes** with a required reason or explicitly confirm a human approval. Requesting changes returns the submission to draft; the tenant sees the reason above the checklist, corrects the setup/training, and submits again for a fresh decision. The approver is recorded; the current policy allows the submitting administrator to approve after explicitly reviewing. The application does not assert that an AI performed the review.
4. Open **Support tickets**. A tenant or global administrator opens a ticket for the selected tenant. Global support assigns an active central/platform administrator, changes priority, responds, and resolves with evidence. Tenant administrators may reply or reopen their own tickets. The message history and recent deadline history are available in the UI.
5. Open **Territory lead routing**. The global enquiry desk records a new client enquiry, postal code, requested service, and evidence that the person requested contact and consented to sharing. The API matches the FSA to the governed territory owner. Only an active tenant with current launch approval and the sold service receives an offer. The recipient can accept or decline. Accepted enquiries become existing growth-pipeline client leads assigned to the accepting tenant administrator.

## Launch and renewal policy

Five prerequisites: active `tenant_admin`; active location and service-category master records; at least one sold territory; latest agreement and insurance approved and unexpired; training evidence. Approval stores a fingerprint of those prerequisites and document revisions. A changed document revision, missing prerequisite, expired document or changed training makes approval stale. An invalid prerequisite restored to its approved state can restore validity; this is a current-state eligibility check, not an irreversible suspension policy.

Expiration is inclusive of the expiration date in **America/Toronto**. Renewals are flagged beginning 30 calendar days before expiry. These are in-app notices; no email/SMS delivery is configured by this bundle. Rejection of the latest renewal does not fall back to an earlier approved revision. Tenant administrators cannot approve their own documents or administrative launch. Clinical credentials and care-service coverage require separate workflows.

## Returning a launch for correction

Owner: platform operations. In **Launch checklist**, a central/platform administrator sees **Request changes** for a submitted review. Enter a reason in **Evidence / reason**, then select the action. The approval confirmation checkbox is required only when approving. Tenant administrators cannot issue this review decision.

The API changes the submitted record back to `draft`, clears approval metadata, increments its version and records `launch_request_changes` with the reviewer, tenant, reason and timestamp. It uses the existing tenant lock, active-session recheck, write rate limit, idempotency receipt and atomic audit transaction. A stale version, non-submitted state or blank/overlong reason fails; audit failure rolls back the state change. No new migration or database access from the UI is introduced.

Launch decisions and active feedback are ordered by the committed launch version, so transaction timestamps do not reorder the review. The return reason is visible to authorized administrators for that tenant and remains through training corrections, even after more than 20 history entries. A new submission clears the active feedback card while retaining its audit history. The tenant must satisfy the current prerequisites before resubmitting; approval must again come from a global human reviewer with explicit confirmation. Request changes remains available on a submitted review when a prerequisite becomes invalid, allowing the reviewer to explain the correction. A returned draft does not authorize launch or receive new routed enquiries. The attention queue lists submitted reviews and removes a returned draft until resubmission.

Controls, policy, response fields and EN/FR/ES labels are registered through the bundle seed and registration script. The API adds `request_changes` to the existing launch action contract, plus server-owned `canRequestChanges` and nullable `feedback` fields in launch reads. This is additive; stored launch states remain `draft`, `submitted`, and `approved`.

## Support policy

| Priority | First platform response | Resolution |
| --- | --- | --- |
| Normal | 24 elapsed hours | 72 elapsed hours |
| Urgent | 4 elapsed hours | 24 elapsed hours |

These are initial configurable product defaults, not contractual service promises. No business-hour calendar or holiday exclusion is applied. Tenant replies do not satisfy the platform response deadline. Priority changes recalculate deadlines from the original cycle start. In-progress/resolved tickets require a valid platform support owner. Resolution requires a message. Reopening starts a new cycle and retains previous deadlines, response/resolution timestamps, actor, and evidence in the audit. The UI shows active overdue work and late completed responses/resolutions; a reopened ticket's prior late cycle is visible in deadline history. No pay deductions or automated employee disciplinary decisions are made.

## Routing policy and privacy

- FSA matching uses the existing 2021 Census planning territory catalog, not live postal delivery verification or a travel-time/service-capacity assessment. Ambiguous or mismatched catalog entries fail closed; reserve and unsold territory enquiries remain unmatched.
- Offers expire after 24 elapsed hours. Expired offers cannot be accepted. Global administrators can explicitly recheck unmatched, declined, or expired offers with evidence. A live offer cannot have its clock reset through reassignment.
- Receiving tenants see only the enquiry ID, postal area, requested service, receiving organization and deadline before acceptance. Names, email and phone are withheld. A tenant never sees another tenant's offers. Global enquiry administrators see the central contact record.
- Acceptance rechecks ownership, sold service, launch eligibility, deadline, version and existing destination contacts/opt-outs. It atomically creates one growth lead, its initial milestone, delivery link, audit and idempotency receipt. Existing contacts are not overwritten or silently reactivated.
- Duplicate enquiries matching email or normalized phone are rejected. Accepted assignments cannot be reassigned by this workflow. Sharing-consent withdrawal is global-only, retains audit history, and blocks contact on the delivered growth lead.
- Routing applies to **new enquiries captured in this centre/API** and public marketing links created with the new **Match service territory** delivery mode. Existing public links retain direct tenant delivery. See [public territory intake](../marketing/TERRITORY_PUBLIC_INTAKE.md). There is no automatic historical migration, Facebook/Google import, provider connection, or outreach sending.
- A global routing advisory lock serializes these enquiry transitions. Production throughput and contention need measurement before large-volume use. Contact matching is conservative: shared household contact details may require human investigation.

## API and architecture

Governed contracts: [openapi.json](openapi.json). The seed contains the explicit requirement, role policy, controls, timing policy, contracts and EN/FR/ES resources. `scripts/register-platform-bundle.py` registers them in governance before generating shared metadata and OpenAPI. Export checks compare generated files against persisted governance. Existing form/shell/theme and approved PrimeCare HTML component adapters are reused. UI state contains presentation drafts only, and is scoped by the selected tenant; credentials and document bytes are not saved in browser storage.

| Endpoint under `/v1/governance/platform/bundle` | Purpose |
| --- | --- |
| `GET /` or `/tenants/{tenantId}` | Scoped launch, bounded previews, routed offers, counts and capabilities |
| `GET /tenants/{tenantId}/history` | Scoped document, message, deadline or launch history in 20-entry pages |
| `POST /tenants/{tenantId}/launch` | Training evidence, launch submission or explicit human approval |
| `POST /tenants/{tenantId}/documents` | Bounded base64 upload and new immutable file revision |
| `GET /tenants/{tenantId}/documents/{id}/download` | Authenticated attachment download |
| `POST /tenants/{tenantId}/documents/{id}/review` | Global review of the latest pending revision |
| `POST /tenants/{tenantId}/tickets` | Create support ticket and initial message |
| `POST /tenants/{tenantId}/tickets/{id}` | Reply, global triage, or reopen |
| `POST /enquiries` | Global consented capture and automatic territory matching |
| `POST /enquiries/{id}` | Tenant accept/decline or global reroute/withdraw |

Reads accept only `list=tickets|routes`, `offset=0..100000`, and literal `search` up to 100 characters. Lists use 20-row pages; the selected list determines pagination. Tickets follow selected tenant scope (or global scope when no tenant is selected); the global routing desk remains platform-wide. Initial document, message, deadline and launch previews are bounded to 20 entries. The [paginated history viewer](HISTORIES_AND_ACCESSIBILITY.md) exposes older entries through scoped API pages; document previews keep both current document kinds first. Histories remain live pages rather than a frozen export; large-volume acceptance remains pending.

The support/routing filter selects the workflow as well as its list. Applying it resets to the first page and displays matching records and page totals; switching workflow tabs resets the selector to that tab. Unapplied search drafts survive language changes while the workflow is unchanged. Old records and counts are cleared during a workflow change until the API returns.

All database reads/writes, matching, consent checks, authorization, deadlines, transitions, versions and audit writes run in API modules. The browser contains no DB client or bundle service module. Bearer sessions must belong to an active user and active home tenant. Role and tenant scope derive from the session; tenant override headers are rejected. Mutations require an idempotency key, revalidate authority under locks, enforce current versions, and commit business state, audit and replay receipt in one transaction. Limits: 30 writes and 120 reads per actor per minute. Errors do not disclose database details. Reads and downloads use `Cache-Control: no-store`.

PDF/PNG/JPEG signatures and canonical base64 are checked; filenames and sizes are bounded. Downloads are attachments with `nosniff` and a restrictive CSP. This is not a malware scanning service. Files are stored in PostgreSQL `bytea` through the API for this bounded first version; object storage, scanning, quotas, retention and backup/restore acceptance remain production considerations.

## Validation and release

Run:

```bash
python3 scripts/register-platform-bundle.py
python3 scripts/register-platform-bundle.py --check
PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-platform-bundle.mjs
npm run web:build:typescript
```

The dedicated acceptance workflow now registers the bundle and runs the tests against PostgreSQL before the existing platform/territory/browser regressions. `PLATFORM_TEST_ADAPTER` allows an explicit local compatible adapter; it is not used by CI and it skips the independent-connection race case.

Local verification uses PGlite and headless Chromium, with synthetic tenant accounts and files. Browser workflows exercise the actual shell and API handler in EN/FR/ES at **320 and 1440 CSS pixels**, including draft/file retention through language changes, document upload/review/download, human launch approval, support creation and receiving-tenant acceptance. Browser bundle inspection checks that the server implementation and PostgreSQL client are absent. The synthetic schemas are dropped and absence checked after the tests. Evidence is under `test-results/platform-bundle/`.

Pending: independent-connection PostgreSQL CI, full Cypress/WCAG acceptance, screen-reader testing, physical devices/native Flutter parity, large-volume and storage acceptance, human review, and live deployment. The implementation tags remain partial/human-pending; local checks and screenshots are not production acceptance. No production tenant, territory, enquiry, account, document, or ticket was created by the tests.

Recorded local results on 2026-10-16: **25 new checks passed**, **32 existing tenant/territory checks passed**, **112 auth/bootstrap checks passed**; **two independent-connection race cases skipped locally**. TypeScript 5.9.3 checking and the build of all nine website variants passed. Governance export verification also passed against the current working database and a clean committed database snapshot. Native-button keyboard activation and input accessible-name checks are included; this does not constitute full WCAG acceptance.

Filter-navigation verification on 2026-10-16: all six new browser regressions failed against the previous controller and passed after correction. The expanded first-bundle suite passed 31 checks with one independent-connection PostgreSQL case skipped locally; the attention suite passed all 13 checks. These 44 passing local checks include EN/FR/ES at 320/1440 CSS pixels, keyboard submission, second-page-to-first-page reset, exact routing record lookup, tab/selector agreement and search-draft retention through language changes. Type checking, all nine website builds and governance export checks passed. No production release is claimed.

Launch-review verification on 2026-10-16: the expanded bundle suite passed 34 checks with one PostgreSQL contention case skipped locally. Attention-queue regressions passed 13 checks; public intake/routing regressions passed 18 with one contention skip. Total: 65 local checks passed, two real-PostgreSQL contention cases pending. Coverage includes invalid roles/tenant scope, stale versions, blank/overlong reasons, retry idempotency, revoked reviewer access, audit-failure rollback, lost prerequisites, version-ordered decisions despite older timestamps, feedback retention beyond 20 corrective edits, canonical text identities, and the tenant correction/resubmission/global approval browser flow in EN/FR/ES at 320 and 1440 CSS pixels. Narrow checklist status labels remain on one line. Synthetic feedback screenshots were visually inspected; they are stored under `test-results/platform-bundle/launch-feedback-{width}.png`. TypeScript checking, all nine website builds and export checks against working and clean committed governance snapshots passed. Physical-device, full WCAG/Cypress, human and live deployment acceptance remain pending.
