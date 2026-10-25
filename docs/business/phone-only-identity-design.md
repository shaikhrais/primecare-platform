# Phone-only identity and task approval

User requirement: complete account tasks during a phone call without an app UI.
This supersedes the app-pairing requirement for the proposed phone-only path.
Existing native enrollment and app flows remain separate capabilities.

## Research findings

Vapi's keypad input settings explicitly turn digits into a user conversation
message available to the model. Disabling transcript retention does not prevent
model exposure. Standard keypadInputPlan must therefore not collect SMS OTPs.
Source: https://docs.vapi.ai/documentation/assistants/conversation-behavior/keypad-input-settings

Twilio Gather can collect DTMF and submit it to an action endpoint. A dedicated
Twilio-controlled verification segment must run with no AI stream or recording.
The handler must validate Twilio signatures against a fixed public URL, verify
the canonical live call, and never log digits or forward them to Vapi.
Source: https://www.twilio.com/docs/voice/twiml/gather

Vapi documents Twilio-controlled call orchestration and a provider-bypass TwiML
example. That example is not production-ready identity infrastructure: its global
CallSid storage, unprotected application routes and implicit call mapping must
not be copied. Compatibility with our saved assistant and canonical provider
call binding still requires a controlled integration test.
Source: https://docs.vapi.ai/calls/call-handling-with-vapi-and-twilio

## Required backend changes before activation

1. Register provider-authenticated phone verification and approval operations in
   the pinned PostgreSQL governance authority before implementing HTTP routes.
2. Resolve eligible account candidates from the provider-read contact number.
   Caller ID is only a candidate selector. Do not reveal account names or tenant
   details before OTP verification. Zero candidates must use generic failure.
   Shared numbers require an explicit account selector and account authorization;
   possession of a shared phone alone cannot safely disambiguate personal access.
3. Create a short-lived call authentication challenge with durable send quotas,
   attempt limits and one active check. Send through Twilio Verify. Collect the
   code through a DTMF-only Gather action outside Vapi. No automatic resend after
   an uncertain provider response.
4. Create a call-scoped verified identity only after successful verification and
   current user, tenant, contact version, call and permission checks. Do not fake
   a native app session or remove native checks from existing VoiceOtpService.
5. Allow Vapi to propose an authorized task. Load its exact server-side summary
   and digest, temporarily move call control outside the AI, read the summary,
   then collect 1 for approval or 2 for cancellation. The signed callback carries
   a single-use challenge bound to call, user, tenant, identity grant and digest.
   A generic keypad 1 observed by the AI is not an approval credential.
6. Consume approval once; execute with a durable idempotency key and verify the
   saved result before reporting success. End, transfer, contact change or expiry
   invalidates access. Keep reception fallback configured independently.

## Current implementation gap

VoiceOtpService currently requires a real native session and private app pairing.
PostgresVoiceTaskConfirmationService currently writes app approvals. Merely adding
Gather XML cannot make those services phone-only. The new provider-authenticated
identity lifecycle and approval collector require metadata, implementation and
tests. No new live routes, phone routing or assistant tools were enabled here.

Acceptance must cover model/transcript exclusion, signed callback forgery, hidden
and spoofed caller numbers, shared contacts, cross-tenant isolation, wrong OTP,
quotas, duplicate callbacks, call transfer/end, changed task digest and independent
API/database result readback. Synthetic tests cannot certify live isolation.

## Concrete contract proposal

See phone-only-contract-proposal.json for the four proposed provider operations,
signed form transport, challenge bindings, lifecycle and activation gates. This is
a database registration proposal, not live API documentation. No HTTP handler may
be mounted from this draft. The callback query must be included in signature
verification; do not weaken the fixed-URL verifier to accept arbitrary host URLs.
An unsigned or replayed keypad digit cannot create a voice identity or approval.

Shared-phone handling is intentionally unresolved for personal account access:
phone possession cannot distinguish family members. Until a separate selector
and authorization policy exists, ambiguous contacts use reception. No list of
account holders is read aloud before authentication.
