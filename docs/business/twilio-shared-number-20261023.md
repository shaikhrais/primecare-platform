# Twilio shared number and tenant extensions

The requested design is one platform-owned voice number, followed by a globally
unique six-digit extension per published user destination. The extension resolves
to its stored tenant/user pair; caller-supplied tenant IDs, user IDs, client names
or telephone destinations do not control routing. Extensions do not authenticate
a caller or grant access to application records.

## Documentation confirmed

- [Gather](https://www.twilio.com/docs/voice/twiml/gather) collects DTMF and can call an action URL even when no digits arrive. Separate exact incoming/gather URLs prevent timeout prompt loops. The adapter prompts once and then hangs up for unavailable input.
- [Dial/Client](https://www.twilio.com/docs/voice/twiml/client) targets a registered Voice SDK client identity. The identity must also be used by a separately authorized token issuer/device registration flow. Rendering TwiML does not prove a connected device or live call.
- [Dial](https://www.twilio.com/docs/voice/twiml/dial) bridges an existing call; it does not start a new outbound call by itself. This adapter makes no REST calls or arbitrary-number forwarding and enables no recording.
- [Webhook security](https://www.twilio.com/docs/usage/webhooks/webhooks-security) requires the configured full public URL and all received form parameters for signature validation. Future parameters must not be dropped. The official SDK handles signature computation/validation; no custom production HMAC implementation is used.
- The official `twilio` npm package metadata was checked and version 6.2.0 is pinned. Actual Worker testing uses its real helpers and native Node crypto compatibility. Synthetic credentials are test-only.

## Implemented and testable

`TwilioVoiceExtensionAdapter` derives from `BoundedBinaryAdapterBase` and reuses
the existing stream ownership, byte/chunk limits and reader cleanup. Headerless
HTTP bodies use the same bounded reader. The adapter checks the expected Twilio
account, owned destination number, inbound direction and Call SID after signature
validation. It requires exactly one active, published destination and performs a
second lookup before rendering its tenant-derived client identity.

Unknown, duplicate, disabled and reassigned extensions share a generic response.
Malformed input never reaches directory lookup. Provider or directory failures
remain unavailable responses, without private error output. Request body data
cannot select a tenant or arbitrary SDK/PSTN destination. No role-specific copy
of the communication core is introduced.

## Still required for live setup

1. Sign into the Twilio account, confirm country/area code and choose a concrete voice-capable number. Review the recurring number charge and usage rates before purchase. No number has been purchased.
2. Configure credentials securely on the server; never put the Auth Token or API key secret into Flutter/browser code or chat.
3. Implement and approve durable extension assignment/publication with global uniqueness for current active tenant/user destinations. No real user extensions have been assigned by this change.
4. Register provider webhook and Voice SDK token contracts, implement current session/voice authorization, mount the approved handler and connect SDK devices. This internal adapter is not a public endpoint or a complete token/device integration.
5. Verify live inbound/outbound calling, destination revocation, unavailable/offline devices, provider callbacks and device/network behavior. Existing core audio tests use loopback and synthetic microphones; they do not replace Twilio phone acceptance.

The existing text, picture, audio and email core remains inherited. Twilio voice
extensions do not route SMS/MMS. Production activation, role grants, mailbox
ownership/routing, live scanner/storage and deployed communication acceptance
remain separate release gates.
