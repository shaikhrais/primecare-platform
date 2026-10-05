# Visit and document status summaries (Batch 15)

`GET /v1/client/visits/summary` returns counts grouped by the stored status of the authenticated client's visits. Both client profile and tenant must match.

`GET /v1/provider/documents/summary` returns counts grouped by the stored status of the authenticated provider's documents. Provider documents have no tenant column, so the query joins provider profiles and binds provider ID, tenant and user identity. Counts do not infer license validity or compliance.

Both responses contain `groups: [{status, count}]` and `pagination: {limit, offset, total, hasMore}`. Total counts status groups. Null statuses form a distinct group ordered last. Empty results return an empty group array and total zero; an offset beyond the last group preserves the total.

Only `limit` (1–100, default 25) and `offset` (0–100000, default 0) are accepted. Unsupported filters, repeated parameters and bodies receive 400; writes receive 405. Summary paths are reserved before identifier matching.

Authorization requires an explicit active, unexpired bearer session, a unique owned profile and matching tenant. Missing profiles return 404, ambiguous profiles and backend errors return 503. Reads use repeatable-read transactions, source throttling and no-store responses. No additional role grants or write audit events are introduced.

The registration script links both contracts to existing profile screens for governance page blueprints. See `visit-document-summaries-batch-15.openapi.json`. Screen readiness remains unchanged.

Validation: 174 local API fixtures, worker TypeScript checking and governance guardian checks pass. Real PostgreSQL coverage includes ownership, tenant isolation, null statuses, empty results and pagination in the text/UUID auth identity CI matrices. Local test evidence does not claim PostgreSQL or production verification. Legacy domain routes and broader business write workflows remain separate outstanding work.
