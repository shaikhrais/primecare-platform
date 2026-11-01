# Shared communication module foundations

B14 provides four original optional collection templates. Web uses `PrimeCommunicationModule`; Flutter uses the shared `PrimeWorkModule` with the B14 metadata catalogue. Both reuse the actor-bound collection, editor, receipt and readback engine introduced in B13. Existing Flutter `CommunicationWorkspace`, `CommunicationHub`, channel clients, server services and policies remain in place.

| Template | Confirmed integration | Explicit remaining scope |
|---|---|---|
| Mailbox | Registered sent/received mailbox listing and safe per-item reads; queued/sending/accepted/unknown/quarantined states | New-template compose, queue/deliver, drafts, labels/folders, archive/delete, attachments and delivery receipts |
| Messenger | Existing conversation inbox, latest message, send text, mark-read, optimistic version, original-key retry and independent readback | Conversation creation, complete history, typing/presence, reactions, attachment composer, realtime transport and call controls in this template |
| Notifications | Registered optional presentation with unavailable state | Own-notification reader is absent from production API metadata; actual read binding, mutations and navigation need registration/specification |
| Files | Read-only private picture references from authorized conversation messages | Binary preview/download/upload, general documents, folders, move/rename/delete, sharing and storage/quota policy |

File references are not a general file manager. A reference has no invented filename, URL, download success, or mutation. The existing registered picture-open API 16509 is verified by registration, but this template does not yet bind its binary operation. The authoritative conversation service remains the source of attachment visibility.

## Verified authority

Registration source `07e0cb25b7ede06a4f03a7477fbd98fbc6c9ae3f`, run `41269023480`, validates the following existing governance contracts: POST `/v1/messages` (710), GET `/v1/messages/inbox` (857), POST `/v1/messages/email` (16511), GET `/v1/messages/email/inbox` (16512), GET `/v1/messages/pictures` (16509). All require the existing authenticated role/screen permission policy. The registration added only optional controls/draft labels on pilot screen 2534, with no API, screen link, permission, business row, schema or activation changes. The pilot registration grants no communication access.

Two earlier dry-run registrations stopped before writes. Run `41268942317` independently reported no metadata row for GET `/v1/auth/me/notifications`. Source `self-records.ts` and its Flutter repository are not proof of registration. The B14 notification transport therefore remains unbound, preserving the B08 activation gap.

## Web composition

Import `PrimeCommunicationModule`, `WorkModuleSession`, `CommunicationModulePort` and `RegisteredModuleTransport` from `packages/primecare_ui/web/communication-modules.ts`. Load `packages/primecare_ui/catalogs/communication-modules.registration.json` and pass the selected locale's labels into the port. Supply the host's current authenticated scope and token; scope is immutable per resource. The transport accepts only the six read/send/read-receipt operations implemented by the port. It has no mail queue/deliver operation.

Construct a `RegisteredModuleTransport(origin, token, scope, currentSession)` using the real gateway origin and an accessor that returns the current token and tenant/user/role/dataset. Bind `transport.execute` to a `CommunicationModulePort`, then bind that port to the shared session with module `mailbox`, `messenger` or `files`. For notifications, omit the port; the template honestly shows unavailable. Mailbox configuration is supplied by the authorized host as `{direction:'outbound'}` or `{direction:'inbound',id:authorizedMailboxId}`. Configuration selects a mailbox and never grants access.

Pass locale, calendar year/month/first-weekday configuration inherited from the shared renderer, an exclusive root and the B06 theme variables. Only live scopes are supported in the new web adapter/view; there is no synthetic fallback. Dispose view, session/port and transport when route or actor/tenant/role/dataset changes. The port inherits `CommunicationResourceBase`; its cleanup clears private projections, cursor and pending-command caches. Transports check the current session before and after fetch and response decoding, refuse identity overrides/redirects, and never retry automatically.

The conversation service limits inboxes to 100. This template displays only the latest message, never call signals or arbitrary raw state. Local search covers the bounded authorized projection, not every historical message. File inventory is bounded to 1,000 references and pages 100; reaching the conversation bound reports partial data. Mail follows the server's deterministic cursor through host-local offset mappings, reads at most 100 safe item projections sequentially, and rejects item-version disagreement. Mail search covers the current page and reports partial scope. No exact global totals are inferred from cursors.

## Save, retry and readback

A message editor captures the displayed aggregate version. Send uses the existing text action; mark-read captures the displayed message sequence. The real HTTP handler validates schemas, active endpoint access, conversation membership, policy and tenant scope. Current policy remains checked for replay through the inherited durable atomic store.

A successful send/read receipt is followed by a new conversation read. The adapter verifies version, message key, author and text, or the exact read-through sequence. The shared session also compares expected fields/version before showing success. An uncertain response retains its command/key and draft. The registered confirmation button retries that exact command, so a lost acknowledgement cannot generate another message. Known invalid/denied/conflict responses remain failures. A conflict requires reload and user reconciliation; another writer's later version is not accepted as this command's success.

Mailbox views are read-only. Queued means queued; provider acceptance does not mean recipient delivery. Received mail stays quarantined and the sender unverified. Only the existing bounded plain-text preview crosses into the view. Raw MIME, rawBase64, HTML and executable links are not rendered. Message and preview text use literal DOM text, never HTML insertion. No external mail is sent by the batch tests or registration.

## Flutter composition and shared ID support

Import `package:flutter_core/communication_modules.dart` or the `primecare_ui` forwarding entry. Build `CatalogueLabels.fromMetadata` with the B14 export and bind `PrimeWorkModule` to a scoped `WorkModuleSession` with a host-supplied UUID-v4 request-ID provider. Shared spacing/width tokens remain host inputs. The existing `CommunicationHub` is exported for host adapters; the established full Flutter communication workspace is not replaced.

The new collection view has no concrete native live `WorkPort` adapter or host mount yet. Native tests validate the shared view/protocol with isolated ports, not live portal acceptance. Use inherited hub clients for any future transport binding; do not copy channels or place permissions/business rules in widgets.

Inbound-mail IDs can exceed the old task/record bound. The common model now accepts the existing service's bounded ASCII identifiers up to 200 characters. Lowercase UTF-8 hex suffixes remain deterministic and collision-free; old IDs are unchanged. Web and Flutter semantics accept suffixes up to 400 characters and reject excess lengths. B09 catalogue and B13 regressions cover this common change.

## Release gates

No application host is mounted or declared production ready by these factories. Current registered policies, mailbox access and native transport bindings, deployment/device acceptance, UI integration and independent release review remain gates. Common/action/status EN/FR/ES text is registered draft text. Module-specific composer and reserved-create wording still need host review. Human language, screen-reader, focus, keyboard, contrast, responsive layout and accessibility review remain pending. Full mail, messenger, notification and file-manager reference adoption is not claimed. Existing authentication catalog consumer-review blockers remain unchanged.


## Native collection binding

`package:primecare_ui/communication_modules.dart` exports `CommunicationModulePort.authenticated` and `RegisteredModuleHttpTransport`. Supply the real origin, captured token/live scope, current-token/current-scope callbacks, registered labels and one of `messenger`, `mailbox`, `files`. For inbound mail supply the already-authorized mailbox ID; outbound mail must omit it. Construct the existing `WorkModuleSession` and `PrimeWorkModule`; dispose the session at logout/tenant/role/route changes. A host-injected HTTP client stays owned by the host.

The collection port composes inherited `MessageChannelClient` and `EmailChannelClient`; the scoped HTTP transport extends `CommunicationTransportBase`. The six mapped operations are existing message inbox/read/send/mark_read and email inbox/read. Mailbox rows and picture references are read-only. Inbound mail exposes only the existing quarantined safe-preview contract. No raw MIME, delivery/provider action, file mutation, general storage or notification binding is created. Sending messages retains the exact original key/version/body across uncertain acknowledgements and checks an independent owned read before success. An acknowledged save retries readback only. Scope checks, one-MiB reply limits, abort triggers and latest-query guards suppress late/stale responses.

`communication-modules-native-fixtures.mjs --check` reproduces eight projections and two mutation/receipt/readback cases from the existing web adapter. Native regression groups additionally cover complete session HTTP composition, uncertain/acknowledged retries, identity/membership/quarantine denial, read-only behavior, cursor pages, stale queries, invalid receipts, cancellation and borrowed-client ownership. Native/source acceptance passed targeted run 41336298352 and combined run 41336612512; see `native-communication-settings-evidence.json`. Actual host mounting, full mail/messenger/file/notification requirements, durable restart recovery, devices and human release review remain open.
