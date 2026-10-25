# Internal browser calling — live verification, 25 October 2026

Internal audio calling is deployed for active users with existing communication
access, within the same tenant. It uses WebRTC and Cloudflare TURN. Twilio is not
required for this internal calling path.

The live production test passed in both call directions, including a call back.
The first connection in the final test took **52,951 ms**. Calling works, but
initial connection setup is still slow and needs further performance work.

## Use calling

1. Sign in to your permitted portal, such as [the clinic portal](https://primecare-clinic.pages.dev/login).
2. Open **Calls** from the workspace navigation.
3. Click **Enable incoming calls**. Your four-digit extension is shown on the page.
4. Share that extension with the other permitted user. They enter it and click **Call**; you click **Answer**.
5. Allow microphone access. Use **Hear audio** if the browser blocks automatic playback.
6. Use **Mute** or **End call** as needed. **Disable incoming calls** unpublishes your extension.

Both people must keep the Calls page open. Optional browser notifications require
permission; closed-app/background push ringing is not part of this release.
A user without an existing communication screen grant does not gain calling
access through the UI or by guessing an endpoint.

## Shared implementation and storage

The existing messaging service and call-only composition inherit
`ConversationCallServiceBase` and the scoped communication/channel bases.
Browser sessions reuse `BrowserAudioSession` and `BrowserAudioCall`; a derived
`BatchedIcePeerConnection` sends candidate-bearing SDP without a database RPC
for every candidate. Native identity, current API/screen grants, participant
scope and tenant boundaries remain server-authoritative.

Four-digit extensions are stored in native PostgreSQL
`public.communication_voice_extensions`, with tenant/user ownership, publication,
active state and version. The global non-cycling sequence allocates 1000–9999.
Assignment is explicit for the current user; unpublished/revoked values are not
silently reassigned. Real users were not automatically enrolled.

Private call sessions, semantic commands and events use the existing
`business_work_aggregates`, `business_work_commands` and `business_work_events`.
A session binds to tenant/caller/request UUID for stable retries and mutual
calling. Sorted per-user advisory locks enforce one active call per user.
Operational presence updates preserve signaling versions. Ringing expires after
45 seconds; accepted calls lose their lease after 90 seconds without presence.
The inbox prioritizes active calls and excludes inactive-party histories.

The five registered POST APIs are directory, extension, dial, command and media
under `/v1/calls/` (native IDs 16542–16546). They use native opaque sessions and
current existing-screen grants. Media credentials require a current accepted
call and participant scope. Long-lived TURN secrets stay encrypted in the owned
Worker. Only expiring credentials reach the browser, which uses relay-only ICE.

The deployed Worker is `primecare-internal-calls-api`, connected through the
existing API gateway. All prior known service/secret bindings and public phone
routing were preserved. This release does not activate Vapi/PSTN appointment
operations or establish voiceprint accuracy.

## Verification evidence

- Deployed source: `f9129710664697903cbeb2a783485bd19905c76e`.
- [Production workflow 40224041770](https://github.com/shaikhrais/primecare-platform/actions/runs/40224041770): all 17 jobs passed, including metadata, native checks, deployment, nine website publications and live acceptance.
- Native suite: 52 cases passed, one existing optional case skipped; 11 PostgreSQL HTTP groups passed, plus real Workerd request/redirect checks and native/tagged policy projection tests.
- Chrome 155.0.8059.39: actual native login, explicit extension publication, no pre-acceptance microphone, increasing audio RTP packets and selected relay candidates on both peers.
- Both call directions, call back, mute/unmute, hangup, idempotent dial, foreign-tenant denial, independent PostgreSQL readback and server-side session revocation cleanup passed.
- All synthetic users, sessions, extensions and owned call/tenant records were removed. Receipts contain no bearer credentials, raw audio, SDP or IP addresses.

[Machine-readable receipt](../../reports/communications/internal-calling-live-20261025.json)
records the source and job identities. This is functional execution evidence;
independent governance review flags were not marked approved.

## Known limits

Initial setup remains slow (about 53 seconds in the final live test, improved
from about 63 seconds). The proof used synthetic microphone audio in real
authenticated browser sessions against live infrastructure. Physical device
acoustics, every browser/network combination, closed-app ringing, real-speaker
biometrics and public telephone calling are not claimed by this evidence.
