# Provider operational metadata: batches 51–55

| Batch | GET route | Output |
| --- | --- | --- |
| 51 | `/v1/provider/conversation-threads`, `/{recordId}` | Thread ID, stored type, creation time |
| 52 | `/v1/provider/conversation-threads/summary` | Counts by stored thread type |
| 53 | `/v1/provider/timesheets`, `/{recordId}` | Timesheet ID, opaque week ID, stored status/minutes and timestamps |
| 54 | `/v1/provider/timesheets/summary` | Counts by stored status, including null |
| 55 | `/v1/provider/availability-overrides`, `/{recordId}` | Override ID, recorded date/time strings and strict availability flag |

An active explicit bearer session, matching non-null tenant and exactly one provider profile owned by the actor are required. Every query binds that profile ID and tenant. Missing profiles return 404; duplicates return 503. Unassigned threads and records belonging to another provider/tenant are excluded. No arbitrary user, provider, tenant or role filters are accepted.

Thread responses exclude message contents and client IDs and grant no message access. Timesheets exclude reviewer IDs, rates, amounts and payroll details; stored status/minute values do not establish approval, payable hours or payroll eligibility. Null counters/timestamps remain null. Availability overrides expose stored data only; they do not guarantee bookability or availability approval. Override time strings are not normalized or interpreted as a timezone. All endpoints are read only; no new role grants or mutations.

Lists and summaries accept `limit` 1–100 (default 25) and `offset` 0–100000. Details accept no query. Lists sort creation time descending then ID, except overrides sort recorded date descending then ID. Summaries paginate stored groups, so total counts groups rather than records. All reads use repeatable-read transactions and `Cache-Control: no-store`. Empty collections/groups return 200; unowned/missing details 404; malformed requests 400; inactive sessions 401; tenant mismatch 403; unsupported methods 405; throttling 429; unavailable/malformed data 503.

OpenAPI: `provider-metadata-batches-51-55.openapi.json`, including schemas/examples/errors. Reproducible registration validates governance schema columns, registers existing provider ownership predicates and screen links, and generates the runtime catalog before implementation. API execution inventory and page blueprints include these contracts; screen links do not certify completed pages. Unit and real PostgreSQL suites verify projections, profile uniqueness, ownership isolation, nullable timesheet fields, strict flags, pagination, summaries and gateway routing for UUID/text identities. No migration or deployment is included.
