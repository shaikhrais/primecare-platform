# Owner status summaries (Batch 14)

`GET /v1/client/bookings/summary` returns booking counts grouped by status for the authenticated client's profile and tenant.

`GET /v1/provider/visits/summary` returns assigned visit counts and recorded duration minutes grouped by status for the authenticated provider and tenant. Duration is returned as an exact decimal string; it does not represent billable or completed time.

Both endpoints accept only bounded `limit` and `offset` parameters and return `groups` plus `pagination`. Pagination totals count status groups, not underlying records. Status ordering is ascending with null statuses last. Empty pages preserve the total group count.

Bearer sessions must be active and unexpired. Profile ownership comes from the session identity; caller-supplied owner, tenant and status filters are rejected. Responses are read-only and no-store. The literal summary path is reserved before identifier routes.

See `owner-summaries-batch-14.openapi.json` for response schemas. Registered screen links expose endpoint metadata through the governance page blueprint mechanism without promoting screen readiness.

Validation: 168 local API fixtures, worker TypeScript checking, PostgreSQL fixture syntax checking and governance guardian checks pass. Real PostgreSQL checks run in CI for text and UUID identity schemas. Local evidence does not assert PostgreSQL or production verification.
