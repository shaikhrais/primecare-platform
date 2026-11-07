# Existing maintenance presentation lifecycle

## Purpose and scope

This maintenance-only change connects the existing `/maintenance/configuration` renderer's continuing lifetime to its installed ScreenManager. It creates no route, screen, role, control, API or governance record. The checked-in maintenance catalog, MaintenanceClient validation and server permission/tenant checks remain authoritative. This is a presentation-lifecycle correction, not an authorization implementation or release approval.

The renderer uses one root owner with captured pathname/query, session and generation. Each private read, event payload extraction, mutation dispatch, completion, redraw and navigation revalidates ownership and the existing manager registration's four synchronous connections. Root/frame/main-content identity catches a replacement inside an otherwise retained shell. A newer renderer retires the earlier owner, including retained handlers. Manager/connection/storage failures are contained and never fall back to direct private reads.

The real shared shell receives its existing optional presentation lease. Search entries guard their open callbacks; appearance and Theme Center retire with their owner using the existing expected-owner cleanup API. No shared shell implementation is changed.

## Existing actions and contracts

Identity still loads before configuration. Settings retain sender, exact template fields and revision; settings readiness remains required. Account creation retains the existing grant and email/password/role payload. Test-email and save require their exact server acknowledgements. No password policy, transport URL, permission or business rule is changed. Mutations and logout are single-flight within the current renderer. Existing disabled states are restored only on the same generation, and passwords clear only after a current successful response.

MaintenanceClient gains an optional ownership callback solely before its existing 401 token removal and confirmed-logout browser token removal. The default remains true for standalone callers. This prevents an obsolete same-token renderer from deleting the browser session of its replacement. It cannot cancel a logout or any other request already dispatched to the server. A new account's token remains protected by the existing BaseSessionClient checks. Current-session 401 still clears its matching token, retires stale visible settings and presents the existing localized unavailable/sign-in recovery; its refresh navigates to login without a private read. A known null-session transition is accepted only after that client has recorded successful owned token removal. Confirmed logout likewise navigates only after browser deletion.

Successful mutation acknowledgements are shown only after the subsequent identity/configuration reads succeed. They report the existing server acknowledgement, not independent evidence that a newly created account or accepted email has become observable or delivered. A failed refresh presents the existing GET retry. There is no automatic POST replay, durable receipt, extra idempotency contract or claim of exactly-once processing. Uncertain non-idempotent submission/retry semantics remain a separate product/API question; this patch does not silently redesign them.

## Page lifecycle

Persisted pagehide suspends renderer and shell callbacks. Pending reads and mutations hold UI continuation until pageshow revalidates the same URL, session, root and manager; they do not dispatch follow-up GETs while suspended. A valid restore continues the existing work, never reissues its POST. The narrow transport-side browser-session guard revalidates ownership, including the four synchronous presentation connections, during suspension so a current confirmed logout/401 retains prompt browser-session invalidation. This is an explicit exception to suspended UI continuation, not a zero-effects suspension guarantee. An accepted logout retains the known null session and waits to navigate until restore. Invalid restore retires the owner. Nonpersisted pagehide disposes listeners, observer, waiting continuations and owned shell controls.

## Regression evidence and limits

Run `env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test --test-concurrency=1 scripts/test-maintenance-manager.mjs`. The 38 bounded cases execute the actual renderer, client, session transport, manager/resolver, shell, layout customizer and Theme Center against synthetic `.invalid` endpoints and a small DOM model. They cover current locales/actions, manager failures and revocation, real refresh/retry, retained payload callbacks, replacement roots/main content, session/storage changes, same-token late 401/logout, stale completions/finally, single-flight actions, grants/readiness, confirmed logout and modeled BFCache/cleanup. Existing tests and fixtures are unchanged.

`MAINTENANCE_SOURCE=/path/to/predecessor` replays these same assertions against an unchanged source tree with the same module interfaces; the harness does not import the new owner module directly. This is a behavioral negative control, not a browser run. Existing release/deploy workflows invoke the added suite without changing triggers, permission settings or publication controls.

Native browser/history/BFCache, keyboard/focus, responsive/layout and WCAG 2.2 AA acceptance remain outstanding, as do whole-main reconciliation, required CI on reconciled source, production governance/cutover verification and release authorization. These synthetic tests and compile/bundle checks do not establish those gates.
