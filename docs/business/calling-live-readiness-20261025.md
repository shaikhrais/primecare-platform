# Internal browser calling — live verification, 25 October 2026

Internal audio calling is deployed for active users with existing communication
access, within the same tenant. It uses WebRTC and Cloudflare TURN. Twilio is not
required for this internal calling path.

The live production test passed in both call directions, including a call back.
The latest answer-to-audio connection took **11,043 ms**, improved from 21,059 ms
in the preceding indexed-query test. The measurement starts at the Answer click
and ends when both peers report connected relay audio. Calling works, but the
one-second setup target remains unmet.

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

## Verification evidence

- Deployed source: `be2e6fbec97dce110d3b053dc713ac64139f363a`.
- [Production workflow 40238845542](https://github.com/shaikhrais/primecare-platform/actions/runs/40238845542): all 17 jobs passed, including metadata, native checks, deployment, nine website publications and live acceptance.
- Native suite: 59 cases passed, one existing optional case skipped; 12 PostgreSQL HTTP groups passed, plus real Workerd request/redirect checks, native/tagged policy projection tests and the combined-query PostgreSQL flow with current revocation, participant, tenant, policy and duplicate-endpoint denials.
- Chrome 155.0.8059.39: actual native login, explicit extension publication, no pre-acceptance microphone, increasing audio RTP packets and selected relay candidates on both peers.
- Both call directions, call back, mute/unmute, hangup, idempotent dial, foreign-tenant denial, independent PostgreSQL readback and server-side session revocation cleanup passed.
- All synthetic users, sessions, extensions and owned call/tenant records were removed. Receipts contain no bearer credentials, raw audio, SDP or IP addresses.

[Current combined-query performance and live receipt](../../reports/communications/internal-calling-context-performance-20261025.json)
records the source and job identities. This is functional execution evidence;
independent governance review flags were not marked approved.

## Known limits

Initial setup remains slow (11.0 seconds after answering in the latest live test). One-second
calling is not verified. The proof used synthetic microphone audio in real
authenticated browser sessions against live infrastructure. Physical device
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
