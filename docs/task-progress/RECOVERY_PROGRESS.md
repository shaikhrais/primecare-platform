# PrimeCare recovery progress

Scoped engineering checks are separate from full role workflows. No historical completion totals have been carried forward.

| Item | Implementation | Evidence status | Current scope | Commit | Evidence | Next action |
| --- | --- | --- | --- | --- | --- | --- |
| Restore one isolated care availability API fixture | pending | pending | planned API/database test fixture | pending | none | Use real care migrations and handlers with synthetic prerequisites; do not seed successful workflow states. |
| Verify registered PSW availability workflow | unverified | blocked | role login to UI, API, database result and reload | pending | none | Check allowed and denied access, tenant isolation, lost-response retry, reload and video evidence before verification. |
| Closed-appointment action policy | implemented | scoped_tested | unit policy only | ed9f76af | docs/task-progress/evidence/recovery-closed-appointments.json | Run the existing database integration assertions and a real role workflow; unit checks do not close the workflow. |
| Care loading and retry in shared layout | implemented | scoped_tested | care renderer loading and retry with synthetic HTTP responses | 578a80b1 | docs/task-progress/evidence/recovery-loading-retry.json | Repeat recovery checks with real role login, APIs and an isolated database. |
| Care notices and shared sidebar | implemented | scoped_tested | shared shell and care alert components only | 1681fa45 | docs/task-progress/evidence/recovery-sidebar-content.json | Verify the notices in a real authenticated database-backed care workflow. |
| Fail-closed evidence gate evaluator | implemented | scoped_tested | gate evaluator unit checks only | 61959a14 | docs/task-progress/evidence/verification-gate-evaluator.json | Connect an executable registered workflow specification and real evidence producers. |

## Status rules

- pending: work is planned.
- implemented_unverified: code exists, but current evidence is missing or stale.
- scoped_tested: current tests pass only for the stated unit/component scope.
- blocked: an exact prerequisite or external blocker remains.
- verified workflow: reserved for all registered acceptance criteria and all seven evidence gates; none is claimed by this ledger.

Current counts: {"blocked": 1, "pending": 1, "scoped_tested": 4}. Fully verified workflows: 0.

## Next sequence

1. Restore the isolated availability API fixture.
2. Run the registered PSW availability workflow through real login, UI, API, database and reload.
3. Attach video evidence, denied-access and tenant-isolation checks; evaluate the workflow gates.

Refresh with `python3 tools/workflow-verification/progress.py`. Use `--run-small-checks` to reproduce the two small unit receipts. Use `--refresh-browser-evidence` after rerunning the browser checks to preserve their validated receipts and diagnostic recordings. Missing receipts or changed source hashes remove scoped test credit automatically.

The seed registers engineering work in governance.db; generated Markdown/JSON and a database snapshot provide the current view. Existing business roles, permissions and workflow completion flags are not changed.
Commits are local until published; the deleted historical branch and its evidence remain unavailable.
