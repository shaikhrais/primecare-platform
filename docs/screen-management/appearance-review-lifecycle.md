# Appearance review presentation ownership

## Scope and authority

This bounded integration extends the existing `/appearance-review` renderer and its existing route registration. It adds no screen, element, route, API, role, permission, grant, or governance record. ScreenManager remains presentation registration only. The API still determines review eligibility, accepted mutations, human actions and image evidence. The real shared shell, media renderer, FormDraft, and Theme Center remain in use.

## Continuing owner

The renderer requires the installed ScreenManager and all four synchronous connections before private reads. Every continuation and interactive handler rechecks the exact entry path plus query, session token, root connection, root frame, main identity and direct main children. A synchronous manager connection can replace those values, so ownership is checked again after entry, including the error path. Changed roots are never adopted or erased by the retired owner. Owned URL/session invalidation clears old content; the existing session-switch reload and current-session sign-in recovery remain intentional.

Each draw supplies a distinct presentation callback to bindShell. Redraw and disposal release only that exact customizer lease. Saved old theme controls and delayed imports cannot write the replacement owner's profile or remove its customizer. FormDraft capture now reports invalidation to callers so a second manager connection cannot let draft capture fall through into editing replacement content. Current form drafts, including browser-owned file inputs, survive locale redraws.

## Suspension and requests

Persisted pagehide suspends interaction and asynchronous continuations. Pending reads, body decoding, upload bytes, image bytes/digest/decode and mutation results wait until pageshow revalidates registration, URL, session and DOM ownership. Busy state remains held during suspended mutations. Valid restore processes the existing result and, for accepted mutations, performs the existing GET refresh without replaying the POST. Invalid restore retires the owner and releases waiters without side effects. Nonpersisted pagehide disposes the owner, listeners, evidence URLs and shell lease.

The transport accepts optional owner current/wait hooks. Its two-argument standalone behavior remains compatible. With renderer hooks, owner checks precede payload serialization, digest and fetch, and follow async fetch/body boundaries. A delayed same-token 401 belonging to a retired renderer cannot clear the browser session or navigate. A 401 received while suspended is held until a valid restore; a current 401 retains existing token removal and sign-in navigation. This does not change server authorization, status interpretation, retry keys or receipts. No automatic mutation replay was added.

## Validation

- `scripts/test-appearance-manager.mjs`: 65 focused tests using the actual renderer, client, manager, resolver, shell, media and FormDraft. Fixtures include real image rows and real Theme Center actions, not only empty lists.
- Existing `test-look-review-session.mjs` and `test-look-review-client-session.mjs`: 88 tests, original test bodies and assertions unchanged. Only the renderer suite fixture/import setup was adapted for installed manager, URL and main-node identity.
- Focused serial result: 153/153 passing. Four identical-harness predecessor controls fail at missing manager, retained query-invalidated handlers, revoked retry and delayed same-token query-invalidated 401, as expected.
- Browser main entry bundles successfully in memory. Strict main-entry typechecking retains the same ten predecessor diagnostics after candidate path normalization; it is not a passing typecheck.
- New suite is included in both TypeScript deployment and release workflows.

These are isolated synthetic DOM and transport checks, not native browser BFCache, focus, accessibility, visual or production evidence. Whole-candidate validation and independent review are separate release gates. This isolated candidate does not resolve divergence with current main, publish a commit, deploy, change governance data or certify release readiness. Production credentials, actual authorized browser journeys, native visual/accessibility checks and the remaining route integrations must still be verified under the existing project gates.
