# Vapi API Request integration

The dashboard API Request tool can bind PrimeCare APIs. Provider request
configuration is not caller authorization. The tool uses a reusable credentialId;
its credential is separate from the private Vapi management key. Never put a user
session, endpoint token, tenant override or approval in the model schema/prompt.

## Implemented boundary

VapiApiRequestAdapter inherits BoundedBinaryAdapterBase and dispatches only to
VoiceTaskService.propose/execute, retaining existing ScopedServiceBase policies,
OTP/passkey broker identity, exact digest approval and atomic execution claims.

The host supplies an exact registered HTTPS URL, provider org/assistant/phone IDs,
authenticate/authorize/admit callbacks, canonical calls.current, durable
claims.claim and the existing task service/allowlist. No defaults grant access.
The URL is configuration, not a model argument. No new production route is mounted.

The API Request tool must send X-PrimeCare-Vapi-Call-Id resolved from the provider
call context (for example Liquid call.id), not caller/model input. A header alone
is never trusted: calls.current must independently read the live Vapi and Twilio
call, verify the pinned org/assistant/phone/inbound routing, and map to its canonical
Twilio CallSid. The existing OTP broker then resolves the authenticated app actor.
An ended, mismatched or unverified call fails closed. This resolver is not yet bound.

Request body is one of:

```json
{"action":"propose","taskId":"appointment.booking.request","args":{"serviceId":"registered-service","slotId":"registered-slot","slotVersion":1,"startsAt":"2026-11-02T15:00:00.000Z"},"requestId":"11111111-1111-4111-8111-111111111111"}
```

```json
{"action":"execute","intentId":"22222222-2222-4222-8222-222222222222","requestId":"33333333-3333-4333-8333-333333333333"}
```

These are synthetic transport examples, not deployed endpoints or valid slots.
A proposal returns awaiting_confirmation, intentId, summary and expiry. It never
returns actor/session or approval digest to the AI. The authenticated app reads and
approves the exact proposal using existing native endpoints. Execute returns
awaiting_confirmation until the task service consumes independent approval.
Completed means the specific registered task completed; a request task does not
confirm an appointment. Never expose OTP check or task approval as AI tools.

HTTP failures: 400 malformed/oversized body, 401 provider credential denied,
403 endpoint policy denied, 404 wrong URL, 405 wrong method, 409 duplicate request,
429 rate limit, 503 unavailable/unknown outcome. Responses use no-store and generic
errors; no provider bodies or credentials are logged. A requestId is an atomic
at-most-once claim scoped to the provider call; duplicates are not reexecuted or
served cached sensitive proposals. The durable claim port must retain claims for
the full configured retry horizon. A new execution attempt after app approval has
a new requestId; the task service independently prevents repeated execution.

## Live binding status

4277 now routes to PrimeCare Reception, confirmed through provider API readback.
The API Request adapter passes six isolated integration tests using the real task
service, including app approval, tenant change, OTP denial, concurrent replay,
changed canonical calls, invalid input and error redaction. This is not a live
business API acceptance test.

Still required before attaching a business tool: production endpoint registration
and policy, deployment composition, service credential binding, canonical Vapi to
Twilio call resolver, durable request claims, the app pairing/approval entry point,
and real appointment/callback request ports. The current client booking API only
creates pending requests and does not match the slot/version task contract. Do
not bypass that mismatch by accepting model actor IDs or claiming confirmed slots.
No tools are attached to the live assistant while these are unconnected.

## Official documentation reviewed

- https://docs.vapi.ai/tools/api-request
- https://docs.vapi.ai/tools/api-request/configuration
- https://docs.vapi.ai/server-url/server-authentication

For API Request tools, body is the model input schema; Vapi derives its function
arguments from body. credentialId supplies authentication. Static/Liquid headers
are configured separately. Business rules, permission, approval, ownership and
persisted readback remain on PrimeCare's API server.
