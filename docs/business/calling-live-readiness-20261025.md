# Internal browser calling — live verification, 25 October 2026

Internal audio calling is deployed for active users with existing communication
access, within the same tenant. It uses WebRTC and Cloudflare TURN. Twilio is not
required for this internal calling path.

The latest production test passed in both call directions, including a call back.
Both relay transports connected before Answer with zero microphone tracks.
Answer-to-bidirectional-relay-audio took **5,047 ms**, following 7,071 ms with
pooled preparation and 10,040 ms with authenticated push. This measurement starts
at the Answer click and ends when both peers report connected relay audio with
more than ten received audio packets. The one-second production target remains
unmet. The separate local real-Chromium transport test took 352 ms; that test
excludes production authorization and TURN.

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

The original five registered POST APIs are directory, extension, dial, command and media
under `/v1/calls/` (native IDs 16542–16546). They use native opaque sessions and
current existing-screen grants. Media credentials require a current accepted
call and participant scope. Long-lived TURN secrets stay encrypted in the owned
Worker. Only expiring credentials reach the browser, which uses relay-only ICE.

The deployed Worker is `primecare-internal-calls-api`, connected through the
existing API gateway. All prior known service/secret bindings and public phone
routing were preserved. This release does not activate Vapi/PSTN appointment
operations or establish voiceprint accuracy.

## Permission-query performance

Five nonunique production indexes were built concurrently on native governance
API permissions, screen permissions, screen/API links, role codes and endpoint
routes. Existing rows, grants and public telephone routing were preserved.
The calling policy inherits every current authorization check, while preserving
native bigint/text fields in indexed joins instead of converting them to JSON.

Actual PostgreSQL query plans measured the legacy query at 233.509 ms and the
indexed native query at 1.095 ms. The planner used the permission, screen-link,
screen-permission and endpoint-route indexes. Native authorization decisions
matched; foreign tenants, missing users and inactive users were denied. The
rollback-only profiling identities were removed without issuing sessions.
The index fixture preserved 80,000 rows, reused an existing equivalent index,
rejected conflicting index definitions and verified repeatable application.

The read transport uses cache-disabled Hyperdrive against the same pinned native
PostgreSQL origin. Advisory-lock transactions remain on the native connection.
Neither roles nor authorization results are cached. Optimistic client versions
are concurrency hints; every command still receives current server checks.

## One database operation for current call context

The inherited session, endpoint and call policies now share one generated,
parameterized PostgreSQL query. It reads the current native session, manifest,
API and linked-screen grants, scoped policy documents, active participants,
linked task and selected call state in one database snapshot. It does not cache
roles, grant decisions or session validity. Each authorization boundary obtains
a fresh snapshot. An authorized store read consumes its own snapshot receipt
once; commands and later reads cannot reuse it.

The production credential returned SQLSTATE 42501 when creating the optional
stored function, on both pinned database hosts. No function or extra grant was
installed. Production therefore executes the same SQL directly as one query.
The optional owner-only SECURITY INVOKER function was tested in disposable
PostgreSQL, including dry run, independent readback, repeat application and
preserving a conflicting function.

A complete read request now typically uses four SQL statements instead of 26:
three fresh HTTP authorization boundaries and one authorized state read. Media
requests use eight instead of 56. Call mutations keep the inherited native
transactions, advisory locks, version checks and command ledger.

In the controlled live runs, mean read-request time fell from 1,352 to 574 ms;
media requests from 3,003 to 1,040 ms; accept from 3,031 to 1,596 ms; and signal
writes from 2,337 to 1,445 ms. These are observations from one synthetic-browser
run per source, not a latency guarantee. Database/network latency, native write
transactions and polling/signaling order remain measurable costs.

## Authenticated push notifications

A per-user Cloudflare Durable Object now holds the browser's WebSocket connection.
The new registered `GET /v1/calls/events` endpoint is native API 16547. The server
checks the current native session, active tenant, existing command permission,
events permission and linked screen grants before authenticating a connection,
on heartbeats and before releasing each notification. Four existing eligible
roles received the additive event grant; existing command and screen denials
were preserved. A client-provided user ID selects a connection target and must
match the authenticated native identity; it never supplies authority.

The raw session token is sent in one bounded authentication frame, never in a
URL or retained socket attachment. Attachments retain an identity/session-hash
reference, not a cached grant. Server messages carry only `ready`, `changed`,
`signal` or `pong`, with no call IDs, private bodies, SDP or audio. Call updates
must commit before invalidation is scheduled. The receiving browser reads its
current private state through the existing authorized APIs. Invalidations can
coalesce; reconnect reads current state again.

When connected, inbox recovery polling runs at ten-second intervals; it uses
two-second intervals when disconnected. Existing one-second audio checks remain
to preserve native session-revocation cleanup. Ringing still expires after 45
seconds. This release does not remove all polling or reduce the native write
transaction's SQL statements. Durable Object storage holds transport/expiry
metadata only; PostgreSQL remains the call and governance authority.

Both live browsers received a ready acknowledgement, three call-change
notifications and a signaling notification before the first audio check.
Bidirectional relay packet growth, reverse calling, mute/end, denied access,
idempotency, independent PostgreSQL readback and session-revocation media cleanup
passed. The observed answer-to-audio result was 10,040 ms versus 11,043 ms in the
previous run. Each source has one controlled run, and readiness is sampled at
approximately one-second intervals, so this is not an isolated latency benchmark.

The actual Workerd WebSocket/Durable Object test checks origin rejection,
first-frame authentication, subject mismatch, bounded payloads and revocation
before delivery with a fixture authorization port. Separate real PostgreSQL tests
check current native sessions and both API/screen permissions. Three browser
resource tests cover authentication, denial, cleanup and reconnect fallback;
three native metadata tests cover existing-grant eligibility and deny preservation.

## Earlier push verification evidence

- Deployed source: `3b6feca3e0c911de0da0779f1f932b2b3a23523f`.
- [Production workflow 40247396185](https://github.com/shaikhrais/primecare-platform/actions/runs/40247396185): all 17 jobs passed, including metadata, native checks, deployment, nine website publications and live acceptance.
- Native suite: 59 cases passed, one existing optional case skipped; 12 PostgreSQL HTTP groups passed, plus real Workerd request/redirect checks, native/tagged policy projection tests and the combined-query PostgreSQL flow with current revocation, participant, tenant, policy and duplicate-endpoint denials.
- Chrome 155.0.8059.39: actual native login, explicit extension publication, no pre-acceptance microphone, increasing audio RTP packets and selected relay candidates on both peers.
- Both call directions, call back, mute/unmute, hangup, idempotent dial, foreign-tenant denial, independent PostgreSQL readback and server-side session revocation cleanup passed.
- All synthetic users, sessions, extensions and owned call/tenant records were removed. Receipts contain no bearer credentials, raw audio, SDP or IP addresses.

[Current push performance and live receipt](../../reports/communications/internal-calling-push-performance-20261025.json)
records the source and job identities. This is functional execution evidence;
independent governance review flags were not marked approved.

## Current silent transport and verification

Three preparation POST contracts are registered with independent native readback:

| Route | Native API | Purpose |
| --- | --- | --- |
| `/v1/calls/prepare` | 16548 | Short-lived relay credentials for unexpired ringing or accepted parties |
| `/v1/calls/prepare/read` | 16549 | Current session, command/media and own API/screen grants, policy, state and active participants in one read-only SQL snapshot |
| `/v1/calls/prepare/signal` | 16550 | Inherited atomic offer/answer signaling during an unexpired ring or accepted call |

Only current same-tenant call parties can use these contracts. Existing command
and media grants are prerequisites; explicit denies are preserved. Four existing
eligible roles have the additive preparation grants and 12 screen links. The
original media and signaling routes retain their accepted-call requirements;
ordinary command reads continue to hide ringing SDP. The separately scoped
preparation read releases it only after its current permission and participant
checks. Original screen-link purpose text is preserved as historical registration
metadata; the pinned preparation contract describes the new silent-SDP scope.

During ringing, the caller creates an empty audio transceiver and the recipient
adopts the incoming offer's audio transceiver, setting it to send and receive
before answering. No microphone is acquired and no remote stream is delivered to
playback yet. On acceptance, a fresh current-state read precedes microphone
capture. Captured tracks remain disabled until another current accepted-call
read passes, then replace the negotiated sender's track. No second SDP exchange
is needed. Acceptance initializes both presence leases in the inherited atomic
transition; subsequent heartbeats preserve semantic versions. A current-state
read prompted by authenticated push can start media without waiting for inbox
polling. One-second authorization watchdogs and close/navigation cleanup remain.

The recipient-transceiver rule matters: a separately `addTransceiver`-created
answerer sender is not associated with the remote offer. An intermediate source
connected both transports but produced one-way audio; its failed live test
completed synthetic cleanup. The corrected source reuses the offered sender.
See the [W3C transceiver specification](https://w3c.github.io/webrtc-pc/#rtcrtptransceiver-interface).
A real-Chromium preconnection test now gates deployment and checks both connected
peers, zero microphones and no playback delivery before acceptance, two active
microphones afterwards, two-way audio packets and exactly two SDP writes.

- Current deployed source: `bcc701eeb6b8f005487f639d15a0ce42236fceb4`.
- [Production workflow 40256035852](https://github.com/shaikhrais/primecare-platform/actions/runs/40256035852): all 17 jobs passed, including native metadata, PostgreSQL, real Chromium, deployment, nine websites and live acceptance.
- Core unit suite: 67 passed, one existing optional skip. Adapter/Flutter bridge: 31 passed. Events browser: 3 passed. Native endpoint: 7 passed. Twelve PostgreSQL HTTP groups and the current-scope context flow also passed.
- Native checks include old-route rejection before acceptance, separate preparation signaling, hidden ordinary ringing SDP, current media revocation, nonparty/tenant denial, expired sessions, inactive participants, policy/manifest drift and duplicate endpoint denial. Readiness uses exactly one native query.
- Real local Chromium: both connected before Answer with zero microphone tracks; two-way audio after acceptance in 352 ms. This is transport evidence, not production latency.
- Real production Chrome 155.0.8059.39: both preconnected relay peers had zero microphone tracks before Answer. Both call directions, increasing two-way audio packets, mute/end, idempotent dial, independent PostgreSQL readback, tenant denial and session-revocation cleanup passed.
- Production answer-to-audio: 5,047 ms, sampled at approximately one-second intervals. The acceptance request took 2,030 ms. The recipient activated its microphone at about 3,154 ms and the caller at 4,378 ms after the Answer clock estimate. ICE gathering finished before Answer (312/322 ms); remaining latency is in acceptance and current-state/media activation, not connection gathering.
- All synthetic users, sessions, extensions and owned call/tenant records were removed. Evidence contains no credentials, raw audio, SDP or IP addresses. Independent governance review flags were not marked approved.

[Current preparation performance and receipts](../../reports/communications/internal-calling-preparation-performance-20261025.json)
include exact sources, jobs, stages and limits. The
[preceding pooled-preparation receipt](../../reports/communications/internal-calling-pooled-preparation-performance-20261025.json)
records the independently successful 7,071-ms checkpoint.

## Known limits

The latest production setup took 5.047 seconds after Answer despite both
transports being connected beforehand. One-second production calling is not
verified. Each source has one controlled run, not a latency distribution. The
proof used synthetic audio and pregranted microphone permissions in real
authenticated browser sessions against live infrastructure. First-use permission
prompts and blocked autoplay can add user-dependent delay. Physical device
acoustics, every browser/network combination, closed-app ringing, real-speaker
biometrics and public telephone calling are not claimed by this evidence.

## Additional index review

A subsequent read-only production review inspected the existing indexes and nine
query plans for directory, inbox, busy-call detection, extension ownership/number,
call state, participants, native permissions and a deliberately missing session.
The sampled SQL execution times were 0.151–1.929 ms. Existing indexes cover session
hashes, user and tenant IDs, extension number/ownership, call tenant/ID, command
idempotency and event versions. No additional index was justified or added.

This reflects the current small data set, including one work aggregate and three
extensions. Several probes returned no matching calls; the combined context used
an invalid session, and the sampled principal lacked the command grant. This is
not a large-history or full authorized-context load test. Previously verified
permission indexes and the live calling implementation remain in place. Revisit
membership/inbox indexing when retained call history or measured scan cost grows.

[Read-only index review and query plans](../../reports/communications/internal-calling-index-review-20261025.json)
record the observations and limitations. [Workflow 40240760253](https://github.com/shaikhrais/primecare-platform/actions/runs/40240760253)
passed without changing data, grants, indexes or the deployed application.
