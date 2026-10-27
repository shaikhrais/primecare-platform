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

## Deployed configuration and readback

Source 208fb9cf9ceb592f5ffd9a303209615fc738f093, workflow run 40429469151:
focused tests job 121943349096 and production deployment job 121943535397 passed.
Registered API ID 16565; function tool 764dd85f-fafd-45c1-9352-45867ed94371 is
attached to the active receptionist 5ae2ab0c-fad0-454c-8cf7-64b81c91c850.
The dedicated Verify service, tool, full assistant model and artifact settings
were read back. Anonymous requests return 401 and a nonexistent call receives a
safe tool error without sending SMS. Phone routing and business tools are unchanged.

At readback there were zero active verified-contact records. First enroll the
owned account phone in the existing Account SMS screen. A real incoming call,
SMS delivery and spoken-code approval remain unverified; no SMS or call was
started by these checks. This is configuration plus negative-live-boundary proof,
not a successful live identity verification.

The unrelated workflow-contract-plan check was already failing before this change
(run 40426784922) and still fails its reviewed gateway.ts source-amendment hash.
The spoken verification release tests and deployment passed independently. No
unreviewed gateway change or hash bypass is included here.
