# Calling deployment work in progress — 25 October 2026

User goal: make calling ready, researching/reusing the existing structures first.
The active deployed websites are TypeScript, not the Flutter communication panel.
Their generated headers previously disabled microphones. The new code changes
only microphone=(self), preserving camera/geolocation denial.

Prepared: five exact native call contracts (directory, explicit own extension
publication, dial, scoped commands/read/inbox/heartbeat, accepted-call media),
inherited API/access/UI metadata writers, three-locale call controls within existing
communication screens, real native Worker/session/current API/screen policies,
one-person-one-call advisory locks, disconnected-call leases, and browser TURN
renewal through the existing BrowserAudioSession/BrowserAudioCall. No synthetic
policy is composed in the production Worker. No production claims yet.

The native HTTP fixture uses real sessions/PostgreSQL with stubbed relay issuance.
A new workflow runs existing writer regressions plus native call registration,
access and UI tests, native HTTP/busy/lease checks, and read-only production
inventory. There is not yet a deployment or production registration job in this
workflow. The source is an in-progress checkpoint, not calling-ready evidence.

Remaining work before completion:
- Read and fix new CI results; save exact passing source/job evidence.
- Add actual browser UI/HTTP/media integration with a local native server and test
  TURN renewal and session-loss cleanup. Keep audio capture after acceptance.
- Complete strict owned-target Cloudflare deployment plan/script, gateway exact
  route/binding preservation, TURN key provisioning/reuse and no-secret readback.
- Add protected metadata dry-run/apply/independent readback, deployment, website
  publish and live two-browser calling acceptance to the workflow.
- Independently verify live audio packets with relay selected, native call state,
  denied access, logout and cleanup. Do not claim real user/device or background/
  closed-app ringing from synthetic browser proof. The call panel explicitly says
  to keep the page open; closed-app push is outside this first web call release.

Files have been prepared locally; latest checkpoint and CI IDs will be recorded
when saved. Preserve existing public phone routing and native contact Worker.

## Production activation pipeline

Source 19cefeb6 passed the native HTTP fixture, all metadata regression groups
and read-only production readiness. Production inventory measured no extension
table, no internal-call Worker and no owned TURN key. The new additive schema
migration creates only the four-digit directory/sequence and compares the full
native shape and private ACL against a PostgreSQL fixture reference. Existing
assignments, unexpected constraints and partial schemas are preserved.

The protected workflow now registers/readbacks five contracts and existing-screen
access/UI metadata, verifies the schema, provisions only the owned TURN key,
deploys the native Worker and its exact gateway binding, and publishes TypeScript
websites with microphone permission. Existing phone routing and all known service
bindings/secrets are preserved. Live audio acceptance remains a separate required
proof; successful deployment alone does not establish calling readiness.

The next pipeline revision includes a live two-context Chromium proof against
the actual website/gateway/native PostgreSQL. Synthetic users inherit only an
existing role independently verified to have all five call permissions. Login
uses the actual password/MFA UI; microphone access must wait for acceptance.
Both peers must receive increasing audio RTP packets and select TURN relay
candidates. The proof also exercises ambiguous dial retry, foreign-tenant denial,
mute/unmute, server-side session revocation, end-call, and exact synthetic cleanup.
No credentials, audio, SDP, IP addresses or user IDs are included in its receipt.

Production registration completed in run 40213655463: APIs 16542–16546,
20 existing-screen links and 20 grants across the four existing eligible roles,
60 shared controls and en/es/fr resources. Independent readers verified all three.
Schema dry-runs rolled back: the generated schema reference was accidentally
overwritten by the migration's status report under the same filename. The
diagnostic run 40214235703 identified the artifact collision; native PostgreSQL
17.2 showed the intended table/sequence shape. The reference and status report
now use different paths, with an explicit CI assertion that the reference holds
the full native shape and sequence range. Schema comparison remains mandatory.

Run 40214533198 independently verified and committed the private four-digit
extension table and sequence, then deployed the owned calling Worker. TURN key
creation succeeded but its response failed the overly narrow fixed-length check,
so no gateway route or website activation occurred. Recovery is restricted to
that exact unused first-provisioning source, with no gateway binding and no
installed TURN secrets. It cannot replace a live or unrelated key. New key
validation uses the existing bounded provider's accepted format; only field types
and lengths enter diagnostics.

Run 40214861994 proved the live response has a matching owned name and 32-character
UID but no bearer in result.key. The provisioning boundary now also retains the
one-time envelope-level key, rejecting conflicting key fields. Tests cover both
response layouts. Only the two exact failed, unbound, secretless setup sources
qualify for unused-key recovery; any installed key or active gateway binding
continues to block that path.

Run 40215206231 exposed field names only: the actual creation envelope is
result/success/errors/messages and the result contains uid/name/secret/created/
modified. The one-time bearer is result.secret, unlike the published API schema's
result.key. The adapter now accepts that observed field and rejects conflicting
bearers. No key values have been logged or saved as artifacts. Recovery includes
only the three measured failed provisioning checkpoints, all unbound and without
installed TURN secrets.

Run 40215527904/source 34f16a65 successfully deployed the native Worker, issued real
TURN credentials, connected the exact five gateway routes, preserved all prior
service/secret bindings, and verified unauthorized/unknown-session/foreign-origin
denials. Website publication then stopped at a pre-existing shared-account
catalog assumption: session ownership was compared with all account feature API
links. The fix scopes that readback to exact session API IDs, matching its existing
component namespace ownership. Tests preserve unrelated links and still reject
missing or duplicate session links; endpoint identity/authentication/permissions
are unchanged.

The first live proof verified native login/publication/dial/answer/denial but
reported no peer creation. Its independent diagnostic run 40217140939 measured
both accepted participants receiving HTTP503 from call.media, with valid native
call reads and no microphone captured. All synthetic data was cleaned up. The
next revision binds the Worker fetch port explicitly and adds bounded health
categories to authenticated media failures, without provider bodies or secrets.
The UI now distinguishes service failure from microphone permission denial.

The Worker health narrowed the media503 to relay_request. Cloudflare's current
Request documentation explicitly states redirect:error is not implemented in
Workers and throws TypeError. The provider now uses redirect:manual and continues
to accept only HTTP201, rejecting every redirect without following it or sending
credentials onward. A real Workerd regression constructs the native Request,
parses the provider stream, and verifies one-attempt redirect rejection.
Reference: https://developers.cloudflare.com/workers/runtime-apis/request/
