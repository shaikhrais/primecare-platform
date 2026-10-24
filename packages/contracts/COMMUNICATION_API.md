# PrimeCare communication API

The typed OpenAPI 3.1 contract is [communications.openapi.json](communications.openapi.json).
It documents 28 existing registered operations: seven messaging/media/email
operations, nine authenticated voice app operations and twelve signed Twilio
provider operations. It is generated from the registered schema snapshots;
documentation does not create endpoints, permissions or a production deployment.

The broader `openapi.json` remains a draft inventory. Do not import that inventory
as working Vapi tools. The communication contract deliberately has an invalid
default deployment host. Supply the exact independently verified deployment host
before generating a production client or making requests. No live host is asserted.

## Generate and validate

```bash
node scripts/export-communication-openapi.mjs
node scripts/export-communication-openapi.mjs --check
node --test scripts/test-communication-openapi.mjs
```

CI validates the OpenAPI structure and all references, exact registry coverage,
schema parity, synthetic request examples, multipart/query/binary/WebSocket
transports and actual native adapter response/error schemas. Passing these tests
is not evidence that a call, email or appointment succeeded in production.

## Authentication and tenant scope

Native voice operations require an opaque bearer session, current active
membership and exact current API plus linked-screen grants. They reject
cookie-only requests. Browser Origin must match the host's explicit allowlist.
The server derives the actor and tenant from the session, then checks current
resource ownership. Do not add actor, tenantId, roles, phone or sessionHash to
request bodies to impersonate another user.

Signed Twilio operations use `X-Twilio-Signature`, validated with the server's
Auth Token, the exact public URL and provider form values. This header contains
a signature, never the Auth Token. The WebSocket signature uses the exact WSS
URL. Twilio authentication does not establish a PrimeCare user identity.

Vapi's private management key authenticates server-to-Vapi configuration calls.
It is not a PrimeCare user session, a Twilio webhook signature, or authorization
for a caller to change an account. Never expose private management keys to the UI.

## Operation groups

| Group | Methods and paths | Purpose |
| --- | --- | --- |
| Messages | POST `/v1/messages`, GET `/v1/messages/inbox` | Scoped conversation commands and inbox |
| Pictures | POST/GET `/v1/messages/pictures` | Private multipart image upload and authorized PNG retrieval |
| Audio | POST `/v1/messages/calls` | Call signaling; a signaling result is not proof a device answered |
| Email | POST `/v1/messages/email`, GET `/v1/messages/email/inbox` | Scoped mail commands and inbox; accepted is not delivered |
| Voice SDK | POST `/v1/voice/token` | Short-lived token for a current published voice destination |
| Extensions | POST `/v1/voice/extensions/assign`, `/publish` | Four-digit assignment and explicit publication/revocation |
| Voicemail app | POST `/v1/voice/voicemail/read`, `/audio` | Owner-scoped metadata and private WAV audio |
| OTP app | POST `/v1/voice/otp/start`, `/check` | App-linked secure identity verification |
| Confirmation app | POST `/v1/voice/tasks/preview`, `/approve` | Independent review and exact digest approval |
| Provider voice | POST `/v1/twilio/voice/incoming`, `/gather`, `/connect` | Signed menu, directory resolution and Voice SDK connection |
| Provider voicemail | POST `/v1/twilio/voice/dial-complete`, `/record-action`, `/recording-status` | Reserved-route voicemail callbacks |
| Provider pairing | POST `/v1/twilio/voice/pair`, `/wait` | Signed call pairing and verification continuation |
| Provider AI | POST `/v1/twilio/voice/agent`, `/agent-complete`; GET `/relay` | Verified agent start/completion and signed WebSocket upgrade |
| SMS callback | POST `/v1/twilio/sms/status` | Durable signed delivery observations |

The JSON specification contains full paths, request/response fields, constraints,
content types and security for every operation. Examples are synthetic and are
not usable tokens, contacts, call records or approval evidence.

## Wire formats

- JSON native commands return validated JSON, except private voicemail audio,
  which returns `audio/wav` RIFF/WAVE bytes.
- Picture uploads use `multipart/form-data` with an actual binary `file` part.
  Do not send the internal validation sentinel as an uploaded file.
- Picture reads return private `image/png` bytes.
- Inbox query parameters are explicit in the specification. Email
  `direction=inbound` requires mailboxId; `direction=outbound` forbids it.
  `x-query-schema` preserves this cross-parameter rule.
- Twilio forms use bounded UTF-8 `application/x-www-form-urlencoded` bodies.
  Selected callbacks return 204 without a response body; TwiML returns XML.
- The signed relay GET upgrades to HTTP 101 without an ordinary JSON body.
  Relay messages are WebSocket frames, not HTTP request/response operations.

## Native app confirmation example

The signed-in app previews an existing server-owned proposal:

```http
POST /v1/voice/tasks/preview
Authorization: Bearer <CURRENT_APP_SESSION>
Content-Type: application/json

{"intentId":"11111111-1111-4111-8111-111111111111"}
```

Render the returned exact summary and expiry to the authenticated user. After the
user explicitly approves, the app sends the exact returned digest to
`/v1/voice/tasks/approve`. Do not use the example's synthetic ID for a real task.
Preview does not execute; approval alone does not execute. A spoken yes or a
model-generated digest does not constitute independent approval.

Never expose OTP entry or task approval as a Vapi tool. The AI may propose an
allowed task and later attempt execution through a separately authenticated,
registered provider adapter, but only the server can resolve identity, consume
approval and execute the exact authorized action. That Vapi adapter is not yet
registered or connected, and no speculative execution route is included here.

## Vapi integration readiness

The Vapi management API key and saved receptionist configuration have passed
live API readback. Conversation testing returned `payment_required` in Actions
run 40122697994. The verified assistant has no business tools or server webhook.
4277 still uses the original inbound assistant; 2223 is unchanged.

| Proposed capability | Current blocker |
| --- | --- |
| Check service/provider availability | No reviewed callable availability tool contract or connected read adapter |
| Request an appointment | Voice task exists, but its service/slot/version fields are not bound to the current booking-request API |
| Confirm an appointment | A saved pending request is insufficient; eligibility, policy, availability, persistence and readback must be connected |
| Reschedule | Voice task exists; live business adapter and policy checks remain unconnected |
| Cancel an appointment | No cancellation task is attached to the voice agent; do not substitute pending-request cancellation for a confirmed appointment |
| Reception and extension transfer | Requires real configured destinations and a registered Vapi transfer adapter |
| Voicemail notification | Native components exist; Vapi capture and real mail delivery are not connected |
| Sales script coverage | No configurable rubric/transcript evaluation tool is attached |

OpenAPI field descriptions are an integration contract, not a substitute for
business implementation or authorization. The 1,146-operation historical
inventory must not be interpreted as 1,146 implemented endpoints.

## Failure and retry handling

400/415 indicates request/format problems; 401/403 indicates authentication or
authorization failure; 404 can conceal unavailable scoped resources; 409 denotes
a version/state/idempotency conflict where supported; 503 means the service
could not establish a valid result. Exact errors depend on the adapter and are
listed in the specification. Host byte limits and additional rate limits remain
configuration-dependent. No 429 rate-limit guarantee is invented here.

Never retry an account mutation merely because its response failed. A write may
already have committed before a session is revoked or output validation fails.
Reconcile through an authorized read and the underlying API's documented stable
idempotency behavior. A provider-accepted mail or SMS result is not delivery or
read proof. A completed voice request task is not a confirmed clinical booking.
