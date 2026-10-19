# Administrative histories and accessibility checks

Owner: platform operations. Scope: the first platform bundle, shared shell/navigation, and local admin/growth accessibility verification. All records used in tests are synthetic. This work does not deploy or send messages.

## Using histories

Open **Platform administration → Tenant launch & support**. Use **All document revisions**, **Full message history**, **Full deadline history**, or **Full launch decision history** in its corresponding workflow. A shared history region appears above the workflow, with previous/next pages, a range and total, close, and authenticated document downloads. Reviewing a document still uses the existing current-revision workflow; opening its history does not approve it.

Initial previews contain at most 20 entries. Document previews keep the newest revision of both governed kinds first, followed by older revisions grouped by kind. Message previews show the latest 20 messages chronologically; full message history shows newest first. Deadline and launch events use their committed workflow version before timestamp and ID, so transaction start times cannot reorder a committed decision. Renewal totals continue to reflect the current document revisions, including when older history exceeds one page.

History pages contain at most 20 records. They are live reads, not one frozen snapshot across page requests: concurrent new records may shift offsets. Refresh after new activity. A successful workflow mutation or changing the workflow/tenant closes the viewer; reopening starts at page one. Existing version checks still guard writes. Cursor-based exports and production-volume performance acceptance remain future work.

Opening or paging a history focuses its heading. Closing returns focus to the opening control. A failed history read clears its old rows/range and focuses the status message; **Retry history** retries the requested page. EN/FR/ES changes preserve the current page and unrelated form drafts. Changing tenants invalidates pending history requests, preventing a delayed response from restoring another tenant's records. No history or file bytes are persisted in browser storage.

## API and permissions

`GET /v1/governance/platform/bundle/tenants/{tenantId}/history`

| Parameter | Validation |
| --- | --- |
| `kind` | Required: `documents`, `messages`, `deadlines`, or `launch` |
| `ticketId` | Required UUID for messages/deadlines; forbidden for documents/launch |
| `offset` | Integer 0–100000, default 0 |

Unknown/repeated parameters, override tenant headers, bodies and unsupported methods are rejected. An active authenticated central/platform administrator can read permitted tenants; a tenant administrator can read only their own tenant. Ticket existence is checked inside the requested tenant before returning messages/deadline totals. Unauthorized cross-tenant requests and nonexistent tickets return no history. The endpoint shares the existing 120 authenticated reads/minute policy, repeatable-read transaction and no-store response policy.

Response: `kind`, `tenantId`, nullable `ticketId`, a typed `items` array, and `pagination` (`offset`, `limit`, `total`, `hasMore`). Document reads select metadata explicitly and never select attachment bytes. Download remains the existing scoped, authenticated attachment API. Message authors are platform/tenant categories; histories do not add employee emails. No migration is needed beyond the first bundle. Controls, role policy, contracts, ordering and EN/FR/ES resources are registered before implementation by `scripts/register-platform-bundle.py` and exported to the shared registry/OpenAPI.

## Accessibility verification

`scripts/browser-accessibility.mjs` runs pinned axe-core 4.10.3 with WCAG 2.0/2.1/2.2 A/AA tags. Reports retain both violations and incomplete checks in `test-results/accessibility/`. Incomplete checks require review; zero automated violations is not full WCAG conformance or human acceptance. Tooling reference: [axe-core API](https://github.com/dequelabs/axe-core/blob/v4.10.3/doc/API.md).

Explicit keyboard checks cover history opening/paging/closing, error status focus, tab focus after API reloads, mobile menu open/Escape, and search Escape. Focused history/status/section targets scroll beneath the measured sticky header, and closing the mobile sidebar preserves section focus. Shared shell language now follows the selected EN/FR/ES locale. Search uses native search-field semantics without an unsupported expansion attribute. The tenant-selection field has a translated accessible name; the platform language selector also uses its translated resource.

Run the dedicated suites against PostgreSQL in CI:

```bash
python3 scripts/register-platform-bundle.py
python3 scripts/register-platform-bundle.py --check
python3 scripts/register-media-look.py
python3 scripts/register-media-look.py --check
PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-platform-history.mjs
PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-admin-growth-accessibility.mjs
```

An explicit local PGlite adapter and headless Chromium can verify compatible SQL and browser behavior; they do not replace independent-connection PostgreSQL tests. The acceptance workflow installs the scanner and saves history screenshots and accessibility reports. Physical devices, native Flutter parity, full Cypress, screen readers, manual accessibility review, large-volume behavior, human approval and production deployment remain pending.

## Verified local results — 2026-10-16

- Histories: 12 checks passed, covering API validation, metadata-only bounded previews, full paging, role/tenant boundaries, attachment access, shared rate limits, text identities, six EN/FR/ES browser workflows and delayed-response isolation.
- Admin/growth accessibility: 38 role/language/size checks passed. Central administration was exercised in EN at both sizes; platform/tenant administration and CEO, tenant-admin growth, caller and Meta-specialist growth were exercised in EN/FR/ES at 320 and 1440 CSS pixels. Admin scans cover tenant selection, accounts, masters, audit, operations, territories and all five bundle workflows. A focused rerun of 14 English cases additionally scanned open search states. Reruns are not double-counted as new checks.
- Existing bundle: 34 passed; attention: 13 passed; public intake/routing: 18 passed. Combined unique checks: **115 passed**, with two independent-connection PostgreSQL cases skipped locally.
- **204 automated accessibility reports, 0 violations.** 134 incomplete contrast-check groups across 134 reports remain for manual review. These include non-text menu glyphs and partially obscured/off-screen table or form content; they are retained rather than counted as passes.
- TypeScript checking, all nine website builds, whitespace validation and bundle/media exports against both working and clean committed governance passed. Screenshots at both widths were inspected after correcting sticky-header focus. This is headless Chromium on the local Linux environment, not physical-device or cross-OS acceptance.

Shared navigation open/close names, navigation labels, search names and placeholders now inherit governed EN/FR/ES media resources. The media registration script now bootstraps its referenced visual-review screen and adapters, so its exports reproduce from a clean checkout. No live account, campaign, invitation, call, provider connection or production database change was created. Remaining release gates include PostgreSQL CI, manual contrast and screen-reader review, full Cypress/device/native acceptance, provider credentials and source-publication/release approval.

The [visible-state contrast follow-up](CONTRAST_REVIEW.md) rechecked the incomplete findings in the same 204 states. Across 1,143 occurrences, 506 passed after scrolling and 167 received supplemental passing measurements, including 62 temporarily filled textareas. 470 remain unresolved, with zero confirmed contrast failures. Occurrences across states differ from the rule groups counted above. Original reports and human-pending status are retained.
