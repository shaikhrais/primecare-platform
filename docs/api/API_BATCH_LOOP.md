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


## Iteration 10 — batches 269–283, source decisions and maintenance validation, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 269 | Login and password recovery | Require boolean source decisions before parsing credentials or opening PostgreSQL. |
| 270 | Workspace bootstrap | Validate source provider decisions before workspace queries. |
| 271 | Governance catalog reads | Validate provider decisions across every catalog binding. |
| 272 | Account reads and session revocation | Validate account-list and account-admin source budgets. |
| 273 | Personal session list/revocation | Validate provider decisions before database access or revocation. |
| 274 | Client owned reads | Validate decisions before client profile, invoice, booking, visit, payment and registered record reads. |
| 275 | Provider owned reads | Validate decisions before profile, availability, visit and document reads. |
| 276 | Provider registered records | Validate decisions before existing list, detail and summary source boundaries. |
| 277 | Account owned records | Validate decisions before account-owned metadata projections. |
| 278 | Client booking lifecycle | Validate decisions before submission, cancellation and audit access. |
| 279 | Provider timesheet items | Validate decisions before existing list, detail and summary reads. |
| 280 | Maintenance configuration metadata | Validate positive int4 revision and finite update date; retain absent-configuration defaults. |
| 281 | Maintenance templates | Validate persisted content and placeholders; derive required variables from canonical templates and discard extra fields. |
| 282 | Maintenance audit | Validate the two existing actions and finite dates; return only action/date within the twenty-row bound. |
| 283 | Configured native mail | Require zero/one configuration row and valid stored sender/templates before recovery or test delivery. |

Only an object containing an actual boolean source success value is accepted, read once. False retains no-store 429 and the existing 60-second retry; malformed or failed providers return sanitized no-store 503 before PostgreSQL. Existing hashed keys, optional workspace bindings and bearer/tenant/owner/grant checks remain intact. Direct Worker and gateway tests cover all registered source boundaries, CORS, hashed keys, boolean decisions, bearer ordering and zero database access on rejection. Five PostgreSQL account/session corruption checks and twelve booking checks assert unchanged protected state.

Maintenance returns explicit template/audit projections and rejects corrupt stored revisions, dates, senders, placeholders and ambiguous configuration results. Canonical required variables replace untrusted stored arrays. Invalid configuration reads roll back; invalid runtime mail configuration sends no email and writes no acceptance audit. Nine PostgreSQL checks cover corrupt configuration, audit, field projection and rejected recovery/test delivery. Supplemental documents record runtime hardening without promoting authority.

PostgreSQL CI exposed a shared counter timing race: transaction-start NOW can produce a 61-second retry for a 60-second window when a request waits on a row lock. Retry projection now uses clock_timestamp after the wait. A deterministic PostgreSQL lock-wait regression accompanies the existing concurrent budget and saturation tests. Strict result bounds and atomic counters remain in place.

Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No routes, grants, authority promotions or deployments. Local validation: 1,808 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL and security CI passed in run 37552341294 at 5826243ebbb7b1b527273f0651943ba455245e4b. PR #109 merged as 8098c497b871b68ff15ab5fa978fec4704f6cf7f. Latest completed batch is 283; next batch is 284. No deployment or production database changes.


## Iteration 11 — batches 284–298, read dates and native email results, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 284 | Client profile | Validate the registered update date without JavaScript coercion or calendar normalization. |
| 285 | Client invoices | Validate list/detail date-time fields while preserving decimal precision. |
| 286 | Client payments | Validate own/nested list/detail dates without changing invoice ownership. |
| 287 | Client visits | Validate requested start and update dates. |
| 288 | Client bookings | Validate start/end dates. |
| 289 | Client booking requests | Validate preferred, creation and update dates. |
| 290 | Client registered records | Validate every registered date field in list/detail projections; retain declared nullable values. |
| 291 | Provider documents/visits | Validate required and nullable dates under existing ownership. |
| 292 | Provider registered records | Validate registered date fields across existing list/detail projections. |
| 293 | Account owned records | Validate registered date fields while retaining existing owner/tenant scope. |
| 294 | Booking lifecycle/audit | Reject extended-year Date results before mutation audit/commit or audit serialization. |
| 295 | Provider timesheet items | Reject extended-year Date results in list/detail responses. |
| 296 | Workspace activity | Validate existing event actions and dates; explicitly project action/date within the twenty-row bound. |
| 297 | Native email transport | Require callable binding, uncoerced normalized addresses and a valid string acceptance ID read once. |
| 298 | Runtime email templates | Validate IDs, bounded content and placeholders before rendering; derive canonical required variables. |

Existing read contracts require finite RFC3339 date-times. JavaScript parsing alone previously accepted date-only strings, impossible calendar dates normalized into another month, and extended-year Date values outside the four-digit contract. A shared validator now enforces the same calendar/time bounds as account reads, preserving valid RFC3339 strings, PostgreSQL Date serialization and declared nulls. Old unit fixtures containing date-only strings are corrected to explicit UTC date-times. Direct Worker tests cover list/detail routes across every registered date family. Invalid results return sanitized no-store 503 with rollback. Booking/timesheet Date projections now also reject years outside 0000–9999; booking failures precede audit/commit.

Workspace activity permits only the three persisted event actions from the selected account/configuration audit sources, and returns two fields. Native email results must contain an actual nonempty trimmed messageId string without control characters. Addresses are validated without coercion and passed to the native transport as bare emails. Malformed send receipts are generic failures; recovery removes its reset code and maintenance writes no acceptance audit. One template validator is shared by maintenance projection and rendering: content/placeholder bounds and canonical required variables cannot be overridden by stored/deployment variable arrays. HTML escaping and native-only transport remain intact.

Disposable PostgreSQL checks inject infinity and year-10000 timestamps into owned rows across the read families, assert rejection and unchanged state, and restore each fixture. Additional checks cover workspace activity, booking mutation/audit rollback, and malformed native receipts during recovery/test delivery. Supplemental runtime documentation adds no authority. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No routes, grants, authority promotions or deployments.

Local validation: 1,845 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL and security CI passed in run 37554565922 at 06ae62d8b1089421fcd688eec5565abd6cda0f91. PR #110 merged as e973f171fe4f1668c14292283e55b6aee399f531. Latest completed batch is 298; next batch is 299. No deployment or production database changes.

## Iteration 12 — batches 299–303, password mutation results, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 299 | Recovery/reset account lookup | Validate account identifiers and bind recovery email to the normalized requested address. |
| 300 | Recovery code storage | Confirm exactly one stored account/hash inside a transaction before delivery. |
| 301 | Reset code consumption | Require exactly one consumed code belonging to the locked account before updating credentials. |
| 302 | Reset credential update | Confirm returned account and exact new hash before revocation, audit and commit. |
| 303 | Own password change | Confirm returned account and exact new hash before revocation and audit under the caller's transaction. |

Unknown and ambiguous recovery accounts retain generic success; absent or expired reset codes retain 400. Malformed persisted or adapter results return sanitized no-store 503. Recovery storage rolls back invalid insert results before native delivery. Reset failures roll back code consumption and credential writes; own password failures use the existing caller rollback. Password hashes remain internal and excluded from responses and audit.

Twenty-eight new focused fixtures and one grouped gateway regression cover invalid lookup identities/email, absent/ambiguous accounts, mixed-case stored email, insert cardinality/binding, consumed-code ownership and update cardinality/identity/hash. Six disposable PostgreSQL trigger checks suppress or corrupt recovery inserts and password updates through the gateway, asserting no delivery and unchanged protected state, including restored reset codes and retained sessions. Existing successful bcrypt, revocation, expiry and replay tests remain.

Supplemental runtime documentation adds no authority. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No routes, grants, authority promotions or deployments.

Local validation: 1,874 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL and security CI passed in run 37556707433 at 03b0f4f230df14948afe3979dd433974a0f570b0. PR #111 merged as 7ed767f13eb913c07a1419b3d25108f22931a287. Latest completed batch is 303; next batch is 304. No deployment or production database changes.


## Iteration 13 — batches 304–318, account and maintenance result boundaries, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 304 | Account management | Validate locked target cardinality, identity and prior state before update, revocation and audit. |
| 305 | Maintenance revisions | Bound request revisions to incrementable int4 values; validate locked revision, cardinality and retained credential type. |
| 306 | Maintenance configuration save | Confirm returned tenant, sender, templates, retained ciphertext, next revision, date and configuration audit. |
| 307 | Maintenance test email | Confirm acceptance audit tenant, actor, action and cardinality before reporting success. |
| 308 | Account listing | Require one count row and bound returned users to the requested limit. |
| 309 | Account details | Require zero/one detail row whose identifier matches the requested account. |
| 310 | Admin session listing | Validate target identity/cardinality, count cardinality and returned page bounds. |
| 311 | Admin session revocation | Validate target identity/cardinality and deletion count cardinality before audit. |
| 312 | Management audit reads | Require one count row and bound returned events to the requested limit. |
| 313 | Creation audit reads | Require one count row and bound returned events to the requested limit. |
| 314 | Own session listing | Validate actor identity/cardinality, count cardinality and page bounds. |
| 315 | Own session revocation | Validate preflight/locked actor, bearer recheck cardinality and deletion count cardinality before audit. |
| 316 | Workspace identity | Reject ambiguous actor rows and malformed IDs/roles before grants or overview queries. |
| 317 | Workspace session totals | Require exactly one session aggregate row before projecting counts. |
| 318 | Workspace tenant metrics | Require exactly one aggregate row for each available tenant-bound metric. |

A shared adapter-result guard validates arrays, object rows, zero/one authority lookups, exactly-one aggregates and requested page limits. Duplicate or malformed rows cannot silently become the first account/session/count. Target detail and revocation rows must bind to the requested account. Existing missing-target 404, absent-session 401, authorization, source/rate controls, SQL scope, read-only transactions and explicit field projections remain.

Management validates prior account role/status before changing the row or serializing audit state; declared legacy nulls remain allowed. Maintenance request revisions are 0–2147483646 so the next persisted revision fits int4. Locked configuration revisions must be positive int4, and retained ciphertext must be string/null. Saves confirm one returned configuration matching all intended fields and the next revision before confirming the audit. Invalid inserts/updates/audits roll back with sanitized no-store 503. A test-email acceptance audit must match tenant, actor and action before success is reported. Provider acceptance occurs before that audit and cannot be undone by database rollback; failure responses do not assert delivery.

Twenty-eight new grouped gateway regressions cover all fifteen families, ambiguous/malformed rows, wrong target IDs, count cardinality, oversized pages, revision overflow, corrupt save fields, unconfirmed audits, stop-before-work and rollback behavior. Existing maintenance fixtures now return actual mutation projections. Disposable PostgreSQL adds eight maintenance checks, two corrupt prior-state checks, six session pagination boundary checks and one workspace identity check, using synthetic fixtures only. Existing real database success, tenant isolation, revocation and audit rollback checks remain.

Supplemental runtime documentation adds no authority. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No routes, grants, authority promotions or deployments.

Local validation: 1,902 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL and security CI passed in run 37557619387 at 9aa0a4c6680bbcf9c25472b700d1e94a85e0d9e4. PR #112 merged as 84b51d0ebfbd384e27268c652b85b25d219e86a8. Latest completed batch is 318; next batch is 319. No deployment or production database changes.


## Iteration 14 — batches 319–333, owned read result boundaries, merged

| Batch | Existing handler family | Change |
| --- | --- | --- |
| 319 | Client owned profile/authority | Validate unambiguous actor/profile rows and string identifiers before deriving ownership. |
| 320 | Client invoices | Validate exact-one totals, list/summary page bounds and detail identity. |
| 321 | Client payments | Validate own/nested payment pages, totals, detail IDs and the parent invoice binding. |
| 322 | Client booking requests | Validate list/summary page bounds, total cardinality and requested detail identity. |
| 323 | Client visits | Validate list/summary page bounds, total cardinality and requested visit identity. |
| 324 | Client bookings | Validate list/summary page bounds, total cardinality and requested booking identity. |
| 325 | Client registered records | Apply cardinality, page and detail binding checks to every registered list/detail/summary family. |
| 326 | Provider owned profile/authority | Validate unambiguous actor/profile rows and string identifiers before deriving ownership. |
| 327 | Provider documents | Validate total cardinality, bounded list/summary results and requested document identity. |
| 328 | Provider visits | Validate total cardinality, bounded list/summary results and requested visit identity. |
| 329 | Provider availability | Validate total cardinality, bounded list/summary results and requested availability identity. |
| 330 | Provider registered records | Validate actor/profile authority, counts, pages, singleton rows and requested details across all registered records. |
| 331 | Account owned registered records | Validate actor authority, counts, pages, singleton rows and requested detail identity. |
| 332 | Provider timesheet item list/detail | Validate actor/profile rows, exact-one total and bounded item results; retain exact detail binding. |
| 333 | Provider timesheet item summary | Require one total row and bound returned status/minute groups to the requested limit. |

Owned-read authority is now an unambiguous object row with a valid string account/profile identifier. Tenant values are not coerced; absent tenants retain denial. Exactly-one aggregate results and requested page limits are enforced before projection. Detail rows must match the requested identifier, including the invoice parent of nested payment routes. The shared helpers retain explicit field projection, declared nullable values, decimal precision, strict date validation, existing tenant/owner SQL joins, active explicit bearer sessions, source budgets and repeatable-read rollback.

All existing registered client/provider/account record definitions receive these runtime boundaries. Singleton absence remains 404, missing actors remain 401, missing profiles remain 404 and valid empty pages retain zero totals. Unsupported summary routes are not introduced. Invalid or ambiguous adapter results return the existing sanitized no-store 503 before returning data or deriving another owned query. No business mutations are added.

Sixty-one new grouped gateway regressions cover every registered family, malformed actor/tenant/profile identities, duplicate and nonobject rows, exact-one aggregate counts, oversized list/summary pages, detail/parent binding and valid/missing/empty responses. Existing focused suites passed without changing their success fixtures. Additional disposable PostgreSQL checks verify one-row caps and maximum empty offsets across base reads, nested/own payments, timesheet items, representative registered metadata and their approved summaries. Existing database detail identity, tenant isolation, ambiguous profile and nullable-value tests remain.

Supplemental runtime documentation adds no authority. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked. No routes, grants, authority promotions or deployments.

Local validation: 1,963 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL and security CI passed in run 37558568217 at cfd5650b48a370e0dce098ec7ef0c8276d7a08ef. PR #113 merged as 60e5ea13f0f5fe61ab331d2df94332ac7aae0468. Latest completed batch is 333; next batch is 334. No deployment or production database changes.


## Iteration 15 — batches 334–348, authentication and booking result boundaries, in review

- Batch 334 maintenance actor.
- Batch 335 account list actor.
- Batch 336 account administration actor.
- Batch 337 mutation budget actor.
- Batch 338 locked password actor.
- Batch 339 locked account creation actor.
- Batch 340 locked account management actor.
- Batch 341 confirmed session insert.
- Batch 342 recovery tenant rows.
- Batch 343 governance actor.
- Batch 344 booking actor/profile/session.
- Batch 345 booking replay binding.
- Batch 346 booking audit reads.
- Batch 347 confirmed creation audit.
- Batch 348 cancellation binding and confirmed audit.

Privileged actor rows now require one object, a string account ID and role, and an uncoerced tenant. Mutation preflight validates identity before allocating a budget; locked authorization remains authoritative. Password authority, recovery tenant lookup and governance catalog reads enforce result shape and cardinality. Login confirms the persisted token hash and account inside a transaction before issuing a token or cookie.

Booking lifecycle checks actor, profile and session rows, replay cardinality, request hash and current owned parent identity. Audit reads enforce parent binding, exact aggregate cardinality and requested page bounds. Creation and cancellation confirm every audit binding and the persisted response before commit; cancellation also verifies the locked target. Missing actors/profiles, valid empty pages and conflicting retries preserve their existing responses. Malformed adapter results use sanitized no-store failures and rollback.

New unit corruption regressions exercise these boundaries. Disposable PostgreSQL triggers suppress or corrupt session and booking audit inserts and assert unchanged snapshots after rejection. No routes, grants, authority promotions, deployment or production database changes. Inventory remains 1,416 declarations, 337 local fixture records, 1,069 pending and 10 blocked.

Local validation: 2,033 API fixtures, eight authority regressions, Worker TypeScript and governance guardian passed. Exact-head UUID/text PostgreSQL/security CI and merge remain pending.
