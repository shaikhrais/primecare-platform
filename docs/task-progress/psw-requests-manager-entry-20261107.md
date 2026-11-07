# PSW requests review ScreenManager boundary

## Scope and ownership

The existing TypeScript `/psw-requests` route now enters its existing ScreenManager registration before reading or presenting the request queue and before retained review actions. The owner is the existing `renderPSWRequests` renderer in `websites/typescript/src/psw-personal/index.ts`. This is a presentation lifecycle boundary, not an authentication or permission grant.

The existing `/v1/governance/care/personal?dataset=queue` endpoint, request-review action, labels, dialog and table remain in use. Queue tenancy still comes from the authenticated server actor; this change does not add a tenant query selector. No screen, route, API, permission, business policy, localization key or governance record is introduced. The existing managed ID and route contract is unchanged; compatible registration metadata remains supported.

`PersonalClient`, `renderPersonal`, the personal view and shared session transport retain their behavior for other live/demo personal and care consumers. A queue-only subclass reports response status without applying sign-out side effects. The current queue owner decides whether a 401 still belongs to its route and dialog before clearing the session and navigating to login.

## Behavior and failure controls

- Renderer invocation, connected root and owned nodes, document path/query, session and all four presentation connections are checked before queue reads, retained review actions and visible asynchronous results. Root replacement, query change, repeated rendering, manager revocation and account change invalidate obsolete work.
- The server remains authoritative for session validity, tenant membership, coordinator context, review permission, no self-review, request status and request version. The existing request body, optimistic version, idempotency headers and coordinator header are preserved. Server source files are unchanged.
- Only one review dialog and one mutation can be active. Closed, canceled, removed, detached or obsolete dialogs and forms cannot submit. Pending controls are disabled, failed or uncertain writes retain the response draft and existing payload retry identity, and a changed payload receives its own identity.
- A successful POST is treated separately from its follow-up GET. An acknowledged response remains a receipt for the same request ID/version. A failed or malformed refresh leaves the response visible and frozen; Save response retries only the read. Closing and reopening that version preserves the receipt. An unchanged-version read cannot cause another POST. Receipts are local to the owning renderer, not durable storage or a replacement for server idempotency.
- A current forbidden follow-up queue read clears the old queue and dialogs using the existing unavailable presentation, even if the dialog closed while the read was pending. The route and generation must still match, so an obsolete read cannot replace newer content. Transient read failures do not turn an acknowledged write into an uncertain write. Other dialog-specific completions cannot apply late success, errors, authentication effects or refreshes after that dialog closes.
- BFCache suspension holds pending results and preserves drafts and receipts until restoration revalidates ownership. Nonpersisted departure releases listeners, observers and owned dialogs. Clicks do not retire the document before actual departure, so canceled navigation leaves it usable.
- A request already dispatched can still commit on the server after local retirement. This change suppresses obsolete client effects; it does not claim to cancel server execution. Existing request versions and idempotency remain the final protection across a full navigation or reload.

## Verification

`scripts/test-psw-requests-manager.mjs` bundles the actual queue renderer, shared PersonalClient transport, ScreenManager and managed route resolver. It reuses the existing minimal DOM fixture byte-for-byte. It does not mock the queue renderer or add browser claims.

The focused suite covers 146 cases, with three consecutive passing runs. The same suite against the predecessor finishes with 47 passes and 99 expected failures, no cancellations or skips. Five original missing-boundary regressions were reproduced before implementation. All 1,068 selected predecessor tests pass, and all existing tests and fixtures remain byte-identical. An independent actual-module suite also passes all 113 checks in three repeated runs; its unchanged-predecessor replay completes with 22 passes and 91 failures. Both existing TypeScript release workflows retain prior commands and add this isolated, credential-free suite.

## Release limits

This is bounded source and simulated-DOM evidence. Real-browser native dialog behavior, focus, keyboard operation, history, BFCache, accessibility, layout and visual review remain required. Browser execution was unavailable before navigation in this environment; no bypass or browser success is claimed. No live database, production API, credentials, governance mutation, published commit, deployment or hosted release verification is included. Full release readiness still depends on existing governance, localization, accessibility, security, performance, strict-type and CI gates. Broader `/care` and `/psw` workspace integration is outside this change.
