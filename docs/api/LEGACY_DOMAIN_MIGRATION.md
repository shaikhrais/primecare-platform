# Legacy Worker domain migration (Batch 17)

The TypeScript service Worker previously executed unauthenticated, unscoped SQL for 10 legacy operations. Some queries also used table or column names that do not match the current schema. Those handlers are now disabled before body parsing, database connection or SQL. Governance keeps their business implementation status `blocked`; passing guard tests does not make these workflows complete.

## Changed contract

The worker paths below return 501 with `{"error":"Legacy domain operation is not implemented securely","status":"not_implemented","code":"legacy_domain_disabled"}` for their historical methods. Other methods return 405 with Allow. All guard responses are no-store. Service CORS handles OPTIONS before the guard. The same denial applies to anonymous and bearer callers; no permission can enable an unsafe legacy handler.

| Service | Worker path | Historical methods | Secured APIs for narrower use cases |
| --- | --- | --- | --- |
| client | /api/clients | GET, POST | /v1/client/home/profile reads the caller's profile |
| provider | /api/providers | GET | /v1/provider/profile reads the caller's profile |
| provider | /api/providers/{providerId} | GET | /v1/provider/profile reads the caller's profile |
| visit | /api/visits | GET, POST | /v1/client/visits or /v1/provider/visits reads owned/assigned visits |
| billing | /api/invoices | GET | /v1/client/invoices reads owned invoices |
| scheduling | /api/schedules | GET | /v1/client/bookings and /v1/provider/availability supply scoped scheduling data |
| compliance | /api/compliance/audits | GET | Domain compliance workflow pending |
| compliance | /api/compliance/findings | POST | Domain compliance workflow pending |

These are not equivalent drop-in replacements: versioned self APIs return projected, scoped, paginated objects. Tenant-wide lists, client creation, visit creation and compliance findings need separately governed authorization, validation, audit and database contracts. Do not rewrite callers to broad access or fabricate success. Migrate read callers only where their intended semantics are personal ownership/assignment. Write callers must handle the explicit pending response until secure write workflows are implemented.

The gateway forwards `/v1/{service}{workerPath}` (for example `/v1/billing/api/invoices`) to these Worker paths. The OpenAPI artifact describes service-relative Worker paths; it does not introduce new gateway aliases.

The reproducible registration script inventories all legacy operations and generates `legacy-domain-registry.json`, the runtime deny catalog, from governance.db. It also links blocked contracts to existing screens for page blueprints, preserving missing-work visibility and screen readiness.

## Validation and scope

196 local API fixtures pass, including all 10 historical operations with anonymous and bearer callers, invalid write bodies, method denial, service/path matching, gateway forwarding and secured self API authentication. A database adapter that throws on connect proves no legacy request reaches SQL. Worker TypeScript checks and governance guardian pass. PostgreSQL CI remains a separate gate for the secured APIs; guard fixtures require no database.

This change covers `cloudflare/workers/src/service.ts`. The separate historical container runtime is outside this batch and still requires an audit before use. No deployment or UI changes are included.
