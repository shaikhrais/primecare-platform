# Native first-time phone enrollment

A user signs into PrimeCare again, requests an SMS for their own entered phone,
and enters the six-digit code in the app. The first enrollment succeeds only
while that same active user, tenant and session remain current and recent (five
minutes). Existing or revoked contact records cannot be overwritten by this flow.
It does not authenticate a phone call, approve a task or expose OTP to an AI.

## Registered contracts

Production registration workflow 40139738210 independently verified these APIs:

| ID | Method and path | Request | Successful response |
| --- | --- | --- | --- |
| 16535 | POST /v1/voice/contact/status | Empty object | verified, enrollmentAllowed |
| 16536 | POST /v1/voice/contact/start | phone in E.164, requestId UUID | challengeId, verificationRequested, expiresAt |
| 16537 | POST /v1/voice/contact/check | challengeId UUID, six-digit code | verified |

All require the native app session, CSRF/origin boundary and explicit registered
API plus linked-screen grants. Start/check additionally require recent login.
Identity, tenant, role, session hash, provider SID, verified flag and URLs are not
accepted in request bodies. Registration creates no grants or public handlers.

## Server implementation

VoiceContactEnrollmentService inherits ScopedServiceBase. The host supplies the
current registered policy and native session directory; no default policy grants
access. PostgresVoiceContactSessions reads current active users/tenants and the
actual auth_sessions.created_at and expiry. There is no inferred login timestamp.

PostgresVoiceContactRepository atomically claims one explicit send per user in ten
minutes and shares the existing maximum of three sends per phone in ten minutes.
Pending retries of the exact same request/session/phone return the same challenge
without sending again. Sending/unknown/expired attempts do not resend. Unknown
provider outcomes require checking status and waiting; clients must not retry
automatically. Each challenge lasts at most two minutes and permits five checks.
The provider code lifetime may be longer; the send cooldown prevents accidental
repeated sends and reuse of provider SIDs after an ambiguous response.

Twilio Verify supplies the code and verifies the exact bound SID/destination.
The new enrollment capability does not claim the destination is already verified;
the existing voice OTP adapter retains its verified-contact requirement. Codes
and passwords are never stored. Provider errors and destination details remain
outside public error responses. Native app requests are the only entry point.

On approval, a transaction rechecks and locks the active native session/user/tenant,
then inserts contact version 1 only if no prior record exists. A concurrent contact
writer cannot be overwritten. Logout or contact changes prevent later call OTP
trust through the existing broker. Approval races and uncertain commits must be
resolved by reading native status, never by assuming verification succeeded.

## Schema and verification

The additive migration creates only communication_voice_contact_challenges. It
first verifies the full fingerprint of the previously deployed five voice tables,
then creates the sixth with unique request/provider SID constraints and private
owner-only access. Any other partial or changed baseline is preserved and fails.
No phone is seeded or marked verified by a migration. The PostgreSQL tests use
isolated accounts and a mocked official Twilio SDK HTTP port, not real SMS.

The inherited NativeVoiceHttpAdapter now supports the three contracts when an
explicit contacts service is supplied. Without that capability they return 404.
The PostgreSQL composition supplies the enrollment repository, recent-session
directory and dedicated Verify adapter. The candidate voice worker dispatches
these native routes separately from signed provider callbacks. Current endpoint
policy requires the exact VOICE_CONTACT_* identity and existing API plus
linked-screen grants; no grants are created by construction.

This candidate is not deployed. Next: register the app controls and permission
links, connect the app, deploy the native runtime, and verify a user-driven SMS flow.
Do not attach enrollment or SMS checking to the Vapi assistant.

## Deployment evidence

Source commit `5a9ca91f88ad33bf56bfb57d27f13dce4a621738` passed workflow
[40140345889](https://github.com/shaikhrais/primecare-platform/actions/runs/40140345889).
The reference job passed four native schema tests, six native enrollment tests,
eight Verify adapter tests and strict TypeScript checking. The production job
verified the existing baseline, rolled back its dry run, applied the additive
migration and independently verified all six tables through a read-only pooled
connection. It also verified that auth_sessions.created_at is available for
recent-login enforcement. No contact was enrolled and no SMS was sent.

Caller identity integration (40140345874), business communications services
(40140345951) and communication acceptance (40140345948) also passed for this
source commit. Readiness remains blocked: zero verified contacts, zero native
OTP grants, no deployed contact enrollment boundary, no private pre-AI pairing
delivery, no native pairing UI and no deployed OTP runtime. Vapi business tools
remain unattached and business actions remain disabled.

## Native API integration evidence

Commit `14a02d36ba373da28b9b83c7ae03a28740d0f2f7` composes enrollment into
the bounded native voice adapter and candidate PostgreSQL worker. Workflow
[40140990383](https://github.com/shaikhrais/primecare-platform/actions/runs/40140990383)
passed all twelve communications jobs, including native PostgreSQL HTTP tests,
standalone validator regeneration, strict types, Flutter transport/workspace and
browser media checks. Typed OpenAPI workflow 40140990329 passed.

Voice runtime workflow 40140990303 passed routing tests and provider credential
preflight, but its full Twilio deployment configuration check failed because
TWILIO_APPLICATION_SID, VOICE_MODEL and VOICE_ORIGIN are absent. No defaults were
invented or phone routing changed. That workflow failure remains a deployment
blocker; passing candidate code checks does not make the native endpoint live.

The HTTP-to-PostgreSQL acceptance test uses the real native session parser,
current database session lookup, bounded HTTP adapter, enrollment service and
repository, plus an isolated official SDK HTTP fixture. It verifies initial
status, one SMS request, identical pending replay without another SMS, code
approval, exact tenant/user/phone/version database readback, status reload and
logout rejection. Its first fixture used a short token and correctly received
401; commit `feb3abfd6fe82e20fe38e714398f0adac9de7373` corrected the fixture to
the canonical 43-character token. Authentication was unchanged.

Workflow [40141201020](https://github.com/shaikhrais/primecare-platform/actions/runs/40141201020)
passed seven native enrollment tests, eight Verify adapter tests, four schema
tests and strict TypeScript checks. Production separately verified all six
existing tables without schema changes, contact writes, grants or provider
traffic. Its readiness report still blocks live activation and tool attachment.

Communication stack acceptance workflow 40140990412 also passed on attempt 2.
The first browser/PostgreSQL run failed to observe positive inbound audio packets;
a single rerun of failed jobs passed without source changes (browser job
121013498522). This preserves the initial failure as evidence of intermittent
media-test behavior; it is not proof of a live telephone call or live enrollment.

## Native app controls and permissions

UI registration run 40141701875 independently verified seven new controls and
13 new labels per locale (English/French/Spanish) on the four existing shared
communication screens. The shared generated catalog now contains 50 controls and
86 label keys. Source and receipt hashes must agree before generation.

Access registration run 40141831495 independently verified 12 API/screen links
and 12 grants for four active roles already permitted to view those screens.
The writer never changes role-screen rights or unrelated API grants, preserves
explicit native API denials, fails on edited/duplicate metadata and checks the
full registered native endpoint identities. Native status/start/check enforce
these current API and screen rights again at request time. No grant authenticates
a caller, substitutes for recent login or approves an AI task.

VoiceContactController inherits CommunicationWorkspaceControllerBase and uses
VoiceContactChannelClient through the shared authenticated CommunicationHub.
Routes are generated from pinned contracts and the independent access receipt;
URLs and identity never come from presentation. POST transport removes the
internal action field for these exact action-less registered contracts. Native
phone failures cannot use the legacy demo/cache success fallback.

The panel loads status only; SMS requires an explicit click. Pending enrollment
prevents another send. Codes are obscured and cleared immediately on submission;
phone/code inputs and controller state are cleared on disposal/session change.
The controller suppresses late results, prevents double clicks, validates exact
responses and cannot automatically retry an uncertain send or check. Status can
resolve an already-committed verification; otherwise sign in again before a new
attempt after the server-enforced cooldown. Only the app handles enrollment.

Production native HTTP hosting and a real user-driven SMS acceptance test remain
pending. Shared UI code and metadata registration do not make those endpoints
live, verify a telephone call or enable Vapi business tools.

UI commit `f10dc524aa6fc31b949eb00d62b3263533ebcfdb` passed the Flutter client
and widget jobs in communications workflow 40142142569: seven enrollment
controller cases, the native POST-body transport case, and three panel cases
cover explicit send/code clearing, uncertain-send status-only recovery, and
three localized layouts at narrow width. Existing Flutter/browser-media jobs
also passed. Browser-to-PostgreSQL communication regression 40142142514 passed.
These synthetic tests do not establish live native enrollment acceptance.

Follow-up commit `f4055fb2f9e26ff051ef575cde954d014a5a246d` keeps expired
challenges and unmounted endpoints closed, with an additional unavailable-endpoint
case. No authentication or provider routing was relaxed.

The final client guard checks passed in workflow 40142379072, including eight
enrollment controller cases and the exact native POST-body transport case.
Access writer follow-up `f0aa598cd4c0dd7ac4391af7d4134635350e93cb` locks the
source API and screen metadata as well as role and grant tables, preventing
concurrent metadata edits during the grant transaction.

Final communications workflow 40142379072 passed all 12 jobs for the client
guard commit, including the Flutter widget and browser-media reruns. Final
browser-to-PostgreSQL regression 40142379011 also passed. The strengthened
access-registration isolated job passed nine native PostgreSQL cases, including
a concurrent source-metadata write rejection test.

Strengthened access-registration run 40142788938 completed its rollback dry run,
apply and independent production readback successfully: the same 12 links and
12 grants for four eligible roles, without business data writes, provider traffic
or activation. Live native enrollment, SMS and caller-identity acceptance remain
unverified until endpoint deployment and a real user-driven test.

## Native endpoint host

The dedicated `primecare-voice-contact-api` Worker inherits BaseWorker and
constructs the contact-only NativeVoiceContactHttpAdapter, which inherits the
existing bounded NativeVoiceHttpAdapter. It has no placeholder call, extension,
voicemail, AI task or authentication handler. The existing API gateway forwards
only the three exact registered paths through its VOICE_CONTACT service binding.
Future generated gateway configurations retain that binding.

Each request resolves the current database session and checks registered API and
linked-screen rights. PostgresVoiceContactAccessPolicy repeats exact own-contact
authorization at service checkpoints around provider I/O. Pools are request-local
and closed; the PostgreSQL URL is restricted to the pinned pooled host with TLS
certificate verification. Database and Verify credentials stay in encrypted Worker
secrets. Browsers send native requests through the API; they never connect to
PostgreSQL or receive its credentials.

The host requires bearer authentication, an approved exact app origin when
present, source/session edge limits and existing durable user/phone quotas.
Rejected bodies are canceled without being read. Public failures remain generic.
Only the native send/check services can invoke the official Verify SDK, through
TwilioVerifyFetchClient: fixed Verify service and two POST forms, bounded JSON,
no redirects, arbitrary SDK options, automatic retries or provider error logs.

Deployment independently reads contracts, grants and six-table readiness; it
refuses stale main and preserves unexpected Worker/gateway bindings. It installs
only database plus Verify credentials into the dedicated native host, reads the
existing six-digit Verify service configuration without changing it, and checks
direct and gateway denials with a fresh nonexistent session. No real code or SMS
is part of deployment. A rejected nonexistent session confirms the native session
query can run, but does not prove a real user's grants or SMS flow.

Reference documentation checked for this implementation:
- https://developers.cloudflare.com/workers/tutorials/postgres/
- https://developers.cloudflare.com/workers/runtime-apis/bindings/service-bindings/
- https://www.twilio.com/docs/verify/api/verification-check

Successful publication and live SMS acceptance must be recorded separately below.

The shared Twilio credential check now treats API secrets as bounded opaque
printable text, using twilioApiKeySecret across Verify, SMS, voice token/call,
voicemail and sales-analysis adapters. API-key SID checks remain exact SK SIDs.
The earlier hexadecimal-only secret check could block a valid configured credential
before a provider request. Regression fixtures include non-hex secrets and
continue to reject empty, short, oversized, whitespace and control-bearing
values. No credential was read, logged, recreated or rotated to fix validation.
See https://www.twilio.com/docs/iam/api-keys/key-resource-v1 for the credential
resource and the distinction between the key SID and its secret.

## Publication and live boundary evidence

Workflow [40145897181](https://github.com/shaikhrais/primecare-platform/actions/runs/40145897181)
published source `f9b0e8a7a0c9db4aca2e8c4140b26f0c92cb54f7` after all 46
checks passed: four schema cases, 18 enrollment/Verify/credential cases, 19
host/gateway/preservation cases and five actual workerd checks. Strict types
also passed. The native PostgreSQL fixture exercised actual current role/screen
grants, a revoked API permission, exact own-phone persistence/readback and logout.

The deployed service is https://primecare-voice-contact-api.itpro-mohammed.workers.dev.
The app uses the existing gateway https://primecare-api-gateway.itpro-mohammed.workers.dev
and its three registered POST routes. Live source-tagged probes independently
verified anonymous and nonexistent-session 401 responses, foreign-origin 403,
approved-origin CORS and unchanged existing gateway service/secret bindings.
The fixed six-digit Verify service was read back without provider writes.

Earlier publication attempts stopped before gateway changes: a missing audit
credential binding, preservation of the existing gateway JWT secret, an overly
strict API-secret alphabet check and the native readiness check. The final host
uses client-side database timeouts because Prisma's pooled proxy rejects the
connection-startup statement timeout. TLS certificate verification stays enabled.
Deployment probes use a descriptive client identity; safe bounded failure
categories expose no private error text, SQL, phone, code or credential values.

The readiness audit now requires a fresh read-only source/CORS/nonexistent-session
check in addition to this saved receipt, and separately inventories the three
contact API grants. A deployment receipt alone cannot mark the boundary live.
Real signed-in-user phone enrollment and SMS acceptance are still unverified.
No contact was seeded, SMS sent, number routing changed or Vapi tool attached.

Final independent readiness run 40146211159 passed 28 integration/readback
cases. Its production reader rechecked all six voice tables, found exactly one
registration and four current grants for each contact API, and freshly verified
the deployed gateway/source/CORS/session-denial boundary. An additional public
probe outside the deployment job also returned source-tagged 401 and approved
CORS with no caching. The stale contact-deployment blocker is now removed.

Remaining live blockers are zero verified account phones, missing native call-OTP
grants, private pre-AI pairing delivery, native app pairing UI and OTP runtime
deployment. The contact-verification panel is distinct from that call-pairing UI.
The overall identity audit correctly remains blocked; neither a successful
deployment nor a denied fake session authenticates a caller or enables tasks.

### Code Administrator self-service host — October 24, 2026

A production metadata read (workflow 40147254855) confirmed that `code_admin`
had only Platform Administration screen 1269 and no contact API permissions.
The consent page is a separate unavailable OAuth feature, not an access editor.
The existing communication screen permissions therefore correctly denied access;
changing route guards or treating the role name as a bypass would be incorrect.

The narrow platform registration (workflow 40147489642, source
47c00addb376330a5d741cbf97b7e72e7d7a5101) passed seven native PostgreSQL tests,
a production rollback rehearsal and independent committed readback. It added
three contact-only API grants and links plus the existing seven shared phone
controls to screen 1269. Existing explicit denials are preserved. No role-screen
permissions, clinical messages, phone records, provider configuration or AI tools
were changed. The stored receipt is
`evidence/voice-contact-platform-registration-20261024.json`.

The app uses the same `VoiceContactVerificationPanel`, inherited controller,
native transport, localized catalog and session lifecycle as communication
screens. It renders on the platform screen after the existing server capability
read succeeds. The server accepts platform screen 1269 only for the exact three
registered contact API IDs, POST paths and endpoint codes; messaging, call OTP
and AI task permissions retain their existing screen restrictions. Current user,
tenant, session, own-contact scope, recent login and SMS checks remain mandatory.

The new source must pass deployment and Flutter acceptance before this host can
be called live. Registration alone does not verify an account phone or a call.
