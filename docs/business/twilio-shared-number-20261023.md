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

## Follow-up official documentation review — 2026-10-23

The selected shared number remains **+1 647 930 2223**. These are implementation
decisions and acceptance requirements, not claims that live configuration exists.

| Area | Official behavior | PrimeCare continuation |
| --- | --- | --- |
| [Access tokens](https://www.twilio.com/docs/iam/access-tokens) | Server-issued tokens use Account SID, API Key SID and API Key Secret. Main and Standard keys support token signing; Restricted keys do not. | Use a dedicated Standard key stored only in server secrets. Never substitute the webhook Auth Token for the API Key Secret. No key has been created. |
| [Voice grants](https://www.twilio.com/docs/iam/access-tokens) | Voice tokens contain identity and VoiceGrant; outgoingApplicationSid identifies the required TwiML App, incomingAllow enables incoming calls. | Derive identity with the existing tenant/user identity function. Resolve current session and voice permission before signing; accept no client-selected tenant, identity or app SID. Define and register the token contract before exposing it. |
| [Device lifecycle](https://www.twilio.com/docs/voice/sdks/javascript/twiliodevice) | The JavaScript Device API provides registration and token lifecycle operations. | Await actual registration; handle registration failure, token expiry, logout, tenant switch, incoming call rejection and cleanup. A constructed Device is not a registered receiving destination. |
| [Gather](https://www.twilio.com/docs/voice/twiml/gather) | An action URL handles submitted digits; actionOnEmptyResult controls no-input callbacks. Redirects can lose the Digits parameter. | Keep incoming and gather URLs separate, return TwiML directly and avoid redirecting the gather POST. Preserve finite timeout/no-input handling. |
| [Dial Client](https://www.twilio.com/docs/voice/twiml/client) | Client dialing targets a Voice SDK client. | Preserve the current tenant-derived identity and recheck published destination status. Test offline, rejected, busy and revoked destinations before cutover. |
| [Webhook security](https://www.twilio.com/docs/usage/webhooks/webhooks-security) | Validate the signed public URL and received parameters with the official helper; Twilio has no fixed webhook source IP range. | Keep SDK signature verification mandatory. Do not replace it with an IP allowlist or trust forwarded hosts. |
| [Inbound messaging](https://www.twilio.com/docs/usage/webhooks/messaging-webhooks) | Incoming messages and status callbacks are separate webhook events. | Voice extensions do not identify an SMS recipient. Define explicit tenant conversation routing; ambiguous sender/recipient matches must not choose a tenant by last-message timing. |

Proposed token lifetime is 5 minutes, capped by the remaining authenticated
session lifetime, with refresh requiring current authorization. This is a
PrimeCare design choice, not a Twilio-mandated duration. Twilio permits up to
24 hours and recommends the shortest practical lifetime. Issued tokens must not
be logged; revocation acceptance must account for already issued token lifetime
and active device/call state rather than promise immediate JWT invalidation.

### Ordered cutover and rollback

1. Read back the production requirement and register exact extension-directory,
   token, provider-webhook and callback contracts. Resolve the required production
   writer scopes; a source JSON file is not a production registration.
2. Implement durable globally unique assignments, explicit publication and
   current tenant/user permission checks. Reserve the selected number in server
   configuration without assigning real users automatically.
3. Provision the dedicated key and TwiML App through an authorized secure setup.
   Store secrets in Worker bindings. Never copy them into source, Flutter, chat,
   screenshots or logs.
4. Deploy and verify the exact incoming, gather and SDK outgoing handlers before
   replacing the current number's Studio flow. Outgoing handler must separately
   authorize the caller and destination; an App SID alone is not permission.
5. Verify a registered device and a synthetic published extension; then test a
   real inbound call, no input, invalid extension, offline device and revocation.
   Verify outbound calling separately; inbound Dial/Client is not outbound proof.
6. Preserve the current IVR flow and messaging service identifiers from the
   console inventory as rollback references. Capture the full voice settings
   before cutover; the inventory is not a complete configuration backup. Keep
   Messaging Service configuration unchanged until its own routing is verified.
7. Change the selected number only after those checks, then verify a live call.
   Restore its prior voice configuration if acceptance fails. Do not delete the
   old Studio flow or reconfigure the shared Messaging Service as a side effect.

No new endpoint, credential, permission, user extension or provider setting is
activated by this documentation review. The browser origin approval and GitHub
push approval blocks remain unresolved; research does not authorize bypassing
either block.

## Implemented and testable

Current local validation: **174 distinct Node tests passed** across core services,
Twilio adapters/tokens/SMS/directory, picture access, audio lifecycle, inbound
email and HTTP transport. **14 native workerd assertions passed**; strict
TypeScript and whitespace checks passed. The sender and outbox reject SMS bodies
above 1,600 UTF-16 code units as well as the configured UTF-8 byte bound, before
any provider submission. This conservatively enforces the documented message
body limit ([Twilio Messages resource](https://www.twilio.com/docs/messaging/api/message-resource)).

Still unverified here: disposable PostgreSQL integration, Flutter/browser
acceptance of the new Twilio-specific client flow, deployed secure bindings,
provider callbacks, live SMS delivery and real phone/device calling. No number
settings, real user extensions, role grants or live provider resources changed.

The next continuation adds native PostgreSQL extension/session directories,
inherited assignment/publication service and native composition. The extension
schema is a candidate only; no real tenant/user is automatically assigned or
published. Globally unique sequence values are not reassigned or deleted by the
service. Nine added local tests cover tenant boundaries, denied assignment,
proposed publication, session-hash validation and default-denied native policy.
The prepared disposable database check also covers extension/session persistence.

Latest local continuation: SMS transport, official API-key SDK composition,
inherited one-attempt notification outbox, shared signed form boundary, delivery
projection, durable PostgreSQL callback storage/reconciliation, unapplied SMS
schema candidate and server-only composition are implemented. 127 local Node
tests and 14 native workerd assertions pass; strict TypeScript checks pass.
PostgreSQL integration coverage and a disposable CI database are prepared but
not executed locally. Durable storage acceptance therefore remains pending.
No live messages/calls, production schema changes, grants, provider configuration
or route mounts occurred. Publication remains blocked by the prior automatic
approval rejection. The current IVR remains connected.

Continuation added internal `TwilioVoiceTokenService`, derived from
`ScopedServiceBase`, and CI coverage. Strict TypeScript checks and 29 Node tests
pass. Native workerd now passes 10 assertions, including official-SDK token
signing and denied-policy handling. The Worker test bundle loads real Node
built-ins with native `createRequire`; wrapping the legacy stream module in an
ESM namespace broke the signing dependency and was corrected. This remains
synthetic provider testing, not deployment or phone acceptance.

The token service requires trusted current-session and destination directory
ports and a current `voice.token` policy. It exposes no HTTP route. Durable
production directories, registered token/outgoing/callback handlers, credential
bindings, device registration, and SMS send/delivery persistence remain pending.

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

### Account inspection and user selection — 2026-10-23

The user signed into Twilio and selected existing number **+1 647 930 2223**
(the second number in the active-number inventory) for PrimeCare. The inventory
shows Voice, SMS and MMS capability. Its current voice configuration is the
Studio flow `IVR`; messaging uses `Message Service`. This is a selected existing
number, not evidence of a completed PrimeCare connection or assigned extensions.

No number purchase, credential creation, webhook change or extension publication
was performed. Opening its configuration encountered an automatic browser
approval rejection for `1console.twilio.com`, outside the approved
`console.twilio.com` origin. Do not bypass the rejection or replace the current
IVR with an unmounted or unverified endpoint.

Continuation checks passed locally: 18 Node adapter tests and 8 native Worker
assertions. Live provider calls and devices remain unverified. The separate
workflow-contract CI check still rejects stale source provenance for
`cloudflare/workers/src/auth.ts`; do not refresh evidence hashes merely to make
that check pass. The production requirement record is unchanged and remains
the live authority; this note records the user's selection only.

1. Sign into the Twilio account, confirm country/area code and choose a concrete voice-capable number. Review the recurring number charge and usage rates before purchase. No number has been purchased.
2. Configure credentials securely on the server; never put the Auth Token or API key secret into Flutter/browser code or chat.
3. Implement and approve durable extension assignment/publication with global uniqueness for current active tenant/user destinations. No real user extensions have been assigned by this change.
4. Register provider webhook and Voice SDK token contracts, implement current session/voice authorization, mount the approved handler and connect SDK devices. This internal adapter is not a public endpoint or a complete token/device integration.
5. Verify live inbound/outbound calling, destination revocation, unavailable/offline devices, provider callbacks and device/network behavior. Existing core audio tests use loopback and synthetic microphones; they do not replace Twilio phone acceptance.

The existing text, picture, audio and email core remains inherited. Twilio voice
extensions do not route SMS/MMS. Production activation, role grants, mailbox
ownership/routing, live scanner/storage and deployed communication acceptance
remain separate release gates.


### Verified continuation — 2026-10-23

Main `c40604ac8` passed all ten communication CI jobs, including disposable
PostgreSQL callback/extension tests, Worker runtime, Flutter transport/workspace
and browser media checks. This supersedes the earlier local-only PostgreSQL
status; it does not establish production acceptance.

Added an unmounted inherited browser Voice SDK lifecycle adapter after reviewing
[Twilio.Device documentation](https://www.twilio.com/docs/voice/sdks/javascript/twiliodevice).
It waits for actual registration, renews tokens through authenticated host ports,
checks session-generation and identity continuity, closes on expiry/failure, and
owns SDK cleanup. Incoming calls default to rejection. Host logout/tenant-change
handlers must call close immediately. Tests use a deterministic Device port;
real SDK registration, permissions and phone calls remain unverified.

The live number remains +1 647 930 2223 with the existing IVR configuration.
Extension assignment is implemented but not applied to real users. Required
production contract registration, credentials, endpoint mounts and authorized
provider cutover remain outstanding. No live grants or provider settings change.

### SDK extension-call continuation — 2026-10-23

Reviewed [Voice SDK server flow](https://www.twilio.com/docs/voice/sdks) and
[custom call parameters](https://www.twilio.com/docs/voice/sdks/javascript/twiliocall).
SDK outgoing calls require the TwiML App Voice URL to return separately authorized
TwiML; a token's outgoing grant is not destination authorization.

Added an internal inherited connect service and signed adapter for same-tenant,
published extension destinations. The service verifies the canonical Call resource
through the official SDK instead of trusting browser-provided From/tenant/user
parameters, and repeats directory and policy checks. The browser lifecycle can
now initiate an extension call with late-result cleanup. Arbitrary telephone and
SIP forwarding remain unsupported. A separate native PostgreSQL composition root
is available for a subsequently registered TwiML App handler URL.

Local acceptance: 22 device/connect tests, strict TypeScript integration/declaration
checks and 16 native Worker assertions passed. Tests use synthetic provider calls;
no live calls, number changes, permission grants or extension assignments occurred.
New action `voice.call.connect` remains unregistered/default-denied until production
contract registration. No Twilio or Cloudflare credentials are available in the
execution runtime. The existing IVR remains in place pending deployed handler and
live acceptance; do not point it at these unmounted modules.

### Ring, answer and voicemail behavior — 2026-10-23

| Caller action/outcome | Destination and behavior |
| --- | --- |
| Dial shared number and enter published extension | Resolve its current tenant/user; ring that identity's registered Voice SDK devices |
| User has app open and registered | Show Incoming call with Answer and Decline; answer rechecks current permission, then enables voice; connected controls provide Mute and End Call |
| Other users in same tenant | Do not ring unless they independently use the same assigned identity; extensions are user-specific |
| Busy, offline, declined/no answer, or failed call | With opt-in voicemail configured, offer a message after the Dial result; actual decline status is determined by Twilio |
| Caller leaves message | Record caller only after disclosure/beep, up to 120 seconds; pound finishes; silent recording does not email |
| Completed recording becomes available | Verify signed callback and canonical recording; queue email to the original target user's active verified mailbox |
| Email recipient opens link | Require sign-in as original owner in original tenant; check permission before and after private audio retrieval |

Reviewed official [Dial action/status](https://www.twilio.com/docs/voice/twiml/dial),
[Record action versus status callback](https://www.twilio.com/docs/voice/twiml/record)
and [Call answer/reject events](https://www.twilio.com/docs/voice/sdks/javascript/twiliocall).
Record action may precede audio availability; email therefore waits for completed
recording-status and canonical metadata verification. Email uses an authenticated
app link rather than a public recording URL or raw audio attachment.

Added inherited ringing controller and accessible optional DOM panel; integrated
resource ownership/busy handling with the existing device lifecycle. Added native
voicemail ledger candidate migration, scoped capture/notification/read service,
signed callbacks, canonical Recording verifier, bounded authenticated WAV adapter,
existing-mail-outbox notifier and separate server composition. SDK connect can
opt into the same fallback. All endpoint activation and new permissions remain
default-denied. The panel and playback route are not yet installed into a live
registered screen; users cannot receive this flow in production yet.

Local Node and native Worker checks cover these paths; CI also runs a real Chrome
answer panel and disposable PostgreSQL concurrency/ownership tests. These use
synthetic Twilio call/recording and email ports. Live ringing, browser microphone
permissions, simultaneous registrations, first answer across devices, voicemail
storage/playback and actual email delivery still need deployed acceptance. The
existing IVR and +1 647 930 2223 settings remain unchanged.

### Reception fallback and AI task execution — 2026-10-23

The opt-in initial prompt now asks for a known extension; otherwise press zero
then pound or wait for reception. An empty, invalid or unknown extension resolves
the explicitly configured published reception extension through the same native
directory checks. With one shared number and no established tenant context this
is platform reception. The caller cannot supply a tenant or reception identity.
No real reception user/extension is assigned by this change.

Reviewed official [Vapi tools](https://docs.vapi.ai/tools),
[Vapi server authentication](https://docs.vapi.ai/server-url/server-authentication),
[Twilio ConversationRelay](https://www.twilio.com/docs/voice/conversationrelay),
[Relay handshake authentication](https://www.twilio.com/docs/voice/conversationrelay/onboarding),
[Twilio Verify](https://www.twilio.com/docs/verify) and
[NIST authentication guidance](https://pages.nist.gov/800-63-4/sp800-63b.html).
Vapi can call a defined server function; ConversationRelay can connect managed
speech to an application WebSocket/LLM server. Either can use the same task gate.
Use one voice engine for a call. Reusing the existing Twilio setup favors Relay;
reusing an existing Vapi assistant is another supported integration plan. Neither
engine is configured/deployed by this change.

Proposed task flow: resolve verified caller/account/tenant -> OTP/passkey step-up
outside the LLM -> validate a registered task and exact arguments -> read back
server summary -> consume independent app/DTMF confirmation -> recheck current
permissions -> claim once -> run existing typed business API -> report outcome.
Examples for future explicit task definitions: request a receptionist callback,
book or reschedule an owned appointment, and send an already authorized
notification. These are examples, not registered/active API integrations.

Voice recognition can transcribe a request, but voice matching and caller ID are
not authentication in this implementation. NIST SP 800-63B-4 explicitly excludes
voice biometric comparison. A future specialized identity design would need its
own review; it must not bypass OTP/passkey, permission or exact-action approval.
Never expose OTPs or tokens to the model. Unknown task names, actor/tenant/URL
injection, changed proposals, stale confirmation, expired identity and duplicate
execution attempts fail closed.

Added the inherited task gate, bound-task base, durable PostgreSQL candidate
repository/migration and explicit separate native composition. Current trust
ports and tests are synthetic: production OTP-to-call binding, durable one-use
confirmation capture, provider authentication, task catalogue registration and
business API bindings remain required. No automatic business mutations, new
roles/grants, OTP sends, AI agent creation or live provider cutover occurred.

### Selected initial AI scope and durable approval — 2026-10-23

The user chose **Callbacks and appointments** through the task-scope selector.
Added concrete inherited definitions for receptionist callback requests, booking
requests and reschedule requests. Inputs reject actor/tenant/contact/URL overrides
and require current slot/appointment versions with explicit future UTC instants.
Server summaries distinguish a request from a confirmed appointment. The existing
client-self appointment endpoints are read interfaces; care schedule mutations
are operations-restricted. Real client request-writing bindings therefore remain
an explicit registration/implementation dependency, not an assumed existing API.

Added native PostgreSQL app confirmation storage and a scoped preview/approve/
one-use consume service. Exact actor/tenant/call/session/proposal/digest context,
current verified identity and permission must match. Proof expires within one
minute; repeated approval does not extend it. Consumed or stale proof cannot
execute again. An authenticated app read-back/confirm endpoint is separate from
the AI tool endpoint; the model cannot invoke approval or submit a raw OTP.
The production identity broker still must perform real OTP/passkey verification
and invalidate call bindings on native logout/session revocation.

Local tests now include 102 Twilio/task/confirmation tests and 23 native Worker
checks. CI adds disposable PostgreSQL proof-expiry/concurrency/revocation checks
and passes the three selected request definitions through the durable gate using
synthetic request APIs. No live AI assistant, OTP challenge, native permission,
production migration, callback request, appointment change or IVR cutover is
activated by these modules. Existing live deployment blockers remain explicit.

### Verify provider continuation — 2026-10-23

Reviewed the official [Verification Check reference](https://www.twilio.com/docs/verify/api/verification-check)
and local Twilio SDK declarations. Added a narrow server-only SMS Verify port
using configured API keys/service, current verified account contact and exact
Verification SID. It validates receipt scope, accepts only approved status,
forwards no model-selected destination/status/custom-code fields, redacts failures
and disables automatic retry of uncertain sends. Added strict input-length checks
for code/SID/secret/contact handling, including terminal-newline rejection.

Local verification: 109 Twilio/task tests and 24 native Worker checks pass. New
provider tests exercise the real SDK HTTP serializer with synthetic responses;
no OTP was sent and no phone was authenticated. This is not yet the durable
OTP-to-call/user/tenant broker. Production still requires that binding, send/attempt
limits, expiry/revocation handling and registered secure code entry outside the
LLM, plus the existing separate task confirmation and business API gates. No
Verify Service, live AI agent, extension assignment or provider cutover occurred.
