# Operational summaries and bootstrap metadata — batches 96–100

| Batch | GET endpoint | Ownership | Projection |
| --- | --- | --- | --- |
| 96 | `/v1/auth/me/technical-audit-records/summary` | Actor User `performed_by_id` and matching tenant | Stored status and count |
| 97 | `/v1/auth/me/audit-signoff-records/summary` | Actor User `rn_id` and matching tenant | Stored status and count |
| 98 | `/v1/provider/performance-reviews/summary` | Unique actor-owned ProviderProfile `provider_id` and matching tenant | Stored status and count |
| 99 | `/v1/provider/availability-overrides/summary` | Unique actor-owned ProviderProfile `provider_id` and matching tenant | Stored boolean is_available and count |
| 100 | `/v1/auth/me/bootstrap-record` | Actor User `user_id` and recorded matching tenant | Historical created_at only |

Every query derives ownership from the active explicit bearer session. A supplied x-tenant-id must match the actor's non-null tenant. Null or foreign owners and tenants are excluded. Provider summary ownership differs from reviewer User ownership; missing or ambiguous profiles return 404 or 503.

Summaries return groups and bounded pagination: limit 1–100 (default 25), offset 0–100000 (default 0), total status/flag groups and hasMore. Boolean availability groups sort false before true; empty groups return 200. No status/role/owner/tenant filters are accepted. Stored statuses do not establish compliance, review outcomes or completed care; availability flags do not prove bookability or override scheduling.

The bootstrap audit's existing user_id primary key supports a singleton metadata response. Only the recorded timestamp is exposed; source, user ID and tenant ID are excluded. Absence or a foreign recorded tenant returns 404; malformed/duplicate data returns 503. The timestamp does not establish current CEO privileges or grant any permission. The existing auth bootstrap audit migration is a dependency; no migration is added.

The shared handlers supply no-store responses, read-only repeatable-read transactions, source throttling and sanitized errors. These additions introduce no business writes, clinical contents, review details, audit details, grants or UI changes. Governance registration precedes runtime generation; OpenAPI and execution/page-building metadata are reproducible.

Fixtures cover projection, owner/tenant SQL binding, boolean counts, paging, invalid inputs, source limits, gateway forwarding and singleton absence/malformed data. Disposable PostgreSQL CI covers UUID/text identities, foreign/null owners and tenants, reassignment, unique profiles, historical recorded tenant and inactive/expired sessions. Local evidence does not claim database, production or screen readiness.
