# Owned booking and payment reads — batches 23–25

| Batch | GET endpoint | Result |
| --- | --- | --- |
| 23 | `/v1/client/booking-requests/summary` | Counts by stored request status |
| 24 | `/v1/client/invoices/{invoiceId}/payments` | Payment metadata for one owned invoice |
| 24 | `/v1/client/invoices/{invoiceId}/payments/{paymentId}` | One payment attached to that owned invoice |
| 25 | `/v1/client/invoices/{invoiceId}/payments/summary` | Counts by stored payment status for that invoice |

Each endpoint requires an active explicit bearer session, a unique client profile belonging to the actor and matching tenant. The optional tenant header must match the actor. No new role grants or UI changes are introduced. Booking requests are scoped by `client_id` and `tenant_id`. Payments have no tenant column: ownership is enforced by joining the registered invoice relation, binding invoice ID, client ID and tenant ID in every payment query. Detail additionally binds the payment ID. Missing and foreign invoices/payments return 404. Empty owned invoices return an empty list or groups array.

The payment projection contains only `id`, exact decimal-string or null `amount`, nullable stored `status`, `created_at` and `updated_at`. Processor IDs are excluded. No payment currency is assumed or added; an invoice currency does not establish the meaning of a payment amount. No settled-payment, refund, eligibility or booking-approval judgment is derived from stored statuses. These endpoints do not create, charge, cancel or refund payments.

List and summary queries accept only `limit` (default 25, 1–100) and `offset` (default 0, 0–100000). Duplicate/unknown parameters, GET bodies, malformed IDs and writes are rejected. Payment detail accepts no query parameters. Payment lists sort by creation time then ID descending. Summaries sort stored status with null last; pagination total counts groups, not records. Responses use `Cache-Control: no-store`, the existing source throttle and read-only repeatable-read transactions. Malformed projected data fails closed with 503.

For example, a summary may return `{"groups":[{"status":"pending","count":2}],"pagination":{"limit":25,"offset":0,"total":1,"hasMore":false}}`. A payment detail may return `{"payment":{"id":"payment-id","amount":"100.1000","status":"pending","created_at":"2026-01-01T12:00:00Z","updated_at":"2026-01-01T12:00:00Z"}}`.

`scripts/register-booking-payment-reads-api.py` validates registered database columns and reproduces all four contracts and links to the existing client-profile screen before implementation. Workspace registration invokes it; the API execution-status inventory records batches 23–25. See `booking-payment-batches-23-25.openapi.json` for schemas and error responses.

Unit tests exercise strict inputs, owner/tenant/profile/session checks, exact decimal strings, nulls, invalid data, error masking and gateway-to-service routing. Disposable PostgreSQL CI checks aggregation and pagination, empty results, foreign tenant/client invoices, payments attached to a different invoice, decimal preservation, expired sessions and inactive actors for both UUID and text auth identities. No migration is needed. CI, deployment and authenticated production verification remain distinct gates.
