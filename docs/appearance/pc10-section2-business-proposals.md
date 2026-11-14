# Section 2A: four concrete business contract proposals

Status: **DRAFT — unapproved and not implemented or activated.** Together with the Help proposal, all five domains now have concrete proposed behavior and decisions to review. This is contract preparation, not five working business modules. No production rows, permissions, provider accounts or host mappings are changed.

## Recommended first implementation scopes

| Domain | Proposed first scope | Existing operation evidence | Still required before implementation |
| --- | --- | --- | --- |
| Help | PSW-only, tenant-published EN/FR/ES guide reads | API794 POST `/v1/psw/help-support`, screen685, reusable control779 | Approved published/versioned content source, exact role/screen/section/element/API permission mapping and operational policy |
| Academy | Own assigned modules and own recorded progress; read only | API279 POST `/v1/user/training/catalog`; API280 POST `/v1/user/training/my-progress` | Approved staff/provider-to-user mapping, exact audience/host/permission and localized/published content; no certification or completion write inferred |
| Commerce | Tenant-owned local draft requisition; no supplier order or payment | API104 POST `/v1/admin/erp/purchase-orders` | Purchaser/supplier/item authority, catalogue/prices/currency/tax source and reviewed exact-decimal/line-item/receipt/revision model |
| AI-chat | Unbound text-only protocol; no tools, private-record retrieval or business mutation | No approved canonical chat API.308–310 are analytics;408 is support | Actual governed chat identity, host/participants, provider/model/account, data/retention policy and budget; no nearby operation silently repurposed |
| Finance | Tenant-authorized read-only ledger projection | API1122 GET `/v1/premium/transactionledger` | Exact financial-reader role/host/resource scope and visible-field mapping; existing owner-read/Founder Growth authority stays specific |

Source: recorded pinned production read43535550518/job132265141091/source9f65531b. The candidate Academy, Commerce, Help, analytics/support and generic ledger declarations lack request/response schemas and exact permission/host bindings in that evidence. Existing API16475 Founder Growth finance has a specific contract; it does not grant general finance access. The companion JSON records source/model hashes and all proposed wire schemas; it creates no new endpoint identities.

## Concrete requests and responses

The JSON has strict Draft2020-12 schemas and positive/negative examples for every proposed request/response. Unknown properties and client tenant/user/role/permission/provider-key selectors are rejected. Paging, identifiers, Unicode, exact money strings, fixed read/draft actions, timestamps and error envelopes are bounded. A syntactically correct scope still needs independent server authorization and client session comparison.

| Proposed wire shape | Example request | Response |
| --- | --- | --- |
| Academy assigned catalogue, API279 | `{"version":1,"action":"list_assigned","locale":"en","offset":0,"limit":25}` | Captured live self scope, locale, assignment/module IDs and title, stored state/dates, bounded count/page |
| Academy own progress, API280 | `{"version":1,"action":"read_progress","locale":"fr","assignmentId":"assignment-1"}` | Same independently owned assignment projection; no certification approval or new write |
| Commerce local draft, API104 | `{"version":1,"action":"create_draft","supplierId":"supplier-1","idempotencyKey":"00000000-0000-4000-8000-000000000001","items":[{"itemId":"item-1","quantity":2}]}` | Tenant-scoped draft ID/revision, server-resolved supplier/currency/exact four-place decimal amount; no supplied total or approved/sent/paid state |
| AI text protocol, **unbound** | `{"version":1,"requestId":"00000000-0000-4000-8000-000000000002","locale":"en","message":"Synthetic product help question"}` | Same request/locale/self scope, bounded reply, toolsExecuted0; no fabricated provider reply on error |
| Finance ledger query, API1122 | `version=1&offset=0&limit=25` | Exact scoped ledger projections with decimal-string amount, source currency/state/time and bounded page/count; no totals across currencies |

All examples are synthetic. JSON Schema does not validate duplicate JSON keys, transaction isolation, database ownership, actual actor identity, provider outcome or body-byte limits by itself. Those server/client checks are explicit requirements in the JSON and remain unimplemented.

## Source and model constraints

**Academy:** TrainingModule has tenant/title/description/category/video URL but lacks publication/locale/revision. TrainingAssignment has optional providerId/staffId; neither alone proves which authenticated user owns it. A proposed read must independently resolve the existing actor relationship and join through a current-tenant module. Ambiguous mappings deny. Name matching is not authorization. Stored completion state does not certify competence, expiry or renewal. Existing management write methods are not authorization for a new host.

**Commerce:** PurchaseOrder has tenant/supplier and a Float total but lacks exact-decimal amount, currency/tax, line items, revision and idempotent receipt. MarketplaceListing's nullable tenant/category is not an approved purchasable catalogue. The proposal needs a reviewed data-source/migration before implementation. Local draft creation would be atomic and tenant+actor+key scoped: identical replay returns its receipt; changed payload with the same key409. It does not send an order or create a payment. Supplier effects and approval transitions need separate contracts.

**AI-chat:** No canonical chat operation has been established. Therefore the proposal specifies a protocol without adding a path, API number, role or route. Initial text input is capped at4000UTF-16 units and reply5000; body/response byte limits and provider token/spend budgets are separate. Proposed current-session ephemeral data has no transcript cache. Actual participant/retention/provider/model/account/data policy must be agreed before a handler. A timeout with unknown paid-provider outcome cannot automatically create a duplicate request.

**Finance:** TransactionLedger has tenantId, immutable source records and Decimal(20,4) amounts; the proposed wire uses exact four-place strings. Stable createdAt/id ordering and snapshot-consistent rows/count prevent inconsistent pages. No floating-point conversion, inferred currency, IP metadata, unreviewed checksum assurance or cross-currency sum is exposed. Existing LedgerService write methods and Invoice/Payment models do not confer generic read/write authority. Payment/reversal/tax/period-close policies remain separate.

Each module's JSON includes authentication/authorization, persistence, state transitions, provider rules, validation, error, rate/audit policy, shared-client binding and required database/browser/native acceptance. Exact quota values/source, audit identifiers/retention and host mappings remain explicit decisions, rather than fictional approved settings. Reads use no-store, captured live identity, revocation checks and no private path-only cache or synthetic success. Required quota/audit failures return errors. Shared factory registration alone grants nothing.

## Academy false-success defect repaired during recovery

TrainingService previously fabricated successful certificate verification, compliance figures, activity records, curricula and certificate lists when Prisma/Accelerate errors occurred. Repair source `6347290414d5cbb7a6e8eea0c0293e877f8cd73a` removes those five inner fallback blocks. The existing Result.guard now preserves database failures. Successful queries, tenant predicates/results and mutation methods retain their prior behavior. This repair does not make the incomplete certification policy or assignment-write authority approved.

The68-case regression script independently executes pinned old source96ee5d1/blobd663ccf7 and reproduces synthetic success before checking corrected synchronous/asynchronous/partial-query failures, real success/empty/expired outcomes, and unchanged scoped queries. Local68/68PASS and exact-source GitHub43555533770/job132327428987SUCCESS; downloaded logs independently confirm68/68cases and the pinned old-source control. These are controlled dependency tests, not live database or external certificate verification. The separate APIclient repair43553547629 is now5/5SUCCESS; downloaded Mac132321173811 confirms the old-source regression then1557shared/transport+11host testsPASS. Contract review43554180918 is2/2SUCCESS; the source634 contract43555533799 also passed. Broader cross-batch native closure retains its own queued Mac gate until it actually passes.

## Reproduction and next gate

- `python3 docs/appearance/pc10-section2-validate-help-proposal.py --check`:32 synthetic Help cases.
- `python3 docs/appearance/pc10-section2-validate-business-proposals.py --check`:121 synthetic cases and4 exact recorded operation identities; AI intentionally has no bound operation.
- `node --test scripts/test-training-failure-boundary.mjs`:68 actual service/control cases; esbuild0.27.2 dependency. CI includes this in the existing API caller workflow.

The two-part plan remains2A preparation/failure repairs, then2B agreed implementation. Before2B, select the first scopes above and resolve each module's exact authority/source/provider decisions. Only then reconcile approved metadata/models and implement the shared host/service. Actual PostgreSQL/API ownership, denied/cross-tenant, replay/reload, browser/native and required device/human proof remain distinct. No schema-example pass or removed mock marks a module complete.
