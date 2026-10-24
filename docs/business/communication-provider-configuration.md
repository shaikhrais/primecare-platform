# Communication provider configuration

## Current implementation and activation

PrimeCare has inherited message, picture, audio and mail channels and a Twilio
ConversationRelay implementation. Vapi is an alternative transport; the shared
task boundary does not constitute a complete Vapi integration. No working
PrimeCare provider administration screen has been verified. Do not present a
configuration mockup as a connected production screen.

The production metadata audit includes Twilio, Vapi, telephony and integration
names, alongside communication and appointment names, to discover existing
registered screens, APIs and grants before implementing administration UI.
It reads governance metadata only and never provisions a provider or grants access.

## Provider consoles

| Provider | Configuration UI | PrimeCare responsibility |
| --- | --- | --- |
| Twilio | [Console](https://console.twilio.com/): number voice handler, TwiML application, Verify service and ConversationRelay settings | Signed webhooks, four-digit directory, reception, verification, current API permissions and task execution |
| Twilio Studio | Visual call flow, including ConversationRelay widget | Retain equivalent verification and routing; do not run a second conflicting call router |
| Vapi | [Dashboard](https://dashboard.vapi.ai/): Assistants, Phone Numbers, Tools and authenticated server URLs | Separate authenticated adapter, canonical call binding and the same OTP/app-confirmation task boundary |

Use the existing Twilio implementation as the current configuration path.
Do not import the shared number into Vapi or overwrite its handlers merely to
experiment: Vapi SMS enablement can configure the Twilio messaging webhook.
First review inbound ownership and preserve PrimeCare's extension/reception menu.

For Twilio, configure the registered deployed incoming handler on the number and
the registered outbound handler on the TwiML App. Accept ConversationRelay terms
in Console, then configure the deployed secure WebSocket receiver. Verify the
handshake signature and canonical call before accepting a session. Actual URLs
must come from the deployed registered configuration; this guide supplies none.

For a future Vapi adapter, create the assistant and explicit function tools in
Dashboard; configure each server URL with a custom credential. A tool may request
a preview or submit permitted task arguments. Never expose the independent app
approval operation as an AI tool, accept identity from model JSON, or provide a
general-purpose arbitrary URL/API executor.

## Agreed PrimeCare settings

| Setting | Required behavior |
| --- | --- |
| Shared number | Selected +1 647 930 2223; ownership and live activation still require verification |
| Extensions | Globally unique 1000–9999; assignments and publication require authorized directory operations |
| 0 | Configured reception; do not guess a destination |
| 1 | Verified AI pairing flow; full 1xxx values remain extensions |
| Unknown extension or no input | Configured reception, otherwise generic unavailable response |
| Ringing | Signed-in app, 20 seconds; explicit Answer/Decline/Mute/Hangup |
| Unanswered call | Voicemail up to 120 seconds, protected app playback link through authorized mailbox |
| Mail sender | shkh.rais@gmail.com requires Gmail authorization or an approved sender identity; no spoofed From address |
| Sales script | Versioned configurable weighted rubric; evidence-backed 6/10 = 60%, 9/10 = 90%; uncertain coverage requires review |

One shared number does not identify a tenant by itself. Reception and AI must
resolve authorized tenant context through the directory/session flow; never trust
a caller's claimed tenant, extension ownership or caller ID as authentication.

## AI actions and cancellation policy

Current typed tasks request a reception callback, booking or reschedule. They do
not claim to confirm an appointment change. Confirmed booking, rescheduling or
cancellation must bind to the correct existing clinic API and current policy,
including ownership, appointment version, slot availability, notice window and
any applicable fee. Show the exact server-calculated action and terms for app
confirmation after OTP/passkey verification. Recheck policy at execution.

Voice matching, caller ID and a spoken yes cannot replace verification or exact
app confirmation. Sales appointment status updates, care visit cancellation and
pending booking-request cancellation are different domains; do not substitute
them for a clinical appointment cancellation API.

Further useful tasks are availability lookup, appointment status, reminder
preferences and a reception handoff. Each needs its existing registered contract,
current permissions and correct read/write policy before exposure.

## Data path and acceptance

The data path is Flutter/browser → HTTP API gateway → API Worker → PostgreSQL.
Only server code receives database credentials. The test runner's independent
PostgreSQL readback verifies persistence; it is not a browser database connection.
Twilio/Vapi events also enter authenticated server adapters and scoped services.

Before calling the feature live, verify the actual provider account/number,
registered runtime mounts and grants, candidate business migrations, real reception
destination, user extension publication, Gmail authorization, mailbox routing and
clinic policy/API bindings. Then exercise real inbound/outbound calls, answer,
busy/no-answer voicemail, email delivery/receipt, tenant denial, OTP expiration,
policy changes and ambiguous provider failures. Existing fixture acceptance does
not prove live carrier, Gmail or background mobile push behavior.

## Official references

- [Twilio ConversationRelay onboarding](https://www.twilio.com/docs/voice/conversationrelay/onboarding)
- [Twilio Studio ConversationRelay widget](https://www.twilio.com/docs/studio/widget-library/run-conversationrelay)
- [Vapi Twilio import](https://docs.vapi.ai/phone-numbers/import-twilio)
- [Vapi authenticated server URL configuration](https://docs.vapi.ai/server-url/setting-server-urls)
- [Vapi inbound SMS webhook behavior](https://docs.vapi.ai/phone-numbers/inbound-sms)

Research and local recheck: 2026-10-23 America/Toronto. The existing OTP app,
exact approval and inherited reception-task suites passed 19 tests with no skips.
No provider activation or new settings UI was performed by this documentation change.
