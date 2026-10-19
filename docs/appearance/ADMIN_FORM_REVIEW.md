# Platform and tenant administrator form review

Scope: existing platform administrator, tenant administrator and partner-activation forms. Marketing workflows were regression-tested. No new screens, APIs, permissions or legacy operation-completion credit are introduced.

## Result

Create-tenant, create-account, create-master and partner-activation forms keep non-sensitive values during language changes and failed requests. Drafts live only in memory and only within the same actor, selected tenant and task. Changing tenants or tasks discards them. Password and hidden inputs are excluded. A successful mutation clears its form before refreshing API data, so a failed subsequent refresh does not restore the submitted draft.

The existing FormDraft component supplies capture and restoration. The governance registrar records the existing form controls, approved card mappings and retention policy; it exports `packages/shared/src/admin-form-draft.json`. Existing API handlers still own every database transaction, authorization check and audit event.

## Validation — 2026-10-14

- 8 admin browser cases passed: EN/FR/ES at 320/1440 px, plus explicit platform-admin cross-tenant checks at both widths.
- Verified synthetic 503 responses preserve tenant name/slug or account email/role, while passwords clear.
- Retried account creation through the real platform handler, verified exactly one stored account and an empty form after success.
- Verified a draft from one tenant is absent after selecting another tenant; submitted tenant drafts do not return after changing tasks.
- 34 marketing browser cases passed, including language preservation, leads, campaigns, caller/digital staff scope, partner workflows and tenant reporting.
- 3 review-manager regression cases passed, covering existing shared draft behavior and approval contracts.
- TypeScript check and all nine website builds passed.

Local integration runs used PGlite, Chromium and explicitly synthetic identities. The admin fixture schema was dropped in `finally` and its absence was checked. CI retains the PostgreSQL 16 test path. No live account, real email, deployment or human approval was used. These checks do not certify all admin workflows or native platforms.

Reproduce with `python3 scripts/register-admin-form-drafts.py --check` and the existing `test-growth-admin-browser.mjs`, `test-growth-browser.mjs` and `test-look-manager.mjs` scripts using a disposable `GROWTH_TEST_DATABASE_URL` database and Playwright Chromium.

Additional row-edit verification: see [platform admin and growth closeout](ADMIN_GROWTH_CLOSEOUT.md). Existing account/master table fields now retain memory-only drafts, discard refreshed/stale drafts and use descriptive accessible labels.
