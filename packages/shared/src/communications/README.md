Warning: truncated output (original token count: 23200)
Total output lines: 1322

# Shared communication core

## Linked messaging AI lane

The native `PostgresSmsMessagingRepository` implements the mandatory link port.
Its internal `bind` operation requires a fresh server-derived native session,
explicit consent, active user/tenant, independent verified-contact version and
current conversation membership/policy. The request cannot supply a phone,
actor, tenant, role or provider configuration. A globally unique active provider
address pair selects one account/conversation; ambiguous/shared-account binding
is denied. The policy factory uses the owned native client so a single-slot pool
cannot deadlock by recursively acquiring itself. These storage operations are
not public APIs and have no automatically granted permissions.

`PostgresSmsConsentInboxStore` extends the durable inbox repository. Its signed
host must use this derived store when activating messaging: STOP, consent update,
link revocation and inbox acceptance commit atomically before acknowledgement.
Duplicate controls do not replay their effects. START removes provider blocking
but does not restore a link. A new link requires explicit consent in a fresh
native session; an old link/queued reply remains invalid after re-linking.

`linkBoundSmsRecipientPolicy` composes the existing country/consent/quota policy
with the exact link saved in the durable AI turn. `linkBoundSmsTransport` rechecks
that binding under the same sender lock used by STOP/revoke/re-link immediately
before provider submission. The existing inherited SMS outbox remains the only
queue/claim/delivery implementation. Hosts must reconstruct these adapters from
the persisted original turn/link, never from the current phone mapping or HTTP
body. No new submission can begin under a revoked link after STOP commits; a
submission already handed to the provider cannot be recalled. The guarded port
must use the bounded official SMS client (10-second timeout, no retries), must
not reacquire the held native pool, and must not perform an unbounded callback.

The 13-table messaging storage design is registered and deployed, with 78 columns
independently verified in production run `40189337571`. Ten missing tables were
created and the three existing shared tables preserved. Native link contracts
16539–16541 are registered. Native runtime/access activation, dispatcher/outbox
composition and live acceptance remain pending; these adapters do not activate
API 16538 or change phone routing. Native checks: `node scripts/test-communication-sms-links-postgres.mjs`
using the named disposable loopback SMS fixture only.

`TwilioSmsInboundAdapter` extends the existing signed, bounded Twilio form
adapter. It saves a normalized SMS in `PostgresSmsInboundStore` before returning
empty TwiML. Provider account + MessageSid deduplication is durable across
connections/restarts; conflicting payloads cannot overwrite the first event.
No webhook field can assign a tenant, user or role. Control messages are stored
outside the AI queue. MMS is quarantined without fetching attachment URLs;
media ingestion remains pending its bounded private-picture composition.

`MessagingAiReplyChannel` extends `CommunicationChannelBase`, and
`MessagingAiReplyService` extends `ScopedServiceBase`. The same service accepts
verified SMS, WhatsApp and Telegram link projections through mandatory trusted
host ports. It rechecks policy and the full link/version at queue, generation,
read and reply queueing, including duplicate retries. Inbound event ID is the
turn ID; host consumers must derive it from provider account + immutable event
ID and resolve account ownership independently. A phone number alone never
authorizes a turn. Host linking must reject shared/ambiguous accounts.

The service claims generation and outbox queueing durably before invoking external
ports. Duplicate claims do not invoke them again; uncertain queue acceptance is
left in `queueing` for explicit reconciliation using the deterministic outbox ID.
A queue receipt is not proof of sending or delivery. Host outbox implementations
must revalidate link and consent atomically with queueing and again before send.
Production opt-out handling must suppress pending sends, not merely exclude STOP
from model input. Host consumers must serialize conversation processing and keep
pairing/OTP ceremonies outside model messages.

`OpenAiMessageModel` extends `CommunicationResourceBase`. It uses bounded Responses
API input/output, a fixed endpoint, configured service information, cancellation,
no provider storage and no shared message history. Up to 16 independent requests
can be in flight per resource. This initial model lane answers general service
questions only: it exposes no tools and cannot execute account actions. Vapi's
existing task boundary remains separate; verified proposals and confirmations
must reach the shared task service rather than being inferred from AI text.

The runtime components remain internal and **not mounted or activated**. Their
inbox/turn/link/consent storage is deployed; current production permissions,
dispatcher composition, original-link outbox bindings and live receive/
AI/send/delivery tests remain activation gates. No Flutter contract or screen is
changed, and current phone routing is preserved. WhatsApp/Telegram transport
configuration and Vapi task activation are not implied by the common service.

Checks: `node --test scripts/test-communication-sms-inbound.mjs
scripts/test-communication-messaging-ai.mjs scripts/test-communication-openai-message.mjs`.
Native concurrency/readback checks: `node scripts/test-communication-messaging-postgres.mjs`
with the named disposable `TWILIO_SMS_TEST_DATABASE_URL` fixture only. The existing
communications CI runs these checks; it does not apply migrations to production.

Vapi provider management uses `VapiManagementClient`, inheriting the bounded
binary adapter. It reads saved assistant and phone projections without exposing
embedded provider credentials. Synthetic chat refuses assistants with tools or
server webhooks and never adds phone transport. The verification workflow reads
`VAPI_PRIVATE_API_KEY` only from encrypted production secrets. This adapter does
not expose an app endpoint, grant permissions or place calls. Explicit workflow
dispatch can assign the pinned 4277 number after exact assistant and routing
readback. The adapter rechecks scope, patches only assistantId, then reads back;
changed routing or tool/webhook configuration denies the write. Provider updates
have no CAS, so concurrent Console edits must be avoided during activation.

`VapiApiRequestAdapter` is an internal bounded transport for the dashboard API
Request tool. It connects to the existing inherited VoiceTaskService and accepts
only propose/execute commands. Provider credentials, registered policy, rate
limits, canonical call resolution and durable duplicate claims are mandatory host
ports. Model input cannot set actor, tenant or approval; OTP/passkey identity and
exact independent approval remain in the existing task service. Six integration
tests use that real service with isolated storage/trust fixtures. No new endpoint
is mounted and no tool is attached until those production ports and registration
are present. See docs/business/vapi-api-request-integration.md.

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
transport success. The actual gateway forwards exact registered commun…7200 tokens truncated…complete OTP broker. The host
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

### Authenticated Relay socket and call-bound model tools

`TwilioRelaySocketAdapter` inherits the binary boundary; it validates one exact
configured upgrade URL/signature using the official SDK. `signatureUrl` is pinned
explicitly to the deployed provider signing convention (HTTPS upgrade URL or its
WSS target), with no alternate-URL or trailing-slash fallback. Live handshake
acceptance must verify that configuration before mounting. `TwilioRelaySession`
inherits resource cleanup and can be created only through this signed boundary.
It owns listeners, setup/expiry/turn/audit timers, model cleanup and interruption.

The shared `createVerifiedAgentCallGuard` is used by startup and socket sessions.
Setup checks provider account/destination/Call/Relay SIDs, current canonical Call,
OTP/passkey broker and explicit native authorization. A mandatory atomic claim
allows only one session per Call and one use of a provider session ID. Native
`PostgresRelaySessionClaims` and its candidate migration preserve that claim even
after disconnect. The host must apply an approved schema/retention/privilege policy;
no memory claim implementation is a production fallback. Construction performs
no migrations, grants, publication or mounting.

`createPostgresTwilioRelaySocket` composes native claims and the official read-only
Call verifier. Its mandatory model factory creates a separate model resource for
the verified tenant/user/Call. Transcripts are untrusted text, not instructions or
identity proof. Each turn receives only bounded text, an AbortSignal and two tools:
propose an allowed task, or execute a proposal created in this session. Both tools
close over the verified Call SID and delegate to the existing server task gate.
There is no approve/OTP/contact/actor/tenant/URL tool. A typed missing-confirmation
result keeps the proposal waiting for independent app approval; a spoken yes or
DTMF cannot approve it. Uncertain execution is not automatically retried.

Frames, accumulated prompts, model output, turns, proposals, tool calls and socket
backpressure are bounded. Output is plain text without SSML; newline/tab spacing
is normalized. Interrupt/closure abort the pending model turn and discard late
speech/tools. A task already submitted to the business service may have committed;
closing cannot undo it, and the existing durable task status must be reconciled.
Native logout/call-transfer notifications must close the resource immediately;
periodic and per-tool/output broker checks also enforce revocation. No automatic
AI reconnect is permitted on the same Call. Zero ends Relay and uses the fixed
signed Connect completion/reception path. No model-supplied forwarding URL is used.

Node protocol, real task-gate composition, actual workerd WebSocketPair and native
PostgreSQL one-use/concurrency tests are in the corresponding
`test-communication-relay-*` scripts. Provider signatures, model and call/broker
ports in those tests are synthetic. The receiver still needs registered routes,
production migration/bindings, configured model credentials, Relay onboarding and
live telephone/model/task acceptance; no configured model or live AI is claimed.

### Configured Responses provider

`OpenAiRelayModel` implements the Relay model port and inherits
`CommunicationResourceBase`. `createPostgresOpenAiTwilioRelaySocket` composes it
with the existing canonical call/OTP guard, durable one-use claim and server task
gate. A server secret, explicit model, allowed task IDs and trusted task guide
(describing argument contracts and reference sourcing) are mandatory. There is no
default model, endpoint override, browser key, model-created identity, approval
tool or business API URL. The guide must come from registered task definitions;
never fill it from caller speech. Missing slot/record references require a human
handoff or independently authorized discovery service, not guessed IDs.

The server POSTs to the fixed official Responses endpoint with `store:false`,
strict function schemas, `parallel_tool_calls:false` and encrypted reasoning
continuation. Complete output items and `function_call_output` results are
replayed in order within this call only, without a stored conversation ID.
Caller text stays in user messages. The server gate validates the JSON arguments
of `propose_task`; `execute_task` can only attempt an intent already created in
this socket. Spoken consent still cannot supply independent app confirmation.

Provider bodies (64 KiB), history (48 KiB), prompts, speech, tool JSON, call IDs,
tool rounds and deadlines are bounded. Provider/network errors are redacted and
never automatically retried. Interruption before tool submission discards late
output and preserves only earlier completed history. Interruption after submission
closes the model because business execution may already have committed; the host
must reconcile durable status. Close aborts the provider and discards the secret
and history references. `store:false` does not itself assert zero provider
retention; approved privacy/account settings remain a deployment requirement.

Tests exercise serialized HTTP requests, encrypted reasoning replay, exact tool
results, missing approval, injection, malformed responses, bounds and cleanup.
The real callback service gate is exercised through the provider adapter and
Relay session; workerd exercises the provider adapter over an actual socket pair.
All provider HTTP responses in tests are synthetic. No live model request,
secret provisioning, route registration, migration, extension assignment or IVR
change is performed. Configuring credentials/model/guide, registered host routes
and policies, actual business APIs and live provider acceptance are still required.
Protocol sources: [Responses function calling](https://developers.openai.com/api/docs/guides/function-calling)
and [Responses creation](https://developers.openai.com/api/reference/resources/responses/methods/create).


### Current email authorization at dispatch

The inherited `BusinessMailService.deliver` snapshots the authenticated actor
before any storage await. After its atomic one-use claim and current message read,
it checks the recipient/contact basis again and then current `mail.deliver`
permission immediately before invoking the provider. Claim-time permission does
not authorize a later send after revocation. This shared service also carries
voicemail notifications through `BusinessMailVoicemailNotifier`; there is no
separate notification path that bypasses these checks.

If the post-claim checks deny, no provider call occurs and the existing durable
record stays `sending`. The claim is deliberately not reset to `queued`; retries
cannot resend it. This status requires reconciliation and does not prove that a
provider accepted or delivered mail. Network/provider failures after submission
retain the existing `unknown` behavior. There is no automatic channel fallback or
retry of ambiguous sends. A permission change after the final check cannot undo
an already submitted provider request.

The domain regression suite runs the same revocation, actor snapshot and
concurrent-claim checks with the memory fixture locally and with native PostgreSQL
in CI. Provider acceptance is synthetic in both. See the official
[Cloudflare structured email binding](https://developers.cloudflare.com/email-service/api/send-emails/workers-api/)
for provider request/receipt and failure contracts; real inbox delivery remains a
separate acceptance test. No new route, permission, schema or production binding
is created by this change.

### Voice boundary registration package

The 21 native/provider contracts in
`tools/governance-production/twilio-contracts-registration.json` cover the existing
SDK token, extension, voicemail, OTP, app approval, TwiML, Relay and SMS-status
ports. Their dedicated pinned PostgreSQL writer records only API metadata with
`registered-unimplemented` status. It inserts no access grants, screen links,
extension assignments or provider settings. The workflow requires native fixture
tests before dry-run/registration and independently rereads complete production
rows. Existing differing contracts are preserved and require reconciliation.
See `docs/business/twilio-boundary-registration-20261023.md` for exact transport and
identity boundaries. Registration is not mounting or live acceptance; the host
still needs current policies, exact handlers, secure bindings and device tests.

## Sales script quality candidate

`SalesCallQualityService` inherits `ScopedServiceBase` and evaluates a host-approved versioned script against canonical call transcripts. `scoreSalesCall` computes weighted coverage (six of ten equal points = 60%, nine = 90%) with exact agent sentence evidence, timestamps, critical misses and uncertain ranges. `salesOperatorDefinition` prepares bounded classic Twilio GenerativeJSON configuration; `createTwilioSalesQualitySource` uses official SDK read-only calls with account/recording/transcript/operator/config pinning. No route, role grant, recording or provider configuration is enabled. Candidate storage uses separate `business_sales_quality_*` tables after production registration; current production `planLimitReached` blocks live registration/activation. See [scope, scoring, wiring and validation](../../../../docs/business/sales-call-quality-20261023.md). Run `node --test scripts/test-communication-sales-quality.mjs`; native storage acceptance runs only against the disposable PostgreSQL fixture.

Sales quality provenance hardening: completed transcript duration must agree with recording duration within one second before scoring. Reports persist account/service/recording IDs, the agent channel and pinned operator configuration digest. Source adapters must supply this provenance; it is validated and fingerprinted to preserve report history on changed-config retries. The candidate remains unmounted and requires production registration.

Sales quality accepts only supported two-party call recordings; conference mixtures and voicemail recordings are rejected to preserve agent/customer attribution.

## Voice SDK error cleanup

`TwilioRingingCall` and `TwilioVoiceDevice` keep the shared `CommunicationResourceBase` ownership model. A Call `error` event is distinct from a completed disconnect: incoming errors reject ringing offers or disconnect answering/connected media, and outgoing errors disconnect the owned call before releasing its slot. Terminal cancel/reject/disconnect events still release without an extra termination request. All owned listeners are removed before SDK teardown, avoiding reentrant disconnect loops. Late authorization/accept completions cannot reopen an errored incoming call. A throwing call disconnect destroys the outgoing device as a fallback; end-state display failures cannot escape this shutdown path. No raw provider error is displayed.

Unit regressions cover ringing, pending authorization, pending accept, connected errors, reentrant disconnect, throwing teardown/display callbacks, and an outgoing error followed by another call. Browser acceptance checks the call panel ends/disables controls and the next extension call owns independent cleanup. SDK events/transports are synthetic in these checks; they do not establish live Twilio calling or native mobile background ringing. Run `node --test scripts/test-communication-twilio-ringing.mjs scripts/test-communication-twilio-device.mjs scripts/test-communication-adapter-base.mjs` and the existing `scripts/test-communication-ringing-browser.mjs` Playwright suite. Existing production registration/activation blockers remain unchanged.

Twilio documentation reviewed: [Call methods and events](https://www.twilio.com/docs/voice/sdks/javascript/twiliocall), particularly `disconnect()` (closes media), separate `error`/`disconnect` events, and `accept()`/`reject()` behavior. This implementation deliberately ends the owned call on an error; nonterminal connectivity/recovery notifications are not reclassified as errors here.

### Current destination after voicemail reservation

Inbound extension TwiML rechecks publication, active membership and unchanged
tenant/user ownership after durable voicemail preparation completes. A changed
destination hangs up generically without dialing or redirecting to a new owner.
SDK extension calls additionally re-read the canonical live Call, both published
destinations and the current connection policy after reservation. A denied or
changed result returns a generic failure without a Dial response. Reservation
is not permission to ring. Any already reserved voicemail remains subject to the
existing fallback/capture/playback checks; this change performs no compensating
delete or retry and cannot undo a provider request already submitted.

The existing `TwilioSignedFormAdapter` and `ScopedServiceBase` inheritance remain
the boundaries. No contract, role, grant, number, extension assignment or live
activation changes. Regression tests reproduce revocation during reservation,
target/caller reassignment, ended calls and current policy denial, and retain a
successful unchanged route. Run `node --test scripts/test-communication-twilio.mjs
scripts/test-communication-twilio-connect.mjs
scripts/test-communication-twilio-voicemail.mjs` (41 tests). Provider/lookup/storage
ports are synthetic in this suite; live phone acceptance is separate.

The communication inventory artifact now retains the exact independent readback
receipt for all 21 pinned Twilio contracts. Bash pipefail preserves verification
failure through `tee`; writing a receipt never promotes runtime acceptance.

### Native voice HTTP service boundary

`NativeVoiceHttpAdapter` extends `BoundedBinaryAdapterBase` and dispatches only
the nine independently registered native app contracts from
`twilio-contracts-registration.json`: SDK token, extension assignment/publication,
private voicemail read/audio, OTP start/check and exact task preview/approval.
The signed provider callbacks and Relay sockets are separate adapters. There is
no AI tool for native approval and no new route, grant or publication here.

`createPostgresNativeVoiceHttpAdapter` composes current native session lookup.
The browser supplies only its bearer credential to the API. On the server, the
shared token parser and hash function resolve `auth_sessions`, active users and
active tenants. Request bodies never supply the authenticated actor, tenant,
phone, roles or native session hash. A forged `x-tenant-id` is denied. The host
must supply current exact endpoint/screen authorization and rate limits; no
permissive production policy or guessed API ID is included. Cookie-only requests
are rejected. Same-origin requests are supported; separately hosted portals need
explicit exact HTTPS `appOrigins` and matching gateway CORS/preflight policy.
Origin lists are captured, never selected by a caller or wildcard.

Request parsing uses the inherited streamed byte/read bounds. Both request and
JSON response schemas are compiled at build time by
`tools/voice-schema-validators.mjs`; Worker requests never compile schemas or
evaluate strings. The generated module is checked in CI. Private audio uses
bounded copied WAV bytes with header validation and private/no-store responses.
Current session, identity and endpoint permission are rechecked after body reads
and after service work. A post-service denial suppresses sensitive output but
does not undo an already committed mutation. All ambiguous failures remain
generic failures, with no automatic resend/retry.

Validated service JSON and private audio bytes are copied before the final
asynchronous identity/permission check. Service buffer reuse cannot rewrite the
response during that wait; oversized audio is rejected before making the copy.

Run `node --test scripts/test-communication-voice-native-http.mjs` (15 local
cases plus a disposable PostgreSQL case when `TWILIO_SMS_TEST_DATABASE_URL` is
set). Tests cover all nine dispatches, identity injection, CSRF/origin boundaries,
binary/JSON limits, method/route isolation, revocation during reads/service work,
response validation, native session resolution and private error suppression.
The actual workerd suite also exercises real JWT issuance through this adapter,
identity override denial and endpoint denial. Provider, specialized service and
authorization ports remain explicit fixtures in those tests. The native database
case uses the real token service/session directory with isolated grants; it does
not verify production endpoint permissions.

Production still requires exact host route mounting, approved current API/screen
grants and voice action policies, applied business schema, mailbox/provider/model
bindings, reception selection and extension publication, and live phone/email/
device acceptance. This adapter removes the HTTP dispatch gap, not those gates.

### Voicemail route snapshots

The inherited `VoicemailService` copies and freezes repository routes before
awaiting directory, policy, recording or mailbox operations. Adapter row reuse
cannot change the tenant, owner, extension or call used for notification and
playback metadata. Current directory/policy checks still run; reassignment during
recording verification denies notification rather than selecting the new owner.
The voicemail suite covers mutable repository rows during recording verification
and playback authorization. No HTTP contract, permission or provider setting is
changed by this internal isolation fix.

### Vapi tool service credential

`createVapiToolCredentialVerifier` supplies the provider-only authentication port
for VapiApiRequestAdapter. It accepts only the exact dedicated Bearer credential
through the Authorization header, hashes it and compares fixed-length digests.
It accepts no query/body/cookie credentials and never grants caller identity or
task approval. The endpoint must also use the registered policy, rate limit,
canonical call resolver and current OTP/passkey/app approval services. Provision
the dedicated random secret in server storage and a reusable Vapi credential
before deployment; do not reuse the Vapi management key. This helper alone does
not deploy a route, provision a credential or attach a tool.

VapiManagementClient.installToolCredential is a server deployment port for the
single PrimeCare tool credential. It verifies saved assistant scope, preserves
credential conflicts, and hands secret material only to a trusted installation
callback. The public receipt includes no token. The dedicated VapiToolBoundaryWorker
inherits BaseWorker and currently denies all business actions after provider auth;
its guarded deployment and HTTP checks are in deploy-vapi-tool-boundary.yml.

VapiCallReadClient is a separate read-only bounded provider port: no call writes,
tool management or credential methods. createVapiCanonicalCallDirectory composes
its sanitized lifecycle projection with the existing Twilio call verifier, rereads
Vapi after Twilio I/O and returns only a short-lived canonical call binding. It
never selects an actor or grants user access. VapiApiRequestAdapter can use this
port while VoiceTaskService retains the VoiceOtpService trust broker and separate
exact app approval. The OTP integration tests use real inherited services with
isolated provider/storage fixtures; the production identity-readiness workflow
performs read-only inventory and no traffic or activation.

VoiceContactEnrollmentService inherits ScopedServiceBase and is native-app only.
It requires current active user/tenant/session context and a login within five
minutes before first-time phone verification. PostgresVoiceContactRepository owns
atomic per-user/per-phone send limits, check claims and first-time-only contact
insertion. Existing/revoked contacts are preserved. createTwilioContactEnrollmentClient
is a separate fixed-destination Verify capability; createTwilioVoiceOtpClient still
requires an already verified contact for call step-up. No code or password is
persisted or returned. Native HTTP/UI permissions and deployment remain required;
none of these methods is an AI tool. See the enrollment guide in docs/business.

Native phone enrollment uses the existing NativeVoiceHttpAdapter bounded bearer
boundary through an explicit optional contacts capability. The status/start/check
contracts are compiled into standalone validators at build time; request identity
fields and malformed UUIDs/codes are rejected. Session and exact API/screen grants
are rechecked around body and service I/O. Candidate PostgreSQL composition does
not activate production routes, create grants or attach enrollment to an AI tool.

## Vapi management transport

Server-side management clients use Cloudflare-compatible manual redirects to the fixed Vapi origin. Every non-success response, including redirects, is rejected; credentials are never forwarded to a redirected host. The UI continues to use native session authorization. This transport correction changes no endpoint contract, phone routing or business-tool permission.

## Voiceprint transport

The Aculab adapter invokes the fetch port as a standalone function so the native
Worker fetch receiver remains valid. Redirects are returned manually and rejected
before any verdict is accepted; credentials are never forwarded to another host.
The workerd suite exercises the actual runtime fetch primitive with intercepted
HTTP as well as injected provider functions. It does not measure biometric accuracy.
Text-dependent verification requires the enrolled phrase; arbitrary security
question answers must not be substituted as the verification audio. Recognition
remains evidence, separate from task authentication and transaction approval.

## Native SMS phone verification

The account screen uses the existing registered contact status/start/check routes.
An explicit phone consent and button action precede any send; opening the panel
only reads status. Codes are cleared before checking and never stored in browser
storage. A verified status is read back after approval. Recent native sessions,
current role and linked-screen rights, first-time-only enrollment and durable
quotas remain enforced by the existing server. This enrolls an account phone;
it does not authenticate a Vapi call or approve any business task. The Verify
transport uses standalone native fetch and rejects manually returned redirects.
