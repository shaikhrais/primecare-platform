# Own client profile and invoices (Batch 7)

| Method | Gateway route | Scope |
|---|---|---|
| GET | /v1/client/home/profile | The bearer actor's client_profiles row with the same tenant |
| GET | /v1/client/invoices | Invoices belonging to that profile and tenant |

These endpoints use the registered client_profiles.user_id ownership relationship. An active explicit bearer session and matching tenant are required. Screen grants do not override ownership. No arbitrary userId/clientId/tenantId is accepted. Cookie-only credentials fail. No profile returns 404; ambiguous profiles fail closed. Invalid methods return 405 with Allow: GET. Existing registered POST entries are not implemented by this batch.

Profile returns id, full_name, city, province, postal_code and updated_at. It excludes birth date, emergency contacts, coordinates, free-form preferences and clinical relationships. Invoice returns id, status, currency, subtotal, tax, total and timestamps; payment-processor identifiers and unrelated invoices are excluded. Monetary values are exact decimal strings. Missing schema dependencies return generic 503 rather than synthetic success or an empty dataset.

Invoice pagination accepts limit 1–100 and offset 0–100000, ordered by created_at and id descending. Both queries use read-only repeatable-read transactions, no-store responses and the client source rate-limit namespace 2026100403 (120 per 60 seconds). Gateway forwarding uses the existing client service prefix.

No production migration is added: table and column definitions come from the registered domain schema and Prisma ClientProfile/Invoice models. Disposable CI creates representative domain tables and verifies real owner/tenant isolation, decimal amounts, missing profiles, deactivation and pagination for text/UUID auth identities. These fixtures do not establish production schema parity or deployment readiness.

138 fixture tests pass locally. Seven additional PostgreSQL checks per identity variant run in CI. OpenAPI: client-self-batch-7.openapi.json. No UI or role grants changed.

Remaining: provider and broader clinical policies, domain mutations, legacy unscoped routes, full domain schema validation and production smoke tests. These owner-bound reads do not make those workflows complete.
