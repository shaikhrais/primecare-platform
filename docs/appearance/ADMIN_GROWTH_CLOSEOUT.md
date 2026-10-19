# Platform administration and growth closeout

Priority: platform administration and growth first. Employee memberships, recurring duties and payroll workflow work are paused. This is a local implementation and verification report, not a production-completion claim.

| No. | Operation | Current status |
| ---: | --- | --- |
| 1 | Create/select tenants and isolate tenant records | Implemented locally; admin API/browser checks pass |
| 2 | Create accounts, change eligible roles/status, protect global peers | Implemented locally; API/browser permission checks pass |
| 3 | Create/update location, department and service-category master records | Implemented locally; version and audit checks pass |
| 4 | Review partner verification and activate tenant/admin atomically | Implemented locally; synthetic activation checks pass |
| 5 | Review administration audits and authorized reports | Implemented locally; earlier report acceptance remains applicable |
| 6 | Keep unsaved account/master row edits through language changes or failed saves | Fixed; EN/FR/ES at 320/1440 px |
| 7 | Clear saved rows and discard stale server-version or refreshed row drafts | Verified; saving another row retains unrelated drafts while a new server version replaces a stale draft |
| 8 | Set founder targets; identify pipeline gaps and corrective actions | Implemented locally; founder browser checks pass |
| 9 | Collect client/partner leads, edit contacts, deduplicate and enforce opt-outs | Implemented locally; growth API/browser checks pass |
| 10 | Plan/review campaigns; restrict specialists to governed sources | Implemented locally; growth API/browser checks pass |
| 11 | Record caller outcomes, callbacks, appointments, task reassignment/escalation | Implemented locally; growth API/browser checks pass |
| 12 | Collect website/offline/referral enquiries and download QR codes | Implemented locally; growth browser checks pass |
| 13 | Record verified partner/care references and manual CAD finance | Implemented locally; does not certify clinical delivery, bank reconciliation or profit |
| 14 | Generate growth performance PDFs; control sharing permissions | Implemented locally; live email provider delivery remains unverified |
| 15 | Preserve lead owner, deadline and evidence drafts during language changes and failed saves | Fixed; six language/viewport journeys verify retained fields and subsequent persisted workflow |
| 16 | Live Google/Meta leads and telephone provider connection | Pending authorized provider access; no ad or call launched |
| 17 | Production release and authenticated live acceptance | Blocked: repository publication previously returned HTTP 403; deployment credentials unavailable |
| 18 | PostgreSQL concurrency, full accessibility/Cypress and physical/native device acceptance | Pending; local simulator tests cannot certify concurrency or physical devices |

## Corrections

The previous create-form retention did not cover editable table rows. Account/master rows now preserve non-sensitive drafts only in memory within the same actor, tenant and view. Protection controls stay protected. Successful row saves clear that row. Explicit refresh discards row drafts, and changed server baselines prevent stale restoration. Passwords still do not survive redraws.

Growth lead owner, callback deadline and evidence fields now survive language changes and failed requests using the current actor, tenant, lead and version. A successful data reload replaces row drafts. Fields unavailable to the role are excluded. All mutations still go through the existing authenticated APIs; no database credentials or server database code were added to the browser.

Master-record table headings use existing translated labels; editable account/master fields have descriptive accessible labels. These targeted improvements do not constitute complete accessibility acceptance.

## Evidence and limitations

- 8 admin browser cases, with actual account/master PATCH operations, transient 503 retries, row independence, concurrent server-baseline replacement, refresh and tenant draft boundaries.
- 34 growth browser cases covering founder flows, public intake, PDF downloads, business operations, six staff roles and direct API denials. Six journeys additionally exercise lead-row draft retention.
- 25 unit/API integration cases pass locally, using PostgreSQL-compatible PGlite and synthetic identities. The platform duplicate-request scenario was executed sequentially in a disposable local helper because PGlite's shared connection cannot represent independent concurrent PostgreSQL transactions. The checked-in PostgreSQL test retains its concurrent calls; no concurrency-pass claim is made here.
- A first growth browser run received 503 while checking a direct denial before the preceding UI mutation had settled in the shared-connection simulator. Request overlap is a suspected cause, not a verified production defect. The test now waits for the existing Refresh control to be re-enabled before making the denial request. This preserves its 403 assertion without certifying concurrency.
- TypeScript check and all nine website bundles pass. The two browser entry-point bundles contain 53 inputs and zero server database/runtime modules; this does not certify unrelated legacy Flutter code.
- Headless Chromium on Linux, synthetic accounts. Admin widths 320/1440 px; growth also covers 768/3840 px. No physical device or live account is used. Disposable admin test schema removal is verified.
- Earlier report-document and appearance evidence remains local. No live screenshots, real emails, advertisements, invitations, calls or deployment are claimed.

Governed sources: admin form/row policy registrar and growth seed/registry. Existing screen readiness and legacy API completion counts remain unchanged. Reproduce using the checked-in browser/API test scripts with isolated PostgreSQL test databases; the growth and platform acceptance workflows keep their PostgreSQL 16 paths.

Synthetic screenshot samples: [Admin desktop](admin-growth-closeout/admin-desktop.png), [Growth desktop](admin-growth-closeout/growth-desktop.png), [Growth mobile](admin-growth-closeout/growth-mobile.png). Screenshots document the local interface; functional assertions provide the transaction/permission evidence.
