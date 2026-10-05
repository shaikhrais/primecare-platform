# Feedback and reputation reads — batches 36–40

| Batch | GET endpoint | Result |
| --- | --- | --- |
| 36 | `/v1/client/feedback` | Client-owned feedback metadata |
| 36 | `/v1/client/feedback/{recordId}` | One owned feedback record |
| 37 | `/v1/client/feedback/summary` | Counts by recorded nullable status |
| 38 | `/v1/client/care-feedback` | Client-owned care-feedback metadata |
| 38 | `/v1/client/care-feedback/{recordId}` | One owned care-feedback record |
| 39 | `/v1/client/care-feedback/summary` | Counts by recorded triage_status |
| 40 | `/v1/auth/me/reputation` | Personal recorded reputation profile |

Feedback APIs require an active explicit bearer session, a unique owned client profile and matching tenant. Every record and count query binds `client_id` and `tenant_id`; detail additionally binds the exact record ID. Ownership refers to the registered client relationship, not proof that the actor authored a feedback record. Responses project only id, recorded rating/status and timestamps; care-feedback uses triage_status and has no updated_at. Comments, internal resolution notes and visit identifiers are excluded. Statuses/ratings do not prove resolved care, satisfaction or clinical quality. No feedback creation, moderation, triage update or resolution action is implemented here.

List and summary requests accept only limit (default 25, 1–100) and offset (default 0, 0–100000); detail accepts no query parameters. Lists sort by created_at and id descending. Summaries sort the recorded group value with null last; total counts groups, not source records. Missing or foreign details return 404. Empty owned collections return empty arrays and total zero. Rating projections require safe integers; no rating scale or threshold is inferred. GET bodies, invalid IDs, unknown/duplicate filters and writes are rejected.

Reputation requires an active bearer and matching non-null tenant. Because user_reputations has no tenant column, every query joins the owning User and binds that User's current tenant and actor ID. Personal profiles follow the owning user; they are not historical tenant-tagged records. The projection is id, points, elite_status, crises_resolved, created_at and updated_at. The reward multiplier is excluded. These are recorded counters/flags, not verified outcomes, competence, money, permissions or entitlements. No points are added, redeemed or recalculated. Missing profiles return 404 and multiple owned profiles return 503 without inventing a replacement. Reputation accepts no query parameters or writes.

All modes use no-store responses, source throttling and read-only repeatable-read snapshots. Projection types, timestamps and group counts are validated; malformed data/database failures return 503 without driver messages. Existing registered ownership predicates are reused; no role grants or UI changes are introduced.

The registration scripts verify the existing database columns before implementation and reproduce the runtime projections, contracts, existing screen links and batch metadata. Feedback contracts are in `client-feedback-batches-36-38.openapi.json` (batches 36 and 38) and `client-feedback-summaries-batches-37-39.openapi.json` (batches 37 and 39). Reputation uses `self-reputation-batch-40.openapi.json`. The API execution-status inventory exposes conservative declaration and fixture evidence.

Examples: feedback detail may return `{"feedback":{"id":"record-id","rating":4,"status":null,"created_at":"2026-01-01T12:00:00Z","updated_at":"2026-01-01T12:00:00Z"}}`. Care-feedback summary may return `{"groups":[{"triage_status":"PENDING","count":2}],"pagination":{"limit":25,"offset":0,"total":1,"hasMore":false}}`.

Unit fixtures cover SQL ownership, private-field exclusion, metadata projection, nullable statuses, triage keys, strict input, active sessions/tenant/profile checks, unsafe ratings/counters, ambiguity, paging, throttling and gateway/auth routing. Disposable PostgreSQL CI verifies foreign clients and tenants, null statuses, triage grouping, stable paging, empty results, reputation ownership/reassignment/ambiguity and expired/inactive accounts for UUID/text identities. The ambiguity fixture omits normal user_id uniqueness only to test fail-closed handling; it is not a migration. No migration or deployment is included. Production verification remains a separate release gate.
