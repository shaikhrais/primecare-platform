# Auth live repair checkpoint — 2026-10-21

The original public-probe 403/1010 is repaired, with all nine deployments passing at e40ee7d7. The request identifies itself truthfully as PrimeCareDeploymentVerifier; no browser identity is impersonated and no Cloudflare protection is disabled.

A real browser then exposed a second blocker: Flutter sends credentialed requests, while the gateway omitted Access-Control-Allow-Credentials. Browser diagnostic39532792216 captured the exact preflight error. Gateway source 3f2b0a07a78a121c2b6910d9c001175cd0191381 adds the credential acknowledgement only within its existing allowed-origin branch. Release39533198501/job119003698671 passed14 targeted allowed/denied/passthrough scenarios, type checking, pinned production authority, publication and live allowed/foreign-origin checks. Runtime version f2d0cf15-1d9d-4435-ae5f-34f719d9ea57. The first release stopped on missing Node type declarations before publication; the dependency was corrected.

The browser could then log in, but session restoration recreated the router and lost the public recovery route. Source 5e9a3413b0d91a28022e29016247141621566f37 retains the current URI and root navigator identity per application while rebuilding role-specific route registrations. Disposal is owned by the provider. Guest fallback route registration uses the URI path rather than query-bearing text. The regression proves recovery route, semantics query, form State and draft survive both restoration and logout. All11 Auth Gateway jobs passed in run39533901132; logs confirm104 UI +295 core +4 routing tests,403 total.

A semantics focus handoff also erased fast browser-fill input. A named nonexistent-account diagnostic proved that waiting for focus/activation frames retains both inputs and dispatches login. The helper fills once and fails if the value is lost; it does not silently retry. Upstream fast-input behavior remains a separate limitation: https://github.com/flutter/flutter/issues/194186 (reported issue, not a confirmed fixed engine guarantee).

Latest completed live run39533901208 reached real browser login and accepted recovery submission, then its strict localized-text assertion found both Flutter's live announcement and visible copy. It did not prove receipt. Synthetic native accounts were cleaned. Unmatched inbox messages were preserved; do not claim all mail was removed or receipt proved. The producer now correlates received mail before presentation assertions, marks submitted-request progress immediately, accepts a visible localized match despite announcement duplication, and selects language via the actual UI.

New source ec38b2edd8a8daef84b637f1fad2fa55388e95bf, run39534720268, is pending at this checkpoint. Still require received-code/native-hash correlation, reset, denial of old password/session and replay, normal new login, logout/reload, exact fixture/mail cleanup and unchanged deployed source. Full auth sign-off remains false.

Source-binding amendment da4d8e51ee779383b046939eb37138236854560d proves gateway bytes outside the exact CORS block equal the previous pinned SHA256. The four unsupported method-capture workflows retain their blocked dispositions and no independent review is fabricated. The broader backend run39534027842 passed the old source-hash stopping point and is still running; do not count the whole run passed.

## Later live findings and current pending repair

Both Auth Worker PostgreSQL suites in run39534027842 passed after the exact CORS-only evidence rebind. Native invalidation and revocation fault proofs also passed.

Run39534720268 sourceec38b2edd8a8daef84b637f1fad2fa55388e95bf proved real receiving-Worker email receipt, native code-hash matching and browser reset in EN/FR/ES, but its immediate secret-clear check failed. Awaited recheck run39535359500 source c66ae0a21d40cb667f2493ef29aa225242059811 confirmed the browser still retained a12-character recovery-code value after10seconds. This is a real web input rendering defect, not merely a slow assertion. Matched messages and synthetic accounts were cleaned; older unmatched messages were preserved.

Pending repair f252cf4b3ef4f090995778ff73da0370703a1aae clears controllers, releases focus and changes the field subtree keys only after a confirmed reset, removing stale semantics DOM inputs. Failure/retry drafts remain. Source f8b3c2fe9c5b8ae83d426adedfb7547548e0549f also limits retained router/navigation State to existing public auth pages; protected pages retain their old rebuild behavior. Latest Auth Gateway run39536220864 and deployed inbox run39536221115 are in progress. No full roundtrip pass or full auth sign-off is claimed yet.

Research: https://api.flutter.dev/flutter/widgets/Widget/key.html and https://api.flutter.dev/flutter/widgets/TextEditingController/clear.html . The final producer retains an awaited DOM-value check and does not print the code/password if clearing fails.

## Final superseding result

Source `3529100a21be93043026a085ab6581063667ffce` passed all11 Auth Gateway jobs in [39536853037](https://github.com/shaikhrais/primecare-platform/actions/runs/39536853037) and404 focused Flutter tests. The current deployed owned-inbox run [39536853161](https://github.com/shaikhrais/primecare-platform/actions/runs/39536853161) passed EN320/FR768/ES1440 through real receiving-Worker mail/hash correlation, browser reset and DOM secret clearing, old-credential/session and replay denial, new login, logout/reload, exact cleanup and unchanged source binding. Both backend PostgreSQL identifier suites and the14 targeted CORS cases passed. See [the final scoped report](auth-live-repair-final-20261021.md). Full auth sign-off remains false; no policy/review approvals are fabricated.
