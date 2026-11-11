# Operations and Territory authentication errors: 2026-11-07

## Scope and baseline

This bounded, unpublished change fixes three reproduced authentication-error defects in the existing Operations and Territory clients:

1. Operations did not navigate to login when removal of its current session threw.
2. Territory parsed a 401 response body before handling authentication, allowing malformed, rejected, or indefinitely pending JSON to suppress login navigation.
3. Territory did not navigate to login when removal of its current session threw.

The exact baseline is the verified eleventh-patch candidate. Its original preserved base is `fad8a62e1a32c642df26f50c7b45b2c521c62800`, followed by eleven ordered unpublished patches. Remote main was separately checked at `df27a32822e6255709c48bfcf71be5f9bbccc6ac`. This candidate is not integrated with newer main. The three auth residuals recorded in `admin-child-sessions-20261107.md` are addressed here; that document remains a historical report of its own batch.

There are no new APIs, routes, grants, resources, localized UI strings, registry entries, or governance data. Existing client endpoints, owner guards, controller lifecycle, and authoritative registries remain unchanged. No commit, branch, push, deployment, production database operation, dependency installation, or publication override was performed.

## Implementation and security boundaries

Both clients retain their current-session and current-owner assertions before handling a response. Inside the existing current-401 branch, session removal is now best effort: a storage exception is caught, then the existing `location.assign('/login')` is called. This does not catch or conceal a navigation failure.

**If the browser denies session removal, the stored token can remain. This change guarantees the login-navigation attempt despite that cleanup failure; it does not prove that storage was cleared, that navigation succeeded, or that the server revoked a token.** No fallback storage writes or new route were added. The login route does not automatically forward a user merely because the token remains in storage.

Territory does not access the JSON reader for a 401 response. Authentication handling therefore does not depend on that body being valid, readable, or settled. JSON handling for success, 403, 409, 5xx, and other statuses is unchanged.

Territory's deferred receipt contract remains intact. The request may return a receipt to a controller, but only `consume()` performs authentication effects or retry settlement, after rechecking the current account and owner. A switched account, disposed/detached controller, or replacement owner cannot consume the prior receipt. Direct callers retain their ordinary payload/error contract.

Login navigation remains before retry-key cleanup. A retry-key read or removal failure cannot suppress a preceding login-navigation attempt. Terminal outcomes remove only the request's matching retry identity; a replacement identity remains untouched. Network/body uncertainty, 5xx responses, and stale or unconsumed receipts continue to retain their retry identity. The actor/path/serialized-body fingerprint is unchanged. A 401 no longer has a body-parse uncertainty: its status is handled directly under the current-owner guard.

Operations continues to reject current 401 with `forbidden` after navigation. Territory continues to reject it with `failed` after navigation and ordinary cleanup, unless an existing retry-cleanup error is thrown. Current 403/409/5xx behavior, account-switch guards, deferred settlement, controller disposal/remount behavior, and navigation-pending lifecycle are unchanged.

These client checks do not cancel or roll back already-dispatched server mutations. They do not grant access or substitute for server authorization.

## Focused validation

All test commands run without inherited credentials:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test --test-reporter=tap scripts/test-admin-auth-edges.mjs
```

The dedicated regression suite bundles actual clients, controllers, panels, and label logic through the existing fixture. Only storage, fetch, controlled promises, form extraction, and DOM/layout peripherals are synthetic. It rejects database/Cloudflare credential environment variables. It performs no real HTTP or database operations.

Final focused results:

- **100/100 pass** against the changed candidate, with zero failures, cancellations, or skips.
- **66 pass, 34 expected failures** against the exact unchanged eleventh-patch baseline, with zero cancellations or skips. The same final test and fixture source run with the baseline as the working directory, so the bundled runtime comes from that baseline. The counts are test outcomes, not distinct defects.
- Existing regression test and fixture sources are unchanged. The prior **510/510** tests pass on the exact baseline; the final combined candidate suite passes **610/610**, with no skips or cancellations.
- The final focused suite passes **100/100** again, plus three repeat runs.
- Full-entry release-compatible non-strict TypeScript checking passes. Strict checking retains exactly the same ten baseline diagnostics outside the changed runtime files; strict checking does not pass.
- Browser bundling succeeds with **247 inputs and zero warnings**. Environment-isolation validation passes.
- Separate independent runtime checks pass **122/122** focused authentication cases and **86/86** prior client/controller cases. The exact independent baseline has **85 passes and 37 expected failures**. All **3/3** former authentication-residual assertions now pass. Final file-manifest verification is recorded in the independent review report.

Coverage includes:

- Current 401 with normal removal, removal denied before deletion, and failure after deletion.
- JSON reader property failure, synchronous exception, immediate/asynchronous rejection, actual malformed JSON, and a never-settling body. Neither client accesses a 401 JSON reader.
- Deferred read and sale receipts with no authentication or retry effects before consumption; stale account and owner consumption is rejected.
- Own versus replacement retry identities, retry read/removal denial, and authentication-before-cleanup order.
- Stale entry, pending fetch fulfillment/rejection, and the helper-to-caller promise continuation, for accounts and owner assertions. A rejection already leaving the helper remains an error and performs no authentication effects.
- Current non-401 statuses and JSON handling; non-401 sale success/error/uncertain-body retry policy.
- Mounted refresh, account replacement, disposal, detachment, replacement controllers, and the receipt-to-sale continuation. Current 401 releases navigation-pending work; stale continuations preserve replacement sessions and retry identities, do not reset drafts, and do not issue a follow-on read.

Final focused evidence is retained as `auth-edges-positive.tap`, `auth-edges-exact-baseline.tap`, and `runtime-before-hashes.json`. The aggregate and repeated runs are `final-combined.log`, `final-focused.log`, and `final-focused-repeat-{1,2,3}.log`. TypeScript and bundle evidence is in `final-nonstrict.log`, `final-strict.log`, and `final-bundle.log`, with corresponding exit-code files. `baseline-strict.log` retains the comparison baseline. `changed-files-frozen.json`, `full-source-hashes-frozen.json`, `existing-test-preservation.json`, and `admin-auth-edges.patch` record exact source identity and the bounded delta. The independent review has its own report and evidence; none of these synthetic checks imply browser or production acceptance.

## Workflow changes

Only one new invocation is added to each existing deployment/release test block:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-admin-auth-edges.mjs
```

Approval, credentials, build, and release/deployment controls are unchanged.

## Changed files

- `websites/typescript/src/tenant-operations/client.ts`
- `websites/typescript/src/territories/client.ts`
- `scripts/test-admin-auth-edges.mjs`
- `.github/workflows/deploy-typescript-websites.yml`
- `.github/workflows/release-primecare.yml`
- `docs/task-progress/admin-auth-edges-20261107.md`

## Remaining release gates

This is bounded client regression coverage, not real-browser, Cypress, layout, visual, accessibility, real HTTP/server, production-database, or deployment acceptance. It does not prove successful browser navigation under navigation restrictions. No fallback authority or new permission was introduced.

Current-main integration, required remote CI, full governed builds, metadata/permission checks, existing strict TypeScript diagnostics, and actual-browser acceptance remain separate release gates. The complete Screen Management System and the release must not be marked ready from this change.
