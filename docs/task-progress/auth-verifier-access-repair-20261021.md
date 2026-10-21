# Auth deployment verifier access repair — 2026-10-21

The 403/1010 source-verification blocker is repaired at `e40ee7d71f51d94b42c8606685e5af918ffa9493`. This is a CI HTTP-client repair; no Cloudflare security setting, role, permission or auth policy was changed.

Read-only diagnosis run [39531040882](https://github.com/shaikhrais/primecare-platform/actions/runs/39531040882) confirmed the production Pages build was successful, but Python's default public probe returned Cloudflare HTTP403/error1010. The existing scoped token could read Pages and Access metadata; no matching Access application was reported. This distinguishes the actual edge rejection from the previously observed local proxy response.

The same probe, identifying itself truthfully as PrimeCareDeploymentVerifier, returned HTTP200 and the exact expected Flutter source stamp in run [39531207228](https://github.com/shaikhrais/primecare-platform/actions/runs/39531207228). It does not impersonate Chrome/Firefox or solve a challenge. No firewall/BIC setting was disabled.

The shared public-asset reader is used by deployment and owned-inbox verification. It rejects redirects and non200 responses. Source stamp equality and main.dart.js SHA256 checks remain required; 401/403 do not receive propagation retries. Three local/CI HTTP integration cases passed: truthful identity, denied access and redirect rejection.

All nine website deployment workflows at this source passed. Clinic run [39531391397](https://github.com/shaikhrais/primecare-platform/actions/runs/39531391397), job118997856931, printed the successful source-bound Flutter verification.

The dedicated owned-inbox recovery run [39531391322](https://github.com/shaikhrais/primecare-platform/actions/runs/39531391322) is still in progress at this checkpoint. Do not count it passed. Three earlier fixes have all11 Auth Gateway jobs and402 focused tests passed at ee89c5cf. Policy decisions, physical-device/manual-accessibility checks and independent reviews remain outstanding; full auth sign-off is false.

Research before repair:
- https://developers.cloudflare.com/support/troubleshooting/http-status-codes/cloudflare-1xxx-errors/error-1010/
- https://developers.cloudflare.com/waf/tools/browser-integrity-check/
- https://docs.python.org/3/library/urllib.request.html
- https://developers.cloudflare.com/api/resources/pages/subresources/projects/methods/get/
- https://developers.cloudflare.com/api/resources/zero_trust/subresources/access/subresources/applications/methods/list/
