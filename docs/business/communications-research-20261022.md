# Communication architecture research — 2026-10-22

This review uses official platform documentation, W3C specifications, PostgreSQL
manuals and OWASP project guidance. Recommendations below are mapped to code and
checks; the sources do not constitute production acceptance of PrimeCare.

| Area | Finding and implementation decision | Source |
| --- | --- | --- |
| Authorization | Deny by default and check each request. Keep endpoint/screen grants separate from current tenant, account, task and mailbox relationships. Both native adapters inherit one policy-source base and re-read native state rather than caching grants. | [OWASP authorization](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html) |
| Pictures | Do not trust the declared MIME type. Bound bytes/pixels, decode and re-encode, scan, generate private object identities and authorize downloads. Existing PrivatePictureRepository implements this pipeline; a real compatible scanner/decoder/storage composition remains a release dependency. | [OWASP file uploads](https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html) |
| Outbound email | The current native send_email binding supports structured from/to/subject/text/html messages and returns messageId. Keep configured sender restrictions and explicit queue/deliver actions. A receipt identifies provider acceptance; do not infer inbox delivery or retry an ambiguous send. | [Cloudflare sending API](https://developers.cloudflare.com/email-service/api/send-emails/workers-api/), [email lifecycle](https://developers.cloudflare.com/email-service/concepts/email-lifecycle/) |
| Inbound email | Receive through the Worker email event, not a public JSON receive command. Bound rawSize and streamed bytes; use the envelope recipient to resolve an explicitly owned mailbox. Raw MIME stays quarantined; rendering/parsing requires a separately bounded parser and sanitized presentation. | [Cloudflare receiving API](https://developers.cloudflare.com/email-service/api/route-emails/email-handler/) |
| Audio negotiation | Deliver offer/answer and ICE signaling through authenticated participant-scoped transport. Queue candidates until a remote description is installed. Release microphone tracks and peer resources on denial, end or failure. Preserve the existing actual browser packet tests. | [W3C WebRTC specification](https://www.w3.org/TR/webrtc/) |
| Network reachability | TURN relays calls that direct connections cannot establish. Generate expiring per-user credentials on the server; never expose the long-term TURN key. Loopback media tests do not establish mobile/firewall reachability. Live TURN provisioning and deployed network tests remain open. | [Cloudflare TURN](https://developers.cloudflare.com/realtime/turn/), [credential generation](https://developers.cloudflare.com/realtime/turn/generate-credentials/) |
| Database consistency | Repeatable Read provides a stable snapshot within one native authorization evaluation. It does not promise instantaneous revocation during an already-running request or serializable coordination with a separate business transaction. Recheck every new action, avoid long-lived authorization caches and retain versioned atomic commands. | [PostgreSQL transaction isolation](https://www.postgresql.org/docs/current/transaction-iso.html) |

The new native-policy integration tests exercise actual PostgreSQL account status,
tenant status, task handoff, mailbox ownership/delegation, contact scope, policy
drift, session resolution, endpoint grants and persistence through registered HTTP.
Email and image provider ports in that test are explicitly synthetic. Other suites
exercise real raster decoding and browser audio packets. Neither suite establishes
that live providers, user screens or production route activation are complete.

The hierarchy policy rows registered by run 39855660364 are requirements and an
empty owned-mailbox directory. They do not create endpoint grants, verify domain
ownership, provision a user mailbox or grant broad clinical/HR access.


For the Flutter workspace, official [ChangeNotifier lifecycle documentation](https://api.flutter.dev/flutter/foundation/ChangeNotifier/notifyListeners.html)
requires avoiding notifications after disposal. The shared controller commits only
while active and clears state on disposal; session-dependent providers rebuild the
view with a new controller. Official [file_selector documentation](https://pub.dev/packages/file_selector)
informs the platform file-picker port; selection remains a hint, with actual byte
bounds and raster validation in controller/server. Flutter [live-region semantics](https://api.flutter.dev/flutter/semantics/SemanticsProperties/liveRegion.html)
inform status presentation. Tests cover these behaviors rather than inferring
accessibility or deployed acceptance from a screenshot.

## Call and email presentation follow-up

Official sources rechecked on 2026-10-22:

- https://developers.cloudflare.com/email-service/api/send-emails/workers-api/ (updated 2026-10-21): native `send_email` binding configuration and send result contract. A provider ID alone is not recipient delivery evidence; keep queue, sending, accepted and unknown visible separately.
- https://developers.cloudflare.com/email-service/api/send-emails/rest-api/: REST results distinguish delivery, deferral and rejection. Do not substitute that richer REST contract for a Workers binding response.
- https://developers.cloudflare.com/email-service/api/route-emails/email-handler/: receive through the trusted Worker email event, independent of user-facing channel dispatch. Incoming sender/content remains untrusted.
- https://www.w3.org/TR/webrtc/ and https://www.w3.org/TR/mediacapture-streams/: microphone tracks and peer connections have separate lifetimes. Explicitly stop tracks, close peers and remove listeners/timers on denial, termination and account changes; late permission results still require cleanup.
- https://dart.dev/interop/js-interop/usage: use typed JS interop extension types and explicit conversions for a small browser-only adapter. Keep the established browser session as the single signaling/media implementation rather than duplicating its state machine in Flutter.

Implementation decisions: explicit queue then send; exact immutable retry keys for ambiguous mutations; received envelope/quarantine status only until trusted content processing exists; no raw MIME or HTML rendering; accepted-party-only microphone connection through the shared BrowserAudioSession; trusted media configuration injected by composition, no public relay credentials or permissive default.

## Bounded received-email text preview

Official sources rechecked for the follow-up:

- https://github.com/postalsys/postal-mime and https://github.com/postalsys/postal-mime/releases/tag/v4.1.2: choose the pinned 4.1.2 parser, whose source provides aggregate header/part budgets and MIME nesting guards. Restrict nested messages to attachments; do not render or expose attachments.
- https://postal-mime.postalsys.com/docs/guides/security/: decoded content is untrusted. A parser does not authenticate the sender or authorize a mailbox.
- https://developers.cloudflare.com/email-service/api/route-emails/email-handler/: the trusted email event supplies the envelope. Header addresses must not replace its tenant/mailbox scope.

Design: authorize the stored mailbox record before parsing. Bound raw bytes, aggregate headers, MIME depth/part count, UTF-8 preview size and subject length. Return a dedicated unverified plain-text preview under the existing registered mail-read contract; withhold raw MIME, HTML, attachments, routing headers and digest from user responses. Keep quarantine and senderIdentityVerified=false. Parse/budget failures yield a generic preview-unavailable result and no partial content. Flutter renders Text only under the registered quarantine warning, with no embedded media, HTML renderer or automatic link navigation. Legacy stored mail is projected through the same boundary without rewriting the quarantined object.

## HTML-only email text extraction

Official sources checked on 2026-10-22:

- https://github.com/fb55/htmlparser2 documents incremental callbacks, entity decoding, implied close events and the separate DOM-building API. The package metadata and npm integrity confirm version 12.0.0 requires Node >=20.19; the communication runtime/tests use Node 24. Pin 12.0.0 and use callbacks only, without a DOM tree.
- https://github.com/fb55/htmlparser2/releases records HTML-mode changes in version 12.0.0. A forgiving parser is not a sender authenticator, HTML sanitizer or browser layout engine.
- https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html recommends treating untrusted values as displayable text and avoiding HTML-rendering sinks. Continue using the existing Flutter Text presentation, even when decoded entities look like markup.

Design decision: only attempt HTML extraction when the MIME parser supplies no text/plain body. An invalid or oversized plain-text body must not trigger an alternative-content bypass. Limit decoded HTML input, nesting, callback events and UTF-8 output. Keep text from a conservative set of formatting/structural elements; omit unknown/active/embedded subtrees, explicit hidden/aria-hidden subtrees, comments and attribute values. Preserve paragraph/table/list separators without including href, src, alt or form values. No network, browser document, script, CSS or attachment evaluation occurs. This is approximate text extraction, not visual fidelity: CSS visibility/layout is not evaluated, so text hidden by styles may appear as unverified text. Any failed budget discards the complete preview, including subject; never return partial output. Authorization before/after parsing and quarantine retention remain mandatory.

## Picture access and storage consistency

Rechecked official sources:

- https://developers.cloudflare.com/r2/api/workers/workers-api-reference/: `head` and `get` are separate reads; GET returns its own object metadata and body. Validate the returned object itself, including the expected conversation, tenant, type and size. Do not trust metadata from a different read to authorize the downloaded object.
- https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html: deny by default, authorize static resources and test permission failures. Apply the existing registered current account/task policy again after asynchronous scanner/storage work, before handing content back to HTTP.
- https://sharp.pixelplumbing.com/api-input/ and https://sharp.pixelplumbing.com/api-output/: metadata inspection is separate from full decoding/output operations. Keep actual raster decoding, pixel limits, re-encoding and metadata stripping in the existing inherited adapter and preserve real-image tests.

The repair does not add a new policy, endpoint or UI. It enforces existing `activeAccountEveryAction`, tenant and conversation scope at the final response boundary. A rejected body is canceled, without masking the original denial if cleanup fails. A final check cannot guarantee revocation after streaming has begun. Upload denial can leave an unattached private object; do not invent a delete operation or erase unrelated objects. Separate governed deployment/retention work remains necessary.

## Audio operation cancellation and unexpected track ending

Rechecked official W3C sources:

- https://www.w3.org/TR/webrtc/: peer operations and close involve queued/asynchronous work and closed-state checks. Application continuations and signaling callbacks need their own resource-lifetime checks; stopping a peer does not cancel application promises already awaiting completion.
- https://www.w3.org/TR/mediacapture-streams/: tracks can end when sources stop or permission is revoked. `stop()` explicitly ends a track without emitting an `ended` event. Listen for unexpected ending, remove listeners during disposal, and keep explicit track stopping in cleanup.

Design: reuse the inherited resource base and add open-state checks after each awaited SDP/ICE stage, before further peer work or signaling. Ignore captured callbacks after close, and contain both synchronous and asynchronous candidate-port errors. An ended microphone closes the local audio/session and its timer without introducing an unregistered automatic server mutation. Reject an already-ended track at startup. These checks prevent newly created post-close work, not recall of network requests already dispatched. Keep the generated Dart browser asset tied to source and re-run actual Chromium packet/cleanup checks; synthetic lifecycle fixtures do not prove physical device or TURN-network acceptance.

## Complete Flutter browser acceptance

Official Flutter documentation https://docs.flutter.dev/deployment/web recommends serving and validating an actual release web build. https://docs.flutter.dev/ui/accessibility/assistive-technologies and https://flutter.dev/blog/accessibility-in-flutter-on-the-web describe building the web semantics tree, including `SemanticsBinding.instance.ensureSemantics()`. The isolated host enables semantics and uses existing registered controls; browser navigation retains `enable-semantics=true`. Build self-hosted CanvasKit resources with `--no-web-resources-cdn`, keeping the compiled app on the loopback test server. These are acceptance-host choices, not a new production portal or replacement UI.

Continue applying OWASP authorization guidance at the native server. Browser tokens come only from real credential login, tenant scope comes from native account records, and session reload must validate current server identity instead of trusting local preferences. Gateway forwarding is an exact registered-route mount and does not substitute for native endpoint/screen or resource policy. Provider fixtures must remain explicitly distinguishable from live mailbox/scanner/TURN acceptance.


## Build-time communication schemas for Workers

Official Ajv documentation https://ajv.js.org/standalone explains generating
standalone validators at build time, avoiding runtime schema compilation and the
Function constructor. It recommends bundling generated code to include only the
small helper dependencies. The registered schemas are static build inputs; no
user-supplied schema is compiled. Keep the same pinned Ajv/ajv-formats versions as
the reference acceptance compiler, and preserve unknown-schema denial, format
checks and non-mutating validation. Use an actual workerd test in addition to a
VM with string code generation disabled. This is a runtime compatibility step,
not production mounting or provider acceptance.

The existing configured send_email binding was also checked against current
Cloudflare documentation https://developers.cloudflare.com/email-service/api/send-emails/workers-api/.
Structured message sending and a messageId acceptance result are supported; no
transport signature change or live send was necessary for this step. The existing
inbox Worker snapshot stores messages in its INBOX binding, while business inbound
mail still requires governed owned-mailbox routing and runtime composition.


## Worker-native private picture processing

Primary sources rechecked:

- https://developers.cloudflare.com/images/optimization/binding/: Images accepts raw streams, provides info format/fileSize/dimensions and encodes a chosen format. Separate stream instances are necessary for inspection and transformation. Output can explicitly disable animation. No public source URL is required.
- https://developers.cloudflare.com/images/optimization/features/#metadata: PNG output discards metadata; color profiles and EXIF orientation are applied by the provider. Private responses must retain the existing no-store HTTP behavior rather than copying public-cache examples.
- https://developers.cloudflare.com/images/get-started/limits/: provider limits are larger than the existing registered upload bound; preserve the application byte/pixel limits rather than adopting provider maximums.
- https://www.w3.org/TR/png-3/: PNG chunk framing and CRC cover type plus data; acTL/fcTL/fdAT identify animation. Keep critical pixel chunks and tRNS when independently removing ancillary metadata, and reject corruption instead of recomputing checksums for changed data. Container checks do not decode compressed pixels.
- https://github.com/cloudflare/workers-sdk/blob/miniflare%404.20260730.0/packages/miniflare/src/plugins/images/index.ts: the pinned test runtime accepts an Images binding configuration. The local implementation uses its offline codec; remote fidelity and provider/scanner acceptance remain separate release checks.

Implementation reuses a shared inherited picture storage/scan base, retaining the
Node constructor while adding a native Workers codec. Both scans remain explicit
mandatory ports. Own input/output and tenant scope before suspension; a scanner
must not be able to mutate approved bytes. No new public API, metadata policy,
role grant, account, storage resource or activation is introduced by this adapter.

## Inbound event and stream lifecycle — 2026-10-23

Primary sources rechecked:

- https://developers.cloudflare.com/email-service/api/route-emails/email-handler/: `from` and `to` are the SMTP envelope, separate from MIME headers; rawSize accompanies the raw readable stream, and setReject marks input rejection. Native fields are readonly. Snapshotting them before suspension additionally protects mutable trusted host adapters, not a claim that Cloudflare allows changing its native recipient.
- https://streams.spec.whatwg.org/: acquire a reader to lock a stream; cancel through that reader while it owns the lock, then release it. Cancel the stream directly when rejecting before acquisition. Cleanup must preserve the original failure.
- https://developers.cloudflare.com/email-service/observability/local-development/routing/: local email events simulate routing; they are not evidence of remote SMTP or recipient delivery. Keep synthetic persistence/event ports explicit in workerd evidence.

Application inference: actual byte bounds alone do not bound empty-chunk work.
The inherited reader therefore limits delivered chunks to declared bytes plus
1,024, preserving the existing 1,000-empty-chunk compatibility test. This does not
set a read timeout or replace runtime resource limits. Preserve current mailbox
authorization, quarantine, idempotency and transient-failure propagation.
