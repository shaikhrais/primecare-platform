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
