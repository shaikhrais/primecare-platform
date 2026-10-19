# PrimeCare recovery progress

Scoped engineering checks are separate from full role workflows. No historical completion totals have been carried forward.

| Item | Implementation | Evidence status | Current scope | Commit | Evidence | Next action |
| --- | --- | --- | --- | --- | --- | --- |
| Restore one isolated care availability API fixture | implemented | scoped_tested | sequential embedded PostgreSQL authenticated availability API/database checks; no login UI or concurrency | pending | docs/task-progress/evidence/recovery-availability-api.json | Run native PostgreSQL and real login/browser workflow; embedded sequential API checks do not close the registered workflow. |
| Verify registered PSW availability workflow | implemented | implemented_unverified | role login to UI, API, database result and reload | pending | none | Six real-credential browser cases and eight API/recovery groups pass on embedded PostgreSQL. Continue native concurrency, governed recording playback, full acceptance and required review; see virtual_workflow_checkpoints. |
| Registered virtual process catalogue | implemented | implemented_unverified | virtual process plans and source coverage only; no workflow execution | pending | none | Review process gaps and execute real login/UI/API/database/reload acceptance per process; catalogue counts are not verified outcomes. |
| Closed-appointment action policy | implemented | scoped_tested | unit policy only | ed9f76af | docs/task-progress/evidence/recovery-closed-appointments.json | Run the existing database integration assertions and a real role workflow; unit checks do not close the workflow. |
| Care loading and retry in shared layout | implemented | scoped_tested | care renderer loading and retry with synthetic HTTP responses | 578a80b1 | docs/task-progress/evidence/recovery-loading-retry.json | Repeat recovery checks with real role login, APIs and an isolated database. |
| Care notices and shared sidebar | implemented | scoped_tested | shared shell and care alert components only | 1681fa45 | docs/task-progress/evidence/recovery-sidebar-content.json | Verify the notices in a real authenticated database-backed care workflow. |
| Real credential login and care availability browser loop | implemented | scoped_tested | real credential login and availability UI/API/embedded PostgreSQL roundtrip; sequential harness | pending | docs/task-progress/evidence/availability-workflow-current.json | Do not promote this scoped harness receipt to whole workflow verification; resolve recorded native/runtime/evidence/review gaps. |
| Fail-closed evidence gate evaluator | implemented | scoped_tested | gate evaluator unit checks only | 61959a14 | docs/task-progress/evidence/verification-gate-evaluator.json | Connect an executable registered workflow specification and real evidence producers. |

## Status rules

- pending: work is planned.
- implemented_unverified: code exists, but current evidence is missing or stale.
- scoped_tested: current tests pass only for the stated unit/component scope.
- blocked: an exact prerequisite or external blocker remains.
- verified workflow: reserved for all registered acceptance criteria and all seven evidence gates; none is claimed by this ledger.

Current counts: {"implemented_unverified": 2, "scoped_tested": 6}. Fully verified workflows: 0.

## Next sequence

1. Run the isolated availability API fixture and preserve current evidence.
2. Run the registered PSW availability workflow through real login, UI, API, database and reload.
3. Attach video evidence, denied-access and tenant-isolation checks; evaluate the workflow gates.

Refresh with `python3 tools/workflow-verification/progress.py`. Use `--run-small-checks` to reproduce unit and isolated API receipts. Use `--refresh-browser-evidence` after rerunning the browser checks to preserve their validated receipts and diagnostic recordings. Missing receipts or changed source hashes remove scoped test credit automatically.

The seed registers engineering work in governance.db; generated Markdown/JSON and a database snapshot provide the current view. Existing business roles, permissions and workflow completion flags are not changed.
Commits are local until published; the deleted historical branch and its evidence remain unavailable.
