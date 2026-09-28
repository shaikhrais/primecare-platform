# Authentication task board

Indicators: ✅ verified at the stated level; 🔄 implemented, further verification
pending; ⬜ pending; ⛔ external prerequisite. No indicator below means production ready.

| Task | Status | Evidence / remaining work |
|---|---|---|
| Login, sessions, logout | ✅ Production smoke | Run 36465061031 passed valid/invalid login, GET/POST identity, logout and revoked-session rejection |
| CEO/HR registration policy | ✅ CEO production / HR isolated CI | Production creation, read-back and forbidden-role/tenant checks passed; HR allowlist covered in isolated tests |
| First CEO setup | ✅ Unit-tested | Protected workflow code; production setup not executed |
| Login throttling | ✅ Isolated PostgreSQL | Run 36457853287 passed, including concurrent attempts and counter expiry |
| Authenticated mutation throttling | ✅ Unit and PostgreSQL CI; deployed | Password change 5/minute; account creation and management 10/minute each; counters persist across rollback and sessions; PR #8, CI 36477112955, deployment 36477431047 |
| Source/IP login protection | ✅ Deployed; normal production journeys verified | Governance-backed 120 attempts/60 seconds per source per Cloudflare location, before database access; native counters are approximate; CI 36483277129, deployment 36485650599 |
| CEO account role/status management | ✅ CI and production deactivation | Production deactivation and target session revocation passed; role allowlists/self-protection covered in CI |
| Password change | ✅ Production smoke | Old password/session rejected; new password login passed in run 36465061031 |
| Password recovery and delivery | ⛔ Requirements and delivery missing | See AUTH_RECOVERY_GOVERNANCE_GAP.md; registered routes have no approved schemas or permission keys |
| Auth OpenAPI | ✅ Seven governed operations documented | All seven routes exercised by production smoke; exhaustive schema/error conformance remains separate |
| Production schema checks and migrations | ✅ Applied | Run 36463366031; additive auth tables preserve existing text IDs; deployment preflight passed |
| Production first CEO | ⛔ Setup values required | Existing tenant ID and CEO credentials in protected GitHub secrets; no permanent CEO created by smoke tests |
| Deployment and public API journeys | ✅ Production verified | Deployment 36463534382 and 17-check smoke 36465061031 passed; QA fixtures removed |
| Auth web release | 🔄 Published; login page rendered | Release 36485554743 includes API_GATEWAY_URL; browser login form and language selection verified; authenticated UI journey and recovery still pending |

Current Worker CI suite: 71 passing tests including schema validation, auth handlers, client transport,
bootstrap, management and password change. Self-modification checks reject case-based bypasses
while preserving opaque text IDs. PostgreSQL UUID and text-ID matrix run 36462832340 passed.
Account-management and password-change PostgreSQL run 36458402955 completed
successfully. Run 36460028606 also passed the GET/POST compatibility unit tests,
type checks and real PostgreSQL schema preflight/lifecycle integration.

The per-email login throttle deliberately counts both valid and invalid attempts.
This can temporarily throttle a targeted account. It is not a substitute for
edge/IP abuse controls. Expired counter cleanup is scheduled hourly. Production preview run 36474948002
passed and found zero expired counters; the first scheduled apply run remains unverified.
No raw email or token is stored in the counter table.

See AUTH_PRODUCTION_EVIDENCE.md for deployment URLs, scope and remaining limitations.

## Fresh auth repair — 2026-09-28

PR #5 fixes a login/password-change race by revalidating the checked password hash
and active status while holding a user row share lock through session insertion.
Login and current-password validation also reject inputs above bcrypt's 72-byte
limit, consistent with existing registration and new-password validation.

Three new regression tests failed against the previous implementation and pass
after the fix. All 53 local tests and Worker type checks pass. PostgreSQL tests
interleave real password changes and deactivation immediately before session
insertion in both UUID/text fixtures; run 36473732595 passed. These repairs
were deployed in run 36474769659 from commit 94900e61fb79ad5b7eb6229461ed2d1748ac5598.
Post-deployment production auth run 36475523539 passed all 17 checks and removed
its temporary fixtures. Cleanup CI run 36474305871 passed both identity matrices. No new routes, permissions, roles or schema are introduced.

## Configuration checked 2026-09-28

GitHub lists Cloudflare account/token, production database, BOOTSTRAP_CEO_EMAIL
and BOOTSTRAP_CEO_PASSWORD secrets, with no environment secrets. Permanent CEO
setup still needs BOOTSTRAP_TENANT_ID; the email and password secrets are present. Recovery still needs approved sender,
provider configuration and governed contracts; no recovery email is sent by this release.
Source/IP login protection and the auth website are now deployed (see latest release below); broader abuse controls and authenticated UI verification remain unfinished. The GitHub AI security scan
failed with an unsupported-model service error, so it is not a completed security review.

## Authenticated mutation limits — 2026-09-28

PR #8 merged as b6ee56718780f5106849f7a4e1b9f06093500716. All 60 unit tests
and PostgreSQL UUID/text jobs in run 36477112955 passed, including concurrent
attempts across sessions and rollback-resistant counters. Governance migration
36477328579 succeeded. Deployment 36477431047 succeeded; post-deployment live
run 36477795900 passed all 17 checks and removed its temporary QA tenant/accounts.
These smoke checks cover existing journeys; the new throttle thresholds and
concurrency behavior are verified in isolated PostgreSQL CI.

## Flutter auth transport — 2026-09-28

PR #9 merged as a3ba133ed72c4705186612446d3e3ca69e1ceeb7. Auth errors no longer
fall through to cached/mock HTTP 200 responses. Server error statuses and payloads
are preserved; connection failures return a generic 503. Covers all five client
methods, absolute auth URLs and query strings. The production security interceptor
remains installed; the transport tests replace it only within test fixtures.

Auth Gateway Verification run 36478586863 passed Flutter analysis, the 125-case
transport suite, Dart service/gateway checks and PostgreSQL login/logout smoke.
This is a Flutter source fix on main, not evidence of a published Flutter release.
No new auth route, permission, or password recovery implementation is introduced.

## Flutter session ownership — 2026-09-28

PR #10 merged as a954ccfe47705d1c150a8fe73153b8ab759d7d7e. Account creation now
sends only the governed email/password/role fields and keeps the provisioning
actor signed in. The legacy Dart method signature remains compatible; first/last
name arguments are not sent because the account-creation contract excludes them.

The security interceptor no longer recursively logs out on a logout 401, treats
login/current-password credential errors separately, and ignores stale-token
responses when deciding whether to log out the current session. Logout leaves
routing initialization complete and clears persisted session data.

Run 36479471041 passed Flutter analysis, all 139 client tests (125 transport and
14 session regressions), Dart service/gateway checks and PostgreSQL login/logout.
These fixes are merged source changes; a published Flutter release and end-to-end
UI verification remain pending. Backend deployment evidence above is unchanged.

## Gateway, source protection and auth web release — 2026-09-28

- PR #11 (4ac1c8e44b8c41eb427e6da6d605642866668f5e) closes Flutter error-handling gaps for canonical /v1/user/change-password, /v1/admin/users and /api/auth aliases. Run 36482631053 passed all 263 Flutter tests and analysis/Dart/PostgreSQL checks.
- PR #12 (51c874316f86b95a196c2d866750b283297537c9) adds governance-backed source login protection. Both UUID/text jobs in 36483277129 passed all 69 Worker tests, type checks and PostgreSQL lifecycle tests. Governance migration 36484211228 succeeded. Deployment 36484553670 and production smoke 36484904880 passed. See AUTH_SOURCE_LIMIT.md for scope and shared-network/locality limitations.
- PR #13 (a83017f1979d7ecaa53c4ffded54d6f8abe44083) fixes two Riverpod 3 compatibility errors blocking the auth web build. Auth CI 36484502191 passed full app lib analysis and 263 client tests. State shells retain TODO markers; they are not completed features.
- API_GATEWAY_URL is configured as https://primecare-api-gateway.itpro-mohammed.workers.dev. Auth web release 36485554743 succeeded and its build log confirms this value. https://primecare-auth.pages.dev/login?enable-semantics=true renders the login form; language selection was exercised. No permanent user login was attempted.
- PR #14 (9c470faebc00ce7c70c63b17002b1d2fb1ecc20b) permits the existing Flutter security headers in gateway and Worker CORS preflight while retaining origin restrictions. Both PostgreSQL jobs in 36485365910 passed the 71-test Worker suite and type checks. Final deployment 36485650599 succeeded; final live run 36485971747 passed all 17 auth checks and removed temporary QA fixtures.

Remaining release gaps: permanent CEO tenant ID, password recovery contracts/provider/sender,
full authenticated UI journey and unfinished UI flows. The existing page still displays
sign-up/recovery controls and compliance/operational claims; their presence is not proof of
public registration, email recovery, certification or monitoring. These need UI follow-up.
The hourly cleanup's first scheduled apply run remains unverified; only its preview is recorded.
Native packaging runs were cancelled to prioritize auth checks; native releases are not claimed.

## Shared auth architecture — 2026-09-28

PR #15 merged shared local auth screens and routing into all nine production app entry points. Each product app owns /login and the other auth entry routes; central AuthNotifier/ApiClient manages credentials and sessions. No redirect to a separate auth website is required. See SHARED_APP_AUTH.md for scope and validation.

Auth Gateway Verification run 36490077115 passed 280 Flutter tests, Dart checks and PostgreSQL login/logout. Sign-up remains administrator-provisioned. Recovery delivery/reset redemption, MFA challenges and consent persistence remain unavailable; simulated success and consent token forwarding have been removed. Full web rollout and signed-in browser journeys remain unverified. Existing non-auth Dart build failures in other apps are a release risk, not a passing auth check.
