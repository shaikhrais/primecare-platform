# Task 3 Commerce: additive draft requisition review

Status: PROPOSAL ONLY — not accepted policy, not a production migration, not a registered API or access grant. Prepared against source `c635640f`; no business data read and no provider/financial operation performed.

## Existing evidence

| Evidence | Exact source | Meaning and limit |
| --- | --- | --- |
| Global supplier records | `packages/database/prisma/schema/06_extensions.prisma:190` (`Supplier`; generated mirror `packages/database/generated/client/schema.prisma:1978`) | Supplier has id/name/contact/category/status and no tenant column. An active supplier is not automatically visible to every tenant. |
| Inventory price is Float | `packages/database/prisma/schema/06_extensions.prisma:204` (`InventoryItem`; generated:1992) | Inventory has tenantId, Float unitPrice, integer quantity; it has no currency, supplier relation or tax rule. Neither its price nor stock quantity establishes a purchasable catalogue. |
| Existing order is Float | `packages/database/prisma/schema/06_extensions.prisma:223` (`PurchaseOrder`; generated:2011) | totalAmount Float, supplierId/tenantId/status/poNumber; no line items, currency, actor ownership, receipt, revision or exact-decimal provenance. |
| Existing admin ERP host candidate | `packages/domain/src/registries/PageRegistry/hubs.ts:8` | `admin.erp`, `/platform/admin/erp/inventory`, source owner `admin`; not a pinned production permission receipt. |
| Existing procurement button candidate | `packages/domain/src/registries/ButtonRegistry/operations-buttons.ts:65`; role name at:8 | `btn-erp-po-create`, source role `operations_manager`; opens a modal and has no attached API option. |
| Existing host/button candidate link | `packages/domain/src/registries/PageActionRegistry/platform-actions.ts:25` | admin.erp lists btn-erp-po-create. This does not decide purchaser role or tenant supplier visibility. |
| Canonical-role discrepancy | `cloudflare/workers/src/api-execution-inventory.json` versus `packages/domain/src/registries/permission_registry.ts:17,28,162` and `packages/domain/src/apps/web-admin/RouteRegistry.ts:55` | Inventory role spelling is `ops_manager`, source registries use `operations_manager`; do not equate them without pinned role identity. |
| Existing draft operation candidate | API104 `POST /v1/admin/erp/purchase-orders`, `cloudflare/workers/src/api-execution-inventory.json` | Declared PRISMA/active but missing permission, requestSchema, responseSchema, screenLink; roles/screens empty. Other API391 supply-chain purchase route, API443 suppliers and API103 inventory also lack those bindings. No alternate route selected here. |
| Existing owner metadata reads | API16666–16670; `cloudflare/workers/src/client-self.ts`; `client-records-registry.json` | Read own ClientProfile inventory/order metadata with explicit tenant predicates. Not purchasing, supplier, catalogue or admin authority. Preserve these unchanged. |
| Existing shared card | `packages/primecare_ui/catalogs/application-modules.registration.json` | Commerce control775, but API bindings contain only API777 preferences. A shared card does not grant business access. |

Source evidence is not a replacement for fresh pinned production schema/role/screen/permission readback before registration or apply. Do not execute legacy SQLite register-owned-commerce-authoring-api.py against production.

## Smallest business decision set

Each row is a mutually exclusive choice; no choice below is silently accepted. The existing draft-only proposal remains `draft-unapproved`.

| Decision | Choice A | Choice B | Consequence |
| --- | --- | --- | --- |
| First purchaser audience/host | One exact pinned tenant-scoped admin role at existing admin.erp | One exact pinned operations-manager role at a reviewed host | Must resolve `operations_manager`/`ops_manager` to actual role ID and review exact screen/section/control; never grant both by name. No global/cross-tenant purchasing. |
| Supplier visibility | Keep existing global Supplier identity; add explicit per-tenant supplier allowlist (**recommended for preservation**) | Make suppliers tenant-owned by an additive reviewed ownership model | A preserves shared/legacy Supplier records and requires explicit adoption per tenant. B needs handling for suppliers legitimately used by multiple tenants; do not simply add NOT NULL tenantId to old global rows. |
| What a first draft means | Unpriced requisition: items/quantity only; no amount/currency | Server-quoted draft estimate in one explicitly approved currency, exact four-place decimal, no tax/payment/send (**candidate SQL supplied**) | A needs a different response contract from current CommerceDraftResponse. B requires an authoritative price owner/source and clear `amount = tax-exclusive estimate`, not a payable total. Neither finalizes a purchase. |
| Idempotent receipt lifetime | Retain immutable tenant+actor+key receipt while requisition exists; no deletion until a separate retention decision (**recommended first stage**) | Explicit finite receipt retention with approved duplicate-after-expiry behavior | A avoids accidental key reuse but is not indefinite retention approval. B cannot silently forget a receipt while a late retry can create another draft. No automatic cleanup policy invented. |

For quoted choice B, additionally confirm whether four decimal places match the actual inventory/quotation business model. The existing draft schema proposes Decimal(20,4)-equivalent strings; it is not an approved rounding/tax policy. If source prices have greater precision, refuse them until an explicit rounding rule exists; do not round silently. Supported currency set, authoritative price editor/importer, publication/revision policy and user role need exact values before a writer is implemented.

## Proposed additive storage (quoted choice B only)

The adjacent SQL is a review candidate, deliberately blocked outside an isolated fixture. Types assume existing TEXT IDs from inspected Prisma source; live identity/constraint discovery must confirm them before a real migration is authored.

1. `commerce_tenant_suppliers`: explicit tenant-to-existing-supplier visibility, status and revision. No old Supplier row modified or automatically adopted.
2. `commerce_catalogue_quotes`: tenant-owned item+supplier quotation, exact decimal unit price, explicit currency, publication state and revision. A composite FK to a tenant supplier membership prevents cross-tenant supplier use. The write transaction must independently validate that the existing InventoryItem belongs to the same tenant. Existing inventory Float prices are never copied automatically.
3. `commerce_draft_requisitions`: separate draft lifecycle, actor, tenant, supplier, one currency, exact estimate, immutable canonical payload digest and idempotency key. Unique tenant+actor+key is the receipt; old PurchaseOrder rows and poNumber allocation are untouched.
4. `commerce_draft_requisition_lines`: one unique item per draft; integer quantity, immutable quoted unit price/revision/currency snapshot and exact derived line estimate. No stock reservation/decrement, supplier send, payment, delivery or receiving state.

Separating draft requisitions avoids rewriting historical Float amounts as if they had exact decimal provenance. A future reviewed approval/conversion contract may create an actual PurchaseOrder with a distinct idempotent link; no conversion is supplied here.

## Transaction and receipt semantics to review

- Derive actor, active tenant and exact purchaser policy from the captured authenticated server session. Client-supplied identity, price, tax, total, currency or approval status is invalid.
- Validate item IDs/quantity (1–100 unique items, each integer1–10000), supplier ID and UUID key using strict duplicate-key/unknown-field/body-size rules. Canonicalize the accepted semantic payload using a fixed version and stable sorted item IDs; persist SHA-256 of those exact canonical bytes. Request order is not a business difference; duplicate item IDs are rejected, not merged.
- Claim tenant+actor+key inside the same transaction. An existing exact matching receipt returns the immutable original response, including its original quoted estimate, without repricing. Same key/different canonical payload returns409. Another actor or tenant never receives that receipt.
- Lock/revalidate the exact supplier membership and published tenant quote rows; verify each referenced InventoryItem is owned by the captured tenant. Reject missing, inactive, foreign, mixed-currency or otherwise unapproved source without disclosing which protected predicate failed. Source rows must remain locked until commit or use reviewed revision predicates.
- Use PostgreSQL NUMERIC/decimal-string arithmetic only; multiply exact quantity*unitPrice and sum. Each line and estimate must fit NUMERIC(20,4); overflow is an explicit rejected request/source condition, never conversion to Float or truncation. No FX or inferred currency/tax.
- Insert draft, all lines and immutable receipt atomically. A failed validation or audit rolls everything back; a committed receipt is durable before success. Unknown commit outcome returns an error and may only be retried with the SAME key/payload. No provider or external side effects exist.
- Return only approved draft response fields. Existing draft schema amount has four decimal places. Required quota/audit policy (counts/retention/definition IDs) is still a separate explicit approval; do not copy Help's policy or send item descriptions/prices/payload into audit by default.
- The proposed unique constraint handles simultaneous same-key requests, but final implementation must define its lock/statement timeouts and race resolution. After unique conflict/serialization failure, use a separate fresh transaction to read the exact matching durable receipt; do not query an aborted PostgreSQL transaction or blindly create another draft.

## Preservation, rollback and ordered next work

Preserve Supplier/InventoryItem/PurchaseOrder legacy rows, Float values, IDs, status, stock quantities, owner-read API contracts and all unrelated grants. Newly created tables start empty; nothing becomes visible or purchasable automatically.

Rollback before adoption: drop these four EMPTY proposed tables in reverse dependency order. Rollback after any draft exists: refuse destructive drop; disable new draft access through reviewed registration/feature policy and retain receipt/line evidence until an approved export/archive/retention decision. Never delete financial evidence merely to make rollback succeed. No ALTER COLUMN Float->Decimal is included.

Shortest order: (1) resolve the choices above; (2) read pinned live types and exact role/host IDs and verify source authority; (3) approve/register schema, source/publication and API104 contract/control/resource bindings; (4) implement the empty additive migration with independent readback; (5) implement atomic draft-only transaction/receipt and mandatory quota/audit; (6) bind approved shared host; (7) prove real PostgreSQL/API/browser/native denial/replay/concurrency/rollback before activation and device/human acceptance.

No production changes, model generation, tests, deployment, full feature credit or approval are claimed by this review package.
