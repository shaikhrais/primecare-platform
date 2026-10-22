# Business tasks and communications implementation

2026-10-22. Internal service code, not a released end-user communication platform.

Shared inheritance and server/Dart usage are documented in [the communication core](../../packages/shared/src/communications/README.md). Task, conversation and mail services now inherit ScopedServiceBase. Message, picture, audio and email channels inherit CommunicationChannelBase and are composed by CommunicationCore. The Dart CommunicationHub provides matching derived clients for all portals through an injected authenticated transport. Browser resources and binary adapters inherit common cleanup and byte-limit bases. No hardcoded role list or permissive grant was introduced; production registration and integration gaps below still apply.

The hub is exported through both existing Flutter core entry points. The existing ApiClient now consumes the shared communication-path guard, so failed registered messaging requests no longer become synthetic demo success or path-only cached conversation responses. This is a real existing-client repair; it neither grants messaging permission nor implements an unavailable backend. Dedicated Flutter tests cover the actual client boundary, offline errors, server denial and genuine successful responses.

## Implemented modules

| Source | Behavior |
| --- | --- |
| cloudflare/workers/src/business-tasks/store.ts | Atomic PostgreSQL aggregates, expected versions, advisory serialization including creation, audit events and actor-bound idempotency receipts |
| cloudflare/workers/src/business-tasks/workflow.ts | Executes all 15 candidate definitions; draft/submission/correction/resubmission, independent review, next assignment, blocked/resumed work, closure and scoped inbox |
| cloudflare/workers/src/business-tasks/communication.ts | Participant-scoped conversations, text/picture references, monotonic read receipts, call invitation/accept/decline/expiry/end and bounded two-party signaling |
| cloudflare/workers/src/business-tasks/workspace.ts | Links a task to a conversation restricted to current task participants |
| cloudflare/workers/src/business-tasks/mail.ts | Permission-checked outgoing queue, explicit one-attempt native send, provider acceptance/unknown state, configured inbound mailbox scope, byte-based deduplication and raw-mail quarantine |
| packages/shared/src/communications/pictures.mjs | Real raster decoding/re-encoding, pixel/byte bounds, metadata stripping, mandatory injected scanner and private object storage |
| packages/shared/src/communications/audio-call.mjs | Browser microphone/peer connection, offer/answer/ICE exchange, mute/unmute and track/connection cleanup |
| packages/shared/src/communications/inbound-email.mjs | Stream-bounded Cloudflare email handler delegating to scoped inbound storage; storage errors remain retryable |

All task transitions retain original evidence and revision history. A snapshot of the candidate definition is saved on creation so later catalog edits cannot silently rewrite an open task. Receivers are actual user IDs checked through a mandatory policy adapter. Accept requires a reason referencing verification; source record verification must be supplied by the production adapter. The domain service does not prove a document is valid simply because its reference is present.

## Deployment boundaries

No new public route, screen, control, permission grant, table or notification channel has been registered or deployed by this change. Do not connect these modules to a public request until requirements and mappings exist in pinned production PostgreSQL and required reviews pass. The SQL in scripts/fixtures/business-communications.sql is a disposable acceptance schema, not a production migration. No operational SQLite authority is used or recreated.

AccessPolicy must resolve authenticated identity, active account/tenant, registered action permissions, assignee eligibility, case confidentiality and evidence-read permission from the production system. Never construct it from request booleans or user-supplied roles. There is no permissive runtime default. Inbound service identity also requires an explicit registered policy. Test policies and the memory store are fixtures only. Fine-grained HR and clinical scoping must be checked on every read and action, including retries.

PostgresAtomicStore expects a pool whose connection search path targets the approved business schema. Runtime deployment must first register/migrate the schema, enforce database ownership and least privilege, and set retention/index/backup policies. Records are bounded aggregate documents intended for initial service acceptance; large conversations require a registered paginated/normalized message store. The service rejects additional messages/signals at configured limits instead of silently discarding history. Inbox currently returns a bounded first page; production pagination and queue filters remain required. Business events are audit records, not a delivered notification outbox.

Picture processing requires a Node image-processing runtime or a compatible approved service; sharp is not automatically a Cloudflare Worker binding. Both source and re-encoded output require a real scanner adapter returning clean. A synthetic scanner in tests is not malware-scanner acceptance. Private storage has no public URL. CommunicationService.openPicture checks conversation membership and picture scope; a runtime HTTP adapter must apply safe content headers and avoid exposing storage keys. Attachment expiry, orphan cleanup and retention must be registered before deployment.

Calls are in-app audio. The browser adapter is JavaScript and is not yet a Flutter/native media integration. An accepted call and authenticated, tenant-scoped signaling adapter are mandatory before invoking media. A local browser transport test does not prove mobile device access or internet/NAT traversal. Configure scoped, expiring TURN credentials, signaling delivery, timeout cleanup and network/device tests before live calling. No recording is implemented. No telephone-network service is configured.

Outgoing business mail accepts a configured sender and mandatory recipient authorization. The transport interface matches the existing native EMAIL.send shape, but no live binding is connected by this change. A native message ID means accepted, not inbox delivery. An uncertain send is Unknown, is not automatically retried, and needs reconciliation. A crash after a transport request can leave Sending; the reconciliation owner must treat that as ambiguous. Inbound raw mail is quarantined, not parsed into executable workflow commands. Sender headers do not establish identity. MIME parsing, attachment scanning, sender authentication review, reply threading, safe display, mailbox-specific access, retention and delivery/bounce correlation remain required for a live business inbox. Existing owned QA receiver remains unchanged.

## Tests and evidence

- node --test packages/shared/test/business-*.test.mjs: shared rule/planning checks.
- node --test scripts/test-business-communications.mjs: every candidate flow plus conversation, picture gates, signaling/call states and outgoing/incoming mail behavior. Without BUSINESS_TEST_DATABASE_URL this uses an explicit isolated memory fixture and earns no persistence acceptance credit.
- BUSINESS_TEST_DATABASE_URL points only to disposable PostgreSQL. The same suite creates a random isolated schema, tests independent-connection write races and rollback of state/audit/idempotency, then removes only that schema. Never point it at production.
- node --test scripts/test-business-media.mjs: sharp raster processing, real inbound byte streams and two real Chromium peers exchanging audio packets. Scanner, object-store and mail transport boundaries are synthetic. No real recipient is contacted.
- Verify business communications inventory and services: separate read-only production registry audit and isolated native PostgreSQL/media jobs. Production credentials exist only in the metadata-reader step. No claims of full business-process or Flutter acceptance follow from these tests.

Local results: 23 shared tests, 24 service tests with isolated memory storage, 13 existing email compatibility tests and 2 real raster/stream-handler tests passed. Strict TypeScript service checks pass. Native PostgreSQL results must be recorded after execution. The original asynchronous browser wait was too weak and briefly reported a false pass; the corrected test polls concrete statistics and asserts packets on both peers. It currently fails locally with zero packets: microphone tracks and offer/answer exchange work, but ICE remains New after gathering. This workspace also rejects network-interface enumeration; that is a likely environmental cause, not a confirmed production diagnosis. Local microphone mute/unmute and track cleanup pass. No audio-transport acceptance or product screenshot is claimed from that false pass. The current diagnostic artifact records the failure honestly. The normal local Playwright download failed with a truncated archive; an explicitly selected alternate Chromium executable permitted the stricter test to run.

The production read-only inventory in run 39788128133 (source cf47f2c8) passed: 53 matching API records, 26 screens and 26 matching business-process definitions. This is a keyword-filtered inventory, not 53 communication features; it includes invoices and sales-call records. Forty-four API records have no permission key. Messaging-related screen records exist, but inspected Flutter service clients still return empty stub data. The matched /v1/governance/growth/calls endpoint records sales-call outcomes, not real-time media. Existing registrations do not establish a usable chat, picture, calling or business-mail contract. The audit changed no governance or business records.

## Passing CI checkpoint

[Run 39789682652](https://github.com/shaikhrais/primecare-platform/actions/runs/39789682652), source e83325951edfc516bb74247d0f27c6c9d488aff3, passed all three jobs. Its isolated native PostgreSQL job passed 23 shared-rule/planning tests, 13 existing email-compatibility tests and 25 workflow/communication/storage tests. The media job passed 3 tests. Total: 64 tests, zero failures or skips. Strict TypeScript checking also passed. The separate read-only production inventory passed again.

The corrected media artifact reports audioPassed=true with both real Chromium peers Connected and five received audio packets each, plus successful mute, unmute and track release. This uses synthetic microphones on a CI host; no person was called. It supersedes the earlier weak-wait false pass and establishes scoped audio transport evidence, while the local zero-packet result remains recorded above. It does not prove physical devices, internet TURN traversal, deployed signaling or Flutter integration. Machine-readable CI transport evidence is preserved at docs/business/evidence/communications-audio-20261022.json. No production approval or full end-user completion is claimed.

## Inherited core checkpoint

[Run 39791814770](https://github.com/shaikhrais/primecare-platform/actions/runs/39791814770), source cc02d4e4d6c78827017d055da98c80242b1565ae, passed the production inventory, isolated PostgreSQL, browser-media and pure-Dart jobs. It passed 71 Node tests (23 shared, 13 email compatibility, 28 PostgreSQL service, 4 adapter-base and 3 media), strict TypeScript checking, Dart analysis with no issues and the Dart channel contract harness. This proves scoped reuse across the new base classes and composition roots; it does not register or deploy communication controls for every live role.

Subsequent hardening releases microphones on invalid remote signaling or terminal peer failure, including display-callback errors, and prevents the Dart call helper from sending a signal action without a signal body.

## Final inherited-core verification

[Run 39794808175](https://github.com/shaikhrais/primecare-platform/actions/runs/39794808175), source fb6cbea995d36329f4e95cd4b6a46a08072d2be6, completed successfully in all five jobs. Results: 72 Node tests (23 shared/planning, 13 existing email compatibility, 28 native PostgreSQL service/storage, 5 shared-adapter and 3 real-media tests), 479 Flutter transport regression tests, strict TypeScript checking, Dart analysis with no issues, the Dart client contract harness and the read-only production inventory. There were no failed or skipped Node tests. The Flutter suite includes 12 new communication transport checks covering failures across all five HTTP methods plus denial and actual-success responses; the other checks are existing auth, profile, business-development and notification regressions.

The streamlined media job used the runner's installed Chrome 156.0.8078.47. Both real peers reached Connected and received two audio packets each. Mute, unmute and track cleanup passed. This validates the inherited browser-resource implementation without another browser/system-package download. The evidence is preserved at docs/business/evidence/communication-core-20261022.json. The diagnostic screenshot is a test report, not a deployed PrimeCare screen.

These scoped tests do not establish live messaging/picture/mail UI acceptance, production business-mail delivery, phone-network calling, TURN/internet traversal, physical-device media or independent release approval. The new core and hub are reusable for every permitted portal/user; actual live access still requires registered permission mappings and the adapters/screens described below. Parent repository instructions now explicitly preserve the shared inheritance requirement.

## Remaining release work (unchanged by inheritance)

Map the existing messaging/email/task records to these contracts, complete the production-compatible registrations and required reviews, implement real policy/scanner/storage/native-mail adapters, configure the media relay, and connect registered Flutter forms/inboxes. Then execute real login → task handoff → message/picture → API → database → reload, two-user call and owned-mailbox send/receive with denied/cross-tenant/HR cases. Do not mark the existing messaging stubs functional until that journey passes.

Technical references consulted: [WebRTC peer connections](https://webrtc.org/getting-started/peer-connections), [sharp constructor](https://sharp.pixelplumbing.com/api-constructor/), [sharp output metadata behavior](https://sharp.pixelplumbing.com/api-output/), [Cloudflare email handler](https://developers.cloudflare.com/email-service/api/route-emails/email-handler/) and [native email sending](https://developers.cloudflare.com/email-service/api/send-emails/workers-api/).

### Authenticated Flutter transport checkpoint — 2026-10-22

`DioCommunicationTransport` now implements the shared hub through inherited
`CommunicationTransportBase` dispatch checks. Inject the existing authenticated
Dio session and a contract map loaded from registered production metadata; this
adapter intentionally supplies no new endpoint mappings or permissions. It sends
JSON commands, GET read queries and actual multipart picture bytes. Private picture downloads use bounded streams with configured byte limits, MIME/signature validation, declared-length checks and guaranteed subscription cleanup; binary data never becomes JSON or a public URL. Missing
contracts, identity overrides, unsafe absolute/redirect paths, GET mutations,
non-success responses and malformed acknowledgements fail. It does not retry
ambiguous email delivery or substitute demo responses.

The new transport suite covers session reuse, command versions/keys, GET query
encoding, copied multipart bytes, denied/unbound commands, unsafe route maps,
malformed/error responses, single-attempt network failure and bounded private picture downloads (including oversized, mislabeled and truncated streams). CI run [39799606375](https://github.com/shaikhrais/primecare-platform/actions/runs/39799606375) passed on source `5bff14600d6d3d7246adf188ec7f4ea43196f58e`: 489 Flutter tests (10 adapter tests plus 479 regressions), 72 Node tests, strict TypeScript, Dart analysis and the pure Dart contract harness. The media artifact 12434907076 records Chrome 155.0.8059.39 and 4/5 received audio packets, mute/unmute and track cleanup. This is an integration adapter, not a
claim that unregistered production commands or Flutter screens are exposed.
Production contract/policy registration, private storage/scanner bindings,
mailbox routing, real call signaling/relay and user acceptance remain open.

### Production contract reconciliation — 2026-10-22

Read-only run 39810235934 on source `48300c595ba2cf610e3b003bf4e7f7380e67e965`
checked schemas, authentication declarations, API-to-screen links and matching
active-role API/screen grants. The six new report tests passed. The broad keyword
inventory contains 53 candidate records (including adjacent tasks and sales-call
records); it is not a count of communication workflows. None meets every minimum
metadata check. This does not prove these other domains fail at runtime.

For the concrete messaging routes, existing API710 (`POST /v1/messages`) and
API857 (`GET /v1/messages/inbox`) both retain service `PRISMA`, no request or
response schema, no permission key, no screen links and no matching role grants.
Existing API191,246,278,783 have the same binding gaps. See
[evidence/communication-registration-20261022.json](evidence/communication-registration-20261022.json).

The next production mutation must reconcile exact API identities, contract
schemas, service routing and existing screen/API permission relationships in a
scoped native PostgreSQL transaction. Preserve existing role-screen grants and
restricted case/mailbox boundaries; the audit is not authorization to infer
missing grants. Register controls/resources before mounting UI or public routes.
The legacy SQLite registrars must not be run against the production connection.
No business data, accounts, credentials, grants or production metadata changed
in this audit. A complete metadata report is not live acceptance evidence.

### Production registration and inherited HTTP adapter — 2026-10-22

Registration run [39811946324](https://github.com/shaikhrais/primecare-platform/actions/runs/39811946324)
passed isolated native PostgreSQL tests, a rolled-back production transaction,
idempotent apply and an independent production read-back. APIs710/857 were
preserved; picture upload/open16508/16509, call commands16510 and email commands16511
were registered with 24 links across existing screens234/331/559/578. Registration
changed no role grants, business records, accounts or feature activation. The six
endpoints remain `registered-unimplemented` until deployment and acceptance.

The database read-back is preserved in
`packages/shared/src/communications/registered-contracts.json`.
`tools/communication-route-bindings.py` checks exact schema/route/identity parity
and reproduces 16 Dart action bindings from it. The shared Flutter transport now
supports the registered inbox query without leaking the internal channel action
into the public query schema. No widget hardcodes a route or role.

`CommunicationHttpWorker` inherits `BaseWorker` and dispatches through
`CommunicationCore`. It requires authentication, current endpoint authorization,
a real JSON Schema validator and an explicit request-byte bound. It validates
registered schemas, rejects identity overrides/duplicate query and form fields,
bounds and cancels streamed bodies, supports private multipart upload/download,
and keeps unknown errors generic. Conversation inboxes invoke the current policy
and the same participant/tenant checks as reads. No permissive production adapter
or live router mount was added.

Nine HTTP tests cover message/inbox persistence and retries, identity/tenant
rejection, endpoint denial, exact route/method/media handling, stream cancellation,
picture attachment/download, call state/signaling, email acceptance/retry and
response-schema failure. Local memory results are not production persistence
proof; native PostgreSQL and Flutter CI passed for this source checkpoint in run39813474576.
The picture scan/mail/auth callbacks in HTTP tests are explicit fixtures, not live
providers. Actual raster processing and browser packets retain their separate tests.

Remaining live work includes registered business storage and its native migration,
authenticated current API/case/mailbox policy bindings, handler deployment/routing,
private storage/scanner, actual inbound mailbox integration, media signaling/relay,
registered shared UI controls/resources and authenticated user acceptance.

Final HTTP checkpoint: [run39813474576](https://github.com/shaikhrais/primecare-platform/actions/runs/39813474576)
completed successfully on source `f01d0efcbedfa36a0bb73847df7a002643a4ed74`: 81 Node
tests (including nine HTTP tests through native PostgreSQL), 490 Flutter tests,
seven contract-report tests, strict TypeScript, Dart analysis/client checks and
browser audio transport. Production inventory remained read-only. See
[evidence/communication-http-20261022.json](evidence/communication-http-20261022.json).
This supersedes the earlier missing-contract checkpoint for these six endpoints;
the role grants, production adapter bindings and user acceptance remain pending.

### Registered native storage migration — 2026-10-22

The storage design now has an exact production writer scope for three
`db_schema_tables` rows, 16 `db_schema_columns` rows and one complete
`database_rebuild_baselines` entry. The baseline preserves the pinned DDL,
relationships, defaults and generated identity. Registration and business DDL
are separate committed steps; migration refuses missing or edited registration.

`CommunicationStorageStore` inherits the pinned `ProductionWorkflowStore`.
`communication_storage.py` restricts metadata writes to the exact definition.
The separately opted-in native migration creates only the three registered
business tables and compares their native parsed schema with temporary tables
on the same PostgreSQL server. It checks columns, nullability, identity/defaults,
primary/foreign/unique/check constraints and validation state. Drift rolls back;
it does not alter existing business records or grant access. Temporary validation
tables are removed before commit.

The production SQL requires matching tenant/record IDs, supported record kinds,
non-null JSON identity fields, safe positive versions, actor-bound command keys,
SHA-256 fingerprints, same-tenant aggregate references and unique audit versions.
The shared store rejects a mutation whose next version would exceed JavaScript's
safe integer range. Native service/HTTP tests now run this actual migration in
isolated schemas instead of the older weaker fixture DDL.

Eight isolated storage cases check idempotence, complete registration rollback,
missing/edited design rejection, permission preservation, native schema drift,
tenant/foreign-key constraints and opt-in enforcement. The storage workflow must
pass these before its production dry-run, registration, DDL dry-run, migration and
fresh-transaction native reread. No synthetic user or message is written in
production by this workflow. Storage readiness is not live channel acceptance.

The live-binding review also exposed two core access gaps, repaired before any
handler activation. Outbound mail now records `ownerId` from the authenticated
actor and refuses another user's reads, delivery claims or retries, even when an
injected policy is too broad. Inbound reads require a mandatory
`MailboxPolicy.access(actor, mailboxId)` check; recipient eligibility and inbound
address resolution cannot substitute for current mailbox read access. Missing
mailbox access adapters fail during construction.

Conversation creation now passes a copied prospective record (business reference
and complete member set) to the current policy before persistence. Previously a
policy saw only null state on initial creation and could not inspect that case
context. Existing tenant/type checks and member eligibility checks remain active.
New tests deny another same-tenant mail reader/sender, an ungranted inbound reader
and a restricted case at creation, and confirm missing mailbox adapters fail.

Storage run [39815550245](https://github.com/shaikhrais/primecare-platform/actions/runs/39815550245)
completed successfully on source `baa51588d9ee4d9628b0c6817159e272ca7fcf94`: eight
isolated native cases passed, production registered table IDs1352/1353/1354 and
16 columns, then completed DDL dry-run, apply and fresh-transaction validation
in public. No production business records or role grants changed. The persisted
design baseline remains unreviewed/application-unimplemented; native schema proof
is recorded separately rather than inventing release approval.

Core run [39816242789](https://github.com/shaikhrais/primecare-platform/actions/runs/39816242789)
passed on source `813f4904b0c6dcfc82164a15feb3c3b4f01b9926`: 84 Node tests, 490
Flutter tests, strict TypeScript, Dart checks, metadata audit and browser audio.
The native service and HTTP tests use the production migration in isolated schemas.
See [evidence/communication-storage-20261022.json](evidence/communication-storage-20261022.json).
The storage registration/migration item is now complete; current session and
permission adapters, provider integration, shared UI and live user acceptance
remain open.

### Native session binding checkpoint

`PostgresCommunicationSession` now resolves bearer credentials against current native `auth_sessions` and active `users`, returning an immutable server-derived actor and tenant. It checks expiry on every request, rejects cookie-only access and tenant overrides, and never accepts request roles. Canonical credential parsing/hashing was extracted from auth with compatibility exports preserved. The registered HTTP worker maps explicit session denials to 401/403; database failures remain unavailable.

Five isolated adapter checks cover credential hashing, ambiguous/malformed identities, tenant denial and revocation on subsequent requests. These checks do not establish live deployment acceptance. Current governance grants/case/contact/mailbox policy, provider composition, gateway mounting, shared registered UI and owned-user end-to-end acceptance remain pending. No new route or permission was exposed by this checkpoint.

### Current native endpoint permission binding

`PostgresCommunicationEndpointPolicy` reads the pinned governance manifest and current native grants in a bounded, read-only PostgreSQL snapshot for each request. It requires an active server-derived user in the same tenant, an active role, an explicit API grant, the exact registered API contract, an active linked communication screen and a screen-view grant. Tagged imported metadata and native scalar columns are both handled; unknown tags and missing values cannot grant access. Every acquired client rolls back and releases on denial or database error. No grants or activation flags were changed.

Five local policy checks passed. A sixth test exercises actual SQL on the disposable CI PostgreSQL database, including tagged permission keys, tenant mismatch, API/screen revocation and unknown tags; local execution skips it when no isolated database URL is provided. Native verification subsequently passed in CI run 39825070796, isolated job 119986089942 (2026-10-22), including the real PostgreSQL tagged/native permission query and revocation cases. This endpoint adapter does not replace service-level restricted-case or mailbox policy, and remains unmounted until the complete composition is ready.

The broader historical-fixture gate correctly flagged the new live permission reader. Source review added an explicit grant-key requirement: historical generated `api_permission_*` grants cannot authorize communication even when numeric endpoint IDs collide. The historical quarantine still rejects every unreviewed consumer; its sole live-reader exception is pinned to the exact source SHA and production-only authority declaration. A regression test verifies that any source drift closes that exception. Source provenance for auth parser extraction and the already-tested communication fallback protection was refreshed without changing operation stages or awarding implementation/activation credits.

### Native business email transport

`NativeBusinessMailTransport` implements the existing mail port for Cloudflare's configured native EMAIL binding. The inherited `BusinessMailService` still owns queue/claim/receipt state, ownership, mailbox access and ambiguous-send handling. The adapter fixes the configured sender, forwards only supported fields, bounds actual UTF-8 text plus rendered HTML, validates provider receipts and never retries or leaks provider errors. Five adapter checks passed locally. Existing mail service tests now compose this actual adapter with a synthetic native binding; native CI must pass before claiming that combined storage verification. No live message was sent and no mailbox or endpoint was activated.

### Shared native worker composition

`PostgresCommunicationWorker<E>` extends `CommunicationHttpWorker<E>`. It creates the shared PostgreSQL store, inherited conversation/mail services, four channel core, current-session authenticator, current pinned-governance endpoint checker and native email transport once from explicit dependencies. Its trusted `email()` event delegates to the inherited bounded inbound adapter and the same mail service. Ordinary HTTP still has no inbound-ingestion action. A `.d.mts` contract describes the existing JavaScript inbound adapter without copying its implementation.

Six composition checks passed locally, covering session and tenant denial before storage, explicit current endpoint denial, generic database failures, trusted-event byte rejection and required dependencies. These are isolated adapter checks, not live user acceptance. Deployment deliberately remains unmounted: current case/contact/mailbox policies, owned provider configuration, private picture decoding/scanning/storage, native call client integration and the shared registered UI still require completion.

### Accepted-call session and creation-policy checkpoint — 2026-10-22

`BrowserAudioSession` inherits `CommunicationResourceBase` and connects the
existing browser media resource to an injected authenticated registered-channel
transport. It checks acceptance before and after microphone permission,
serializes current-version signaling, handles explicit transactional conflicts
without retrying ambiguous transport errors, filters own signals, validates
sequence continuity and releases resources on remote end or current-access denial.
A local hang-up releases media before its single server end attempt. It adds no
route, role copy, permission grant, Flutter bridge or live activation.

Ten lifecycle tests cover denial, delayed permission, recipient answer, offer
replay prevention, remote end, conflicts, ambiguous failure, malformed history,
concurrent refresh, quiet local close and immediate hang-up cleanup. An additional
registered HTTP test negotiates two sessions, reloads persisted signaling, ends
the call and checks nonparticipant/cross-tenant denial. That test uses native
PostgreSQL in CI and an explicit memory fixture locally. The real-browser test
now exercises this session controller with synthetic microphones and an isolated
signaling fixture instead of directly wiring peer callbacks.

The inherited creation helper now makes a copied proposed conversation or mail
record visible to policy before persistence and on receipt retries. This closes
the missing initial mailbox/recipient context for inbound/outbound mail policies.
Inbound bytes and envelope fields are copied before mailbox lookup; tests verify
that later caller mutation cannot change quarantine content or its digest.
Current outbound-owner and mailbox-read restrictions remain enforced.

Local checks: 114 Node tests passed, one native database policy test skipped
because no disposable PostgreSQL URL is available; seven contract-report tests,
registered route parity and strict TypeScript checking passed. The media suite
passed real raster and inbound-stream tests but failed packet acceptance: both
peers negotiated stable offer/answer while ICE remained New with zero received
packets in this workspace. Microphone cleanup passed. Installing local PostgreSQL
was blocked by this workspace's package/user-switch restrictions. CI results must
be recorded separately; local memory results do not earn native database credit.

Release remains blocked by current case/contact/mailbox policy/provider bindings,
private scanner/storage configuration, gateway mounting, the registered shared
Flutter/native UI/media bridge and owned-user deployed acceptance. No live mail
was sent and no user was called by this checkpoint. Existing auth/QA mail workers
are unchanged. The new session is reusable in permitted browser portals but is
not a claim that existing Flutter messaging stubs now work.

CI run [39849759894](https://github.com/shaikhrais/primecare-platform/actions/runs/39849759894)
completed successfully on source `8c9a162129c9590bbaeb4f3b4bc03abb5a146fd9`. All
five communication jobs passed: 116 Node tests with native PostgreSQL, three
real-media tests (119 Node total, zero failures/skips), 490 Flutter transport
regressions, seven contract-report tests, strict TypeScript, Dart analysis and
the pure Dart channel harness. Production inventory was read-only. Native tests
include proposed-mail policy rejection/retry, immutable inbound content and two
accepted call sessions through the registered HTTP worker and PostgreSQL.

Media artifact12457580245 records Chrome155.0.8059.39 with both peers Connected
and two received audio packets per peer through the new session controller, plus
passing mute/unmute, remote hang-up and track-release checks. This supersedes the
local environment's zero-packet result for scoped CI transport acceptance; it
does not establish live gateway, TURN, physical-device or Flutter-media acceptance.
See [evidence/communication-session-20261022.json](evidence/communication-session-20261022.json).
No business-mail delivery, deployed communication screen or all-user release is
claimed. The concrete live policy/provider/UI gaps above remain open.

### Mailbox inbox contract — registration before implementation

The existing queue/deliver/read operations cannot discover received mail IDs.
The new `email.inbox` design registers one GET contract linked to the same four
communication screens. Inbound listing requires an explicit mailbox ID; outbound
listing always uses authenticated ownership. It returns at most100 metadata-only
summaries and an opaque record-ID continuation (`after`/`nextAfter`) in deterministic
ID order. It does not promise newest-first ordering or expose raw mail/body data.
No caller can choose an actor or tenant. Existing endpoint identities and role
grants are preserved. The native registrar must pass isolated tests and production
dry-run/apply/read-back before this command is implemented or exposed.

Production registration run39850982551 passed six isolated native cases, the
production rolled-back transaction, idempotent apply and independent read-back.
API16512 is registered-unimplemented, linked with the same existing screens;
there are seven communication APIs and28 links. No role grant, account, business
record or activation flag was changed. The read-back is committed in the shared
registered contract catalog, and17 Dart action bindings are reproducible from it.

The implementation adds received/sent listing to the inherited email channel,
mail service, native store and Dart client. The HTTP adapter now chooses its
channel from the registered operation rather than path suffix guesses, allowing
the registered nested email inbox route to reach the correct channel. Validation
rejects owner/tenant overrides, duplicate fields, unbounded pages, and mailbox
selection on sent mail. Current mailbox checks run before storage and on every
returned header/sentinel. SQL projects metadata only, so large raw mail bodies
are not loaded into a mailbox listing. Cursor order is ID order, not chronology.

New service/HTTP checks cover discovery→authorized read, two-page continuation,
headers without raw content/receipts, another mailbox, another owner, cross-tenant
rows, revocation, denial before storage, cursor injection and legacy adapters.
Flutter checks exercise the generated authenticated GET query and prevent an
owner override. The actual legacy/generated communication failure paths now have
regressions through all five ApiClient methods, preserving errors rather than
synthetic success. The pure Dart harness covers the same registered inbox call.

A read-only provider inventory reports only binding names/types for the four
existing auth/governance/gateway/email-inbox Workers. It excludes all plain-text
values, JSON/secret values, mailbox contents and object keys. Configuration names
are evidence of configuration, not live channel acceptance. It makes no provider
changes or mail sends and records missing credentials/read failures explicitly.
Live provider/policy/UI integration and deployed acceptance remain separate work.

The shared ApiClient now exposes a `communications(maxPictureBytes: ...)` factory
for all portals. It reuses its existing private Dio/session/security middleware
and the production-generated17 bindings, with no duplicate login or per-role
implementation. Three tests check all four channel paths, replacement session
headers, retained middleware, denial without fallback/retry and an explicit valid
runtime picture limit. The factory still requires registered UI composition.

Read-only CI source9868690f inspected the actual settings for the existing auth,
governance, gateway and email-inbox Workers. Native EMAIL is configured on auth
and governance. None of these four Workers has an R2 binding or named media/
scanner/signaling binding. The existing receiving Worker has INBOX KV and an
INBOX_ADDRESSES setting; this establishes configured QA reception infrastructure,
not user-owned business mailbox routing. The report contains no setting or secret
values, mailbox contents or private object keys. See
[evidence/communication-providers-20261022.json](evidence/communication-providers-20261022.json).
It does not prove that no such resource exists elsewhere in the account.

The fresh production contract read-back also reports no matching active-role
API-and-screen grants for any of the seven communication APIs. Registration
intentionally changed none. The production handler remains unmounted. Current
case/contact/mailbox policies, scoped grants, private scanner/storage binding,
call relay/native media integration and actual registered Flutter controls remain
release work; passing core/client tests must not be described as an all-user
communication rollout or live business-mail send/receive acceptance.

### Verified inbox and shared-session checkpoint

[Run39852753876](https://github.com/shaikhrais/primecare-platform/actions/runs/39852753876)
passed all five jobs on source `203d42a59a3b08cb2134a4957fa726362ee95cbe`:122
native Node tests plus three real-media tests (125 total, zero failed/skipped),
543 Flutter regressions,10 metadata-report tests, strict TypeScript, Dart analysis
and the pure Dart harness. The authenticated ApiClient factory checks passed.
The native inbox tests exercised the production storage migration in isolated
PostgreSQL schemas, including mailbox scope, ownership, pagination and private
body exclusion. Media artifact12459000667 preserves the actual browser test.

The fresh read-only production audit confirms all seven registered APIs and no
matching active-role API/screen grants. The fresh four-Worker provider snapshot
confirms native EMAIL on auth/governance and no R2 or named scanner/media/signaling
bindings on those inspected Workers. It does not read credentials or messages,
provision resources, change grants, call a person or send live business mail.
See [evidence/communication-inbox-20261022.json](evidence/communication-inbox-20261022.json).

This is scoped code/test acceptance, not all-user rollout. General recipient
eligibility, clinical/HR case restrictions and mailbox ownership/delegation must
have explicit registered requirements before live permission grants are written.
The remaining provider, handler, shared-screen and deployed-user acceptance work
is still open. Placeholder Flutter sections are not marked functional by this
checkpoint; the new inherited clients and session factory are available for the
registered composition once those release requirements are resolved.


### Shared input snapshots (2026-10-22)

CommunicationService now copies attachment IDs, picture bytes and nested call
signals before asynchronous authorization/storage work. The validated content,
idempotency payload and saved record therefore remain consistent when an in-process
caller changes its original array, buffer or description while a policy awaits.
This uses the existing inherited service and registered contracts; it adds no route,
permission, database object or provider binding.

Three adversarial regressions pause authorization, mutate the original input, and
check the saved content. Attachment and signal retries also verify the original
fingerprint remains reusable. All three fail against the previous source and pass
with the fix. Local validation: 123 Node passes, one native PostgreSQL test skipped,
strict TypeScript passes. Native database, media and Flutter CI results must be
recorded separately after this source is pushed. Earlier source-specific acceptance
results above do not certify this source or a deployed all-user release.

The repository still lacks a registered native case/contact/mailbox policy source
and live image-decoder/scanner/private-storage composition. Same-tenant defaults
alone cannot substitute for those missing clinical/HR and mailbox relationships.
The communication worker remains unmounted and user screens remain unfinished.


[Run 39854992734](https://github.com/shaikhrais/primecare-platform/actions/runs/39854992734)
passed all five jobs on source `baf1a8771adbab2c0eee1a707285e87a8d3ff962`:
125 native/service/shared Node tests and three browser media tests (128 total,
zero failed/skipped), 543 Flutter tests, ten metadata report tests, strict
TypeScript, Dart analysis and the pure Dart harness. The three new mutation
regressions passed using isolated native PostgreSQL, not only memory storage.
Media artifact 12459242458 and registry artifact 12458942760 preserve the run.
The fresh read-only audit still reports no matching grants for the seven registered
communication APIs; all-user production rollout remains unverified. See
[evidence/communication-snapshots-20261022.json](evidence/communication-snapshots-20261022.json).


### Registered native access adapters (2026-10-22)

Source `77f767fd5d9b9daae92bf0467d44962e5323ee84` registered
`communication-access-v1` and the empty `communication-mailboxes-v1` directory.
[Registration run 39855660364](https://github.com/shaikhrais/primecare-platform/actions/runs/39855660364)
passed six disposable PostgreSQL registration tests, production rollback validation,
idempotent registration and an independent read-only production readback. No user
accounts, endpoint grants, mailbox mappings or activation were changed.

After that readback, native access/mailbox adapters were implemented using one
inherited `PostgresCommunicationPolicyBase`. Each operation reads the pinned native
policy, current active tenant/accounts, current linked-task participants and
current explicit mailbox ownership/delegation. The default runtime now composes
these adapters; trusted specialized ports remain supported. `general` permits
active same-tenant conversations; unknown references fail closed. Linked task
membership is rechecked after handoff. External recipients require an explicit
contact on an accessible provider-verified owned mailbox. The initial empty
directory intentionally provides no inbound mailbox or external recipient access.

Local checks: strict TypeScript passes, 128 Node tests pass and two native-only
checks skip because PostgreSQL is unavailable locally. The new CI test runs
separately against disposable PostgreSQL to avoid fixture table collisions. It
covers native policies and default runtime session -> endpoint grant -> registered
HTTP -> inherited service -> storage -> reload for messages, pictures, calls and
mail. Provider email and image ports in this integration are synthetic; existing
separate real browser/raster tests provide their own bounded acceptance. Current
source CI results will be recorded after execution. This is not deployed all-user
acceptance; provider configuration, mailbox provisioning, live grants/mounting and
shared functional screens remain open.


The first native runtime acceptance found a malformed test fixture (picture upload
and download omitted their required action fields). The fixture was corrected on
`dd6bbf9df4dd0a26f2e00233a95e1c4e4b834459`; registered contracts and production
validation were preserved. Run 39856663423 passed the native policies/default
runtime integration, including all four channels, plus media, metadata and Dart.
The official-source research is recorded in
[communications-research-20261022.md](communications-research-20261022.md).

The research review also found and fixed inherited binary-reader ownership and
memory-accounting weaknesses. The reader now copies producer chunks immediately
into a declared-size buffer, rejects overflow before reading more, cancels invalid
streams and preserves safe errors when cancellation fails. Three regressions fail
against the preceding source and pass with this implementation. Local updated
validation: 131 Node passes, two native-only skips, zero failures. Final native and
cross-platform CI acceptance must reference the resulting source separately.
