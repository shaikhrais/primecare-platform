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


## Iteration 5 — batch 248, maintenance payload bounds, merged

Maintenance configuration and test-email POST bodies now enforce the existing 50,000-byte limit while reading the stream. Previously the fallback check counted UTF-16 characters after reading the entire body, allowing oversized multibyte payloads and unbounded buffering. Declared oversized requests reject before reading; chunked or understated-length bodies stop at the first chunk exceeding the limit. Rejections return no-store 413 before database access. JSON parsing still requires an object.

Ten new focused regressions cover both routes: UTF-8 oversize, stream cancellation, exact byte boundary, split multibyte decoding and malformed JSON, and early declared-length rejection. Existing tenant and maintenance-role authorization is retained. This hardening adds no endpoint declarations and does not reduce the 1,069 pending contract declarations. Local validation: 1,687 API fixtures, seven authority regressions, Worker TypeScript and governance guardian passed. Unchanged-head UUID/text PostgreSQL and security CI passed in run 37541406409. PR #104 merged as 1a26135ad4eec11318ba866958810be9a4960c21. Latest completed batch is 248. Production deployment and the remaining contract backlog are separate.


## Iteration 6 — batches 249–253, CEO read projections, merged

| Batch | Existing GET operation | Change |
| --- | --- | --- |
| 249 | /v1/admin/users | Explicit account projection discards unexpected adapter fields; validates required fields and nullable updated date. |
| 250 | /v1/admin/users/{userId} | Validates account details without coercion; preserves the registered nullable role/status contract. |
| 251 | /v1/admin/users/{userId}/sessions | Validates session dates and target identifier; rejects missing, malformed and infinite timestamps. |
| 252 | /v1/admin/users/audit | Validates audit identifiers, date and allowed action; keeps the existing safe-state projection. |
| 253 | /v1/admin/users/creation-audit | Validates creation audit identifiers and date while returning only persisted creation events. |

All five operations retain existing CEO, active-bearer and tenant restrictions. Invalid projected rows return sanitized no-store 503 and roll back. Tests cover unexpected fields, invalid types, calendar dates, PostgreSQL Date instances, and registered nullable values. The PostgreSQL suite adds five real infinity-timestamp rejection checks per identity type. Contract registration preflights the entire family, including both account-list declarations, before the first write; drift regression covers all five routes and the legacy list. This improves existing verified reads; declarations remain 1,416 with 337 local-fixture records, 1,069 pending and 10 blocked. Unchanged-head PostgreSQL and security CI passed before merge.

Local validation: 1,695 API fixtures, eight Python authority regression tests, Worker TypeScript and governance guardian passed. Unchanged-head UUID/text PostgreSQL and security CI passed in run 37542800970 at 71e317df27a14c8045859518c4b0b478eb00f468. PR #105 merged as 9d302e1db0a79c4a93bb7e24b6d235ad7a92567e. Latest completed batch is 253; next batch is 254. No deployment or production database changes.


## Iteration 7 — batches 254–258, authentication body bounds, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 254 | Login | Stream JSON within a 50,000-byte limit before credential hashing and PostgreSQL. |
| 255 | Forgot/reset password | Bound both recovery handlers before rate counters, bcrypt, database and email work. |
| 256 | Own password change | Keep the explicit bearer requirement first, then enforce the byte limit. |
| 257 | Account management | Keep the bearer requirement and existing CEO tenant policy; reject oversize before database access. |
| 258 | Account creation | Keep the bearer requirement and role-assignment policy; reject oversize before database access. |

The existing maintenance parser is now the shared authentication parser. Declared oversize rejects before reading; chunked and understated-length requests are measured by actual bytes and cancelled at the limit. Valid JSON still must be an object. Oversize returns no-store 413; malformed JSON retains its prior 400 behavior. Twenty-four new route regressions cover UTF-8, streamed bodies, misleading headers, early header rejection, malformed input and anonymous mutation denial. Existing 50,000-byte maintenance boundaries and split UTF-8 regressions continue to exercise the shared parser.

This hardening adds no routes, grants or business writes and does not promote the pending public-auth governance declarations. Inventory remains 1,416 declarations, 337 with local fixture evidence, 1,069 pending and 10 blocked. The supplemental OpenAPI documents actual runtime bounds without changing pending declaration authority. Exact-head PostgreSQL and security CI passed before merge.

Local validation: 1,719 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. The PostgreSQL suite adds six oversized-route checks plus an unchanged-counter assertion per identity. Exact-head UUID/text PostgreSQL and security CI passed in run 37545086290 at de30fded7c3875a60c2ecf08092d0f2ca698ca08. PR #106 merged as 57a004e9b057c6c1a6ad6116a2a0ebca8835c43a. Latest completed batch is 258; next batch is 259. No deployment or production database changes.


## Iteration 8 — batches 259–263, authentication result validation, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 259 | Personal session listing | Validate date-time values and boolean current flag; keep explicit projection. |
| 260 | Login | Validate user identifier and nonempty bounded role before issuing a session; do not coerce active status. |
| 261 | Current identity GET/POST | Validate returned claims and reject unexpected duplicate rows before serialization. |
| 262 | Account creation | Require one returned account matching generated ID, email, tenant, role and status; project five fields before audit and commit. |
| 263 | Account management | Require one returned account matching target ID, tenant, requested role and status; project five fields before revocation and audit. |

Malformed claims and projected session/mutation rows return sanitized no-store 503. Non-string login status is denied as invalid credentials. Login issues no token/cookie on invalid claims. Invalid creation/update results roll back before audit, revocation or success. Existing bearer/cookie, tenant, role-assignment and transactional controls remain intact. Twelve new grouped unit regressions cover malformed claims and rows, unexpected fields, absent/ambiguous results and PostgreSQL Date serialization. PostgreSQL adds empty-role login and GET/POST identity rejection, infinity session-date rejection, and trigger-induced malformed creation/update results with rollback assertions.

Supplemental OpenAPI records runtime validation without promoting pending governance authority. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No new routes, grants or deployments. Exact-head PostgreSQL/security CI passed before merge.

Local validation: 1,731 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Unchanged-head UUID/text PostgreSQL and security CI passed in run 37546139108 at b6baa0f67de79696bfc99042cd9b28c2b6ae88eb. PR #107 merged as 369ff0fe6443171453c6d57c87149890001b6e6d. Latest completed batch is 263; next batch is 264. No deployment or production database changes.


## Iteration 9 — batches 264–268, authentication rate result validation, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 264 | Login | Validate the returned atomic counter before credential lookup and session issuance. |
| 265 | Forgot/reset password | Validate counters before recovery delivery, code consumption and credential reset. |
| 266 | Own password change | Validate the authenticated actor counter before beginning the password transaction. |
| 267 | Account management | Validate the actor counter before management, revocation and audit. |
| 268 | Account creation | Validate the actor counter before account insertion and creation audit. |

The shared PostgreSQL limiter requires exactly one result row, positive integer attempts within the saturated budget plus one, and positive integer retry seconds within the configured window. Values are never coerced. Invalid results return sanitized no-store 503. Atomic increments, inclusive budgets, expiry resets, hashed subject keys and existing authorization remain unchanged. The same shared validation protects maintenance counters. Twenty-eight new grouped unit tests cover all seven configured operations, malformed values, row cardinality, boundary values and six public route stop-before-work checks. PostgreSQL adds six persisted future-reset rejection checks through the gateway, with unchanged account/session/audit/reset snapshots and consumed-counter assertions.

Supplemental OpenAPI documents runtime validation without promoting pending authority. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No routes or grants added. No deployment or production database changes.

Local validation: 1,759 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL and security CI passed in run 37547360252 at e207571810670445bdd98b4692d9d58309ffe988. PR #108 merged as e50b5b170d3d27e89635dc0530781ba17c1fc3e7. Latest completed batch is 268; next batch is 269. No deployment or production database changes.


## Iteration 10 — batches 269–273, source limiter result validation, in review

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 269 | Login and password recovery | Require boolean Cloudflare source decisions before parsing credentials or opening PostgreSQL. |
| 270 | Workspace bootstrap | Validate optional source provider decisions before workspace queries. |
| 271 | Governance catalog reads | Validate provider decisions across every catalog binding. |
| 272 | Account reads and session revocation | Validate both account-list and account-admin source budgets. |
| 273 | Personal session list/revocation | Validate provider decisions before any database access or revocation. |

Only a non-array object containing an actual boolean success value is accepted. Boolean false retains no-store 429 and the existing 60-second retry metadata. Malformed or failed providers return sanitized no-store 503; truthy strings and numbers cannot bypass the limiter. Boolean true retains the existing authentication, tenant and grant checks. Existing hashed keys and optional workspace bindings are unchanged. Focused direct Worker and gateway tests assert zero database access on rejection, same source keys, CORS preservation and bearer-first ordering for private routes. No routes, grants or authority promotions; inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked.

Local validation: 1,774 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Five real PostgreSQL source-corruption rejection checks are included. Exact-head UUID/text PostgreSQL/security CI and merge remain pending.
