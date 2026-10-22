# Auth: scoped engineering verified; external acceptance pending

The user requested completion of auth work. Implementation is committed directly on main with expected-head updates. Runtime source is `116d1eb30108f4590493a3cf1a209d7d5312ac63`. Source integration, scoped automated evidence and independent approval are separate states.

## Verified engineering and deployment — 2026-10-22

- Recovery/replacement and temporary tenant support are integrated. Their four recovery APIs, seven elevation/support APIs and 43 controls were registered in pinned production governance before implementation. No role grant or owner-account assignment was added by registration or evidence recording.
- Native PostgreSQL and Flutter verification/release [39732810463](https://github.com/shaikhrais/primecare-platform/actions/runs/39732810463) passed. This includes text/UUID identities, atomic single-use recovery, rollback, session revocation, lock-wait expiry, outbox leases, key rotation and scoped-evidence writer guards. Auth Worker unit/PostgreSQL run [39732810365](https://github.com/shaikhrais/primecare-platform/actions/runs/39732810365) also passed.
- Tenant approval now loads pending requests after verified session restoration. A queued refresh is discarded on sign-out or actor replacement. Regression tests cover both transitions. All nine portal deployments of this shared UI fix (`f3dc3de067387576930d67bfcdf7e1ec3067bd64`) passed.
- Browser verification synchronizes canvas scrolling before pointer interaction and confirms entered values once. Five deployed focus cases passed [39727599322](https://github.com/shaikhrais/primecare-platform/actions/runs/39727599322); the browser fixture rejects dropped input without silently retrying. Diagnostic runs earn no auth acceptance credit.
- Native MFA baseline [39732810427](https://github.com/shaikhrais/primecare-platform/actions/runs/39732810427) passed EN320, FR768 and ES1440 with exact synthetic cleanup. Its six-control scoped recorder [39733513965](https://github.com/shaikhrais/primecare-platform/actions/runs/39733513965) passed.
- The previous full lifecycle run [39730345167](https://github.com/shaikhrais/primecare-platform/actions/runs/39730345167) passed complete English and French journeys, including tenant approval, aggregate-only access and revocation. Spanish stopped before its first password exchange. That failed overall receipt was not recorded as complete. Remaining base controls now use synchronized clicks; final evidence must still pass every locale.
- Broader automated, monorepo, Unified Dart, Auth Gateway and workflow-contract checks passed for the shared UI fix. The earlier isolated full API fixture completed 3741 tests; fixture counts remain separate from live completion evidence.

## Actual v2 storage-key proof

Canonical deployment policy selects `mfa-v2`, migrates from `mfa-v1` in bounded batches of 10, and retains both bindings for rollback. Release 39732810463 observed the actual scheduled report at `2026-10-22T06:25:36.127Z`:

| Evidence | Result |
| --- | --- |
| Public keyring source | `2b72992b936147a070d3096c8b99f5fca2129dcf4d5a4ce238ea47b237c31923` |
| Actual binding round trip | Verified v1 → v2 → v1 |
| Active key | `mfa-v2` |
| Credentials rewrapped in observed batch | 1 |
| Remaining v1 credentials | 0 |
| Remaining v1 replacement envelopes | 0 |
| Old binding deleted | No |

Rewrap verifies that authenticator seed bytes are preserved. The report contains aggregate counts and public source identifiers, never key material or account identities. Pending live replacement proof is deferred; expired replacement cleanup is bounded. The old key is retained pending retirement/rollback review.

## Final scoped acceptance — verified

The source-bound v2 producer [39733869467](https://github.com/shaikhrais/primecare-platform/actions/runs/39733869467) passed the complete browser/API/database/reload journeys in EN320, FR768 and ES1440. Every locale passed exact synthetic cleanup and persisted `mfa-v2` assertions for enrollment, factor replacement and lost-factor recovery. Scoped production recorder [39735678464](https://github.com/shaikhrais/primecare-platform/actions/runs/39735678464) succeeded at `2026-10-22T06:43:15Z` for source `116d1eb3`: 11 APIs and 43 controls, with independent approvals and whole-platform readiness explicitly false.

Recovery requires a fresh password challenge and one saved code, then confirmation of a new factor before authority is retained. Saved-code hashes are single-use and context-bound. Replacement revokes old sessions/codes. Temporary support requires fresh Code Admin proof, an originating session, a 900-second aggregate-only scope, explicit target-tenant approval/revocation and transactional audit. It exposes no clinical records or impersonated session.

## Supporting isolated browser CI

The triggered current-password browser job exposed an esbuild import-attribute identity being treated as a filename. Commit `04879917a486350c6df711fec700b171fd109975` shares the strict JSON-input path normalizer with offline diagnostics. All 10 diagnostic tests and the actual esbuild 0.27.2 attributed source-byte check passed locally. The [Chromium/Firefox/WebKit isolated password-browser rerun 39736485045](https://github.com/shaikhrais/primecare-platform/actions/runs/39736485045) passed in all three engines. This proof uses native disposable PostgreSQL and supplies no deployed or physical-device credit. Auth Worker text/UUID tests [39736485051](https://github.com/shaikhrais/primecare-platform/actions/runs/39736485051) and workflow-contract checks [39736485055](https://github.com/shaikhrais/primecare-platform/actions/runs/39736485055) also passed after this verification-only change.

## External acceptance still pending

Independent architecture, database, security, accessibility and localization reviews, plus physical-device acceptance, remain external gates. Automated checks and the owner's earlier Android login do not supply those approvals. Owned QA inbox batch delivery now passed for 15 security notices across EN/FR/ES; per-event provider-ID mapping and external mailbox-provider delivery are not claimed. V1 key retirement remains subject to its review and rollback conditions.

The pinned PostgreSQL governance authority remains unchanged. The immutable requirement registration and pending review history are preserved; source-bound scoped engineering evidence does not award whole-platform production-readiness credit or resolve unrelated governance consumers.

## Review follow-up completed — 2026-10-22

The technical review and actual domain inbox check are recorded in [auth-review-20261022.md](../auth/auth-review-20261022.md). Native API/DB/scheduled-sender/receiving-Worker run [39772742647](https://github.com/shaikhrais/primecare-platform/actions/runs/39772742647) received five localized notices per language, with guarded account/tenant/mail cleanup and prior mail preserved. The browser helper now re-resolves a replaced semantics node before one click; five browser regressions passed. Final lifecycle/support producer [39774933735](https://github.com/shaikhrais/primecare-platform/actions/runs/39774933735), source `4ada3b87`, passed 103 checks and cleanup in each locale. Scoped recorder [39777265212](https://github.com/shaikhrais/primecare-platform/actions/runs/39777265212) passed. Earlier failed interaction receipts remain failures; independent approvals and whole-platform readiness remain false. No production auth API/UI behavior changed during this review.
