# Production workflow attempt recording

`execution.py` defaults to the pinned PostgreSQL tracking store. Install `tools/governance-production/requirements.txt`, provide the protected `PRODUCTION_DATABASE_URL` (or identical `GOVERNANCE_DATABASE_URL`) and explicitly set `GOVERNANCE_WORKFLOW_WRITES=1`. Run `python tools/workflow-verification/execution.py --attempt <receipt.json> --export`; `--refresh` conservatively invalidates stale proof. Input validation and all seven verification/review gates are unchanged. Never hand-author approval or execution evidence.

The default reader remains read-only. The separate writer scope is explicitly listed in production-pin.json. It can append attempts/issues/evidence/resolutions and update statuses/checkpoints/catalogue snapshots only; no business-table writes, DDL, grants, reset, import replacement or permission changes. It checks the exact manifest and physical column types. Serial table locks, checked natural keys, explicit row ordinals, generated IDs and timestamps replace SQLite defaults and lastrowid semantics without changing imported tables. Lock timeout is ten seconds; failures roll back. Historical manifest counts/hashes describe the import baseline, not subsequent live tracking changes.

Formerly empty columns retain the import's tagged JSONB encoding; the reader decodes declared text/integer tags and rejects unexpected payload types. `--db` is permitted only with explicit isolated fixture mode and no production credentials. No production-to-SQLite fallback exists.

CI tests the recorder against disposable native PostgreSQL, including simultaneous clients, rollback, source staleness, issue resolution, evidence URL roundtrip and rejection of incomplete verification proof. The post-merge protected job runs six credential login/UI/API/database/reload browser cases using production-governed theme reads with a disposable synthetic business database, uploads its evidence/video and commits a scoped production attempt plus checkpoint. It does not mark the business process verified: deployed routing, business concurrency, PWA/accessibility and independent review remain separate gates.

If native tests, protected reads, browser execution or recording fail, inspect the exact job failure and preserve the current work branch until repair and CI/review are complete. Do not bypass failures or report a production checkpoint before the transaction commits.

Native service setup uses Docker-compatible quoted health checks. Failed browser executions upload their current receipt and record a failed scoped attempt when evidence is available; they never become passing attempts.

## Login attempt evidence and the persistence gate

`login-workflow-tracking.yml` is a **secret-free** GitHub Actions integration for the
current `verify-login-session-race.yml` runner. It runs recorder/gate/native
PostgreSQL tests, then collects completed main workflow attempts including failures.
It also supports historical reconciliation by explicit run ID/attempt. It does
not bind production secrets, record a production attempt, deploy, or change business
data. Enabling a new privileged trigger or credential grant is a separate explicit
approval gate; evidence collection is not reported as a successful metadata save.

`collect_login_evidence.py` reads original GitHub metadata and retained artifacts,
checks repository/attempt/job/artifact identities, preserves receipts byte-for-byte,
restores source bytes at their original commits, reconstructs the original patched
runner without executing it, and verifies source hashes. Unavailable or mismatched
proof becomes blocked metadata, never a pass. Matrix jobs never created have no
invented job/attempt identity. New artifact names include the GitHub run-attempt
number. Legacy unsuffixed artifacts are accepted only for attempt 1 and within the
original job time bounds. Other password/CI/invalidation workflows are deliberately
not relabeled as login replacement cases.

Once the existing protected process is authorized to consume that packet, invoke
`python tools/workflow-verification/record_login_evidence.py --packet
<checkout-relative packet.json>` with its **existing** production configuration and
`GOVERNANCE_WORKFLOW_WRITES=1`. The unchanged `ProductionWorkflowStore` guards remain
mandatory: pinned manifest/schema, verified TLS, table locks, allowlisted statements,
no SQLite fallback, no DDL, grants or business writes. This CLI is not permission to
add credentials to a new workflow or expand existing persistent access.

The writer binds the current definition at ingestion while explicitly preserving the
original receipt's definition binding (or lack thereof). GitHub repository, run,
run-attempt and job make an immutable import identity; table locks serialize the
lookup/append and conflicting reimports fail. The source commit, harness commit,
environment, cases and original started/finished timestamps live under
`result_json.execution`; `created_at` remains the actual ingestion time, never a
fabricated historical execution timestamp. An older or chronologically unknown
existing checkpoint/status is not overwritten by historical backfill.

Every save commits before a fresh-connection readback. The readback reports workflow
ID, attempt ID, checkpoint ID, checkpoint attempt, original run/evidence references,
and actual current verification status. The checkpoint ID is its existing `flow_id`
primary key, not an invented integer. Each attempt also retains its own next action.
A current checkpoint may legitimately point to a different newer attempt. Missing
post-commit proof is surfaced, never reported as confirmed persistence. Re-running
the same import is idempotent even after a lost commit acknowledgement.

A baseline GitHub job can succeed because it reproduced a defect. A timeout before
any cases is a failed execution, not a confirmed reproduction. A candidate three-locale
pass is only `scoped_pass` and `implemented-unverified`. This importer cannot request
`verified`, resolve prior issues, or supply fabricated approval/full-workflow gates.

The historical-append API change is staged in
`patches/login-evidence-history.patch`, not active in `execution.py`: changing that
file currently triggers an unrelated care metadata job. The secret-free test job
applies the patch only in its disposable checkout. Production ingestion remains
blocked until the integration and this patch are reviewed and authorized for the
existing protected process. Do not run the recorder against unpatched execution.py.
