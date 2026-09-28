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
| CEO account role/status management | ✅ Isolated PostgreSQL | Run 36458402955 passed; UUID-case regression additionally passes locally |
| Password change | ✅ Isolated PostgreSQL | Run 36458402955 passed; old password/session rejection and new password login verified |
| Password recovery and delivery | ⬜ Pending | Requires approved delivery configuration and single-use token flow |
| Auth OpenAPI | 🔄 Seven governed operations exported | Approved GET/POST session lookup compatibility implemented; production contract verification pending |
| Production schema checks and migrations | ⛔ Not run | Validate tenant/user types; apply audit and rate-limit migrations before deploying code |
| Production first CEO | ⛔ Setup values required | Existing tenant UUID and CEO credentials in protected GitHub secrets |
| Deployment and public URL journeys | ⬜ Pending | Do not claim production authentication until tested |
| Auth pages | ⬜ Deferred | API verification first |

Current local suite: 48 passing tests including schema validation, auth handlers, client transport,
bootstrap, management and password change. UUID normalization and a regression test
prevent case changes from bypassing the CEO self-modification prohibition.
Account-management and password-change PostgreSQL run 36458402955 completed
successfully. Latest GET/POST compatibility changes await their own CI result.

The per-email login throttle deliberately counts both valid and invalid attempts.
This can temporarily throttle a targeted account. It is not a substitute for
edge/IP abuse controls. Expired counter cleanup requires an operational retention
job before production use; no raw email or token is stored in the counter table.
