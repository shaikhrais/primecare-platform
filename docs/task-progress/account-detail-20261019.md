# Same-tenant account detail — 2026-10-19
Production PostgreSQL governance is the live authority. Only business_process definitions count as workflows.

| Workflow ID | Issue found | Fix | Test result | Status | Evidence | Execution source commit |
| --- | --- | --- | --- | --- | --- | --- |
| auth.inspect-account | Required account-detail UI absent; draft API binding differs from canonical registration | Corrected isolated test fixture to include existing management-audit migration; recorded exact UI/specification dependencies; no application/grant changes | One real-credential API case and eight security groups passed; API only, no browser claim | missing; test_status scoped_pass | [Native receipt/replay](https://github.com/shaikhrais/primecare-platform/actions/runs/39344712184/artifacts/12231105127) | ecdef80a16212988d78164306775d4ffa735e0bf |

## Registered requirements and exact gaps
The live definition SHA is 155841b12b1068e0334da4e90c2be2d2889498073dd497dfacb641b59ba3feb9. It permits CEO only. The live auth_account_management_policy row specifies same_tenant scope, roles/status fields and no self-modification. Platform Admin remains denied for this operation; no grants were widened.

Canonical API16427 is GET /v1/admin/users/{userId}, service auth, explicit authentication, permission auth_account_management_policy and workspace.source rate limit. Its response declares user id/email/roles/status/updated_at/canModify plus assignableRoles. The draft process step instead names /v1/auth/admin/users/{id}; reconcile its exact canonical binding through a production-compatible metadata writer.

API16427 has links to screens705 (ceo_dashboard), 903 (admin_user_management) and 935 (user_management). No screen_components are registered. Required elements are generic root/title/content and unrelated update buttons. There are no exact account-selection/detail display controls or detail API action bindings. Each screen points to the generic governed_workspace_screen.dart telemetry/placeholder renderer. Current TypeScript auth-screen.ts implements login and account.ts implements change password. These are not an account-detail UI.

Register the approved selection/detail controls, stable test IDs, EN/FR/ES resource bindings and their canonical API interaction before implementation. The shared production tracking adapter does not authorize general metadata/schema writes; do not execute legacy SQLite registration scripts or invent controls/routes/grants. The source review and exact hashes are recorded through the protected recorder, without claiming live UI or independent approval.

## Native execution and limits
Actual current-main gateway and inherited service dispatcher ran against a random schema in disposable loopback PostgreSQL16. Isolated CEO, Platform Admin, HR Director and PSW actors used real credential login. Tests demonstrated:
- CEO reads exactly the database-backed safe fields and assignable roles. Self and protected platform accounts have canModify=false.
- Platform Admin, HR Director and PSW receive403, preserving domain data.
- Cross-tenant/missing targets return404. Tenant-header mismatch returns403; tenant/user/query/identifier injection returns400.
- Unsupported methods return405 without mutations.
- Missing, invalid and expired credentials return401.
- The controlled source limiter returns429 with the existing retry contract; clean retry succeeds.
- An invalid persisted timestamp returns503/no-store; the read transaction leaves data intact, and the restored fixture succeeds.
- Eight concurrent reads agree without mutations. A subsequent read reflects an external synthetic account update.

Account/session/audit snapshots were compared around reads. The current source assignable-role list is compared with production CEO creation-policy targets by the recorder. The read-only operation creates no domain changes requiring mutation rollback. Login fixture sessions are expected and isolated. There is no browser reload/offline/video proof because the account-detail UI is absent. Deployed edge/cookie behavior, accessibility/PWA and independent review gates remain unproven. No verified promotion is justified.

Diagnostic run39344505957 failed before detail acceptance because the fixture omitted existing 20260928_auth_management_audit.sql. Its schema was dropped. The corrected producer includes that migration and passed; both receipts are retained in production attempt history, with the first classified as a fixture blocker rather than an application defect.

## Inventory and checkpoint
Live pre-attempt counts: 147 business processes, 11 missing,130 implemented-unverified,0 verified,6 blocked. DONE=0; PENDING=147. The recorder recalculates authoritative post-attempt counts.

Complete catalogue: 5338 definitions =147 business_process +954 screen_journey +1760 action_journey +2474 api_contract +3 legacy_candidate. These supporting categories overlap with business processes and are not extra business duties. Attempt IDs are execution history identifiers, not catalogue totals.

This documentation commit removes inspect-account.yml and record-inspect-account.yml. The already-started protected recorder saves the diagnostic and scoped passing attempt, then verifies the exact final main SHA, unchanged acceptance-bound source, successful main checks, one remote branch/main and zero open PRs before recording recovery-handoff-current. INSPECT_ACCOUNT_ATTEMPT_COMMITTED and INSPECT_ACCOUNT_HANDOFF_COMMITTED contain the actual attempt IDs, evidence links and final state.

No application implementation changed; no work branch or feature PR was opened. Synthetic schema cleanup completed and no production business account/grant was changed. Local historical/staged work remains preserved.

Next concrete action: inspect auth.inspect-account-sessions from its live saved definition, reconcile canonical API and registered UI before isolated credential/UI/API/database/reload acceptance. Do not repeat the completed account-detail API tests unless source/specification/evidence becomes stale.
