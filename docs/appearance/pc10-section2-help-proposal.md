# Section 2: first Help contract proposal

Status: **DRAFT — not approved, registered, implemented or activated.** This proposal is a reviewable business choice, not permission to expose data. Section 1 remains complete; Section 2 remains open.

## Recommended first scope

Start with **read-only, tenant-published Help articles for PSW users**, using existing endpoint identity **API 794, POST /v1/psw/help-support**, existing screen **685, psw_help_support**, and the registered shared Help factory/control **779** only after their exact host, section/element and permission bindings are reconciled. The method and path are preserved as a proposal; they do not already establish list/read semantics. No new API, route or permission is registered by this document.

The first version would list and read approved articles in EN/FR/ES. It would not create tickets, start a chat, send messages, call a provider, certify training or claim that a support service is available. Support ticket/chat is a different business choice with additional membership, assignment, retention and provider requirements.

## What the source actually establishes

- Recorded pinned production discovery: source `9f65531b43a6bb3be0942acc8203f6e9c41fef63`, run **43535550518**, job **132265141091**. API 794 is POST, requires authentication, has **no request schema, response schema, permission key, rate-limit key or linked screen**. Its 64 legacy grant rows do not match an endpoint permission key; they are not an approved role policy. Role **51 psw** and screen **685 psw_help_support** exist and are active. Tenant Admin is not inferred from those legacy rows.
- `packages/primecare_ui/catalogs/application-modules.registration.json` registers reusable Help control **779**. Its absence of a business API binding remains an absence; the shared component is not a grant.
- `FAQ` in `packages/database/generated/client/schema.prisma` has id/question/answer/category/timestamps, but no tenant, locale, publication or revision fields. It cannot safely be treated as a published tenant knowledge base without a reviewed migration or another approved source. Existing rows must never become published by default.
- `SupportTicket` has tenant/office/status/resolution but no requester identity or message membership. It cannot establish ownership of a ticket feed. The registered support-submission form targets **/v1/staff/tickets**, not API 794; those declarations are not silently aliased.
- `provider_messages_support` in `docs/api/workflow-contract-reviews.json` explicitly requires a reviewed workflow contract for API 794. No canonical equivalent was established.

## Concrete wire proposal

The accompanying OpenAPI 3.1 file defines strict list/read request variants, bounded pagination and text, locale, a captured self/tenant/role/live scope, plain-text article projections, and error envelopes. The synthetic examples contain no credentials or actual business data. Unknown properties, client-supplied actor/tenant selectors, writes, negative paging and oversized input are rejected. UTF-16 limits match the existing shared Dart/TypeScript projection limits; the `x-utf16MaxCodeUnits` keyword requires the documented server check as well as ordinary JSON Schema validation.

List request:

```json
{"version":1,"action":"list","locale":"en","query":"account","offset":0,"limit":25}
```

Read request:

```json
{"version":1,"action":"read","locale":"fr","articleId":"guide-account"}
```

The proposed success response must echo the authenticated self scope and locale; clients compare it to the captured session before rendering and discard late replies after account/tenant/token changes. List summaries are bounded; full bodies are returned only by the read variant. No action buttons are created from article content. Text is rendered as text, not HTML or an unreviewed URL.

## Sixteen required contract slots

| Slot | Proposed behavior / remaining decision |
| --- | --- |
| Request | Strict versioned JSON list/read union; body cap4096 UTF-8 bytes; query≤100 UTF-16 units; limit1–100, offset0–100000; IDs1–200 ASCII identifier characters; unknown/repeated JSON keys rejected. No actor, tenant, role, dataset or permission selector. |
| Response | Strict list/read union in the companion OpenAPI; ≤100 summaries, title≤500/body≤5000 UTF-16 units; exact self scope and requested locale; bounded safe total; Cache-Control:no-store. No contacts, live-chat availability or private support records. |
| Validation | UTF-8 byte cap before JSON parsing; reject duplicate keys, invalid JSON, unsupported content type and unknown fields; trim query for matching without altering article IDs; no executable HTML; locale must be en/fr/es. Server cross-field checks require response action/locale/paging to match the request and total≥offset+returned length when rows are present. |
| Authentication | Existing bearer session only; active unexpired user and active tenant; no new login, cookie precedence or service impersonation. |
| Authorization | Proposed PSW-only educational read of explicitly published current-tenant articles in the exact requested locale. Revalidate active session/role/grant before the scoped read; missing or conflicting identity denies access. Other-tenant or unpublished detail returns404 without disclosure. Tenant Admin/HSW/customer-support access is not assumed. |
| Permission | **Unresolved:** reconcile existing role51 and screen685 visibility, exact host section/element mapping, API794 grant/key and screen_api_links before exposure. Permission-key value and migration must come from reviewed governance; no blanket64-role activation. |
| Rate limits | Proposed30 reads/minute per tenant+actor with a separately reviewed source quota, using the established distributed quota store. 429+Retry-After on exhaustion; store outage503, never fallback success. Exact source quota is an explicit review dependency. |
| Audit | Proposed help-read/denied operational audit with actor/tenant/API/article ID/revision/status/server UTC/correlation ID only; exclude token, query text and article body. Audit identifiers/readers/retention need governance review; proposed retention30 days is not an existing policy. Required audit failure returns503. |
| Errors | 400 invalid_request,401 unauthenticated,403 forbidden,404 not_found,409 conflict,429 rate_limited,503 unavailable, all with the companion strict envelope and no SQL/stack/secrets. Malformed transport/response is failure; no fabricated contacts or cached success. |
| Version | Wire version1; preserve registered POST identity pending review. Read-only semantics must be accepted explicitly before mapping the legacy operation. No new GET alias or silent replacement of an existing caller. |
| Workflow | List/read only, with server-side publication+tenant+locale filters. Missing translation is an empty list/404, not another tenant's content or a silent locale substitution. Publication, editing, tickets and chat stay out of scope. |
| Persistence | **Unresolved:** approved tenant/locale/publication/revision source. Existing FAQ.question→title, FAQ.answer→body and FAQ.category are candidate mappings only. A migration/source review must establish tenant ownership, publication, locale and revision before any existing row is readable. No migration or data write is included here. Stable ID ordering and snapshot-consistent rows/count. |
| Idempotency | No business mutation; an idempotency key is not accepted. Retrying a read may append a separately correlated operational audit, never an article/ticket/chat mutation. |
| Tests | Wrong tenant/role/owner/locale; unpublished records; legacy-grant conflict; revoked session during read; duplicate/unknown/oversized fields; Unicode bounds; first/last/empty page; publication/revision race; quota/audit failure; real PostgreSQL query isolation; actual EN/FR/ES browser/native host refresh/logout/keyboard/accessibility. These are required future tests, not claimed passes. |
| Client binding | Existing registered Help factory only after exact screen/API/control/locale mappings pass review. Reuse shared guarded transport, work-session scope, cancellation and loading/empty/denial/error states; no mutation actions or path-only cache. No route or UI capability is enabled by this proposal. |
| Examples | Mechanically validated synthetic positive and negative examples in the companion proposal JSON. Validation proves schema consistency only; it does not prove approved business policy, a live handler, database acceptance or human review. |

## Decisions needed before implementation

1. **Help scope:** A — published read-only guides first (recommended); B — tickets/live chat first (requires a separate requester/assignee/member/provider contract).
2. **Audience:** proposed existing PSW role51 on existing screen685 only. Additional audiences require explicit reviewed roles/hosts; do not inherit legacy broad grants.
3. **Content authority:** approve a tenant-published, versioned EN/FR/ES article source and publication owner. Decide whether to migrate FAQ or bind another existing governed source; do not auto-publish historical rows.
4. **Operational policy:** review exact quota/audit/retention and governance permission/host migration. Mechanical permission naming and migration follow the accepted policy; no grants are changed here.

The API-client false-success repair is independent: failed declared requests must stay failures regardless of which Help scope is eventually selected. It does not implement this proposed Help service.
