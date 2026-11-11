# Session-bound transport failures

Status: isolated local candidate; not published or release-approved.

## Scope

The shared TypeScript BaseSessionClient already rejects account changes before sending and after successful JSON reads. Previously, rejected fetches and JSON reads bypassed the latter check. Protected screen clients could therefore receive a normal recoverable transport error from an old account instead of their existing account-changed failure.

The transport now checks the captured session after response headers and in a finally block around fetch and JSON body reading. Successful and failed reads both preserve the original account boundary. The domain-specific account-changed error remains authoritative if the session changes, while unchanged sessions retain their original transport errors and mutation retry identities. Existing server authentication, tenant grants, HTTP failure policy, endpoints, routes, and idempotency behavior are unchanged. This change does not grant access or add governance records. Binary transports and proactive session-change subscriptions remain outside this patch.

## Verification

The two original runtime/test files match both main df27a32822e6255709c48bfcf71be5f9bbccc6ac and PR222 fad8a62e1a32c642df26f50c7b45b2c521c62800. The patch was tested with the separately preserved manager and tenant-presentation candidates without overwriting them.

- Six added regressions fail on the original runtime: account replacement during network rejection, invalid JSON, and rejected response-body streams, using both CareClient and GrowthClient.
- All 22 shared-client tests pass after the fix. Unchanged-account errors preserve object identity and retry keys. The new session is not cleared or redirected.
- 128 combined Node unit/fixture tests pass for the screen manager, presentation bindings, tenant preference/appearance, auth, workspace authorization, account operations, maintenance, sign-out, tenant reads, and shared-client inheritance.
- Focused strict TypeScript for the changed transport passes.
- The complete main.ts browser bundle succeeds with 247 inputs and zero warnings.
- Full-entry strict TypeScript still fails with the same ten diagnostics as the preserved candidate baseline; no additional diagnostics were introduced.

The existing tenant-work browser test could not start because the isolated dependency set does not include Playwright. It was not counted among the 128 passing checks. Earlier browser launch restrictions were not retried. No real browser, live PostgreSQL, production export, full monorepo CI, publishing, merge, or deployment was performed.

## Reproduction

Run with an empty environment except PATH, temporary HOME/TMPDIR, and LANG:

    node --test scripts/test-session-client-inheritance.mjs

This suite is already included in .github/workflows/care-delivery.yml. No release-approval controls were changed.
