# Personal account records — batches 26–30

| Batch | GET endpoint | Result |
| --- | --- | --- |
| 26 | `/v1/auth/me/notifications` | Own tenant-scoped notifications |
| 26 | `/v1/auth/me/notifications/{recordId}` | One owned notification |
| 27 | `/v1/auth/me/notifications/summary` | Counts grouped by stored boolean `is_read` |
| 28 | `/v1/auth/me/activities` | Own assigned activities |
| 28 | `/v1/auth/me/activities/{recordId}` | One owned activity |
| 29 | `/v1/auth/me/activities/summary` | Counts grouped by stored `status` |
| 30 | `/v1/auth/me/rewards` | Own stored rewards profile |

All endpoints require an active explicit bearer session and a non-null actor tenant. The optional tenant header must match. Every query binds `user_id` to the actor and `tenant_id` to that actor's tenant, excluding null-tenant records. No arbitrary user, tenant or role selectors or new role grants are accepted. Personal account reads do not require a client/provider profile or create one. The same ownership predicate works for any account role.

Notifications expose id, title, message, type, is_read and created_at. Navigation links, user IDs and tenant IDs are excluded. Stored text is data; a page consumer must render it as text. GET does not mark notifications read. Activity fields are id, role, title, description, status, due_date, created_at and updated_at. Role is a recorded assignment label, not a permission grant; status does not establish workflow completion. Rewards contain id, care_coins, current_tier, lifetime_points and updated_at. Recorded points, coins and tiers do not establish money, entitlement, redemption eligibility or balances available to spend.

List and summary requests accept only `limit` (default 25, 1–100) and `offset` (default 0, 0–100000). Detail and rewards requests accept no query parameters. Invalid IDs, duplicates, owner/role filters, bodies and writes are rejected. Lists sort by creation time then ID descending. Summaries sort the stored group value, with null last; total counts groups, not records. Empty owned lists/summaries return empty arrays and zero total. Missing detail/rewards profiles return 404. Multiple owned rewards profiles return 503 rather than picking one; no replacement profile is synthesized.

Only the generated registered field projection is returned, with type/date validation. Source throttling, no-store responses and read-only repeatable-read transactions apply to all modes. Malformed data/backend failures return 503 without driver messages. Notification reads, activity reads and rewards reads do not mutate any state.

`scripts/register-self-records-api.py` validates existing registered database columns and reproduces the runtime projection, seven OpenAPI contracts, authenticated account-screen links and batch metadata before implementation. Workspace registration invokes it. See `self-records-batches-26-30.openapi.json` for schemas, examples and errors. The execution-status inventory exposes these declarations and conservative fixture evidence.

Unit fixtures exercise projected fields, own SQL scope, strict input, active session/tenant enforcement, paging, empty/absent/ambiguous results, malformed types/counts/dates, throttling, error masking and gateway-to-auth routing. Disposable PostgreSQL CI covers other users, foreign and null tenants, exact detail denial, group/list paging, empty results, rewards ambiguity, expired sessions and inactive actors for UUID/text auth identity variants. The ambiguity fixture deliberately omits the normal singleton uniqueness constraint to exercise the guard; it is not a schema migration. No production migration or UI change is required. CI and authenticated production verification remain separate deployment gates.
