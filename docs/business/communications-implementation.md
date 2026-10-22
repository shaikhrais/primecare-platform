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
malformed/error responses, single-attempt network failure and bounded private picture downloads (including oversized, mislabeled and truncated streams). CI must pass before
this checkpoint is counted as verified. This is an integration adapter, not a
claim that unregistered production commands or Flutter screens are exposed.
Production contract/policy registration, private storage/scanner bindings,
mailbox routing, real call signaling/relay and user acceptance remain open.
