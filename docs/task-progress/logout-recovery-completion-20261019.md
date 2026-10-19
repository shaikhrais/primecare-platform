# Logout recovery completion and resume checkpoint — 2026-10-19

Primary auth actor: Platform Admin (`platform_admin`). No production account
roles were migrated or elevated.

## Attempted work

| Business process | Finding | Action | Test result | Status | Evidence | Implementation |
|---|---|---|---|---|---|---|
| auth.inspect-own-sessions | Required account UI absent; sole API UI link points to inactive Guest login screen 948; draft endpoint differs from canonical GET /v1/user/sessions. | Saved exact registration dependency; reused issue 12 instead of duplicating it. No invented screen, control, resource or grant. | UI acceptance blocked; source/live metadata inspected, attempt 318. | missing | https://github.com/shaikhrais/primecare-platform/actions/runs/39321720624/artifacts/12220486545 | No unsupported implementation attempted. |
| auth.logout | On native database DELETE failure, HTTP 503 still cleared the browser token while server /me accepted it. Reproduced in EN/FR/ES. | Shared transport requires signed_out acknowledgement; Platform Admin shows existing localized retry error and preserves replacement browser sessions. Issue 16 resolved by attempt 322. | Twelve transport/login checks; three native browser cases and four recovery/security groups passed; all sixteen original PR checks passed. | implemented-unverified | https://github.com/shaikhrais/primecare-platform/actions/runs/39324494858/artifacts/12221567044 | PR 213 merged at 9924a0d9398f6602638253387651bcb555691e4f. |
| auth.credential-login | Bound source changed during repair. | Refreshed actual main-entry/gateway/worker/native database/workspace/reload proof using the live governed theme. | Three EN/FR/ES cases and five groups passed, attempt 320. | implemented-unverified | Same current-main auth artifact above. | Current merged implementation. |
| auth.change-password | Bound source changed during repair. | Refreshed real Platform Admin account UI, database rollback/retry, session/reset revocation, audit and reauthentication proof. | Three EN/FR/ES cases and three denial groups passed, attempt 321. | implemented-unverified | Same current-main auth artifact above. | Current merged implementation. |
| care.psw.submit-availability | Related credential transport source changed. | Rechecked all source bindings and reused current PR care regression without rerunning passing tests. This proof used explicitly isolated historical CI theme fixtures. | Six cases and eight security/recovery groups passed, attempt 323. | implemented-unverified | https://github.com/shaikhrais/primecare-platform/actions/runs/39322958457/artifacts/12220818758 | Current source bindings match merged main. |

Logout baseline (attempt 319, issue 16):
https://github.com/shaikhrais/primecare-platform/actions/runs/39322477891/artifacts/12220063802

Current auth proof source: 511a0f5318c2ca171da8dfaa585ec207ee9d5341.
Application bindings remain current across the later CI-only repair and cleanup.

## Post-merge CI repair and release

The first ordered release stopped at release_tests because the legacy screen-text
check attempted to open the removed SQLite file. Migration/deployment correctly
did not run for that failed gate. The same work branch was reused for PR 214;
no parallel branch was opened.

PR 214 merged at f6404eae1d70edf5d7a07cd47225817b014b9fa0 after five checks passed.
Six production-only dependent jobs were skipped on the PR as designed.
The repair prepares the approved historical fixture only in an isolated test job
without production credentials. It adds a guarded explicit retry that requires
RELEASE_CURRENT_MAIN and the exact source SHA, preserving immutable checkout and
the policy that editing/installing the release workflow does not automatically
deploy an older feature.

Ordered release of source 2103a241b1b62e5f520aa615e7d14139f9bd9574 passed:
contract, portal preparation, release tests, existing additive screen-text
migration, Worker deployment, gateway verification, website build, all nine
Cloudflare Pages deployments, and smoke checks.

Release evidence:
https://github.com/shaikhrais/primecare-platform/actions/runs/39325668523

Production governance remains pinned PostgreSQL and govt_ tracking. Browser
tests used disposable loopback PostgreSQL schemas; care used disposable CI data.
No production synthetic users or production role changes were made.

## Verification limits and counts

No business process is marked verified. Other role UI surfaces, full deployed
credential/cookie journeys, accessibility/PWA acceptance, formal API/specification
rebinding, governed recording delivery and independent reviews remain pending.

TOTAL = 147 = 11 MISSING + 131 IMPLEMENTED-UNVERIFIED + 0 VERIFIED + 5 BLOCKED.
DONE = 0. PENDING = 147. Attempt IDs count executions, not business processes.

The previous auth.read-current-session scoped proof was correctly invalidated:
its bound auth-client and care-test sources changed. It remains
implemented-unverified with test_status stale until refreshed.

## Lifecycle and next action

Both PRs are merged/closed. This commit removes all temporary operational
workflows while retaining the permanent session-signout regression workflow.
The protected lifecycle job verifies the successful ordered release and final
main CI, confirms merge ancestry/source freshness, deletes only the exact merged
work/logout-session-confirmation ref, verifies main-only remote state and zero
open PRs, and records the actual final SHA and cleanup result in production.
No local task branch was created; pre-existing unrelated staged work/refs remain
preserved.

Next concrete workflow: auth.read-current-session. Read its live definition,
registered API/permissions and checkpoint; refresh real credential UI/API/native
database/reload and safe identity/denial evidence. Reuse the exact own-session UI
registration blocker instead of repeating its unchanged diagnosis. The production
recovery-handoff-current snapshot records the final branch/PR/CI/deployment state,
attempts, evidence, blockers, synthetic cleanup and next action.
