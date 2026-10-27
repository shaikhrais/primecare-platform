# SMS account-phone verification

Implemented and deployed directly on main, 26 October 2026 (Toronto).

The shared Account screen now has an explicit first-time phone enrollment form:
consent, Send SMS code, six-digit code entry, Verify phone and status refresh.
Opening the screen never sends an SMS. Only the registered native contact
status/start/check endpoints are used. Codes are cleared before checking and on
logout, with no browser-storage persistence. The existing service enforces a
session authenticated within five minutes, own-account and current API/screen
permissions, durable quotas, single-flight checks and first-time-only enrollment.
Unknown send outcomes do not cause automatic retries. Existing or revoked phone
records are preserved and require the separate support/recovery process.

The Twilio Verify fetch adapter now invokes native fetch without an object
receiver and manually rejects redirects. A new workerd test exercises the real
native fetch primitive with intercepted HTTP for both send and check.

## Verified evidence

- Source: 1020475922e0fea4f299464a2a762771a9105d81.
- Native tests and deployment: run 40426784863, test job 121934423720,
  deployment job 121934689122, all successful.
- Native deployment preserves gateway services/secrets, validates the actual
  six-digit Twilio Verify service and checks anonymous/unknown-session denial,
  foreign-origin denial and allowed-origin CORS.
- A temporary synthetic Code Administrator session received HTTP 200 and
  verified:false/enrollmentAllowed:true. Removing its role produced 403;
  revoking its session produced 401. Temporary user, tenant and session were
  removed. This is not credential-login or MFA acceptance evidence.
- Browser run 40426508545, review job 121933487665: consent/send, wrong and
  correct code, status readback/reload, unavailable service and logout disposal
  passed with a synthetic provider. All portal publication also passed.
- Native PostgreSQL suite verifies the simulated provider send/check and exact
  phone persistence/readback; no real SMS is sent by the deployment checks.

## Live acceptance still required

Sign in again; open Account > Verify your phone by SMS; enter an owned number in
international format; consent and send; enter the received code only in the app.
Verify the saved status survives refresh. No real delivered SMS or successful
real-code verification is confirmed yet. Do not record the code in chat/logs.

This enrolls an account phone only. Vapi call pairing/runtime, caller identity
and independent booking approval are separate and remain incomplete. Voiceprint
work remains dropped and disabled.
