# Calls first: internal extensions and WebRTC — 25 October 2026

The immediate priority is basic calling: find a permitted user by extension,
ring their signed-in PrimeCare app, accept/decline, carry audio, mute, hang up and
handle unanswered calls. Voiceprints and AI account operations are separate work.

## Where extensions live

The existing authoritative business table is
`communication_voice_extensions` in PostgreSQL. It holds extension, tenant_id,
user_id, published, active and version. The four-digit cutover uses globally
unique values 1000–9999 from `communication_voice_extension_seq`; user+tenant also
has a unique assignment. No separate Twilio extension directory is introduced.
Assignment remains through the existing scoped VoiceExtensionService. It does not
automatically publish a destination or grant another tenant access. This milestone
does not assign or publish real users. 0/reception and 1/AI remain external phone
menu options, not four-digit internal user extensions.

## Shared code and call flow

`ConversationCallServiceBase extends ScopedServiceBase` now owns the existing
conversation setup/access, inbox/read privacy, ring/accept/decline/missed/end and
bounded WebRTC offer/answer/ICE state machine. `CommunicationService` inherits it,
preserving existing message/picture behavior and registered HTTP contracts.
`InternalExtensionCallService` derives from the same base. Its audio channel
inherits CommunicationChannelBase. InternalAppCallCore composes PostgreSQL state,
current policies and the existing PostgresVoiceDirectory; no Twilio SDK, telephone
number, mail transport, image storage or AI capability is required.

A signed-in actor selects an extension within an authorized conversation. The
server resolves one active, published, same-tenant assignment; checks current
eligibility/membership; resolves the exact assignment/version again after awaited
policy work; and creates one durable invitation. Only that recipient can accept.
Caller and recipient exchange private signaling after acceptance; other members
cannot read their SDP/ICE. A duplicate command cannot create a second invitation.
An unanswered call can expire to missed; decline/end use the inherited lifecycle.
Live host timers/notification delivery still need mounting and acceptance.

The existing BrowserAudioSession/BrowserAudioCall and Flutter bridge handle media,
muting and microphone cleanup. Internal app calls use the existing native login;
they do not require a phone-call OTP or voiceprint for each call. The host must
still authenticate current identity and exact registered endpoint permissions.

## Twilio versus internal calling

| Call | Transport |
| --- | --- |
| Signed-in PrimeCare user to another permitted PrimeCare user | WebRTC plus our signaling and TURN; Twilio not required |
| Public caller to the shared business number and an extension | Twilio or another telephone carrier connects the phone leg |
| PrimeCare user to an ordinary mobile/landline number | Twilio or another telephone carrier connects the phone leg |

Internet WebRTC needs a TURN relay when NAT/firewalls prevent direct media.
`CloudflareTurnProvider extends CommunicationResourceBase` now implements fixed
Cloudflare credential generation with bounded responses, pinned TURN hosts,
short expiry, no redirects/retries and server-only long-lived credentials.
InternalCallMediaService inherits the call base and checks the accepted call,
exact participants, quota and current permission before issuing credentials and
again before returning them. Ringing/ended/nonparty calls cannot obtain them.
The server key is never returned. The relay port is optional for routing tests;
production media must configure it and obtain fresh credentials before starting.
No TURN key/account was created and no telephone routing was changed.

## Verification and remaining release work

Local checks passed 72 business/audio/internal-call tests and 21 HTTP/internal-call
checks (these overlap in the seven new internal-call tests), plus three new TURN
checks and strict TypeScript. A bundle dependency check proves the call-only root
contains no Twilio SDK or native mail/image adapter. CI also exercises native
PostgreSQL extension routing/state/denials/relay scope, the existing HTTP/native
regressions, and two actual Chromium peers exchanging synthetic audio packets.
These are scoped fixtures, not a call between real end users or proof of TURN
traversal across internet/mobile networks. Report CI outcomes only after readback.

Remaining: register exact extension-dial and media-credential HTTP contracts;
verify owner directory access; mount/deploy the call-first host and app dialing
surface; configure server-side TURN key and quotas; wire incoming ring/timeout
notifications; and test two real users/devices across networks, including background
or closed apps. Keep the shared public phone routing intact until replacement is
ready. This milestone adds no public endpoint, screen/role grant or live activation.

References:
- https://webrtc.org/getting-started/peer-connections
- https://developers.cloudflare.com/realtime/turn/generate-credentials/
- https://www.twilio.com/docs/voice/sdks/javascript
