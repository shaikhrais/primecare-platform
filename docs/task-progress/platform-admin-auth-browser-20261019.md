# Platform Admin credential and password browser recovery — 2026-10-19

Primary actor: **Platform Admin**, canonical registered role code `platform_admin`.
The main credential/browser fixture already uses this role. The separate
`tenant_admin` fixture exists solely for tenant-scope denial checks.
No production account roles, permissions, business data or application code changed.

## Completed scoped attempts

| Workflow | Issue / setup correction | Fix | Test result | Verification status | Evidence | Tested main |
|---|---|---|---|---|---|---|
| auth.credential-login | Previous attempt 315 had native API/client proof but no current-main router/browser proof. Initial cross-tenant fixture incorrectly used admin. | Corrected synthetic fixture to registered tenant_admin; applied existing screen-text migration. Main actor remains platform_admin. | Three EN/FR/ES cases and five recovery/security groups passed through website main entry, gateway, inherited service dispatcher and PostgreSQL 16. | implemented-unverified; scoped_pass; attempt 316 | https://github.com/shaikhrais/primecare-platform/actions/runs/39319634146/artifacts/12219786401 | b262a70ddd79ba7bd1871375bb5a172c02a16058 |
| auth.change-password | Existing checkpoint 267 had not_run status. | No application defect found; supplied isolated fixtures and exercised existing governed account UI/API. | Three EN/FR/ES cases and three session-denial groups passed. | implemented-unverified; scoped_pass; attempt 317 | https://github.com/shaikhrais/primecare-platform/actions/runs/39320224699/artifacts/12219189901 | a962ba137cdc324261839a1b4895b8b7ee3fd292 |

Both attempts were recorded atomically through the shared pinned production
tracking adapter. Production read/write jobs were separate from browser jobs;
browser jobs rejected production governance credentials and used loopback-only
disposable PostgreSQL databases. Synthetic schemas were dropped. Videos, test
scripts, source hashes, native database receipts and screenshots are retained in
the linked governed repository artifacts.

## Credential login

Live definition SHA-256:
`47871a7c0750f03de65847537bfadd5cbe02895eb7e04fce920907ed062c3791`.

The real main router opens the platform-administration workspace after credential
verification and identity confirmation. Each browser case checks one hashed,
unexpired database session; compares displayed tenant options with database rows;
reloads without creating another session; and exercises revocation.
Additional checks cover incorrect/inactive credentials, offline retry, identity
confirmation outage with provisional-session cleanup, expired session, PSW denial
from platform administration, and tenant-admin isolation.

The initial run's 403-versus-200 assertion was caused by a wrongly seeded admin
fixture, not a product access failure. Run 39319253945 preserves that diagnostic.
Corrected run 39319634146 passed, including the tenant boundary assertions.

API row 2 remains an exact metadata ambiguity: POST /v1/auth/login has
auth_required=1, service_name=PRISMA, and absent request/response schemas and
permission key, while the registered shared credential journey begins without a
session. No unsupported metadata or grant mutation was attempted.

## Change own password

Live definition SHA-256:
`9a459ca1184488951c65fb9e083d4ad881f3bda6647f2e0fa3c8347c7f61e876`.

Registered API row 277 is POST /v1/user/change-password, auth_required=1,
permission_key=authenticated_self_with_current_password.
Registered security policy allows five valid-input attempts per 60-second window,
keyed by operation and authenticated user ID.

Platform Admin logs in with real credentials and opens the shared account form.
Each EN/FR/ES case checks wrong-current-password rejection, offline retry,
forged identity/tenant rejection, forced audit failure and complete rollback,
then successful retry. Database checks verify a changed bcrypt hash, zero old
sessions, deleted reset codes and exactly one password audit. Both old sessions
and old credentials fail. New credentials work and the workspace survives reload.
Missing, expired and inactive-account sessions are also denied.

## Limits and current counts

These are source-bound scoped browser executions, not full workflow verification.
The host is loopback; Cloudflare source limiter and trusted origin/source headers
are controlled fixture bindings. Only the Platform Admin UI path is demonstrated.
Other registered role destinations, deployed source-policy acceptance, complete
accessibility/PWA and localized-error acceptance, governed recording playback
delivery and independent review gates remain pending. Attempt 315 separately
contains native UUID/text authentication concurrency/rate/security regressions.

Live business-process status counts after attempt 317:

| Status | Count |
|---|---:|
| missing | 11 |
| implemented-unverified | 131 |
| verified | 0 |
| blocked | 5 |
| TOTAL | 147 |
| DONE | 0 |
| PENDING | 147 |

Separate test_status counts: scoped_pass 8, not_run 127, stale 11, blocked 1.
A scoped passing test is not a completed business process. Attempts 316 and 317
are execution IDs, not additional workflows.

## Lifecycle and handoff

No feature branch or PR was opened for these operational verification attempts.
All temporary workflow files are removed in this documentation commit. The
protected handoff job checks final main CI, validates current source bindings,
verifies main-only remote state and zero open PRs, and saves the exact final SHA
to both workflow checkpoints and recovery-handoff-current in production.

Next concrete workflow: auth.inspect-own-sessions. Inspect its live definition,
source links, API/permissions and previous checkpoint; test real Platform Admin
credential login, own-session UI, API/database comparison, reload and foreign
session denial. Preserve pre-existing local staged work and inactive refs.
