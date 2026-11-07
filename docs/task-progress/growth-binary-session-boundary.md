# Growth binary response session boundary

Status: isolated candidate; not published, deployed, or release-approved.

## Problem and change

GrowthClient.blob serves the existing performance and marketing-statement PDF controls. It previously checked the session only before fetch and after successful body reading. Network/body rejections bypassed the second check. The HTTP-error body also introduced another asynchronous read after that check, with the 401 redirect occurring before decoding completed. Growth's existing action handler redraws cached data on ordinary errors and clears it on account_changed.

The client now checks identity after response headers, in a finally block covering fetch/body reading, and after error-body decoding. Old-account successful payloads and failures cannot cross those boundaries or invoke the current-account 401 redirect policy. Unchanged accounts retain PDF content checks, error identity, error fallbacks, the registered endpoint, no-store caching, bearer authentication, and existing 401 logout behavior. Error-body parsing now completes before a matching-session 401 redirect. There are no added endpoints, roles, grants, or governance records.

## Verification

- Remote main df27a32822e6255709c48bfcf71be5f9bbccc6ac was checked before edits. The runtime source also matches PR222 head fad8a62e1a32c642df26f50c7b45b2c521c62800.
- Thirteen of 28 targeted regressions fail against the original runtime. All 28 pass on this candidate, including replacement/logout during fetch, body, and error-text reads; early body suppression; same-account exception identity; PDF validation; and unchanged 401/403/503 handling.
- 156 combined Node unit/fixture tests pass with the separately preserved manager, tenant presentation, and JSON-session candidates.
- The full main.ts browser bundle passes with zero warnings and 247 inputs.
- Full-entry strict typing still fails with the same ten baseline diagnostics; no new diagnostics were introduced.
- The only workflow change adds this unit suite to the existing care-delivery test command. Release/publishing controls are unchanged.

Run the focused suite using an empty environment except PATH, temporary HOME/TMPDIR, and LANG:

    node --test scripts/test-growth-binary-session.mjs

## Limits

No real browser, live PostgreSQL, production export, remote aggregate CI, publishing, merge, or deployment was run. This is not whole-screen or production-readiness proof. Platform-bundle downloads, reports.ts exports, and image review use separate binary paths and are outside this scoped fix.
