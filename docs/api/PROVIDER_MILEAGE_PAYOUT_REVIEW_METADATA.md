# Provider mileage, payout and review metadata: batches 56–60

| Batch | GET route | Projection |
| --- | --- | --- |
| 56 | `/v1/provider/mileage-logs`, `/{recordId}` | Record ID, date, stored distance/time/status, creation time |
| 57 | `/v1/provider/mileage-logs/summary` | Counts by stored status |
| 58 | `/v1/provider/payouts`, `/{recordId}` | Payout ID, stored currency/status, processing/creation timestamps |
| 59 | `/v1/provider/payouts/summary` | Counts by stored status |
| 60 | `/v1/provider/performance-reviews`, `/{recordId}` | Review ID, period boundaries, stored status/acknowledgement and timestamps |

Every endpoint requires an active explicit bearer, a matching non-null tenant and exactly one actor-owned provider profile. SQL binds provider ID and tenant on every record query. No arbitrary provider/user/tenant/role filters, role grants or mutations are included. Missing profiles return 404; duplicate profiles fail closed with 503; other providers' or tenants' records are inaccessible.

Mileage exposes recorded finite numeric distance and nullable integer travel minutes; it does not confirm a journey or reimbursement eligibility. Addresses, visit references, reimbursement rates and amounts are excluded. Payouts expose metadata only: no amounts or notes, payment instructions or payout commands. Stored status/currency does not prove receipt or establish payable funds. Reviews expose metadata only: no reviewer IDs, ratings, goals, strengths, improvements, KPIs or notes. Acknowledgement timestamps do not imply agreement or verified competence. Nullable values remain null.

Lists/summaries accept `limit` 1–100 (default 25) and `offset` 0–100000. Details accept no query. Collections sort creation time descending then ID; summaries sort registered status keys and paginate groups, with group count as total. Empty lists/groups return 200; absent/unowned details 404; invalid requests 400; inactive sessions 401; tenant mismatch 403; writes 405; source throttling 429; unavailable/malformed data 503. Responses use repeatable-read transactions and no-store caching.

OpenAPI: `provider-metadata-batches-56-60.openapi.json`, including schemas/examples/errors. Governance registration validates existing columns and registers contracts/owner predicates before generation. Existing screen links appear in API execution and page-blueprint metadata without marking screens ready. Fixtures validate projection, finite numeric data, auth, profile uniqueness, request bounds, throttling and gateway routing. PostgreSQL CI verifies actual owner/tenant isolation, paging, status grouping and nullable fields for UUID/text auth identities. No migration or deployment is included.
