# MFA prompt cancellation — 2026-10-21

The native Flutter verifier checked login revision and actor identity, but did not bind the callback lifetime to its presentation prompt. Prompt disposal could finish login as unsuccessful while a factor or identity request remained in flight. A late successful response could then be accepted into the verifier's abandoned closure, leaving an unused server session without revocation.

The verifier now checks that the prompt is open before issuing the factor request, after receiving a provisional token and after confirming its identity. The prompt closes in a finally block on every normal or exceptional exit. Existing exact-token cleanup revokes any provisional session arriving after closure; no credential is persisted and no authenticated state is established.

Three regressions cover a saved callback invoked after closure, closure during the factor request and closure during identity confirmation. They check request denial, exact-token revocation, no actor/token authority, empty credential storage and no extra identity request after a late factor response. Existing successful MFA, retry, identity-mismatch and logout-race tests remain required.

This repairs the existing registered MFA contract and adds no endpoint, role, permission, UI control or database data. It does not establish lost-factor recovery, independent approval or complete device acceptance.

Source: 8fc46ccb6c9679224a3f4597e1409e35db6aa684. Verification39692484597 passed 304 core/session tests, 104 UI/auth tests, four clinic routing tests, catalog reproduction, static analysis and the clinic release web build. Auth Gateway39692484587 passed all 11 jobs. Contract review39692484550 passed both jobs.

All nine portal deployments succeeded with their final live source-stamp and JavaScript hash checks: clinic39692484698, governance39692484716, enterprise-blueprint39692484640, marketing39692484712, corporate39692484634, business-development39692484708, client39692484912, franchise39692484485 and support39692484412. These source-bound deployments are separate from real-device MFA acceptance. Revocation remains best effort if the network itself is unavailable; late responses cannot establish local authority.
