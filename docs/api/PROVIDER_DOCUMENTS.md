# Own provider document metadata (Batch 13)

| Method | Route | Result |
|---|---|---|
| GET | /v1/provider/documents | Paginated own credential-document metadata |
| GET | /v1/provider/documents/{documentId} | One own document's metadata or 404 |

ProviderDocument has no tenant column. Every query joins provider_profiles and checks profile id, actor user_id and profile tenant_id. This registered relationship is the tenant boundary. Active explicit bearer authentication and optional matching X-Tenant-Id are required. Presentation grants never bypass ownership. Other-provider, foreign-tenant and missing documents return 404.

Metadata fields: id, doc_type, status, expiry_date, verified_at, created_at and updated_at. Storage file_key and verified_by are excluded. Recorded status/verification dates do not certify validity or grant clinical authority. These routes do not serve files, generate signed URLs, upload or approve documents.

List accepts limit 1–100 and offset 0–100000, ordered by created_at and id descending. Detail accepts no query fields. Invalid IDs, unknown/duplicate query fields, owner overrides, bodies and mutation methods are rejected. Reads reuse provider source throttling, read-only repeatable-read transactions, no-store and existing gateway routing. Missing profile returns 404; ambiguous ownership or missing schema dependencies return generic 503.

No schema migration, UI changes or role grants. OpenAPI: provider-documents-batch-13.openapi.json. 164 local fixtures pass; four new fixtures cover join-bound owner/tenant/detail queries, projection, paging, 404, strict input validation and gateway forwarding. Four new disposable PostgreSQL checks per text/UUID auth identity variant cover real metadata, other-provider/tenant denial and empty pages. Production schema parity, secure file delivery and deployment remain separate checks.
