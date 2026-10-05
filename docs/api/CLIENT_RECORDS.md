# Client-owned consent, authorization and waitlist metadata

Six GET endpoints use the authenticated client's unique profile and tenant:

| List | Detail | Response collection / item |
| --- | --- | --- |
| /v1/client/consents | /v1/client/consents/{recordId} | consents / consent |
| /v1/client/service-authorizations | /v1/client/service-authorizations/{recordId} | authorizations / authorization |
| /v1/client/waitlist | /v1/client/waitlist/{recordId} | entries / entry |

Consent metadata includes form type, stored status, signed/expiry timestamps, template version and creation/update timestamps. Signature data, storage keys and witness identity are excluded. Stored status is not a legal validity assessment.

Service authorizations expose service ID, funding source, recorded authorized/used hours, dates, status and timestamps. Authorization codes and notes are excluded. The API does not calculate remaining hours, eligibility, prices or billable care.

Waitlist entries expose service ID, priority, stored status, requested start and creation timestamp. Notes are excluded. Being on a waitlist does not create an appointment.

Every table and projected field is checked against the registered database column inventory before generating the runtime catalog. Runtime SQL uses only those catalog identifiers, while caller input is confined to bound values. Both client_id and tenant_id are required in list/detail queries. Detail also binds the exact record ID. Numeric and required fields are validated before serialization; malformed stored projections fail closed with 503.

List paging accepts limit 1–100 (default 25) and offset 0–100000 (default 0). Stable ordering is created_at DESC, id DESC. Empty offset pages preserve the total. Detail rejects query parameters. Malformed IDs, duplicated parameters, owner/status overrides and request bodies return 400. Mutations return 405. Missing profiles or absent/foreign records return 404. Tenant mismatch returns 403; invalid sessions return 401. Reads retain source throttling, read-only repeatable-read transactions and no-store responses.

The reproducible registration script adds six contracts to the existing client profile screen for governance page blueprints. See `client-records-batch-21.openapi.json`. No role grants, database changes, clinical signing or authorization mutations are added.

Validation: 239 local API fixtures pass, including field projection, tenant/owner SQL bindings, access denial, invalid inputs, source limits, backend errors, gateway routing and corrupt stored fields. PostgreSQL tests cover each table's same-tenant other client, foreign-tenant row with the same client ID, detail denial, stable pagination and empty results for both auth identity types. PostgreSQL CI and production verification remain separate from local evidence.
