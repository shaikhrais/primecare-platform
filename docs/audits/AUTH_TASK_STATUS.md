# Authentication task board

Indicators: ✅ verified at the stated level; 🔄 implemented, further verification
pending; ⬜ pending; ⛔ external prerequisite. No indicator below means production ready.

| Task | Status | Evidence / remaining work |
|---|---|---|
| Login, sessions, logout | ✅ Isolated PostgreSQL | Run 36456902193 passed |
| CEO/HR registration policy | ✅ Isolated PostgreSQL | Same run verifies creation, read-back, audit, duplicate rejection and forbidden access |
| First CEO setup | ✅ Unit-tested | Protected workflow code; production setup not executed |
| Login throttling | ✅ Isolated PostgreSQL | Run 36457853287 passed, including concurrent attempts and counter expiry |
| Other endpoint throttling / abuse controls | ⬜ Pending | Login counter is not a platform-wide abuse control |
| CEO account role/status management | 🔄 Implemented, local tests pass | POST /v1/admin/users; same tenant, no self-modification, session revocation and audit; PostgreSQL CI pending |
| Password change | 🔄 Implemented, local tests pass | POST /v1/user/change-password; current password required, new hash, all sessions revoked; PostgreSQL CI pending |
| Password recovery and delivery | ⬜ Pending | Requires approved delivery configuration and single-use token flow |
| Complete reviewed auth OpenAPI | ⛔ Governance mismatch | Exporter found GET /v1/auth/me implemented but only POST registered as endpoint 779; see AUTH_ME_GOVERNANCE_GAP.md |
| Production schema checks and migrations | ⛔ Not run | Validate tenant/user types; apply audit and rate-limit migrations before deploying code |
| Production first CEO | ⛔ Setup values required | Existing tenant UUID and CEO credentials in protected GitHub secrets |
| Deployment and public URL journeys | ⬜ Pending | Do not claim production authentication until tested |
| Auth pages | ⬜ Deferred | API verification first |

Current local suite: 42 passing tests including auth handlers, client transport,
bootstrap, management and password change. UUID normalization and a regression test
prevent case changes from bypassing the CEO self-modification prohibition.
Account-management and password-change PostgreSQL run 36458402955 was queued at
the latest check; it has not been counted as passing.

The per-email login throttle deliberately counts both valid and invalid attempts.
This can temporarily throttle a targeted account. It is not a substitute for
edge/IP abuse controls. Expired counter cleanup requires an operational retention
job before production use; no raw email or token is stored in the counter table.
