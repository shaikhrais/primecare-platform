# PrimeCare production workflow recovery — 2026-10-19

## Current outcome

Production attempt 310 for `care.psw.submit-availability` is committed. Verification remains `implemented-unverified`; test_status is `scoped_pass`. No completion tick is awarded.

The work branch `work/workflow-production-recorder` was merged and deleted with an exact-head lease after CI and protected production execution passed. There is one remote branch, `main`, and zero open PRs. Historical archive tags were preserved. No local work branch was created for this repair; pre-existing local staged changes and recovery material were left intact.

Source implementation merges:
- PR #209: a682083ae33094f525d48a430cfb930f6a82b601.
- Same-branch TLS follow-up PR #210: 1fc355190ea21a12b6326db2f639e58f405e22fd.

## Workflow report

| Workflow ID | Issue found | Fix | Test result | Status | Evidence | Source commit |
| --- | --- | --- | --- | --- | --- | --- |
| care.psw.submit-availability | Recorder still used removed SQLite authority; browser theme reader bypassed the production adapter; binary PostgreSQL client did not locate its CA bundle | Pinned, explicitly opted-in PostgreSQL tracking store; shared governed theme reads; explicit operating-system CA bundle with verify-full retained | 23 store tests, unchanged recorder/gate/reader tests, full care CI, six credential/browser cases and eight security/recovery groups passed | implemented-unverified; scoped_pass | [Browser results and video](https://github.com/shaikhrais/primecare-platform/actions/runs/39305700696/artifacts/12214106372) | 1fc355190ea21a12b6326db2f639e58f405e22fd |

The browser run exercises real credential login → UI availability action → production handlers → isolated embedded PostgreSQL result → browser reload, EN/FR/ES, responsive widths and time zones. Negative/recovery groups include invalid credentials, identity-validation outage, expired session, role/self/tenant denials, forged tenant headers, invalid input, idempotent replay, response-loss retry, rollback, offline recovery and logout.

This is a loopback renderer/handler harness with synthetic business data. It does not establish full deployed workspace/router, workflow-specific native multi-connection concurrency, full accessibility/PWA acceptance or independent review. Recording-store concurrency tests are separate from business-workflow concurrency proof. Governed playback requirements in the existing acceptance specification still need authority review; no new route, grant or duty was invented.

## Production governance

The sole live authority remains tools/governance-production/production-pin.json, schema `governance_68b0b02dd1215f58630d2c1a`, `govt_` tables, manifest `68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42`.

The general reader stays read-only. The separately pinned workflow writer requires `GOVERNANCE_WORKFLOW_WRITES=1` and permits only tracking changes to definitions' verification fields, attempts, issues, evidence, resolutions, checkpoints and catalogue snapshots. It rejects absent/conflicting credentials, wrong targets/manifests, schema mismatches, duplicate/null tracking keys and unsupported statements. Transactions, serialized table locks, explicit identities/row ordinals/timestamps and tagged JSONB values preserve imported data without DDL or grant changes. See tools/workflow-verification/PRODUCTION.md.

The original failed production recording run stopped at strict TLS before any tracking mutation: https://github.com/shaikhrais/primecare-platform/actions/runs/39303882904.
A protected read-only diagnostic proved the explicit system CA file and pinned manifest: https://github.com/shaikhrais/primecare-platform/actions/runs/39304473101.
The corrected store also passed live schema/key/count preflight without mutation: https://github.com/shaikhrais/primecare-platform/actions/runs/39304792859.
Successful browser execution and committed recording: https://github.com/shaikhrais/primecare-platform/actions/runs/39305700696.
Branch cleanup and committed production handoff: https://github.com/shaikhrais/primecare-platform/actions/runs/39306191668.

No operational governance.db was read or recreated. Explicit isolated CI fixtures remain test-only. No real production business accounts, records, permissions or tenant grants were changed. The disposable synthetic business database was closed.

## Live totals after the committed attempt and handoff

TOTAL = 147 = MISSING 11 + IMPLEMENTED-UNVERIFIED 134 + VERIFIED 0 + BLOCKED 2.
DONE = 0.
PENDING = 147.

These are recalculated production business_process counts; supporting screen/action/API guides are excluded. No workflow was promoted to verified.

## Resumption checkpoint

The production checkpoint for this workflow references attempt 310. Its next_action contains the complete structured handoff; `govt_virtual_flow_catalog_snapshots` also contains `recovery-handoff-current`. It records main SHA `302951c55183836aa8f64bc74f7743af82691b10` as of cleanup, no work branch, zero open PRs, CI/evidence URLs, live counts, synthetic data cleanup and next action. Subsequent report/temporary-workflow removal commits do not change the tested business sources.

Next registered candidate: `auth.bootstrap-first-central-admin` — Bootstrap first protected central_admin. Read its current production definition, steps, source links, permissions, APIs and checkpoint before testing. Use an isolated fresh database for first-administrator bootstrap acceptance.

An authority-review note is preserved in the production handoff: live api_endpoints row 2 (API__V1_AUTH_LOGIN) is marked auth_required=1 while the registered availability specification starts without a session. Clarify the canonical meaning before full acceptance; no grant or API metadata change was inferred.

Other legacy writers and governance consumers remain outside this completed recorder repair. Do not point them at production by substituting a URL. Full platform workflow verification remains incomplete.
