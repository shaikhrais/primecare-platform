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

### Typed native Worker composition

`cloudflare/workers/src/business-tasks/workers-runtime.ts` exports
`WorkersCommunicationWorker`, derived from `PostgresCommunicationWorker`. Supply
the existing database/email/limit dependencies plus `images`, `pictureBucket`,
`scanPicture` and `maxPicturePixels`. The root constructs the native private
picture repository with the same `limits.maxPictureBytes` used by the service.
Missing capabilities fail at construction. A competing `pictures` override is
rejected; use the existing parent composition for another trusted codec.

```ts
const worker = new WorkersCommunicationWorker({
  ...nativeDependencies,
  images: env.IMAGES,
  pictureBucket: env.PRIVATE_PICTURES,
  scanPicture: approvedScanner,
  maxPicturePixels: configuredPixelLimit,
});
```

This example names capabilities; it does not create a scanner, bucket, grant,
mailbox or endpoint mount. The parent owns current sessions, endpoint/screen
checks, scoped services, all four channels and trusted inbound email. Declaration
files expose the actual binary/picture inheritance and narrow capability ports.
The browser acceptance host uses this derived root with local Images/R2 and real
disposable PostgreSQL. Separate workerd checks use synthetic database ports and
actual local image/storage bindings. Existing production release gates apply.
The complete Worker inherits the shared compression layer's Node built-ins; its
pinned July test runtime explicitly enables `nodejs_compat`. The standalone
validator and inbound adapter checks remain separate without that flag.

### Twilio shared-number extension foundation

### Twilio SMS notifications and delivery tracking

`createTwilioCommunicationServices` composes the inherited voice/token services,
`SmsNotificationService`, official SDK SMS transport, signed callback adapter and
durable PostgreSQL observation store. It requires explicit policy, consent/contact
policy, provider principal, live directories, verified sender and secure settings.
It does not mount routes or activate any grant, number or schema.

The SDK factory exposes only `messages.create`, uses server-side API-key auth,
a ten-second timeout and no automatic retries. The transport fixes both the
selected sender and Messaging Service and supplies an exact status callback.
It treats ambiguous provider errors as unknown acceptance, never proof of failure
or permission to resend. Recipient country must be resolved by the trusted
recipient policy: the +1 prefix alone cannot distinguish Canada from the US.

The SMS service extends `ScopedServiceBase`, authorizes queued drafts and current
records, checks ownership and tenant scope, and uses an atomic one-attempt claim.
Consent/opt-out is checked at queue, claim and just before sending. Retries of a
claimed notification do not invoke the provider again. A denied final check can
leave a claimed record requiring operational reconciliation, without sending.

The callback and voice adapters share `TwilioSignedFormAdapter`, which inherits
the binary limit/cleanup base. Signature validation includes all form parameters
and the exact configured public URL. Provider body fields cannot choose a tenant.
`PostgresSmsObservationStore` persists observations before acknowledging, resolves
them by unique stored account/message receipt, and quarantines early callbacks.
An approved worker must invoke reconciliation after send receipts are committed
and periodically; this code does not create a scheduler. The internal principal
requires `sms.status.receive` under current policy. Durable callback writes do
not hold a pool connection while acquiring another through the scoped service.

Repeated and late observations cannot downgrade delivery. Contradictory terminal
states become `reconciliation_required`; SMS has no read confirmation here. Error
codes are persisted without copying provider descriptions into responses.

`20261023_business_sms.sql` is an unapplied schema candidate with separate SMS
aggregate/command/event and callback tables and a unique provider receipt index.
`PostgresAtomicStore` uses a validated table family for shared run/read primitives;
its default business tables and existing inbox behavior are preserved. Register
the exact schema/actions/endpoints in pinned production governance before use.

Checks: 127 local Node tests and 14 workerd assertions passed; strict TypeScript
checks passed. Official SMS request serialization uses a simulated HTTP port;
no SMS or phone call was placed. The disposable PostgreSQL integration script
and CI service are prepared but have not run locally because no disposable
PostgreSQL server is available. This is not persistence or live-provider proof.

### Voice implementation

`PostgresVoiceDirectory` implements both incoming extension lookup and token
directory ports against current native users, tenants and sessions. Token lookup
accepts only a trusted server-side session hash, not a user ID or raw bearer token.
`VoiceExtensionService` derives from `ScopedServiceBase`; assignment and
publication use distinct mandatory policy actions and target eligibility checks.
`createPostgresTwilioCommunicationServices` composes these native directory ports
with the SMS/voice services without mounting any endpoint.

The candidate `20261023_voice_extensions.sql` uses a global 100000–999999 sequence,
unique extension and tenant/user keys, and versioned explicit publication.
Assignments start unpublished; there is no reassignment or delete operation.
Publication is concurrency-checked. Native directory membership is locked and
rechecked during writes. Proposal authorization runs before acquiring the write
connection, with version comparison afterward, so pool-backed policy reads do
not wait on a connection held by the directory itself. Concurrent assignments
may return a version conflict and consume an unused sequence value; a retry reads
the committed mapping rather than reassigning it.

Nine additional local tests cover authorization/publication and session input.
Disposable PostgreSQL coverage includes global uniqueness, version conflicts,
unpublished defaults, inactive users and a single-slot pool whose policy reads
use the same pool. It is prepared but not yet executed. Existing native policy
deliberately rejects all new Twilio actions until exact governed registration.

`TwilioVoiceTokenService` in the Worker business-task layer extends
`ScopedServiceBase`. It is an internal service, not a mounted endpoint. A trusted
session directory supplies current identity and expiry; a destination directory
must return exactly one current published tenant/user extension. Session,
destination and mandatory `voice.token` policy are rechecked before returning
the official SDK JWT. Tokens last at most 300 seconds and no longer than the
remaining session lifetime. The signing key and TwiML App SID are server
configuration; requests cannot select tenant, identity, app or lifetime.
No key, directory, policy grant or public route is provisioned by this service.
Its unit tests use synthetic credentials; they do not establish live calling.

The user-requested requirement `communication-twilio-voice-v1` was registered in
pinned production governance before implementation, with zero numbers, extension
assignments or grants. `TwilioVoiceExtensionAdapter` inherits the same binary
base and uses the official pinned `twilio@6.2.0` signature validator and TwiML
builder. It is an internal provider adapter; no Twilio webhook is mounted.

Supply a verified owned number, Account SID/Auth Token, exact HTTPS incoming and
gather URLs, a byte limit and a trusted `directory.lookup(extension, 2)` port.
The port must return current published tenant/user voice destinations, never an
unscoped first-match search. Extensions are globally unique six-digit values
100000–999999 behind the shared number. Unknown, duplicate, unpublished, inactive
or changed destinations produce the same generic unavailable response. Tenant and
user identities come exclusively from current directory matches, are copied
before suspension and are rechecked before rendering Dial. SDK client identity
is derived from both IDs using `twilioVoiceIdentity`.

All form fields participate in official signature validation, including future
fields and repeated values. Critical account/number/direction/extension fields
cannot use duplicate values. Exact configured URLs are used without trusting
forwarded-host headers. Form decoding rejects invalid UTF-8/percent sequences.
The inherited reader supports both known and absent Content-Length while bounding
real bytes, chunk count, allocation and cleanup. Directory/read infrastructure
failures remain generic unavailable responses.

The result prompts with Gather and renders Dial/Client only: it does not make a
REST call, forward to arbitrary phone numbers, record calls, buy a number, issue
Voice SDK tokens, assign/publish extensions or grant application access. A phone
extension is public voice routing, not an authentication secret. SMS/MMS cannot
be assigned by a voice extension; keep the existing in-app messaging and email
channels separate. Actual account configuration, durable governed extension
assignment/publication, registered webhook/token endpoints, SDK device integration
and live phone acceptance are still required.


`TwilioVoiceDevice` extends `CommunicationResourceBase` and owns an injected
Twilio Voice SDK Device. `start()` waits for the SDK `registered` event, with a
bounded timeout. Concurrent renewals share one authenticated request. A changed
session generation or identity, failed renewal, SDK error, unregistration or token
expiry destroys the device and disconnects calls. `close()` must be called by the
host on logout, tenant switch and disposal; checking scope on asynchronous results
is additional protection, not an authentication subscription. Token transport must
request a fresh token through the registered authenticated server endpoint and
must not cache or log it. The factory uses `new Device(token)` from the official
SDK; no provider credential or SDK singleton belongs in the shared core.
Incoming calls are rejected by default. An explicitly supplied host callback owns
the authorized ringing UI; this adapter never automatically answers a call or
exposes an outbound phone dialer. The adapter is unmounted. Port tests cover race
and failure behavior; actual SDK/network/device acceptance remains required.

`TwilioExtensionConnectService` extends `ScopedServiceBase` for same-tenant SDK
extension calls. It fetches the canonical Call resource with an official read-only
Twilio SDK port, checks account/SID/direction/live status and caller identity, then
resolves both published destinations twice and checks current `voice.call.connect`
permission twice. Provider form fields never become tenant or user authority.
`TwilioExtensionConnectAdapter` inherits the signed bounded form boundary and
renders only the authorized Client identity with the fixed shared caller number.
`createPostgresTwilioExtensionConnectHandler` is an explicit separate composition
root; no endpoint or permission is mounted or registered by constructing it.

The browser resource's `connect({callerExtension,targetExtension})` passes only
six-digit extensions to the SDK. It allows one pending/active outgoing call,
removes ended-call listeners, and disconnects a late result after logout. The
caller extension is a selector, not proof of caller identity. Server canonical
Call verification and current native policy remain mandatory. Incoming host UI
still owns answering/rejecting and must dispose this resource on auth changes.
Tests cover the official REST request serializer, synthetic Call resources and
native Worker execution. They do not place a call or prove production billing,
permissions, device availability, provider webhooks or live phone acceptance.

### Extension ringing and voicemail (candidate, unmounted)

One published extension maps to one current tenant/user identity. The receiving
user must sign in, register the Voice SDK Device, enable audio/microphone access,
and keep a supported app/browser session available. The SDK rings registered
instances of that identity, not everyone in the tenant. This implementation does
not forward to a personal telephone or register native mobile push notifications.
If several devices use the same identity, Twilio may ring those registrations;
first-answer and cancellation across devices need live acceptance.

`TwilioRingingCall` extends `CommunicationResourceBase`. It owns ringing,
answering, connected and ended state, explicit authorized Answer, Decline, Mute
and End Call actions, caller cancellation, and logout cleanup. The optional DOM
panel uses text nodes and accessible status/buttons. Example host integration:

```js
const device = new TwilioVoiceDevice({
  createDevice: token => new Device(token),
  fetchToken, currentScope,
  onIncoming: call => mountTwilioCallPanel({
    element: incomingCallPanel, call, currentScope, authorizeAnswer,
  }),
});
```

All ports above must be real authenticated application bindings. `authorizeAnswer`
is required and must recheck current permission through the server before accept;
never substitute a default `true`. Return the panel resource so device disposal
also closes the ringing/answered call. Host logout and tenant switch must close
the device immediately. Device busy checks reject competing managed calls. Browser
sound restrictions and background suspension can prevent ringing; the browser
panel is not evidence of native mobile incoming-call support.

Opt-in voicemail first persists the exact call/extension/tenant/user mapping,
then adds a Dial action callback. Busy, no-answer and failed outcomes offer a
recorded message after a disclosure and beep. Answered/completed/canceled calls
hang up without recording. Record uses a separate finish action and completed
recording-status callback, 120-second maximum, five-second silence timeout and
pound to finish. Conversation audio is not recorded. Empty recordings do not email.
Both phone-number inbound routing and SDK extension calls support the opt-in Dial
callback. Keep it off until all contracts, storage and endpoint bindings exist.

`VoicemailService` inherits `ScopedServiceBase`; its PostgreSQL repository stores
immutable owner routing and one unique recording per call. Only a signed completed
callback and canonical Recording resource matching account, call, source, duration
and status can queue notification. Current directory/policy checks precede capture
and notification. Mailbox resolution must return the destination user's current
active verified address. `BusinessMailVoicemailNotifier` queues the existing
inherited mail outbox with a stable recording key; queue acceptance is not email
delivery. Retries must preserve that key. No callback-supplied address, tenant,
user or RecordingUrl is trusted.

Email contains a sign-in link to the owner's voicemail, not public audio or a
Twilio credential. Registered playback handlers must call `voicemail.audio` with
the authenticated server actor and `TwilioVoicemailAudioAdapter`; owner/tenant and
permission are checked before and after the bounded private audio download. The
adapter constructs the provider URL from SIDs, disallows redirects, bounds WAV
bytes and keeps credentials server-side. The app playback endpoint and UI are
not mounted by these modules. `createPostgresTwilioVoicemailServices` composes the
candidate native services; mailbox and mail adapters remain mandatory host ports.
No extension assignments, grants, migration application or live email sends occur
on construction. Run Node tests, Worker checks, real-browser panel checks and the
disposable PostgreSQL suite before release; then perform live device/phone/email
acceptance.

### Reception and defined AI tasks (candidate, unmounted)

An optional server-configured `receptionExtension` changes the initial prompt:
enter a known six-digit extension, press zero then pound, or wait for reception.
Empty/zero/invalid/unknown extensions resolve that reception extension through the
same unique published current directory and revocation checks as ordinary users.
Duplicate critical form fields cannot choose reception or another tenant. There
is no hard-coded person, personal phone, inferred tenant or automatic assignment.
A shared number without identified tenant context uses platform reception; a
future tenant-specific reception selector must resolve tenant context explicitly.
If reception is unavailable, do not silently route to a different tenant.

`VoiceTaskService` extends `ScopedServiceBase`; `VoiceTaskBase` and
`BoundVoiceApiTask` supply a reusable provider-neutral task boundary. Vapi function
tools or a Twilio ConversationRelay server can propose only host-registered task
IDs through this service. The model never selects actor/tenant/credentials or a
URL, SQL statement, unrestricted API operation, or permission. Each task validates
strict typed arguments, generates a deterministic summary, and binds an existing
business service with its own ownership/version/permission checks.

The server authentication broker must verify a caller through OTP sent to an
already verified account contact or passkey in the signed-in app, then persist a
call/session/user/tenant binding. Do not derive this from caller ID or voice
similarity. The LLM must never receive an OTP, raw verification secret or auth
credential. The current identity port accepts only fresh active OTP/passkey
bindings, and is checked again just before execution. Identity verification alone
does not approve an operation.

The gateway persists an exact bounded proposal with SHA-256 digest, task version,
call/session/user/tenant binding, server summary and expiry (at most two minutes).
A separate trusted app-confirmation or signed DTMF-event store must atomically
consume approval for that exact digest. A transcript, model argument `confirmed`,
spoken yes interpreted by the LLM, or stale confirmation cannot satisfy this port.
Execution revalidates the proposal, definition and current policy, atomically
claims one attempt and calls the bound service using a stable idempotency key.
Provider timeouts or crashes leave unknown/executing outcomes for reconciliation;
no automatic repeat of a potentially completed task. Status/timestamps provide
execution evidence without persisting private provider errors.

`PostgresVoiceTaskRepository` and its candidate migration implement the durable
proposal/claim boundary; `createPostgresVoiceTaskService` composes it. Neither the
OTP broker, one-time confirmation store, Vapi webhook credentials, Relay WebSocket
handler nor real business task registrations are installed by this code. An empty
task catalogue enables nothing. All new task permissions remain default-denied.
A host must authenticate the provider transport independently, and resolve these
trust ports from server state rather than tool arguments before mounting.

### Durable app approval and first reception tasks (candidate)

The user selected callbacks and appointments as the first agent scope.
`createReceptionAppointmentTasks` returns three `VoiceTaskBase` subclasses:
`reception.callback.request`, `appointment.booking.request` and
`appointment.reschedule.request`. They accept only typed reason/window or
service/appointment/slot references, future exact UTC instants and expected
versions. Model-supplied tenant/user/contact/URL/confirmation fields are rejected.
The server summary says request and subject to availability; success is not a
claim that an appointment is booked. A host must bind approved request services
that independently check account contact, ownership, slot/time correspondence,
current availability, version and idempotency atomically. No arbitrary HTTP
adapter or operations-role impersonation is provided. Current client appointment
APIs were inspected and are read interfaces; care scheduling mutations are
operations-restricted. This code does not bypass those boundaries.

`PostgresVoiceTaskConfirmationService` extends `ScopedServiceBase` and implements
`VoiceTaskTrust` with a mandatory server OTP/passkey identity broker. `preview`
returns the exact proposed summary/digest/expiry to the authenticated native app.
`approve` requires that native owner, tenant, current call/session binding,
`voice.task.confirm` permission and displayed digest. Approval lasts at most one
minute and is consumed atomically once. Repeated approval preserves the original
expiry. Expired/consumed proof requires a fresh proposal; it cannot be silently
renewed. Consumption repeats current identity/policy checks and matches all
call/session/user/tenant/proposal/digest fields against the proposal table. The
existing task gate rechecks permission and claims one execution afterwards.

Only a registered authenticated native app endpoint may expose preview/approve;
its host must enforce native session authentication and CSRF. Never expose
approve as a Vapi/Relay tool or derive the actor from agent JSON. Use an opaque
server binding ID or token hash, never a raw bearer token, as sessionId. Native
logout/revocation must invalidate the call identity broker binding. A transcript,
caller ID or voice-match result never establishes that binding. No OTP code is
accepted, stored or returned by the confirmation service.

`createPostgresConfirmedVoiceTaskServices` composes the durable proof gate;
`createPostgresReceptionAppointmentVoiceServices` adds the selected typed task
catalogue with required business request ports. Candidate schema and all new
permissions remain unregistered/default-denied. Production OTP issuance/binding,
request-writing APIs, app routes/screens, provider authentication and live AI
runtime remain required. Deterministic local tests and disposable PostgreSQL
checks distinguish synthetic identity/request ports from real call/booking
acceptance; no appointments or callback requests are created in production.

### Twilio Verify provider port (server-only, candidate)

`createTwilioVoiceOtpClient` uses the official REST SDK with a fixed server-selected
verified account contact, configured Verify Service SID and SMS channel. It
exposes only start and check, never service administration, custom-code setting,
manual status approval, contact changes or arbitrary SDK options. Checks address
the exact persisted Verification SID; response account/service/contact/channel/SID
must match before only the authoritative approved status succeeds. Secrets and
raw codes are never returned or included in errors. Uncertain sends are not
retried automatically. The shared SID boundary also rejects trailing newline
values instead of accepting JavaScript's end-anchor exception.

This is a provider port, not an identity grant or complete OTP broker. The host
must authorize/limit and durably claim each send, resolve current verified account
contact, bind the exact returned SID to call/user/tenant/session, enforce attempt
limits/expiry and contact/session revocation, and accept code entry through a
registered secure flow outside the LLM. Do not construct this client from a caller
or model-supplied number. Persist a verification receipt before checking; after a
Worker restart, reconstruct the provider from the trusted record. Failures remain
unverified. A correct code cannot approve an AI task; separate exact-action
confirmation and current business permission remain mandatory. The provider's
Verify TTL and country/channel settings need live setup; this module creates no
Verify Service and sends nothing during construction. Tests use an isolated
HTTP port with the real SDK serializer and native Worker runtime.

### App-linked OTP identity broker (candidate, unmounted)

`VoiceOtpService` extends `ScopedServiceBase` and supplies the missing durable
OTP-to-call identity boundary. This initial flow requires the caller to sign in
to the native app. A signed provider handler, before starting or resuming AI
streaming, calls `issue` for a canonical live inbound call to the configured shared
number. It privately speaks an eight-digit pairing code to that caller. Only its
call-bound SHA-256 hash is stored, with a two-minute expiry and five pairing
attempts. A lost initial prompt cannot recover the secret; restart with a new call
or use reception. A pairing code is not an account authenticator by itself.

The native app supplies its trusted server-side session token hash and the pairing
code to start step-up. The service resolves the current native session and current
verified account contact, checks `voice.otp.start` permission and the canonical
Call resource, then atomically claims the pairing and a per-contact quota (three
sends per ten minutes) before sending any SMS. No phone or actor is accepted from
the caller/model. Send ambiguity is non-retryable. Verification SIDs are unique
across bound calls; even a reused provider SID cannot authenticate two calls.

Code entry stays in the registered secure native app flow, outside the LLM. The
service claims one check at a time, caps checks at five, and rechecks native
session/contact/call/policy before and after provider I/O. Approved codes create a
fresh opaque grant ID valid for at most five minutes and no longer than the native
session. Only that grant is exposed to the task trust boundary. On every later
lookup, session membership/expiry, contact value/version/revocation, call status
and `voice.otp.use` permission are checked again. Native session deletion/logout,
contact changes, ended calls or permission denial invalidate use. Raw pairing
codes, OTP values and bearer tokens are not stored in the broker tables or sent
to an AI engine. Host auth routes must also suppress sensitive request logging.

`PostgresVoiceOtpRepository` commits pairing/send quotas before external I/O and
retains no SQL connection while waiting for Twilio. `PostgresVoiceOtpContactDirectory`
reads approved contact enrollment records joined to current native user/tenant
membership. No contact enrollment writer or production phone verification is
provided here: approved onboarding must verify the account contact and increase
its version for every change/revocation without reusing old versions. Candidate
schema creates no contacts, permissions, sessions or live grants automatically.

`TwilioOtpPairingAdapter` inherits the signed bounded form boundary. It uses only
fixed same-origin pairing/wait/agent/reception URLs, pauses while the app verifies,
then redirects only after server identity lookup. Timeout/failure goes to reception.
It does not collect spoken codes, record audio or start an AI stream. The agent
startup endpoint must independently recheck broker identity; knowing its URL is
not authority. Native app start/check endpoints require current session auth,
CSRF protection and endpoint-level rate limits. Provider pairing/polling endpoints
require exact signature validation and current Call verification.

`createPostgresOtpReceptionVoiceServices` composes the broker, existing Verify
provider, native app confirmation and the selected callback/appointment request
tasks. `createTwilioVoiceOtpPairingHandler` prepares the separate provider handler.
All handlers/UI screens, verified-contact enrollment, production migrations,
permissions, request-writing API bindings and AI runtime still require authorized
registration/deployment and live acceptance. Callers without the app or verified
contact must use reception; there is no voice-match or caller-ID fallback.

### App call pairing panel

`VoiceOtpAppSession` extends `CommunicationResourceBase`; `mountVoiceOtpPanel`
provides an optional accessible DOM form for the same flow. The host supplies
registered, authenticated and CSRF-protected `start`/`check` transport ports plus
a current session generation. Logout closes the resource; every operation also
checks that generation before and after transport I/O. The panel asks for the
8-digit private call pairing code, then the 6-digit SMS OTP. Neither phone number,
actor/tenant, native session hash, provider credential nor identity grant is an
input to this component. Typed codes clear before transport and on close.

A send/check is single flight. An uncertain or malformed result disables this
flow and directs the caller to reception; no automatic resend occurs. A definite
false check permits another manual code entry, subject to the existing server
attempt cap. A verified UI label is display only: every AI tool still obtains
identity from the durable server broker and needs separate exact task approval.
This component adds no screen, route, grant, contact enrollment or AI activation.
It still needs the approved native app bridge and registered endpoint binding.
Run `scripts/test-communication-voice-otp-app.mjs` for lifecycle races and
`test-communication-voice-otp-browser.mjs` for real browser form acceptance.

### Exact AI task approval in the authenticated app

`VoiceTaskApprovalSession` inherits `CommunicationResourceBase`. Its captured
`preview(intentId)` and `approve(intentId, digest)` transport ports bind to the
existing `PostgresVoiceTaskConfirmationService` through the host's registered,
authenticated, CSRF-protected app boundary. Preview fetches the server summary
and immutable digest. Approval sends only the displayed proposal ID/digest after
an explicit user gesture; it does not execute the task. The voice task service
independently rechecks identity/permissions and consumes approval once.

`mountVoiceTaskApprovalPanel` is an optional read-back form, with host-provided
localized copy and text-only rendering. No route, screen, permission or AI tool
is registered. Cancel/logout clears the preview and releases event listeners;
scope changes and expiry prevent approval, including changes during rendering
and transport. Concurrent submission is rejected. An uncertain result disables
resubmission and requires status reconciliation; no automatic retry occurs.
Host logout/call termination must close the resource immediately. The timer
clears an expired displayed proposal but is not a server authorization decision.
The host must close/unmount the panel after successful approval or navigation.

Run `scripts/test-communication-voice-task-approval.mjs` for state/transport
checks and `scripts/test-communication-voice-task-approval-browser.mjs` for the
real browser explicit-click, text rendering, cancel and logout scenario. These
ports are synthetic tests; production route/UI binding and real task execution
remain separate acceptance requirements.

### Verified voice-agent startup

`TwilioVerifiedAgentAdapter` derives from `TwilioSignedFormAdapter`, reusing exact
signature validation, bounded form reading and error redaction. It implements the
previously missing agent-start continuation after app OTP pairing and a separate
signed Connect completion callback. `createTwilioVerifiedAgentHandler` supplies
the official read-only Call verifier; neither factory nor adapter mounts routes.

The configured shared number must match the canonical live inbound Call. Startup
requires a current broker identity using OTP/passkey plus an explicit server-owned
authorization port. Canonical call and identity are checked again after that port.
A changed session/account/tenant or denied identity sends the caller to fixed
reception. The host supplies the AI disclosure/greeting. Fixed same-host WSS and
same-origin HTTPS callbacks cannot contain credentials, queries or fragments;
caller fields and model HandoffData cannot select routing or authorize tasks.
A finished Call hangs up; a live Relay completion goes to reception.

This TwiML response is not a socket credential. Before accepting model input/output,
the separately registered socket receiver must validate Twilio's handshake signature,
bind setup.callSid to the canonical Call and current broker, authorize access, and
close on transfer/logout/revocation. Every proposed/executed task still uses the
existing server task/confirmation gate. This module does not implement or activate
that WebSocket/LLM receiver, enroll contacts, mount endpoints or change the IVR.
Live Relay onboarding, approved routes/policies, engine binding and telephone
acceptance remain necessary. Run `scripts/test-communication-agent-start.mjs` and
`scripts/test-communication-twilio-workerd.mjs` for synthetic-provider verification.
