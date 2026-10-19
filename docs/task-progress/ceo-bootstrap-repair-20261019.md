# First CEO bootstrap repair and evidence

Workflow: `auth.bootstrap-first-ceo`. Verification status: **blocked**. Latest scoped result: **scoped_pass**, production attempt **313**. This is not full workflow verification.

Production attempt **312** recorded issues **14** and **15** before repair. Baseline evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39312127623/artifacts/12215519467 . Node 24 with pg@8.11.3 could not load the named pg import. Separately, an isolated embedded PostgreSQL audit trigger returning NULL let the old logic commit one CEO, zero audits and return created=true. Only the pg import was adapted to reach that original logic.

The fix uses default pg import and requires exactly one matching persisted account and audit row before commit. Failure rolls back the transaction. No application roles, routes, grants or UI were added. The protected operator confirmation and credential-secret entry remain intact.

PR https://github.com/shaikhrais/primecare-platform/pull/212 merged candidate `c0dad2aee792b92660bf019b1f45d001e74668c0` into main at `1284dc0229a2ec9ace93740006a5514bf223ba54` after all **seven PR checks** passed. The merged-source run passed **17 bootstrap checks**: nine native PostgreSQL 16 cases and eight contract cases. Coverage includes insert suppression, rollback/retry, tenant eligibility, existing foreign-tenant account preservation, input rejection before SQL, same-tenant races and one CEO for each eligible tenant. Native test schemas were dropped; production business bootstrap was never executed. A separate local regression run passed all 20 CEO/central/platform contract checks.

Current evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39313423450/artifacts/12216498937
Post-merge native execution and protected issue-resolution recording: https://github.com/shaikhrais/primecare-platform/actions/runs/39313423450 .
Attempt **313** resolved issues **14 and 15** using source-bound native evidence, retaining the original failures and attempt history. Recording uses the pinned production PostgreSQL adapter and one transaction.

The cleanup controller https://github.com/shaikhrais/primecare-platform/actions/runs/39313796759 requires the observed merged-main authentication, native, recording, contract, generated-code and compression checks to succeed before deleting the exact merged work ref. Its final branch/PR counts, current main SHA, attempt IDs, evidence, blockers, synthetic cleanup and next workflow are saved to the production checkpoint and `recovery-handoff-current` snapshot. This document is published before that controller finishes so its handoff can bind the final documentation commit. Read the production handoff for the final execution state.

Exact remaining blockers: the draft definition leaves deployment operator identity and approved protected workflow inputs/review unresolved. Its generic session and foreign-tenant alternatives require reconciliation with the protected CLI entry point. Real credential login, tenant-scoped console/API/database/reload, browser recovery/security, video and independent review gates remain unproven. The registered definition retains historical source hashes; attempt 313 binds repaired current source. Review and rebind the specification/source metadata before any future full verification.

Live totals at attempt 313: **147 = 11 missing + 132 implemented-unverified + 0 verified + 4 blocked**. DONE=0; PENDING=147. Supporting CEO core-process guide 78 was inspected and excluded from the business-process count.

Resume from current main and the production handoff's next workflow. Inspect live definition, source links, grants/APIs and prior attempt first. Do not repeat resolved CEO bootstrap cases unless source/specification/evidence becomes stale.
