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
