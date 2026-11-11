# Operations and territory session boundaries: 2026-11-07

## Scope and authority

This bounded, unpublished batch extends the exact verified tenth-patch candidate. It fixes reproduced account-switch defects in the existing OperationsClient, TerritoryClient and their controllers. The original base is `fad8a62e1a32c642df26f50c7b45b2c521c62800`, plus ten preserved unpublished patches. Remote main was separately checked at `df27a32822e6255709c48bfcf71be5f9bbccc6ac`. The unpublished chain has not been integrated with newer main.

No new API, route, permission, resource, UI text or governance data is introduced. Existing operations and territory registries remain authoritative. There was no branch, commit, push, deployment, production database access, schema write, dependency install or publication bypass.

## Reproduced defects and bounded fix

On the unchanged tenth-patch source, delayed Operations and Territory 401 responses remove a replacement account's session. Both also dispatch requests with already-stale captured tokens and return stale payloads. The new focused regression suite has 44 expected failures and 22 passing controls against that exact prior source in a separate copy.

The fix follows the existing session-check pattern without adopting another client's endpoint, error or retry policy:

- Both clients check the captured session at entry, after fetch fulfillment/rejection and after body fulfillment/rejection. Territory also checks digest fulfillment/rejection before allocating a key or sending a sale. Checks at consuming awaits cover the helper-to-caller microtask gap.
- Optional owner assertions bind controller requests to their captured lifecycle. Disposal, replacement or detachment while a request/digest is pending prevents later dispatch or response effects. Already-dispatched mutations may still commit on the server; these checks cannot cancel or roll back a server transaction.
- Territory retains the public `request(id?, body?)` payload/error contract. Its controller opts into a deferred-settlement receipt and synchronously calls `consume()` only after checking its current session and lifecycle. Success and terminal-error cleanup, including 401, therefore cannot be applied by a stale controller continuation. Direct two-argument callers still receive ordinary payloads/errors.
- The persistent Territory retry fingerprint remains actor + encoded endpoint/path + SHA-256 of the complete serialized sale body. Version, tenant, services, reference and confirmation all remain included. One body snapshot supplies both fingerprint and outgoing JSON. Network/body/5xx failures and stale/unconsumed results retain the uncertain key. Accepted success and terminal errors delete only a stored key that still equals the request's captured value. A newer owner's replacement key is never removed or overwritten by late cleanup.
- Current Territory 401 handling keeps the original priority: revoke the matching session and navigate before retry-key cleanup. A failure reading the retry key during cleanup must not suppress that authentication handling.
- Controller loads and all sale/refresh/conflict continuations check ownership before applying data, notices, draft resets or follow-on reads. Invalidation purges cached private data and clears only the still-owned root; stale work cannot clear a replacement controller's root. Render-generation checks make saved handlers inert after redraw, disposal, remount or account change.

## Reusable lifecycle and preserved behavior

TerritoryController.dispose was previously label-observer cleanup called by both parent redraw and parent disposal. It remains **nonterminal**: it now retires the current render/request lifecycle, stops labels and unmounts, but the same controller can load and mount again. Child redraw stops only the prior label observer, rather than disposing its own active operation.

Operations gains the same reusable unmount. The parent calls it alongside Territory during redraw and final disposal. A new explicit load on a detached prior panel first unmounts that panel, then captures a new lifecycle, so initial loads and returning to a tab remain valid. A pending old load or sale cannot use that new lifecycle. The read-only navigationPending getters still reflect active work and preserve parent navigation coordination.

Matching-session endpoint, query encoding, gateway normalization, method, bearer, cache, status/error and form workflows are preserved. Operations still skips JSON parsing for non-success statuses. Territory still parses the response body before status handling. Sale version/confirmation fields, conflict refresh behavior, selection, filtering, paging and open-destination behavior retain their existing contracts. No server grants or validation rules were weakened.

## Validation and evidence

All invocations exclude inherited production credentials. The focused fixture additionally rejects database/Cloudflare credential variable names. It bundles actual clients, controllers, panels and the label observer; only storage, fetch, crypto controls, form extraction and DOM/layout peripherals are synthetic.

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-admin-child-sessions.mjs
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-platform-admin-navigation.mjs scripts/test-platform-admin-transport.mjs scripts/test-admin-child-sessions.mjs
```

- Focused suite: **66/66 passed**, plus five repeated passing runs.
- Original admin navigation and transport suites: **130/130 passed**. Their test bodies are unchanged; their existing mocked client classes gained only the no-op session assertions required by the real controller guards.
- Combined: **196/196 passed**.
- Exact prior-source negative control: **44 expected failures, 22 passes**, exit 1, no cancellations. Only the new test/harness files were copied to a fresh prior-source copy. All preserved candidates remained untouched.
- The two original delayed-401 preservation assertions now pass. The old residual script's separate observations deliberately expect stale behavior and are not acceptance assertions.
- Independent adversarial review: **83 in-scope cases passed**. Three separately labeled pre-existing authentication edge-case expectations still fail, as described below. The review includes caller-promise microtasks, disposed/detached digest boundaries, exact retry values, replacement controllers, storage faults and current conflict controls.
- Existing release-compatible non-strict full-entry TypeScript checking passed. Strict full-entry checking retains the same ten baseline diagnostics, with no added diagnostic. Browser bundling succeeds with 247 inputs and zero warnings.

The retained sibling evidence includes focused positive/negative/repeat logs, combined-admin-tests.tap, original-preservation proofs, strict baseline/candidate diagnostics, diagnostic comparison and browser-bundle metadata. The complete prior regression set and a clean reconstruction are validated separately.

Both existing deploy/release workflow test blocks add only:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-admin-child-sessions.mjs
```

Approval, credential, build, release and deployment controls are unchanged.

## Exact changed files

- websites/typescript/src/tenant-operations/client.ts
- websites/typescript/src/tenant-operations/controller.ts
- websites/typescript/src/territories/client.ts
- websites/typescript/src/territories/controller.ts
- websites/typescript/src/platform-admin.ts
- scripts/fixtures/platform-admin.mjs
- scripts/fixtures/admin-child-sessions.mjs
- scripts/test-admin-child-sessions.mjs
- .github/workflows/deploy-typescript-websites.yml
- .github/workflows/release-primecare.yml
- docs/task-progress/admin-child-sessions-20261107.md

## Remaining boundaries and release gates

The following baseline authentication edge cases are deliberately not redesigned here: Territory malformed 401 JSON rejects before session revocation; either client's session-storage removal failure can prevent its login redirect. These are not account-switch passes. Session-storage read failure at entry still fails closed without issuing a request. Future auth-hardening work should address the baseline cases separately, with explicit error and redirect semantics.

This fixes the Operations/Territory residuals recorded by the tenth-patch report, not all other child transports. It does not retrofit Bundle, dashboard, embedded account, external dialer, Vapi, report or screen-text implementations. No client check proves server cancellation, grants, database correctness or production readiness.

Synthetic tests are not JSDOM, actual-browser, Cypress, visual or accessibility acceptance. JSDOM remained unavailable; the earlier official-registry DNS failure was not retried. Full governed builds, production metadata checks, current-main integration, required CI, the existing strict diagnostics, independent final validation and real-browser release acceptance remain separate gates. Do not mark the full Screen Management System or release ready from this batch.
