# Research before the next implementation

User instruction: “I want you to research before code.” Further implementation is
paused while the next design and unresolved provider capabilities are documented.
The already deployed phone-panel/status-read work remains on main. Phone OTP,
caller identity and business tasks have not passed live acceptance.

## Confirmed from official documentation

1. Vapi API Request tools derive model arguments from their `body` JSON Schema.
   The dedicated API Request documentation says a separate `function.parameters`
   schema is not used at runtime. Specify required fields, enums and no extra
   properties. Use `credentialId` for endpoint authentication; do not put secrets
   in prompts, schemas or static/plain-text headers. Static parameters are merged
   after generated values and override matching keys. These static values are
   configuration inputs, not proof that a caller owns a PrimeCare account.
   Source: https://docs.vapi.ai/tools/api-request/configuration
   Supporting detail: https://docs.vapi.ai/tools/static-variables-and-aliases

2. Vapi supports stored Bearer, OAuth and HMAC credentials. Saved-resource server
   URLs retain configured credentials; transient/request-supplied server URLs can
   receive no organization credential. Therefore the next binding must use the
   saved, pinned tool/assistant configuration and verify actual authenticated
   delivery. HMAC merits a separate compatibility/replay review before choosing
   it; no credential or provider configuration was changed during this research.
   Source: https://docs.vapi.ai/server-url/server-authentication

3. Twilio verification requires starting a verification and checking the supplied
   token with VerificationCheck. Phone numbers use E.164 format. A successful
   check establishes possession of the destination; associating that result with
   the account, tenant, native session and active call remains our application
   design responsibility. The app-only code entry and independent task approval
   are PrimeCare design choices, not automatic Vapi features.
   Sources: https://www.twilio.com/docs/verify/api/verification-check
   https://www.twilio.com/docs/verify/developer-best-practices

4. Cloudflare documents PostgreSQL access from server Workers and recommends `pg`
   for Hyperdrive, with a minimum driver version of 8.16.3 and `@types/pg` for
   TypeScript. The current project uses pg 8.16.3 directly against its existing
   Prisma pool; this research does not justify silently adding Hyperdrive or a
   second pool. Database credentials belong in server secrets. The browser must
   continue to call our API; it receives no PostgreSQL credentials.
   Sources: https://developers.cloudflare.com/workers/tutorials/postgres/
   https://developers.cloudflare.com/hyperdrive/examples/connect-to-postgres/postgres-drivers-and-libraries/node-postgres/
   https://developers.cloudflare.com/workers/configuration/secrets/

5. PostgreSQL documents conversion of scalar values separately from composite
   rows. That supports the existing field-level conversion correction. The
   performance improvement is established by our before/after production probes,
   not asserted by the PostgreSQL manual.
   Source: https://www.postgresql.org/docs/16/functions-json.html
   Evidence: evidence/voice-contact-policy-before-20261024.json
   evidence/voice-contact-policy-after-20261024.json

## Proposed next flow — design, not an activated feature

Vapi handles conversation and requests an allowlisted action through a saved,
authenticated tool. PrimeCare resolves the canonical active provider call and
binds it to the authenticated native account through a private pairing flow.
The user enters the SMS code in the app. PrimeCare checks current tenant/screen/API
rights, availability and the configured cancellation policy. A write requires
independent confirmation of exact details, a durable once-only claim and saved
result readback before the assistant reports success. Reception is the fallback
when identity, policy or routing cannot be established.

## Questions to resolve before coding call pairing

- Which documented Vapi/Twilio call hook can privately deliver the pairing code
  before the AI receives audio or transcript? Keypad collection alone is not
  evidence that secrets are excluded from all model input and artifacts.
- How are the native account, Vapi call and Twilio call bound, expired and revoked
  after logout, contact changes, transfer or call end?
- Which appointment endpoints create confirmed appointments, versus merely
  submitting booking requests? Which source defines duration and cancellation?
- How will reception, four-digit extensions, unanswered calls and voicemail email
  behave on the current number, with a tested fallback and preserved routing?
- Which exact tool schemas, authentication mode, timeout/retry rules and end-to-end
  tests will be used? Provider success alone is not database/business success.

For each next step: read primary documentation, inspect existing metadata and
code, present the design and gaps, then implement and validate against explicit
acceptance criteria. No new production code or tool attachment was performed
following the user's research-first instruction.

## Approved contact-number matching implementation

The user approved using the registered contact number with OTP and independent
task confirmation. The existing native session selects the user and tenant;
there is no public phone-to-user lookup and no automatic selection among accounts
sharing a number. The current verified contact record is the SMS destination.

The inherited VoiceOtpService now additionally compares the independently fetched
Twilio call's From number with that contact before claiming a verification send,
before/after checking OTP, and at each use of the resulting task identity. Exact
canonical E.164 equality is required; hidden, client/SIP, malformed and different
numbers fail closed. This first path requires calling from the registered number.
It does not implement calling from a different phone or a reception transfer.

Caller-number equality is a restriction, not identity proof. Private call pairing,
OTP, current native account/session, tenant rights and independent exact task
approval remain mandatory. Matching caller ID cannot bypass any of them. A
shared contact number does not transfer a grant to another native user or tenant.

Primary sources reviewed before implementation:
- https://www.twilio.com/docs/voice/api/call-resource (provider call fields)
- https://www.twilio.com/docs/verify/api/verification-check (token validation)
- https://docs.vapi.ai/tools/static-variables-and-aliases/how-variables-work
  (signaling variables versus model-generated input)

This is an additional server-side constraint within the existing registered OTP
operations, not a new endpoint or permission. No schema, metadata, credentials,
phone routing or provider tool attachment changes are needed for this constraint.
The unmounted call-OTP runtime and missing private pairing/native UI remain
separate activation blockers. No live OTP, call authentication or business task
is claimed by isolated tests.

Validation of the matching constraint: 33 identity/provider/API tests and 37
composition/approval/task tests passed locally, plus strict service TypeScript.
The real workerd test passes 35 checks, including mismatched caller denial before
SMS. The disposable PostgreSQL suite now checks the same denial before accepting
the matching number; its CI result must be checked separately.

Main commit 33a817f4b483e2ae96aa0a8a7eefce190adc1983 passed the 33-test identity
job and read-only production readiness workflow 40153173060. The production
reader confirms zero verified contacts and missing native OTP grants, pairing UI,
private delivery and mounted OTP runtime. The deployed enrollment boundary still
passes its independent denial/source checks. Evidence:
evidence/voice-contact-task-identity-20261024.json.

The first broad voice CI run exposed two old positive fixtures with mismatched
caller numbers; fixtures were corrected and explicit mismatch assertions added.
An unrelated contract-plan gate also fails on its already-stale gateway source
amendment hash (the preceding main commit failed that gate too). No review hash
is changed or bypassed by this work. Passing identity tests is not passing live
activation or all repository checks.
