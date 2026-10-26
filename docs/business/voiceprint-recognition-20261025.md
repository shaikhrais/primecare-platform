# Voiceprint recognition — 25 October 2026

This implements biometric speaker enrollment and matching, separately from
speech-to-text, OTP and spoken transaction confirmation. It does not relabel any
of those existing flows as voiceprint recognition.

`VoiceprintProviderBase` inherits the shared communication resource base and owns
bounded canonical mono PCM16 WAV validation. `AculabVoiceprintProvider` derives
from it and implements the documented register, verify and delete API calls.
The server pins cloud region, user group credentials and nonnegative sensitivity.
It uploads bytes directly, disables redirects/retries, bounds responses and
request time, enables presentation-attack detection and text dependence, and
rejects replay/synthetic flags even if the provider returns a positive match.
Scores remain internal; this does not claim a calibrated false-accept rate.

`VoiceprintRecognitionService` extends `ScopedServiceBase`, and its audio channel
extends `CommunicationChannelBase`. Both Vapi and Twilio hosts can use this same
core. Enrollment requires explicit versioned consent plus a fresh independent
OTP/passkey/native proof. Trusted host ports must provide the canonical live
call/account mapping and durably consume a signed audio capture bound to that
call. Caller-provided URLs, model judgments and client similarity scores have no
port into recognition. Raw waveforms and voice vectors are not stored in the
lifecycle database; the biometric provider holds its model.

Each external enrollment or verification attempt is claimed durably before
provider I/O. A replay cannot submit it again. Cross-owner/tenant access is denied.
Enrollment uncertainty remains unknown. Verification rechecks the exact current
profile version and live call before releasing a short-lived match result.
Revocation disables local recognition before requesting provider deletion, and
reports whether provider deletion was confirmed or remains uncertain. Deletion
failure does not revive a profile. Profiles and attempts use the separate
`business_voiceprint` store family with its candidate three-table migration;
no existing aggregate kind constraint is weakened.

The recognition result is evidence, not a voice-task grant. Existing task identity
still requires its approved authentication flow. No callback endpoint, enrollment
UI, provider account, role grant, production schema or phone routing is installed
by this change. The host capture/proof/policy bindings and risk-reviewed task
integration must be implemented and verified before enabling live use.

Eight local lifecycle/provider tests and strict TypeScript passed. Seven Worker
checks and eight native PostgreSQL groups are added to communication CI. They use
synthetic WAV and stubbed provider HTTP, proving wiring, state, spoof rejection,
concurrency and access rules rather than actual recognition accuracy. Their run
results must be independently read before being reported as passing.

For live testing, supply an Aculab account with Voice Biometrics enabled and a
Voice Biometric User Group Key. Required host configuration maps to cloudId,
username, groupKey and sensitivity. Do not put credentials in source or chat.
First enroll consenting, independently verified test users, then measure genuine
and impostor/replay/synthetic results on real phone captures before activation.
The current code has not contacted a live biometric provider or enrolled anyone.

Research sources:
- https://docs.cloud.aculab.com/Guides/guides_voice_biometrics/
- https://docs.cloud.aculab.com/Web_Services_API/web_service_voice_biometrics_users/

The current API documentation requires provider-side enablement. Older VoiceIt
search results were not used as an integration contract after their documentation
URL redirected to a different product site. No vendor account was purchased.

## Verified runtime evidence

Source `24534cb19791da719f3138a92473a8addc134b76`, communication CI run
`40198466844`, job `121184334232` (`twilio-voice`) passed. Its actual workerd
report is `WORKERD_VOICEPRINT_PASS 7`. Native PostgreSQL reported eight groups,
independent database readback, one provider request per durable claim, positive
spoof-result rejection, cross-tenant denial and revocation. Eight new provider/
lifecycle unit tests passed in that job. Worker validation job `121184334308`
also passed. Both provider traffic and biometric accuracy remain simulated and
unmeasured respectively; no real enrollment or authentication was performed.
Evidence: `evidence/voiceprint-recognition-20261025.json`.

## Transport repair — 26 October 2026

The provider transport now calls native fetch without an object receiver and uses
manual redirects, rejecting all non-success responses. The previous injected
function fixture did not detect native fetch receiver/runtime behavior. A new
workerd test uses real native fetch with intercepted outbound HTTP. Nine unit
tests and seven existing Worker checks plus the native-fetch regression pass
locally (installed runtime compatibility date 2026-05-03; CI retains 2026-07-30).
These are simulated provider replies, not live biometric acceptance.

Activation still requires an Aculab account enabled for Voice Biometrics, a
region/cloud ID, account username and Voice Biometric User Group Key configured
securely in production; independent verified enrollment and a signed single-use
call capture path are also absent. No saved voiceprint or live identity grant
can be inferred from the presence of this code. Enrollment/revocation and task
authorization remain guarded. The text-dependent adapter requires the same
phrase for enrollment and verification; randomly selected security answers are
not a replacement for that phrase. Three-question account setup/storage and its
phone challenge are not implemented by this transport repair.
