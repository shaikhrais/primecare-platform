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
