# Shared communication core

All portals and permitted users use the same core. There are no role-specific copies, hardcoded privileged users or default grants. The authenticated transport supplies identity; request data cannot choose an actor, tenant or role. Production policy still decides who can contact whom and which restricted cases or mailboxes they can access.

| Base | Derived code | Shared responsibility |
| --- | --- | --- |
| ScopedServiceBase | CommunicationService, BusinessMailService, BusinessWorkflowService | Validate actor, record type and tenant; always invoke current policy |
| CommunicationChannelBase | MessageChannel, PictureChannel, AudioChannel, EmailChannel | One execute protocol, identity-context protection and channel dispatch |
| CommunicationResourceBase | BrowserAudioCall | Idempotent cleanup, pending-microphone race cleanup, closed resource protection |
| CommunicationResourceBase | BrowserAudioSession | Accepted-call checks, serialized current-version signaling, remote hang-up, polling and media cleanup |
| BoundedBinaryAdapterBase | PrivatePictureRepository, InboundEmailAdapter | Bounded bytes and actual streamed size validation |
| CommunicationChannelClient (Dart) | MessageChannelClient, PictureChannelClient, AudioChannelClient, EmailChannelClient | Shared request construction and authenticated transport dependency |

CommunicationCore in cloudflare/workers/src/business-tasks/channels.ts composes the four server channels. CommunicationHub in packages/flutter_core/lib/communications/communication_core.dart composes the four Dart clients. Composition roots connect already inherited services; they do not duplicate business logic or grant permissions. Storage and transport use interfaces because implementations have different platform dependencies.

## Server use

```ts
const conversations = new CommunicationService(store, policy, pictures, limits);
const mail = new BusinessMailService(store, policy, mailboxPolicy, nativeTransport, sender, mailLimit);
const communication = new CommunicationCore(conversations, mail);
await communication.execute('message', authenticatedActor, {
  action: 'send', id: threadId, key: commandKey, version: expectedVersion,
  text: messageText, pictureIds: [],
});
```

Supply actual active-user/tenant and registered permission/case checks in policy. Pass the actor from the authenticated session, never the body. The shared channel base rejects reserved identity fields. The shared service base rejects wrong tenant/type even if a policy adapter mistakenly allows it. The atomic store rechecks authorization on retries. Conversation membership, call-party isolation, confidential HR cases and mailbox access remain additional checks; inheriting a class alone does not confer access.

Use message/create to open a conversation and message/send or mark_read for updates. Picture/upload delegates to the private decoder/scanner; attach its returned ID in a message, and use picture/open through the authorized service. Audio/invite, accept, decline, end, expire and signal use the accepted-call state machine. Email/queue, deliver and read use the native transport and mailbox policy. Ordinary channel dispatch deliberately exposes no inbound-mail ingestion action: only the configured inbound worker can invoke InboundEmailAdapter and BusinessMailService.receive.

## Flutter use

```dart
final hub = CommunicationHub(authenticatedRegisteredTransport);
await hub.messages.send(threadId, commandKey, version, messageText);
await hub.pictures.upload(threadId, bytes, 'image/jpeg');
await hub.audio.call('invite', threadId, key, version, callId, recipientId: recipientId);
await hub.email.read(mailId);
```

DioCommunicationTransport extends CommunicationTransportBase and maps the hub to an existing authenticated Dio session. Its immutable CommunicationRouteBinding map must come from approved registered contracts; it supplies no endpoint mappings or grants. Shared dispatch rejects identity overrides, missing bindings and GET mutations. Reads use query parameters, pictures use real multipart bytes and bounded private download streams (supply the registered maxPictureBytes limit), and commands retain versions and idempotency keys. Redirects, network failures and malformed/non-success responses remain failures, without automatic retries or demo success. The abstract CommunicationTransport remains available for other approved platforms. Picture uploads carry copied Uint8List bytes and require the approved binary upload adapter. Do not JSON-encode binary data or put business rules in widgets. The Dart client passes server denial through without automatic mutation retries. Widgets can bind to this shared hub after registration; this patch does not make the existing stub screens functional. BrowserAudioCall is a browser media adapter; Flutter/native microphone and media bindings still need platform integration.

CommunicationHub is exported by both flutter_core.dart and business_core.dart. The existing ApiClient also uses the shared isCommunicationPath classifier: registered messaging failures now bypass demo-data and path-only offline-success fallbacks for every HTTP method. This fixes existing transport behavior without pretending a missing server exists. The dio_communication_transport_test.dart suite exercises the inherited dispatcher and authenticated Dio multipart boundary. Communication transport failure tests exercise the actual Dio/ApiClient boundary, including real denial/success responses; the pure Dart harness checks the shared classifier and channel protocol.

## Extend and verify

`BrowserAudioSession` connects the existing browser media adapter to the same
authenticated `execute(channel, request)` transport used by the registered
message/audio contracts. Supply the current authenticated user ID for local
signal filtering, the thread/call IDs, media adapters and scoped ICE configuration.
These IDs never grant server access. Invite and accept through the shared channel
before `start()`. Both parties must still be current conversation participants.

`start()` verifies the accepted call before requesting microphone access and
again after permission resolves. It sends a caller offer or consumes the stored
remote offer and sends a recipient answer. Refreshes are serialized, own signals
are skipped, and sequence gaps/regression fail closed. Polling stops and media is
released on remote termination, access denial or signaling failure. `hangUp()`
releases local media immediately and makes one explicit server end attempt;
`close()` is local cleanup only. Do not attach `hangUp()` to an unawaited unload
promise or claim it confirms a remote end when transport fails.

Outbound signaling is serialized. An explicit 409 rollback can reread the current
version and try a new command key up to three attempts. Ambiguous network errors
never retry. Already negotiated media cannot be resumed by replaying a stored
offer after a browser reload; it requires a new accepted call. The session adds
no public endpoint, credentials, permission grant or automatic call acceptance.
It is a browser adapter, and still needs the registered Flutter/native bridge
and configured relay before live portal/device acceptance.

Run `scripts/test-communication-audio-session.mjs` for lifecycle/conflict/denial
cases. `scripts/test-communication-http.mjs` connects two sessions through the
registered handler and native PostgreSQL when configured. The media test runs
real Chromium peers through these sessions with an explicit isolated signaling
fixture. Neither fixture is a live user or production permission provider.

The inherited `ScopedServiceBase.checkCreation` checks both the existing record
and a copied proposed record before persistence, including idempotent retries.
Conversation case policies and inbound/outbound mail policies can inspect the
actual initial scope. Policy callbacks cannot modify the saved draft. Inbound
envelope/bytes are copied before asynchronous mailbox lookup so the quarantine
content and digest remain consistent.

Add a channel by extending CommunicationChannelBase and delegating to the scoped service. Add a service by extending ScopedServiceBase, with mandatory real adapters. Derive binary and resource adapters from the matching bases. Derive Dart clients from CommunicationChannelClient so request/context protections stay inherited. Register new live entities and permission contracts before exposure. Never add a permissive production policy or treat a test fixture as a production adapter.

Run the shared business tests, scripts/test-business-communications.mjs, scripts/test-communication-adapter-base.mjs and scripts/test-business-media.mjs. Native PostgreSQL CI tests persistence/rollback/concurrency; real-browser CI checks actual audio packet counters. tools/communication-client-check.dart exercises the pure Dart client contract independently of unrelated Flutter dependencies. This is not a physical-device or deployed portal acceptance test.

The media job uses the Chrome installed in the GitHub Ubuntu 24.04 runner image, fails if it is unavailable, and records the actual browser version. It avoids another browser/system-package download while retaining the same two-peer packet assertions. See the [runner image inventory](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md).

See [implementation and release gaps](../../../../docs/business/communications-implementation.md). Existing business task APIs remain backward compatible through store.ts contract re-exports. Pinned production governance is the only live registry; this source directory is not a second authority.

### Native worker composition

`cloudflare/workers/src/business-tasks/runtime.ts` exports `PostgresCommunicationWorker`, which inherits the registered HTTP worker and composes the shared store/services/channels with native PostgreSQL sessions, pinned current governance grants and the configured native EMAIL binding. Supply both database pools, current case and mailbox policies, a private decoding/scanning picture repository, a real JSON Schema validator and explicit byte/channel limits. Missing configuration fails closed. The trusted `email(message, env)` event uses the same inherited mail service through `InboundEmailAdapter`; it is never exposed as a user HTTP command. This composition is not currently mounted in the gateway.

### Received and sent mailbox discovery

Production registration run39850982551 added API16512 (`GET /v1/messages/email/inbox`)
before implementation, preserving the other six identities and every role grant.
The shared `EmailChannelClient.inbox` and server EmailChannel use the same inherited
protocol. Supply `direction: inbound` and a configured mailbox ID, or `direction:
outbound` with authenticated ownership only. Both accept an optional bounded
`limit` (1–100, default50) and an `after` record ID; `nextAfter` is null on the last
page. Ordering is deterministic record-ID order, not arrival time.

The mail service checks current mailbox scope before listing and rechecks each
record, including the pagination sentinel. PostgreSQL filters tenant, record kind
and owner/mailbox before a bounded `limit+1` header-only projection. Neither raw
mail, text/HTML bodies, provider receipts nor internal ownership fields appear in
the returned summaries. Use authorized `email.read` for one discovered record.
Inbound content remains quarantined with unverified sender identity. This does
not parse or approve arbitrary MIME/attachments or create a deliverable mailbox.

`AtomicStore.mailInbox` is an optional extension for compatibility with older
workflow adapters. The registered new operation fails if an adapter lacks it;
old queue/read operations continue to work. The native PostgreSQL implementation
and isolated memory fixture implement the extension. All seven registered APIs
reproduce17 Dart bindings from an independently read production snapshot.

The shared failure classifier also covers the eight existing controller/generated
communication paths. Their errors cannot become offline/demo success. This is
failure handling, not backend aliases or functional status for placeholder UI.

### Existing portal session connection

Use `ref.read(apiClientProvider).communications(maxPictureBytes: approvedLimit)`
to obtain all four inherited channel clients using the existing private Dio
instance, current session/security interceptors and production-generated bindings.
No portal needs to create or expose another Dio instance, copy tokens, hardcode a
role or repeat endpoint maps. The factory adds no interceptor, login, grant, cache
or retry. The explicit byte limit remains approved runtime configuration.
Transport denial still throws instead of entering ApiClient demo/offline fallbacks.
This binds the client layer; it does not make a placeholder screen functional.


### Asynchronous input ownership

CommunicationService snapshots attachment lists, upload bytes and nested call
signals before asynchronous authorization. Callers retain ownership of their
original inputs; changing them after invocation cannot change validated content,
command fingerprints or saved communication records. Inbound email separately
copies its raw bytes and envelope before mailbox resolution. Regression tests
pause policy resolution to exercise these boundaries.


### Native account, task and mailbox policies

`PostgresCommunicationAccessPolicy` and `PostgresCommunicationMailboxPolicy`
extend `PostgresCommunicationPolicyBase`. The default worker composes these
adapters when specialized trusted policy ports are omitted. Explicit malformed
ports still fail construction. Native policies read the pinned manifest and both
registered policy documents in a bounded read-only snapshot on every action.
They never create accounts, grant endpoint access or write mailbox configuration.

Use the registered `general` business reference for general same-tenant active-user
conversations. Any other reference must identify an existing workflow aggregate;
all conversation members must remain current originator/owner/reviewer participants.
Unknown clinical/HR references are denied. A task handoff can therefore make an
older linked conversation inaccessible; there is no silent expansion of membership.

Owned addresses come from `communication-mailboxes-v1` in native
`govt_platform_hierarchy_policy`. Each governed entry contains `id`, `tenantId`,
`address` (lowercase), `ownerId`, `delegateIds`, `recipientAddresses`, `active` and
`ownershipVerified`. A separate governed provisioning operation must verify actual
provider ownership before creating entries. The initial production directory is
empty. It grants no inbound mailbox or external-contact access. Active same-tenant
account emails are permitted outbound recipients; known inactive/cross-tenant
accounts cannot be reclassified as external contacts. All other addresses require
an explicit contact on a currently accessible owned mailbox. Owner/delegate and
active-tenant checks are current, including retries and incoming email ingestion.

The registered policy is a requirement, not a release approval. Endpoint/API and
screen grants remain separate. The worker remains unmounted pending providers,
mailbox provisioning, shared screens and deployed acceptance.


The inherited binary stream reader copies each chunk immediately into a single
buffer bounded by the declared size. It retains no chunk list, so reused producer
buffers and many empty chunks cannot change prior content or grow bookkeeping.
It cancels invalid streams, rejects declared-size overflow immediately and preserves
the original input error if provider cancellation itself fails.


### Shared messaging presentation

Four existing Flutter screen entry classes now inherit `CommunicationScreenBase`.
They compose `CommunicationWorkspaceView` and a session-owned
`CommunicationWorkspaceController`, derived from one lifecycle base. Public
exports are available from primecare_ui and both Flutter core entry points. The
workspace uses `ApiClient.communications()` and registered generated control/text
bindings; the view contains no API paths, grant lists or version calculations.

Inbox/open/create, text messages, read receipts and private picture draft/preview
use the same clients. Refresh re-reads the selected conversation while retaining
unsent picture references. Keyboard input is disabled during work. Uncertain
writes retain the original immutable key/version/payload for explicit retry;
wrong acknowledgements and later denied reads cannot turn uncertainty into a new
write. A second click cannot overwrite the first action's result. Account, tenant,
token or role changes dispose private state; no role grants are inferred locally.

The registered labels support en/fr/es and responsive, live-region presentation.
Known recipient account IDs are required until a governed contact picker exists.
This messaging view does not yet expose the core's call/mail clients. Native media,
mailbox/provider provisioning, activation/grants and deployed acceptance remain
separate release work. All presentation implementation tags remain unverified.


Call-party signal privacy is projected by the same service helper for conversation
inbox and direct reads. Third conversation members receive no offer/answer/ICE
signals through either surface. Projection copies records and cannot erase stored
signals needed by the actual parties. Service and registered-HTTP regressions
exercise both parties and a third member.


### Shared call and email presentation

The four `CommunicationScreenBase` entries compose the same inherited
`CommunicationMailController` and `CommunicationCallController`, both derived
from `CommunicationCommandControllerBase` and `CommunicationWorkspaceControllerBase`.
The mail controller implements explicit queue → deliver and exact-command
confirmation; accepted and unknown never enable a replacement delivery. Inbound
views display the authorized envelope and a bounded unverified plain-text preview
when available. Raw MIME, HTML and attachments are excluded from user responses
and presentation state, including inbox summaries.

Call actions refresh the current conversation/version and admit only actual
parties. Media connection is a separate accepted-call action. Account/tenant,
token/role changes, conversation changes, view disposal and media denial release
resources. Trusted host composition may override `communicationMediaFactoryProvider`
with `browserCommunicationMediaFactory(configuration: freshIceConfiguration)`.
The default remains unconfigured and reports an error. This does not grant access
or provision a relay. Native hosts need their own adapter implementing
`CommunicationMediaSession`; no simulated native call is provided.

The typed Dart browser adapter loads one same-origin packaged asset generated by
`node tools/communication-media-bundle.mjs --generate`. It bridges the authenticated
hub to the existing `BrowserAudioSession`; it does not duplicate SDP/ICE logic or
add an endpoint. `node tools/communication-media-bundle.mjs` verifies the asset.
CI compiles the Dart adapter and exercises two real Chromium peers, packet counts,
mute/unmute, track/peer closure and audio-element removal using an isolated
transport fixture. It is not deployed end-to-end acceptance or a product screenshot.


### Received text projection

`InboundMailTextPreview` inherits `BoundedBinaryAdapterBase` and uses pinned
postal-mime 4.1.2. Its limits are generated from the same independently read
production registration as the Dart UI catalog. It caps raw parse bytes,
aggregate headers, MIME nesting/parts, decoded UTF-8 text and subject length.
Attached/nested messages are not expanded. Plain-text parts take precedence,
including when invalid or oversized: a rejected plain body never falls back to
alternate HTML. HTML-only mail uses `HtmlMailTextExtractor`, another
`BoundedBinaryAdapterBase` subclass, with pinned htmlparser2 12.0.0 callbacks.
Generated limits cap decoded HTML bytes (65536), nesting (48), callback events
(8192) and UTF-8 output. Formatting/structural elements provide text and block
separators; unknown/active/embedded subtrees, explicit hidden/aria-hidden content,
comments and attribute values are omitted. No document, network requests, CSS,
script or URL execution occurs. This is approximate text extraction; CSS layout
and visibility are not evaluated, so styled hidden text may appear as unverified
text. Entity-decoded markup-shaped text is still rendered as Text only.
Attachment-only, empty, excluded-only or over-budget mail retains an unavailable
preview warning. Failed extraction returns no partial content or subject.

`BusinessMailService.read` first authorizes the current stored mailbox record,
then projects untrusted text, then rechecks current mailbox access. Every parser
result is validated and copied at that boundary, including trusted injected ports.
Only envelope identity, quarantine metadata and a bounded `contentPreview` are
returned for inbound mail. Raw MIME and digest remain in quarantined storage;
reads do not release quarantine, verify a sender, alter a record/version or send
mail. Repeated reads and legacy records use the same projection. Client state
validates the preview again and renders Text under the registered warning.

Run `scripts/test-communication-mail-preview.mjs`, service/HTTP/native-policy
checks, Flutter mail-controller and channel-widget tests. Native PostgreSQL
and the full default runtime path are exercised in communication CI. Live
mailbox provisioning, endpoint grants/mounting and deployed acceptance remain
separate and unverified.

### Private picture object and access consistency

`PrivatePictureRepository` continues to inherit `BoundedBinaryAdapterBase`.
Its `open(actor, pictureId, threadId)` contract requires the expected conversation
and validates the metadata of the actual downloaded object. A prior `head()`
check cannot authorize a replacement object. Both metadata lookup and download
require matching identity/tenant, clean PNG type, a nonempty conversation and a
positive bounded size matching the storage object's size. Metadata projections
are immutable and exclude extra provider fields. Rejected stream bodies are
canceled; cleanup failures preserve the original denial.

The inherited `CommunicationService` snapshots the actor and rechecks current
conversation policy after upload processing and after opening the private body.
Denied downloads cancel the opened stream before returning an error. This
implements the existing current-active-account/task-scope policy without adding
an API, screen, grant or role-specific path. It is a final check before response
handoff, not continuous authorization after streaming begins. A denied upload
may leave an unattached private processed object; no conversation message is
created and no automatic deletion is attempted. Live private storage/scanner
composition and retention cleanup remain deployment concerns.

Run `scripts/test-communication-pictures.mjs`, service/HTTP/native-policy suites
and the real raster/browser checks in communication CI.

### Audio cancellation and ended tracks

`BrowserAudioCall` and `BrowserAudioSession` continue to inherit the same
`CommunicationResourceBase`. Each awaited SDP/ICE stage checks that the resource
is still open before proceeding; a late completion cannot start the next peer
operation or create a new offer/answer signal after close. Captured late ICE,
track and connection callbacks ignore closed resources. Candidate callback
handling contains synchronous port/serialization errors as well as rejected
promises, closing resources on failure.

Unexpected browser microphone `ended` events close the local call and inherited
session, removing the polling timer, peer handlers and track listeners. A track
already ended at startup fails closed. Normal cleanup still explicitly stops
tracks: the browser `stop()` API does not dispatch `ended`. This performs local
cleanup only; it does not add an automatic server hang-up mutation. Explicit
hang-up remains separate. Already dispatched network requests cannot be recalled.
Regenerate/check `audio-bridge.js` with `tools/communication-media-bundle.mjs`
and run adapter/session, compiled-Dart browser and real packet checks.

### Full browser stack acceptance

`communication-stack-acceptance.yml` builds a disposable Flutter host around the
existing `PrimeAuthExperience`, real `AuthNotifier`/`ApiClient` and existing
`CommunicationScreen`. It does not inject authentication or communication
transport success. The actual gateway forwards exact registered communication
paths to the native runtime, which checks current PostgreSQL sessions, endpoint
and screen grants, account/task/mailbox policy and versioned storage. The test
uses a dedicated loopback database and refuses production credentials or existing
tables. Picture raster decoding is real; scanner, private bucket and mail-provider
acceptance ports are synthetic. Browser microphones are synthetic and no TURN
relay is configured. This is isolated full-stack acceptance, not deployment.

Auth login, completed MFA and current-session replies now include an optional
validated server-resolved tenant claim under the independently registered response
extension. Legacy unscoped accounts remain unscoped. Flutter restoration uses
current server scope and clears cached overrides; the client never grants access.
The production governance service still requires explicit runtime composition,
provider configuration and approved grants before activation.

### Registered ICE signaling boundary

The registered audio API uses `signal.type = ice`. BrowserAudioSession maps the
browser adapter's native `candidate` event into that wire value and maps stored
`ice` records back before calling the browser adapter. CommunicationService
validates and persists the registered value. The unregistered `candidate` wire
alias is rejected by HTTP schema validation. Candidate content, current-call
membership, version checks and signal byte/count limits remain enforced.

### Workers-compatible schema validation

`tools/communication-schema-validators.mjs --generate` compiles all seven pinned
registered API request/response schemas into a bundled standalone module. Normal
check mode rejects drift; the route-binding provenance check must pass first.
Ajv is a build dependency, not a runtime compiler. The native inherited runtime
supplies the compiled validator by default and rejects unknown schema identities.
An optional extra validator can restrict acceptance but cannot bypass the
registered schemas; its output is revalidated after any synchronous mutation.

The actual browser and native PostgreSQL acceptance hosts omit an injected
compiler. Differential checks cover every registered request variant and response,
including ICE wire values, email formatting, Unicode lengths and unchanged input.
A VM forbidding string code generation checks the bundled module, and the
`worker-validator` CI job additionally runs it in workerd. These checks do not
activate production channels, create grants or verify external provider delivery.

### Shared Node and Workers picture codecs

`PrivatePictureRepositoryBase` owns byte limits, scope snapshots, both mandatory
scanner stages and private object storage/read validation. The existing
`PrivatePictureRepository` constructor still accepts Sharp for Node. The derived
`WorkersPrivatePictureRepository` accepts a native Images binding and an
R2-compatible private bucket; it uses raw streams rather than public image URLs.
Missing codecs, scanning or bucket methods fail closed. Neither adapter grants
conversation access; the inherited service still authorizes before and after I/O.

The Workers codec checks format, exact source byte size and bounded dimensions,
then decodes/re-encodes through Images to static PNG. A bounded CRC-checked PNG
container guard rejects animation, truncation, trailing bytes and unknown critical
chunks. Encoded output retains only IHDR/PLTE/IDAT/IEND/tRNS, preserving pixel and
transparency data while dropping text, EXIF and profiles. The guard is not a
replacement decoder or malware scanner. Output is read into one bounded buffer;
invalid/oversized streams are canceled. Callers and scanners receive isolated
bytes, and tenant scope is captured before asynchronous work.

CI adds actual local workerd Images/R2 integration, real JPEG/PNG decoding and
alpha/metadata checks. The full Flutter browser scenario now uses local Images/R2
instead of a map bucket and Sharp repository. These local emulators and synthetic
scan decisions do not prove remote provider, production private bucket or live
scanner acceptance. Existing grants, ownership, activation and release gates apply.

### Inbound event and stream ownership

`InboundEmailAdapter` snapshots the SMTP envelope, raw stream/size and bound
rejection callback before its first suspension. MIME headers never choose an
owned mailbox. Cloudflare's native envelope fields are readonly; this also keeps
trusted host adapters with mutable event objects from changing that decision.
The shared `BoundedBinaryAdapterBase` cancels unread invalid-size bodies and
releases acquired readers after success or failure. It permits up to declared
bytes plus 1,024 delivered chunks, bounding empty-chunk work while preserving
fragmented byte streams. This is a read-count budget, not a wall-clock deadline.

Malformed input is rejected with generic messages. Read/provider and persistence
failures propagate, so they are not converted into permanent SMTP rejections or
fake receipt success. Tests include native workerd streams with synthetic event
and storage ports, plus the existing native PostgreSQL mailbox-policy scenario.
These tests do not establish live SMTP delivery or production routing approval.
