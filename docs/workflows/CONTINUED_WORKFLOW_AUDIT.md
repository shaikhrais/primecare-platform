# Continued workflow audit

Snapshot: 2026-10-27, America/Toronto. This is a test-evidence snapshot for selected implemented workflows, not a statement that every platform workflow is complete or production-approved.

[Download/read the workflow status list](WORKFLOW_TEST_STATUS.csv). It distinguishes passing isolated checks, unsupported account deletion, live-provider checks, and unresolved contracts.

## Result

[Business workflow continuation audit](https://github.com/shaikhrais/primecare-platform/actions/runs/40625134473): **all four jobs passed** on source `ebda6865848d92381106d09fabd3606b86bc8ad6`.

| Area | Passing evidence |
| --- | --- |
| Accounts | 106 client/API tests; auth setup/acceptance 90 checks per identifier type; account administration 37 PostgreSQL checks per type; personal care metadata 33 PostgreSQL checks per type. Both text and UUID identities were used. |
| Care | 211 tests across contracts, real PostgreSQL, state transitions, concurrency, rollback, staffing, schedules, dependencies and browser interactions. Six loading/retry cases passed. Six credential-login/availability browser cases plus eight API check groups passed against embedded PGlite; those are sequential, not native concurrency evidence. |
| Growth | 35 contract/workforce tests, eight database test groups, 34 growth browser tests, eight partner/admin browser cases and six loading/retry cases passed. |
| Workspace | 18 screen-text/training checks, 41 workspace/transport checks and six real-browser credential-login/sign-out cases passed. Sign-out covers database failure, offline retry, malformed acknowledgements, lost responses, session replacement and foreign-session preservation. |
| Calls and tools | [Independent call audit run](https://github.com/shaikhrais/primecare-platform/actions/runs/40625602769) passed: 77 tests with native grant evaluation, PostgreSQL concurrent append/deduplication/conflict/isolation/tamper checks, and real workerd provider-projection, synthetic spoken-SMS and callback-boundary tests. Its production deployment job was skipped. |

Counts describe tests/checks and include overlap. They must not be added together and called a count of distinct completed business workflows.

## Repairs made

The reproduced failures in this continuation were test infrastructure and outdated navigation expectations. No application runtime behavior was patched in this batch.

- Installed the shared voice SDK needed to bundle the screen-text release tests, and included the QR decoder required by growth tests.
- Provisioned the pinned Python governance-reader dependencies and explicit isolated fixture mode for the care login/availability test.
- Updated partner/admin and workspace browser tests to use the current page headings, dedicated administrator destination, dashboard summaries and More menu. Tenant/role checks and save/failure assertions remain in place.
- Restored the DOM constructors required by the workspace unit harness. Its bundled source now has a file URL so exceptions remain readable instead of producing multi-megabyte base64 stack traces.
- Reused the attributed-JSON source-path helper when recording workspace source hashes; source hashing remains enabled.
- Added a repeatable continuation workflow with separate account, care, growth and workspace jobs. The runner writes a receipt after every group, retains failures, streams readable logs and terminates the entire stalled test process group at its deadline. A timeout remains a failed result.
- Expanded the independent call audit tests to cover voice-tool failure boundaries and native PostgreSQL endpoint grants instead of skipping that native check.

## What remains

- Account deactivation and session revocation are implemented and tested. Permanent account deletion is not supported by the current platform administration handler; this audit did not invent a destructive deletion policy.
- These results use disposable databases, test identities and controlled provider responses. Real SMS delivery, real Vapi call completion and current production caller registration still require live end-to-end evidence.
- The existing [workflow contract plan](../api/WORKFLOW_CONTRACT_PLAN.md) contains 1,063 unresolved API operations. That is API catalogue debt, not a count of workflow test failures. No pending operation was silently marked implemented, retired or approved.
- Generic role-page navigation is read-only presentation evidence. Pending business actions on those pages remain pending.
- Formal workflow review states, production-ready flags and independent approvals are not inferred from this passing test batch.

## Reproduce

The workflow is `.github/workflows/business-workflow-audit.yml`. It installs isolated tools and runs `node scripts/run-business-workflow-audit.mjs account`, `care`, `growth` or `workspace` with its disposable database/fixture configuration. Per-group logs and JSON receipts are uploaded in the `business-workflows-*` artifacts.
