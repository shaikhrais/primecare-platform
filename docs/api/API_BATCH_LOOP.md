# PrimeCare batch continuation loop

Each iteration starts from current main. Inspect the declaration and its real schema/authority, implement a bounded related family, write request/response contracts and tests, regenerate the inventory, then run local fixture, TypeScript and governance checks. Publish a PR only after those checks pass. Merge only after that PR's unchanged head passes UUID/text PostgreSQL CI and security scanning. Record the merged checkpoint before starting the next iteration. An unreviewed model or action is not automatically made accessible.

## Iteration 1 — merged

Batches 225–235 implement actor-authored post metadata, actor ledger-event metadata, client-profile-linked inventory metadata and purchase-order metadata. Four existing premium GET declarations are repaired through the canonical owner-scoped handlers. The explicitly registered clientProfileId owner column is quoted in PostgreSQL. Article contents, accounting details, SKU/quantity/prices and supplier/order amounts are excluded. No new grants or business writes.

Local checks: 1,613 API fixtures, five authority-preflight regression tests, Worker TypeScript and governance delta guardian pass. Dedicated disposable PostgreSQL tests are included in both identity jobs; Exact-head UUID/text PostgreSQL CI and security scanning passed; merged in PR #100 (c0ba6bfabea984eea72b526fec80843c7b6042a6). No deployment or production database changes.

Inventory: 1,410 declared operations; 323 have local fixture evidence, 1,077 are verification pending, 10 are blocked. Pending is an evidence gap, not proof that every declaration lacks code. Before this iteration the 1,081 pending declarations comprised 818 POST actions and 263 GET reads. This iteration repairs four GET declarations while adding 11 canonical operations with local fixture coverage.

## Iteration 2 — merged

Batches 236–241 implement six canonical patient observation metadata operations and repair the existing VitalSign/MAR compatibility reads, using the explicit patient_id relations in vital_signs and mar_entries. VitalSign has no tenant column and requires the current unique actor-owned ClientProfile tenant bridge in every record query. MAR_Entry must use patient_id, not its unrelated bare client_id, and exclude null/mismatched recorded tenants. Stable order uses recorded_at and admin_time. Summaries count stored type/status groups; no medication contents or administration claims. New typed summaries reject null labels where the registered schema requires a string. Do not implement unreviewed writes from generated declarations.

Full completion requires the outstanding business-action contracts, authenticated UI workflow evidence and current release/migration/performance evidence. This document never promotes release gates or asserts production readiness.

Iteration 2 exact-head UUID/text PostgreSQL and security CI passed; merged in PR #101 (bd9146c49d173a281c7dcea90b728ce92645eca1).

Current local checkpoint: 1,653 API fixtures pass. Inventory: 1,416 declared operations, 331 with local fixture evidence, 1,075 pending and 10 blocked. The two loop iterations add 17 canonical operations and repair six existing declarations. Production verification remains separate.

## Iteration 3 — compatibility authority hardening, merged

All 72 reviewed compatibility reads now require the canonical declaration to retain its exact service, active-bearer requirement and existing ownership permission before their schemas and links can be copied. A real-generator regression injects three types of canonical drift after earlier aliases have been processed, checks transaction rollback, and verifies that generated artifacts remain unchanged. This hardening does not add operations or reduce the pending declaration count. Local API fixtures and six Python regression tests pass. No release gates are promoted.

Iteration 3 exact-head UUID/text PostgreSQL CI and security scanning passed; merged in PR #102 (a73a5f0608a38d1bc2588880f420a8af364c9087).

## Iteration 4 — existing authentication contracts, merged

Batches 242–247 reconcile six existing declarations with their real authentication handlers: account management, GET/POST session identity, policy-restricted account creation, own password change, and the legacy account-list declaration. Service labels, contracts and existing screen links are repaired without deleting declarations, enabling inactive pages or changing grants. Session identity accepts bearer or cookie and ignores body/query; mutations require explicit bearer. Password contracts describe actual UTF-16 and UTF-8 bounds. The existing disposable PostgreSQL lifecycle suite now traverses the public gateway and real handlers together.

Local evidence: 1,677 API fixtures, seven Python authority regression tests, TypeScript and governance guardian pass. Inventory: 1,416 declarations, 337 with local fixture evidence, 1,069 pending and 10 blocked. Remaining pending methods: 814 POST and 255 GET. Every remaining pending declaration lacks registered permission and request/response contracts; implementing these requires the actual business rules and authority, not a generated route name. No release gates are promoted and no deployment is claimed.

Iteration 4 unchanged-head UUID/text PostgreSQL CI and security scanning passed; merged in PR #103 (73e9bb62a40792fcfddffdcc4bcd8ce80378c6b6). Four iterations are now merged through batch 247. The continuation loop remains a reviewed execution process, not an unattended job that invents contracts or runs after a chat turn.


## Iteration 5 — batch 248, maintenance payload bounds

Maintenance configuration and test-email POST bodies now enforce the existing 50,000-byte limit while reading the stream. Previously the fallback check counted UTF-16 characters after reading the entire body, allowing oversized multibyte payloads and unbounded buffering. Declared oversized requests reject before reading; chunked or understated-length bodies stop at the first chunk exceeding the limit. Rejections return no-store 413 before database access. JSON parsing still requires an object.

Ten new focused regressions cover both routes: UTF-8 oversize, stream cancellation, exact byte boundary, split multibyte decoding and malformed JSON, and early declared-length rejection. Existing tenant and maintenance-role authorization is retained. This hardening adds no endpoint declarations and does not reduce the 1,069 pending contract declarations. Remote unchanged-head PostgreSQL and security CI must pass before merge.
