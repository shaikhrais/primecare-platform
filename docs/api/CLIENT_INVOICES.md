# Invoice detail and summary (Batch 12)

| Method | Route | Result |
|---|---|---|
| GET | /v1/client/invoices/{invoiceId} | One own invoice or 404 |
| GET | /v1/client/invoices/summary | Own invoice totals grouped by currency and stored status |

Both endpoints derive the actor's client profile from user_id and tenant_id, then constrain invoices by client_id and tenant_id. No caller-selected owner/tenant is accepted. Explicit active bearer authentication, optional matching tenant header, client source throttling, no-store and repeatable-read read-only transactions apply. Foreign and nonexistent invoices return 404. Notes and payment processor identifiers are excluded.

Detail returns the same approved fields and exact decimal strings as the existing invoice list. Summary returns currency, status, invoiceCount, subtotal, tax and total for each group. Different currencies and statuses are never combined. Status is stored metadata; this endpoint does not infer outstanding balances, payment settlement or refund semantics. All sums remain PostgreSQL decimal strings.

Summary supports limit 1–100 and offset 0–100000 over groups, ordered by currency/status. pagination.total counts groups, not invoices; invoiceCount counts records within each group. An owner with no invoices receives an empty groups array. Detail accepts no query fields. The literal summary route takes precedence over the dynamic invoiceId route; that word is reserved.

No UI, schema migration, role grants or payment actions. Missing schema dependencies fail with generic 503. OpenAPI: client-invoices-batch-12.openapi.json.

160 fixtures passed locally. Four new fixtures cover detail ownership/projection/404, exact grouped sums and paging, strict validation and gateway forwarding. Four new PostgreSQL checks per text/UUID auth identity variant verify detail isolation, exact additions, separated currencies and group pagination. Production schema parity and deployment remain separate gates.
