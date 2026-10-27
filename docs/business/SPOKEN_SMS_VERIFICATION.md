# Spoken SMS verification

The requested phone-only flow uses the dedicated Vapi function
`primecare_phone_verification`, with request and check actions. The server uses
Twilio Verify for generation, expiry and checking; raw codes are not stored in
PrimeCare. A separate Verify service prevents app enrollment/sign-in codes from
being accepted as phone-spoken verification codes.

The provider-authenticated callback accepts only the registered operation and
one expected function call. The canonical Vapi call is re-read around Twilio
validation. Only the pinned org, active receptionist, existing 4277 phone routing,
inbound in-progress Twilio call and unique active verified account contact qualify.
Unknown, shared, revoked and mismatched contacts fail closed. The model cannot
choose a phone, actor, tenant or provider credential. An explicit caller agreement
is required before the request action. Codes are six digit strings.

A private phone-keyed Durable Object stores the durable send claim, Twilio
verification SID, call/account/contact version, two-minute deadline, attempt count
and idempotent result receipts. It stores no raw code. One send is permitted per
phone per ten minutes; five checks exhaust the challenge. Sending/checking is
claimed before external I/O. Uncertain results cannot trigger a resend. A new
call or changed account/contact cannot reuse the challenge. State is deleted by
alarm after ten minutes. A correct result is released only after fresh call and
contact checks. It is call-scoped phone possession evidence; it does not approve
an appointment, grant native login or activate business-task tools.

The deployment registers only API metadata in the pinned production governance
PostgreSQL database. It changes no role grants or PostgreSQL schema. The dedicated
Worker uses isolated durable challenge storage and its own provider credential.
It creates/reuses the separate PrimeCare Call Verification Twilio Verify service,
then creates/reads back the function tool and preserves the receptionist model
when attaching it. Phone routing remains unchanged. The receptionist's recording,
call logging, packet capture and stored transcript are disabled. Speech/code
still traverses the AI/transcription providers during processing; this is not a
claim of zero retention across every provider.

Tests cover inherited service policy, invalid/overridden inputs, call/contact
changes, real workerd native fetch with intercepted Twilio HTTP, wrong/correct
codes, durable restart, one send, duplicate delivery, expiry, uncertain-send
suppression, cross-account denial and the five-attempt lock. Simulated provider
checks are not live SMS or voice acceptance evidence. Deployment receipts must be
read independently before claiming tool attachment or activation succeeded.

For live acceptance: first enroll the owned account phone in Account > Verify your
phone by SMS, then call the existing receptionist from that number. Ask to verify
identity, consent to a new call-verification SMS, and read only the code in that
new text. Never read app enrollment or login codes. No real call or SMS is started
by the deployment checks. Voiceprint work remains disabled.
