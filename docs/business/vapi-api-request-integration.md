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

## Step 1: endpoint contract registration

The exact proposed boundary is POST /v1/vapi/voice/tasks in the existing governance
service. tools/governance-production/vapi-contracts-registration.json defines four
strict request variants (callback, booking request, reschedule request, execute)
and bounded responses. Model input cannot carry actor, tenant, session, approval,
credential or destination overrides. The authentication contract requires a
separate Vapi service credential plus canonical live-call validation; the existing
task service additionally requires OTP/passkey identity and exact approval.

The dedicated production writer inherits ProductionWorkflowStore, checks the
pinned manifest and physical metadata schema, locks the endpoint table, inserts
only this exact contract, and preserves existing or duplicate identities. It adds
no roles, screen links, grants, business records, schema, provider tools or live
routes. Registration remains registered-unimplemented and activation=false.
The workflow first tests native PostgreSQL transaction rollback, concurrency,
idempotency and preservation, then runs production dry-run/apply and separate
read-only verification. Deployment and real credential/call bindings are the next
step; metadata registration alone is not a working voice endpoint.

Step 1 production evidence: workflow 40134257355, commit
ada59cbc67cd7d8b77c492e07b037cd0d0373076, registered API ID 16534.
The dry-run transaction was rolled back, apply returned independentReadback=true,
and a separate read-only process returned the same ID with writesAttempted=false.
Four schema tests and 28 native PostgreSQL tests passed. roleGrants=0,
providerWrites=false and activation=false. The dedicated provider-only credential
verifier is also implemented; its three local checks pass. No credential has yet
been provisioned or attached, and the endpoint remains undeployed.

Remaining sequence: (2) deploy the registered boundary with a dedicated reusable
credential and canonical provider-call checks; (3) connect secure app pairing
and exact approval; (4) bind real appointment request/availability/policy services;
(5) attach the verified Vapi tools and run phone-to-API-to-database acceptance.
Preserve the distinction between a pending booking request and an appointment.

## Step 2: authenticated boundary deployment

The dedicated `primecare-vapi-tools-api` Worker inherits BaseWorker and exposes
only the registered POST /v1/vapi/voice/tasks operation. Its current release phase
is explicitly boundary-only: missing/wrong service credentials return 401; valid
credentials pass the configured Cloudflare rate limiter and receive 503 Business
tools are not enabled. No request body, caller data or business task is read or
executed. This verifies secure transport separately from caller identity/business
readiness. No AI tool is attached by this deployment.

The deployment workflow independently re-verifies production registration using
read-only credentials and refuses stale main. It discovers the account's workers.dev
subdomain through the Cloudflare API and preserves any unrecognized existing
Worker. Only the dedicated target is published; existing governance/auth Workers
are unchanged. The Worker has no database, Twilio or business-provider secrets.

VapiManagementClient.installToolCredential creates or reuses only the exact
PrimeCare Tools API 16534 credential in the verified assistant org. It uses the
custom-credential bearer schema from official @vapi-ai/server-sdk 3.0.0
(CreateCustomCredentialDto, BearerAuthenticationPlan). A newly generated 32-byte
base64url token is passed only to Wrangler's secret stdin and Vapi's credential
API. Reuse requires the exact org/provider/name/header/plan and readable token;
conflicts, duplicates or redacted existing secrets stop without overwriting.
Creation and installation are never automatically retried after ambiguity. No
secret values are returned in receipts, logs, artifacts, source, CLI arguments
or prompts. The credential is distinct from the Vapi management private key.

The deployment receipt reports endpoint URL, registration ID, credential ID and
separate unauthenticated/wrong-credential/authenticated-closed HTTP checks. A
successful boundary receipt does not mean canonical call mapping, OTP, app
approval, business API execution or live phone acceptance works. Those remain
subsequent integration steps. Official source package:
https://github.com/VapiAI/server-sdk-typescript (npm version 3.0.0).
