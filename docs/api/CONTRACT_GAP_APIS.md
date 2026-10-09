# Registered API contract gaps — batches 101–105

These authenticated GET operations expose the registered work still needed to define and verify APIs. They use existing inventory authority; they introduce no role grants or business writes.

| Batch | Route under `/v1/governance` | Result |
| --- | --- | --- |
| 101 | `/api-verification-summary` | Counts by recorded verification state with overlapping contract-gap counts |
| 102 | `/api-missing-permissions` | Operation records without a registered permission key |
| 103 | `/api-missing-request-schemas` | Operation records without a parseable object request schema |
| 104 | `/api-missing-response-schemas` | Operation records without a parseable object response schema |
| 105 | `/api-unlinked-screens` | Operation records without a registered screen association |

The summary filters operation records by exact app, role and screen association plus case-insensitive search before grouping. Limit/offset then page the groups, whose pagination total is verification states rather than operation count. Gap lists apply their predicate first and then the shared filters and paging. Default limit is 25; limit 1–100 and offset 0–100000 are accepted. Invalid/duplicate/unknown filters are rejected. Empty scopes return empty data; an unlinked record has no inferred app/role/screen association.

Responses contain data, pagination and source catalogVersion/evidenceType. The catalog is shared registered governance metadata, not live tenant business data. Active explicit bearer, non-null tenant, matching optional x-tenant-id and existing inventory authority are required. No-store, read-only repeatable-read session checks, source throttling and sanitized errors apply.

Gap detection describes declarations. A present permission key does not prove correct authorization; a parseable object schema does not prove completeness or validity; a page link does not prove implemented UI. Fixture labels do not establish database or production verification. These routes preserve false postgresVerified/productionVerified flags and never mark workflows or pages ready.

Governance registration scripts reproduce the five contracts before runtime generation. OpenAPI specifies queries and responses. Tests cover exact gap membership, counts before pagination, overlapping gaps, scope/search filtering, empty results, gateway forwarding, session/authority/tenant checks and source/error handling. Disposable PostgreSQL tests verify real UUID/text sessions and role/tenant denial; they do not prove domain business workflows.
