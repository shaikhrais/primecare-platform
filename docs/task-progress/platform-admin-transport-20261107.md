# Platform administration transport boundaries: 2026-11-07

## Scope and authority

This unpublished, isolated change extends the preceding platform administration navigation candidate. It fixes ownership and session checks in the existing `websites/typescript/src/platform-admin.ts` request helper and its immediate callers. It does not create a new API or permission source. Existing server authorization, tenant selection, actor identity, methods, request payloads, version fields, confirmation behavior and idempotency fingerprint format remain authoritative and unchanged.

The original base is `fad8a62e1a32c642df26f50c7b45b2c521c62800`, followed by nine preserved unpublished patches. Remote main was separately rechecked at `df27a32822e6255709c48bfcf71be5f9bbccc6ac`; this local delta is not a claim that the unpublished chain has been integrated with newer main. There was no branch, commit, push, deployment, production database access, schema write, dependency install or approval bypass.

## Proven defects and fix

The focused suite bundles the actual admin module and substitutes only synthetic DOM and peripheral services. Against the unchanged ninth-patch source, 44 of its 67 checks fail and 23 behavioral controls pass. Initial reproductions show both a stale fetch response reading its body and a successful helper starting an old-token capability probe in the next microtask.

The bounded changes are:

- Async digest, fetch, JSON body, call-capability and sign-out work check the mounted owner and session on both fulfillment and rejection. Explicit checks after helper awaits also cover the helper-to-caller microtask boundary. This follows the existing shared session-client pattern without adopting another client's endpoint, error or retry policy.
- Successful requests return an internal synchronous `consume()` receipt. Every immediate request caller consumes it before updating metadata, actor-dependent state, tenants, users, master records, audit events, partners or demo preferences, resetting a form, remembering a saved row, writing history or starting another request. Consumption revalidates ownership before any of those effects.
- Successful mutation keys remain pending until that consumption check succeeds. Network, body and server failures retain the existing retry policy. A stale or retired owner never restores or overwrites a newer key. Terminal 4xx and accepted success remove only the stored key whose value matches that request. The existing actor/method/path/SHA-256 fingerprint and password exclusion are unchanged; the outgoing body still includes the original fields.
- The loader checks at entry and after nested-controller loads. Capability probe results are checked before assignment, and stale error handling cannot replace current notices. Refresh and sign-out continuations are checked before changing draft state, removing a session or navigating. Report-palette selection after an awaited parent navigation is guarded too.
- Missing or unreadable session storage during a same-root remount clears the previous DOM after retiring its owner. Missing tokens retain the existing login redirect. Unreadable storage retains the original rejection rather than displaying prior-account content.

A rejected stale result cannot undo a mutation already dispatched to the server. Retaining its exact retry identity is necessary because delivery or completion may be uncertain. This is a client-consumption boundary, not server cancellation or rollback.

## Preserved behavior

- GET/POST/PATCH endpoints, bearer authentication, `cache: no-store`, tenant paths, JSON fields, row versions and partner-activation version remain unchanged.
- Same-session failures remain visible. Current valid-body 401 still removes that matching session and redirects to `/login`; 403 still ends the admin view. Existing malformed-body behavior is unchanged, including a malformed 401 producing a parse error before revocation.
- The existing successful sign-out uses the unchanged shared `signOut` helper and navigates to `/login?enable-semantics=true` only for its current mounted owner.
- Network/JSON/5xx failures retain their key, while terminal 4xx and consumed success clear the matching key. Repeating the same uncertain mutation reuses its key; a later distinct completed attempt allocates a fresh one. Changing only the password still does not change the fingerprint.
- Original navigation, capability filtering, selected-tenant behavior, native history, draft logic, and API grants are not redesigned.

## Validation

All test invocations below exclude inherited production credentials:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-platform-admin-transport.mjs scripts/test-platform-admin-navigation.mjs
```

- Focused transport: 67/67 passed.
- Existing navigation: 63/63 passed after extracting its synthetic harness into `scripts/fixtures/platform-admin.mjs`; the existing 63 test bodies are unchanged.
- Exact prior-source negative control: 44 expected failures and 23 passes, exit 1. The new suite and harness ran in a separate copy containing the unchanged prior runtime file, not by modifying the preserved candidate.
- Related sign-out, account, bundle and report session suites: 59/59 passed with the same environment scrub.
- Independent review additionally exercises the actual module, including a deeper three-microtask caller boundary and a mutant removing only the receipt's ownership check. Its separate evidence accompanies this batch.

The focused cases cover replaced/logged-out sessions, same-root remounts, detachment, unrelated routes, inaccessible storage, digest/fetch/body fulfillment and rejection, metadata/probe microtasks, all legacy create/update continuations, list/cache consumption, demo and extra-tenant loading, row/partner version payloads, exact retry identity, conditional key deletion, and sign-out. No real form contents or production data are used.

The existing release-workflow-compatible **non-strict** TypeScript check passed:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node node_modules/typescript/bin/tsc --noEmit --skipLibCheck --module esnext --moduleResolution bundler --target es2022 --lib es2022,dom,dom.iterable websites/typescript/src/main.ts
```

A separate strict full-entry check retains ten diagnostics already present in the prior candidate. A passing non-strict check does not mean strict checking or all release gates pass. The strict invocation was:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node node_modules/typescript/bin/tsc --strict --noEmit --skipLibCheck --target ES2022 --module ESNext --moduleResolution Bundler --resolveJsonModule --allowImportingTsExtensions --lib ES2022,DOM,DOM.Iterable websites/typescript/src/main.ts
```

Its retained evidence is `candidate-full-typecheck.log`, `base-full-typecheck.log` and `diagnostic-comparison.json` in the batch evidence directory.

Each existing deploy/release test block adds exactly this separate command:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-platform-admin-transport.mjs
```

No other workflow control is changed. The fixture also refuses inherited database or Cloudflare credential variable names if invoked without the documented scrub.

## Exact changed files

- `websites/typescript/src/platform-admin.ts`
- `scripts/fixtures/platform-admin.mjs`
- `scripts/test-platform-admin-navigation.mjs`
- `scripts/test-platform-admin-transport.mjs`
- `docs/task-progress/platform-admin-transport-20261107.md`
- `.github/workflows/deploy-typescript-websites.yml`
- `.github/workflows/release-primecare.yml`

## Remaining boundaries and release blockers

This is not a general migration of dashboard, embedded account, external dialer, Vapi, report, screen-text, operations or territory child implementations. Parent post-load checks stop subsequent parent work, but cannot stop side effects a child transport already performed internally. In particular, the existing OperationsClient and TerritoryClient still have their own unguarded delayed-401/session-removal behavior and require separately scoped fixes. The call-capability wrapper prevents stale parent consumption but does not retrofit every dialer request.

Synthetic module fixtures are not JSDOM, actual browser, Cypress, visual, accessibility or production acceptance. JSDOM was unavailable; the prior official-registry DNS failure was not retried. Full governed builds and production metadata checks were not run in this isolated candidate. Required CI, the strict baseline diagnostics, current-main integration, independent review evidence, remaining child transports and real-browser release acceptance remain separate gates. Do not mark the full Screen Management System or this release ready from these results.
