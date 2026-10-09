# Owned client record status summaries

Batch 22 adds GET `/v1/client/consents/summary`, `/v1/client/service-authorizations/summary` and `/v1/client/waitlist/summary`.

Each requires an active explicit bearer session, a unique client profile owned by the actor and a matching tenant. SQL restricts both `client_id` and `tenant_id`. No caller-selected owner, table, status or date filters are accepted. No new role grants, mutations or UI changes are introduced.

Responses contain `groups` with stored `status` and integer `count`, plus bounded `pagination`. `limit` defaults to 25 (1–100); `offset` defaults to 0 (0–100000). Pagination total counts status groups, not source records. Groups sort by status with null last. Empty collections return an empty groups array and total zero. Counts and statuses are validated before output; unexpected data returns 503. Responses use `Cache-Control: no-store` and the existing source throttle.

These totals do not establish consent validity, remaining authorized or billable care, or appointments. Summary responses contain no notes, signatures, storage keys or authorization codes. Read-only repeatable-read transactions keep group totals and page data consistent.

Contracts and page-blueprint links are reproduced by `scripts/register-client-record-summaries-api.py`, invoked by workspace registration. See `client-record-summaries-batch-22.openapi.json` for schemas, examples and errors. Unit tests cover owner/tenant scope, null statuses, empty results, group paging, strict input, session/profile denial, invalid data and gateway forwarding. Disposable PostgreSQL checks cover multiple owned rows, other-client and other-tenant exclusion, grouping, pagination and empty results for UUID and text auth identity variants.

No migration is required for these reads. CI and authenticated deployment verification remain separate release gates; local fixtures do not mark production readiness.
