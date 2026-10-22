# Shared communication core

All portals and permitted users use the same core. There are no role-specific copies, hardcoded privileged users or default grants. The authenticated transport supplies identity; request data cannot choose an actor, tenant or role. Production policy still decides who can contact whom and which restricted cases or mailboxes they can access.

| Base | Derived code | Shared responsibility |
| --- | --- | --- |
| ScopedServiceBase | CommunicationService, BusinessMailService, BusinessWorkflowService | Validate actor, record type and tenant; always invoke current policy |
| CommunicationChannelBase | MessageChannel, PictureChannel, AudioChannel, EmailChannel | One execute protocol, identity-context protection and channel dispatch |
| CommunicationResourceBase | BrowserAudioCall | Idempotent cleanup, pending-microphone race cleanup, closed resource protection |
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

DioCommunicationTransport extends CommunicationTransportBase and maps the hub to an existing authenticated Dio session. Its immutable CommunicationRouteBinding map must come from approved registered contracts; it supplies no endpoint mappings or grants. Shared dispatch rejects identity overrides, missing bindings and GET mutations. Reads use query parameters, pictures use real multipart bytes, and commands retain versions and idempotency keys. Redirects, network failures and malformed/non-success responses remain failures, without automatic retries or demo success. The abstract CommunicationTransport remains available for other approved platforms. Picture uploads carry copied Uint8List bytes and require the approved binary upload adapter. Do not JSON-encode binary data or put business rules in widgets. The Dart client passes server denial through without automatic mutation retries. Widgets can bind to this shared hub after registration; this patch does not make the existing stub screens functional. BrowserAudioCall is a browser media adapter; Flutter/native microphone and media bindings still need platform integration.

CommunicationHub is exported by both flutter_core.dart and business_core.dart. The existing ApiClient also uses the shared isCommunicationPath classifier: registered messaging failures now bypass demo-data and path-only offline-success fallbacks for every HTTP method. This fixes existing transport behavior without pretending a missing server exists. The dio_communication_transport_test.dart suite exercises the inherited dispatcher and authenticated Dio multipart boundary. Communication transport failure tests exercise the actual Dio/ApiClient boundary, including real denial/success responses; the pure Dart harness checks the shared classifier and channel protocol.

## Extend and verify

Add a channel by extending CommunicationChannelBase and delegating to the scoped service. Add a service by extending ScopedServiceBase, with mandatory real adapters. Derive binary and resource adapters from the matching bases. Derive Dart clients from CommunicationChannelClient so request/context protections stay inherited. Register new live entities and permission contracts before exposure. Never add a permissive production policy or treat a test fixture as a production adapter.

Run the shared business tests, scripts/test-business-communications.mjs, scripts/test-communication-adapter-base.mjs and scripts/test-business-media.mjs. Native PostgreSQL CI tests persistence/rollback/concurrency; real-browser CI checks actual audio packet counters. tools/communication-client-check.dart exercises the pure Dart client contract independently of unrelated Flutter dependencies. This is not a physical-device or deployed portal acceptance test.

The media job uses the Chrome installed in the GitHub Ubuntu 24.04 runner image, fails if it is unavailable, and records the actual browser version. It avoids another browser/system-package download while retaining the same two-peer packet assertions. See the [runner image inventory](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md).

See [implementation and release gaps](../../../../docs/business/communications-implementation.md). Existing business task APIs remain backward compatible through store.ts contract re-exports. Pinned production governance is the only live registry; this source directory is not a second authority.
