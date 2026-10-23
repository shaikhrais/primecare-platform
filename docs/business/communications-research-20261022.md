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
