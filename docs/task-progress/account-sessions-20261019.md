# Same-tenant account session list — 2026-10-19

Production PostgreSQL governance remains the live authority. This attempt covers one business process, not an additional role/screen/API duty.

| Workflow ID | Issue found | Fix | Test result | Verification status | Evidence | Published execution source |
| --- | --- | --- | --- | --- | --- | --- |
| auth.inspect-account-sessions | Required session-list UI absent; draft endpoint differs from canonical registered API | Corrected producer receipt identity; recorded exact UI/specification dependencies; application/grants unchanged | One real-credential API case and eight security groups passed; no browser claim | missing; test_status scoped_pass | [Native receipt and replay](https://github.com/shaikhrais/primecare-platform/actions/runs/39345441636/artifacts/12230558193) | 2cb9447313b1771ff4b9e65a6ed74d92033cb7cb |

## Live requirements and unresolved implementation
Definition SHA: 7e3f0d10b9878cbbc6e62eda9e0df68f650e3d39bda67fb0ce722012624e17d3.
Allowed actor: CEO. The auth_account_management_policy row remains same_tenant, permitted_fields roles,status and self_modification0. Platform Admin, HR Director and PSW are denied for this operation; no role grants changed.

Canonical API16421 is GET /v1/admin/users/{userId}/sessions, service auth, auth_required1, permission auth_account_management_policy, rate_limit_key workspace.source. Registered query fields are limit1–100/default25, offset0–100000/default0 and includeExpired/defaultfalse. The response contains userId, timestamp-only sessions and pagination(limit,offset,total,hasMore). Tokens and hashes must not be exposed.

The virtual draft step instead names GET /v1/auth/admin/users/{id}/sessions. Reconcile the exact canonical specification binding using a production-compatible metadata writer; do not add a new route or infer new authority.

API16421 links screens705/903/935. No screen_components or exact account-selection/session-list API controls exist. These screens use generic governed_workspace_screen.dart telemetry and placeholder elements. Current auth-screen.ts renders login; account.ts implements change password. Neither implements a timestamp-only paginated session-list duty. Register approved controls, stable test IDs and EN/FR/ES resources before implementation, preserving UI/API separation and the shared skeleton/layout/theme. The tracking adapter does not authorize arbitrary metadata/schema writes; legacy SQLite registration scripts are not production-compatible.

## Native execution
The actual main gateway and inherited service dispatcher ran against a random isolated PostgreSQL16 schema. CEO and denied-role actors used real credential login. Existing auth_sessions, rate-limit and audit migrations were applied.

Eight groups passed:
1. Safe timestamp-only projection, active/all counts and self-session read exactly match database-backed records.
2. Ordered pagination, limit/offset boundaries, expired inclusion and empty pages match the database.
3. Denied Platform Admin/HR/PSW roles, foreign/missing targets, protected platform target and forged tenant header cannot disclose sessions.
4. Missing/invalid/expired caller sessions are denied without domain mutation.
5. Invalid pagination, duplicate/query/tenant injection, malformed identifiers and unsupported read methods are rejected. The separately registered DELETE operation was not invoked.
6. A controlled source limiter produces429 with the existing retry contract; a clean retry succeeds.
7. An invalid persisted timestamp fails closed with503/no-store; the read transaction preserves data and a restored retry succeeds.
8. Eight simultaneous reads agree without mutations; authoritative reread reflects an external synthetic expiration update.

Snapshots include users, sessions and both account audit tables. The required created_at and expires_at fields are compared directly with native records; response keys exclude hashes/tokens. Both synthetic producer schemas were dropped. No production business accounts or grants changed.

The initial producer39345413323 had a duplicated workflow-ID suffix in its receipt. It is retained as a metadata diagnostic and excluded from canonical passing evidence. The corrected producer uses the exact workflow identity; the supported recorder preserves both histories.

These are scoped API/native proofs. No session-list browser, reload, offline UI or video execution is claimed because the required UI is absent. Deployed edge/cookie behavior, full accessibility/PWA/performance, governed playback and independent review gates remain unproven. No verified promotion is justified.

## Counts and handoff
Verification totals remain147 =11 missing +130 implemented-unverified +0 verified +6 blocked. DONE=0; PENDING=147. Separate scoped-pass workflow count is recalculated by the production recorder, never treated as fully verified.

The complete overlapping catalogue contains5338 definitions:147 business_process,954 screen_journey,1760 action_journey,2474 api_contract and3 legacy_candidate. Attempt IDs describe execution history rather than additional business processes.

This documentation commit removes account-sessions.yml and record-account-sessions.yml. The already-started protected recorder verifies their removal, current bound source hashes, final main checks, one remote branch/main and zero open PRs before saving the latest workflow checkpoint and recovery-handoff-current. ACCOUNT_SESSIONS_ATTEMPT_COMMITTED and ACCOUNT_SESSIONS_HANDOFF_COMMITTED give actual attempt IDs, evidence, totals, final SHA and cleanup/review state.

No application change, work branch or feature PR was created. Historical local/staged work remains preserved. Next concrete action: inspect auth.inspect-email-config from its fresh live definition, permissions, source and UI/API bindings before isolated credential/UI/API/database/reload acceptance.
