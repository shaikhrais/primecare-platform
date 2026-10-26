# Staff-to-client telephone calling

The initial outgoing browser-to-phone release shipped from source
`6bf5689cf6adda3ae85143372d2f8dc04c436785`. Production workflow
[40312624692](https://github.com/shaikhrais/primecare-platform/actions/runs/40312624692)
passed all 15 jobs, including PostgreSQL, Worker runtime, browser controls,
production deployment, nine website publications and authenticated staff readiness.
No real telephone call was placed by automation. The first handset/audio test is
for the user to perform with a selected test recipient.

## Test a call

1. Sign in with a permitted staff account at the [clinic portal](https://primecare-clinic.pages.dev/login).
2. Open **Calls**. Refresh the page if it was open before deployment.
3. In **Call a client’s phone**, enter the full number including country code, for example `+1…`.
4. Click **Call phone**, allow microphone access, and answer on the test recipient’s phone.
5. Check audio in both directions, **Mute/Unmute**, then **End phone call**.

The configured caller ID is **+1 647 930 2223**. An existing call reservation can
be released with **End phone call** before starting another. Internal extensions
still use the separate extension controls. The number’s incoming routing was not
changed; calling that business number from a handset is not this outbound test.

## Shared implementation and authorization

`ExternalCallService` extends `ScopedServiceBase`; current endpoint authorization
inherits `PostgresRegisteredCommunicationEndpointPolicy`. The bounded provider
transport extends `BoundedBinaryAdapterBase`, and browser lifecycle resources
extend `CommunicationResourceBase`. The inherited PostgreSQL atomic store supplies
advisory locks, optimistic versions, idempotency, tenant records and audit events.
There is one current external reservation per staff member. An elapsed local
lease alone does not authorize overwriting a still-active carrier call.

Three native POST contracts are registered: prepare (16551), state (16552) and
end (16553), under `/v1/external-calls/`. Current staff session, tenant, API and
linked-screen grants are checked at the boundary and service. State watchdogs
also check current call-placing permission. Three existing staff roles received
nine additive API grants and twelve screen links; patient roles were excluded
and explicit denies preserved. No user/tenant/role/caller-ID override is accepted.

Prepare reserves the selected E.164 number and returns a short-lived,
outbound-only Voice SDK token. It does not dial. The signed connect webhook
(16554) binds the opaque reservation to the actual provider Call SID and derived
staff client identity, rechecks the original session and current grant, then
emits `<Dial><Number>` using the server-owned caller ID. A ticket cannot be
redirected to another phone or used for a second parent call. Signed terminal
callbacks (16555) cannot mutate another current reservation. Provider signatures
use the exact configured public URL and the official SDK.

The provider transport reads or cancels a fixed-account call; it cannot create
REST calls or follow redirects. Browser calls start only from the explicit form
submission. Tokens renew against the same authorized reservation during longer
calls. Closing, logout/account change and failed current-access watchdogs release
local SDK resources. A watchdog is not a guarantee of instantaneous carrier-side
revocation against a modified client; calls also have a one-hour provider limit.
No recording, AI model, appointment tool or biometric authority is enabled.

## Deployment and evidence

The dedicated owned TwiML application isolates outgoing phone calling from the
previous application/IVR. Its URL, the caller-ID ownership and encrypted Worker
bindings were checked using GitHub production credentials. No phone number was
purchased and no incoming voice or messaging routing was replaced. Existing
gateway services and its encrypted JWT binding were retained. Staff controls
are available on portals allowed by the existing communication-origin policy.

- 17 unit, gateway and deployment-plan cases passed; three metadata cases passed.
- Real PostgreSQL tests verified staff permission, patient denial, session expiry,
  cross-tenant denial, current permission revocation, provider signature/identity
  enforcement, the server caller ID and that prepare does not place a call.
- Workerd executed the real JWT/signature/TwiML code and native no-follow provider
  request construction with stubbed production policy/provider traffic.
- Real browser tests used a simulated provider SDK to exercise explicit dialing,
  opaque ticket forwarding, mute, hangup, token renewal and cleanup.
- A real production staff login verified API authorization and visible dial
  controls, with no automatic provider traffic. Its synthetic records were removed.

[Deployment receipts](../../reports/communications/external-calling-deployment-20261026.json)
record source/job IDs and test boundaries. These results do not establish live
handset audio, every browser/network combination, or 100/10,000-call capacity.
Independent governance review flags were not marked approved. The earlier
[blocked-readiness report](../../reports/communications/external-staff-call-readiness-20261026.json)
is historical and superseded for this dedicated outbound path.

The subsequent frontend-build compatibility source
`6ed38c8b6383ffd520de792e8966125c38084b2f` passed all 17 jobs in
[internal calling regression 40314553887](https://github.com/shaikhrais/primecare-platform/actions/runs/40314553887).
Live synthetic browsers verified two-way relay media, reverse calling, mute,
end, revoked-session media release and cleanup. That run measured 4,057 ms
connection and 5,566 ms audio verification; it does not prove a one-second
answer-to-audio target. The external service source above remains deployed.

For the current Code Admin/master-tenant access and mobile dial pad, see the
[staff calling guide](master-tenant-staff-calling-20261026.md) and
[UI release receipts](../../reports/communications/calling-ui-20261026.json).
The earlier source/job IDs above are retained as historical release evidence.
