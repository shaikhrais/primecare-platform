# Phone-only authorization and appointment confirmation — 25 October 2026

Implemented without requiring an app session during the call. The caller enters
their four-digit account extension, receives an OTP at the account's previously
verified contact, enters the code on the phone keypad, hears the exact server
proposal, then says “confirm appointment” or presses 1. The task API uses the
verified call identity and consumes that exact confirmation once before writing.

This is OTP authentication plus spoken transaction confirmation. It does not
identify a person from their voice, enroll voiceprints, treat caller ID as proof,
let the AI approve tasks, or fabricate an auth_sessions record.

## Shared inheritance and composition

- `CallAuthorizationServiceBase extends ScopedServiceBase` owns canonical live
  call validation, current account resolution and scoped policy checks.
- `PhoneOtpCallAuthorizationService` inherits that base for durable OTP claiming,
  verification, five-check limit and a call-scoped grant lasting at most five
  minutes. Existing app-paired `VoiceOtpService` remains compatible.
- `VoiceTaskConfirmationServiceBase extends ScopedServiceBase` owns current
  identity, exact proposal/session/tenant/owner checks and confirmation policy.
  The existing app service and new `SpokenVoiceTaskConfirmationService` inherit it.
- `TwilioPrivateCallAdapterBase extends TwilioSignedFormAdapter` shares signature,
  bounded body, canonical call and fixed redirect behavior. Derived private OTP
  and readback adapters handle their dedicated signed callbacks.
- `PhoneCallOperationCore` composes actual PostgreSQL repositories and the shared
  `VoiceTaskService`. Its Vapi adapter and Twilio adapters use those same services;
  neither provider implements separate task or authorization rules.

The account extension selects a candidate only. The native directory joins active
users, tenants, extensions and independently verified contacts. A phone shared
with another active verified account is ambiguous and goes to reception; OTP at
that shared number cannot silently authorize another user's account. OTP may be
entered while calling from a different phone: possession of the registered
contact is what gets verified. Changing directory/contact versions, deactivation,
policy revocation or ending the call invalidates access on subsequent checks.

SMS submission is claimed durably before Verify, using the existing shared
per-contact quota of three sends per ten minutes. The provider port must use the
existing bounded no-retry official Verify client. Neither code nor its transcript
is stored in the new tables. The host must isolate these private Gather steps
from AI streaming/recording and apply registered endpoint/source/call rate limits.

## Exact confirmation boundary

The full proposal summary is a separate Say before Gather opens, preventing
barge-in during details from becoming approval. Each callback URL carries a new
random challenge covered by Twilio's signature. The repository binds it to the
canonical call, OTP grant, actor, tenant, intent and digest for at most 60 seconds.
A replay cannot approve a later challenge. Bare “yes,” negation, silence, mixed
speech/digits and cancellation decline the one-use decision. Spoken confirmation
is restricted to `appointment.booking.request`; other tasks require their own
reviewed confirmation policy. No model tool exposes OTP checking or approval.

Task execution rechecks the exact digest, definition version, current identity
and scoped permission. Confirmation consumption and task claiming are atomic
compare-and-set operations. The underlying registered booking API must check
ownership, eligibility, slot/version/time and availability transactionally and
honor `voice-task:<intentId>` as its idempotency key. Uncertain writes remain
unknown and never retry automatically. Task completion means the registered
booking-request operation completed; it does not by itself prove an appointment
was booked. Real success still requires API/database readback.

## Validation and activation

Local checks passed 35 new/existing phone, OTP, task and app-confirmation tests,
14 additional Vapi/reception regression tests, strict TypeScript, and a Worker
bundle with nodejs_compat dependencies. The new CI tests run actual workerd and
disposable native PostgreSQL through signed phone callbacks and the shared Vapi
task transport, including independent booking-request readback and concurrency.
Those runtime results must be read from their completed CI jobs before claiming
success. Test accounts, provider responses and booking tables are synthetic.

`20261025_communication_phone_authorization.sql` is a candidate additive schema
with separate call-grant and one-use confirmation tables. It has not been
registered or applied to production. No endpoint or role grant is created here.
Next: register exact schema and signed callback contracts in pinned production
governance, deploy the private host with real policy/Verify/booking ports, wire
the Vapi call handoff/resume, and verify a real booking end to end. Existing phone
routing and the deployed unavailable Vapi tool boundary remain unchanged.

References reviewed: Twilio Gather documentation (signed action callbacks,
SpeechResult, DTMF and empty-result handling), Vapi call handling with Twilio,
and the existing repository's provider identity/tool contracts.
