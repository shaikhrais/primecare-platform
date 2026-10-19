# Workflow recovery checkpoint — 2026-10-19

## Authority and repository state

Started from current main 7930fc8505771b2957d7939fefaae502b90e21ee, not historical branch work/care-recovery-20261018-closed-visits or checkpoint 0dbb337. Read .agents/AGENTS.md and tools/governance-production/production-pin.json. Remote inspection found main only and zero open PRs. No new work branch or PR was created.

Production read used the protected production environment, the shared production_reader adapter, schema governance_68b0b02dd1215f58630d2c1a, govt_ relations and matching pinned manifest. No production mutations, synthetic production accounts, fixture restoration or SQLite fallback were performed.

Read-only inspection commit: c62b937674cfa959151c9872180b5a6701a203ee.
Inspection succeeded: https://github.com/shaikhrais/primecare-platform/actions/runs/39300420530/job/118223843988 .
Temporary inspection workflow removed at 8597e939590505b94686cc07f5a2ed5058dd4789.

## Live production counts

TOTAL = 147 = MISSING 11 + IMPLEMENTED-UNVERIFIED 134 + VERIFIED 0 + BLOCKED 2.
DONE = 0. PENDING = 147.

These counts were recalculated from virtual_workflow_definitions filtered to flow_kind='business_process' through the pinned adapter on 2026-10-19 at 18:11 UTC. No status was promoted or changed.

Supporting inventory, not additional business processes: 5338 total definitions across all flow kinds; 18750 steps; 5976 source links; 98 role guides; 6 catalogue snapshots. Inspected source-schema metadata for all five requested relations. PRAGMA introspection in this adapter reads empty manifest-derived schema metadata, not a local governance database.

## Scoped attempt and exact dependencies

| Workflow | Issue found | Fix | Test result | Verification status | Evidence | Commit |
| --- | --- | --- | --- | --- | --- | --- |
| care.psw.submit-availability | Browser harness still reads removed operational SQLite theme tokens; production attempt recorder is not migrated | No unsupported writer substitution or fabricated workflow completion | Five isolated API checks pass; no browser execution in this attempt | implemented-unverified; acceptance and production recording remain unproven | scripts/test-care-availability-api.mjs, run against current main source | 7930fc8505771b2957d7939fefaae502b90e21ee, tested source; no implementation change |

Additional regression: three closed-appointment checks pass in scripts/test-care-closed-appointments.mjs.

Reproduction: node --test scripts/test-care-closed-appointments.mjs scripts/test-care-availability-api.mjs (Node 24, esbuild, bcryptjs and @electric-sql/pglite 0.3.14).
Final result: tests 8, pass 8, fail 0.
The first API launch lacked @electric-sql/pglite; installing the pinned isolated dependency resolved that setup failure. No implementation defect was inferred from the missing dependency.

Covered by the five isolated API tests: authenticated token-based availability persistence/audit/replay, denied roles/foreign staff/forged tenant, fresh API reads and foreign withdrawal denial, audit failure rollback/safe retry, invalid dates/expired session/changed replay denial. These tests use synthetic disposable embedded PostgreSQL. They do not prove real credential browser login, production routing, PWA/accessibility, native multi-connection concurrency or independent acceptance review.

### Exact blockers

1. tools/workflow-verification/execution.py still imports sqlite3, creates SQLite tables, uses lastrowid and SQLite upsert/DDL semantics, and records attempts through that store. The shared production adapter explicitly rejects writes; production-pin.json is readOnly=true. Consequently this session could not persist a production attempt, issue, evidence or checkpoint through a supported mechanism. This repository checkpoint is a transparent handoff, NOT a production governance checkpoint.
2. scripts/test-care-availability-workflow.mjs reads theme_design_tokens by directly opening .agents/governance/governance.db. That file is intentionally removed. Do not run the harness unchanged: sqlite3.connect can recreate an empty operational file. Theme reads must use the pinned production adapter; synthetic business data must remain isolated.
3. Existing acceptance specification tools/workflow-verification/specs/care.psw.submit-availability.json says required acceptance review is pending. Prior repository tracking also identifies native multi-connection concurrency, deployed workspace/router, full accessibility/PWA and governed playback dependencies. These older findings were not revalidated by this scoped attempt; do not treat them as new executed evidence.

No business-process statuses were bulk changed to blocked for the shared infrastructure dependency. No tests or review gates were bypassed. No browser recording or video was produced. No synthetic production data requires cleanup; disposable embedded test data was closed by the fixture.

## Next concrete actions

1. Migrate the attempt/checkpoint store as a narrowly scoped task, on the single permitted work branch, before resuming persisted workflow attempts. Inspect actual PostgreSQL physical types/constraints, imported identities/defaults and all-null JSONB columns; use parameterized transactions, pinned manifest checks and reviewed explicit write scope. Preserve all existing attempts, issues, evidence and checkpoint history. Never merely substitute a database URL into the SQLite writer.
2. Verify rollback, concurrent attempt IDs, duplicate/retry handling, definition/source drift, parent-child integrity and conservative status gating against isolated native PostgreSQL. Do not enable writes or promote verified until required gates pass.
3. Migrate browser theme-token loading to the production reader without reading or creating an operational SQLite file. Keep browser/API/business database fixtures synthetic and isolated. Run real credential browser/API/database/reload and required negative paths; preserve source-bound evidence.
4. Read the current production workflow definition, steps, exact references, policies and latest attempt/checkpoint before recording the next attempt. Continue care.psw.submit-availability if its acceptance dependencies are resolved; otherwise record its exact dependency through the migrated store and select another supported business process.
5. Finish CI/review, merge and delete that one work branch before opening another. Save current main/work-branch SHAs, PR state, evidence and next action through production checkpoint records.

At this checkpoint: no active remote work branch, no open PR, no implementation merge pending. Workflow verification and production checkpoint persistence are incomplete.
