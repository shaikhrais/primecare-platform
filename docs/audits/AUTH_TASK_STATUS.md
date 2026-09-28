# Authentication task board

Indicators: ✅ verified at the stated level; 🔄 implemented, further verification
pending; ⬜ pending; ⛔ external prerequisite. No indicator below means production ready.

| Task | Status | Evidence / remaining work |
|---|---|---|
| Login, sessions, logout | ✅ Production smoke | Run 36465061031 passed valid/invalid login, GET/POST identity, logout and revoked-session rejection |
| CEO/HR registration policy | ✅ CEO production / HR isolated CI | Production creation, read-back and forbidden-role/tenant checks passed; HR allowlist covered in isolated tests |
| First CEO setup | ✅ Unit-tested | Protected workflow code; production setup not executed |
| Login throttling | ✅ Isolated PostgreSQL | Run 36457853287 passed, including concurrent attempts and counter expiry |
| Other endpoint throttling / abuse controls | ⬜ Pending | Login counter is not a platform-wide abuse control |
| CEO account role/status management | ✅ CI and production deactivation | Production deactivation and target session revocation passed; role allowlists/self-protection covered in CI |
| Password change | ✅ Production smoke | Old password/session rejected; new password login passed in run 36465061031 |
| Password recovery and delivery | ⛔ Requirements and delivery missing | See AUTH_RECOVERY_GOVERNANCE_GAP.md; registered routes have no approved schemas or permission keys |
| Auth OpenAPI | ✅ Seven governed operations documented | All seven routes exercised by production smoke; exhaustive schema/error conformance remains separate |
| Production schema checks and migrations | ✅ Applied | Run 36463366031; additive auth tables preserve existing text IDs; deployment preflight passed |
| Production first CEO | ⛔ Setup values required | Existing tenant ID and CEO credentials in protected GitHub secrets; no permanent CEO created by smoke tests |
| Deployment and public API journeys | ✅ Production verified | Deployment 36463534382 and 17-check smoke 36465061031 passed; QA fixtures removed |
| Auth pages | ⬜ Deferred | API verification first |

Current local suite: 53 passing tests including schema validation, auth handlers, client transport,
bootstrap, management and password change. Self-modification checks reject case-based bypasses
while preserving opaque text IDs. PostgreSQL UUID and text-ID matrix run 36462832340 passed.
Account-management and password-change PostgreSQL run 36458402955 completed
successfully. Run 36460028606 also passed the GET/POST compatibility unit tests,
type checks and real PostgreSQL schema preflight/lifecycle integration.

The per-email login throttle deliberately counts both valid and invalid attempts.
This can temporarily throttle a targeted account. It is not a substitute for
edge/IP abuse controls. Expired counter cleanup requires an operational retention
job before production use; no raw email or token is stored in the counter table.

See AUTH_PRODUCTION_EVIDENCE.md for deployment URLs, scope and remaining limitations.

## Fresh auth repair — 2026-09-28

PR #5 fixes a login/password-change race by revalidating the checked password hash
and active status while holding a user row share lock through session insertion.
Login and current-password validation also reject inputs above bcrypt's 72-byte
limit, consistent with existing registration and new-password validation.

Three new regression tests failed against the previous implementation and pass
after the fix. All 53 local tests and Worker type checks pass. PostgreSQL tests
now interleave real password changes and deactivation immediately before session
insertion in both UUID/text fixtures; CI verification is pending. These repairs
are not deployed. No new routes, permissions, roles or schema are introduced.
