# Platform admin, tenant admin and marketing report review

The review captured the existing views first, applied corrections and recaptured the same views. Scope is nine roles: platform_admin, tenant_admin, marketing, growth_caller, growth_google, growth_meta, growth_seo, growth_offline and growth_coordinator. These are 320/1440-pixel viewport captures of initial states and report generation, not all possible business states or deployed screenshots.

## Critical findings and corrections

| Finding | Correction | Evidence |
| --- | --- | --- |
| Tenant admin had report grants but no Reports link | Backend returns canViewReports from the existing report grant catalog; the UI exposes Reports from that capability | Tenant report generation and PDF download; global platform report still returns 403 |
| Marketing report section was hard to discover | Performance reports added to governed sidebar navigation when canReport is true | Role-scoped navigation checks and generated PDFs |
| Mobile table headings became vertical letters | Admin, marketing and text-editor tables retain column widths inside keyboard-focusable scroll regions | Before/after screenshots; no page-level horizontal overflow |
| Preview silently stopped at 50 rows | Localized shown/total row message added | UI report preview and PDF API regression coverage |
| Tenant sidebar repeated Select tenant | Removed the redundant entry for tenant-local roles | Recaptured tenant views |
| Reports started in English regardless of admin language | Report panel inherits the current admin language | Shared constructor integration and localized controls |

Reports provides server-generated operational PDFs plus a Screen review document link to the packaged synthetic screenshot review. No real customer, staff, credential or clinical data is included in that document. The static review asset is public hosting content; confidential operational reports continue to use bearer-authenticated APIs.

## Evidence

- Before: 154 captures. After: 156 captures, including two newly reachable tenant Reports viewports.
- Nine roles at two widths; 156 after-state checks had no page-level horizontal overflow.
- 42 admin/marketing browser regressions and 16 reporting API/integration cases passed.
- Real reporting, growth and platform handlers ran with isolated PostgreSQL-compatible PGlite fixtures; CI uses PostgreSQL 16.
- PDF downloads were checked for valid PDF headers; the packaged review PDF was rendered and visually inspected.
- Both capture schemas were dropped and absence verified. No real email was sent.
- All captures inspected as contact sheets; principal defects and corrections also inspected at full resolution. This is not an individual durable AI rubric/human approval for every state.

The unrelated legacy auth self-record audit was initially included in a broader test command and failed its required environment setup. It was excluded from the targeted report run; no completion credit is assigned to it.

The Library screenshot archive contains every captured before/after PNG, downloaded fixture PDFs, a searchable index.html gallery and the critical review PDF. Reproducible source: `scripts/review-admin-marketing-ui.mjs`. Its default before mode records the currently checked-out revision; reproducing the original before images requires baseline commit 372e72f5.

## Release and remaining limits

No authenticated production admin session or Cloudflare deployment token is available locally. The connected GitHub actions available to this session do not include workflow dispatch. The document and local captures explicitly do not claim live deployment. Publication/deployment attempt results are recorded separately when available.

Account and live-text mutation dependencies are unavailable in the capture fixture and are not certified by this sweep. The screen-text editor still renders its governed catalog but saving/restoring requires its API. Google/Facebook integration remains manual; no real campaign spend synchronization was tested. Native devices and full accessibility acceptance remain pending. Existing governance readiness tags and legacy API completion counts are unchanged.

Publication attempt: git push to the existing repository branch returned `CONNECT tunnel failed, response 403`. No remote branch update or Cloudflare deployment was verified. No alternate write route was used to bypass that failure. Local commit 59e5002d was prepared before documenting this result.
