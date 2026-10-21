# Auth live repair: verified recovery flow — 2026-10-21

**Result:** The deployed Flutter password-recovery journey passed in English at320px, French at768px and Spanish at1440px. These are Chromium browser viewports, not physical-device/native-platform certification.

Runtime source: `3529100a21be93043026a085ab6581063667ffce`  
Flutter bundle SHA256: `5bdd683b8a20c04db378d54a23f907d269224f439fecf5680c3ed89a4ad4e19d`

## Repairs

- Deployment verification identified itself truthfully as PrimeCareDeploymentVerifier, resolving the default Python client's Cloudflare403/1010 rejection. No browser identity was impersonated and no Cloudflare protection was disabled. Exact source-stamp and JavaScript-hash checks remain required; redirects and authorization failures are not accepted as successful assets.
- The gateway now acknowledges credentialed browser requests within its existing allowed-origin branch. The missing Access-Control-Allow-Credentials response had blocked Flutter login at preflight. Foreign-origin denial remains tested.
- Public recovery navigation survives session restoration and logout. The current URI and root navigator identity are retained only for existing public auth pages. Protected views retain their previous rebuild behavior, and role-specific route registration/authorization is unchanged.
- Confirmed reset clears controllers, releases focus and replaces recovery field/semantics subtrees. This fixes the real browser defect where a12-character code remained in a disabled semantics input after the controller was cleared. Failed acknowledgements retain drafts.
- Shared auth redirects carry explicitly requested enable-semantics=true while preserving destination query values and fragments.

The test producer explicitly selects each language through the UI, waits for Flutter focus activation before entering text, tolerates duplicate live-announcement text when asserting the visible localized message, correlates receipt before presentation assertions, and waits for the actual DOM values to clear. It does not substitute successful API responses.

## Verified evidence

| Check | Result |
|---|---|
| [Auth Gateway 39536853037](https://github.com/shaikhrais/primecare-platform/actions/runs/39536853037) | All11 jobs passed, including eight portal analyze/test/build jobs |
| Focused Flutter tests, job119015673603 |105 UI +295 core auth/transport +4 clinic routing =404 passed |
| [Gateway CORS release39533198501](https://github.com/shaikhrais/primecare-platform/actions/runs/39533198501) |14 targeted CORS scenarios, type check, production pin, deployment and live allowed/foreign-origin checks passed |
| [Auth Worker39534027842](https://github.com/shaikhrais/primecare-platform/actions/runs/39534027842) | Both UUID and text PostgreSQL suites passed |
| Native invalidation39533091128 / revocation39533091078 | Passed |
| [Deployed owned-inbox recovery 39536853161](https://github.com/shaikhrais/primecare-platform/actions/runs/39536853161) | Deployment plus all three locale jobs passed |

Live jobs: EN119018421632, FR119018421538, ES119018421542; deployment119016968930. Each locale records28 scoped checks:

1. Exact live Flutter source stamp and bundle hash before mutations.
2. Actual UI language selection and credential login.
3. Generic recovery acknowledgement with no code/token in the response.
4. Real mail received by the owned Cloudflare inbox Worker; the extracted code matches the native reset-record hash and synthetic user.
5. Actual browser reset; all three recovery-secret DOM inputs empty; local authority cleared.
6. Old session and password rejected; normal new-password browser login matches the fixture account.
7. Consumed-code replay rejected, new-session identity reread succeeds, logout revokes it.
8. Browser reload returns to login, reset codes are absent, and the live source stamp is unchanged.

The401/400 responses in the reports are expected negative checks. Each successful locale removed its exact hash-matched test message and synthetic tenant/user/session/reset/audit/counter rows. Pre-existing and earlier unmatched inbox records were preserved; no other inbox was read.

## Scope and remaining acceptance

This is a successful scoped real-email recovery proof. **Full auth sign-off remains false.** It does not certify every role, every failure alternative, controlled account creation, bootstrap, role switching, PWA installation or physical platforms. Bootstrap operator/environment decisions, role-switching rules, other acceptance coverage and independent review evidence remain required.

Unpaced Flutter semantics focus/input loss is still a known upstream/manual-acceptance limitation. Waiting for focus activation makes the producer enter values reliably; this is not a claim that instant autofill/paste behavior was fixed in the engine.

Historical failed attempts remain documented in [the checkpoint](auth-live-repair-checkpoint-20261021.md). They are not counted as passes. The CORS source-binding amendment proves byte identity outside the exact changed CORS response block, preserves four unsupported workflows as blocked, and does not invent independent review sign-off.

Main is the only branch; there are zero open PRs. This final evidence publication changes documentation only; runtime source remains the tested commit above.
