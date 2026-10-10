# Production auth rollout — 2026-10-10

All nine Flutter web portals were built with the central `BasePrimecareApp` auth implementation and published to their existing Cloudflare Pages projects. Auth API and Gateway remain the previously deployed shared Workers. This rollout replaces app-specific `lib` trees with inherited shells on the release branch and sets the shared auth gateway in each web build.

Shared model/core/UI analysis and tests passed before deployment. All nine deployment jobs succeeded in run 38077403325. Initial browser verification exposed unstable native Flutter focus handling in the test driver. A shared keyboard helper now waits for editor focus, types keyboard events, verifies input length, and blurs before submission. No production form changes were required.

Run 38078610394 passed 37 live checks on each portal, 333 total check executions. This is nine executions of the same 37 checks, not 333 unique API operations. Chromium tested login/logout and recovery -> email receipt -> reset -> login/logout within the same browser. API checks covered identity, account creation, role and tenant isolation, dashboard scoping, deactivation, password change, wrong/weak/expired reset requests, reset replay rejection, password rejection, session revocation, and reset cleanup. Expiry was simulated only on the synthetic fixture reset row.

Every temporary QA tenant/account, related sessions, audit/reset rows, and fixture account rate counters was removed after every run, including the initial failed tests. Recovery messages remain privately stored in the user-requested permanent mailbox; their codes have been consumed or removed.

| Portal | Production URL | E2E |
| --- | --- | --- |
| client | https://primecare-client.pages.dev/ | 37/37 passed |
| clinic | https://primecare-clinic.pages.dev/ | 37/37 passed |
| corporate | https://primecare-corporate.pages.dev/ | 37/37 passed |
| franchise | https://primecare-franchise.pages.dev/ | 37/37 passed |
| support | https://primecare-support.pages.dev/ | 37/37 passed |
| marketing | https://primecare-marketing.pages.dev/ | 37/37 passed |
| business-development | https://primecare-business-development.pages.dev/ | 37/37 passed |
| governance | https://primecare-governance.pages.dev/ | 37/37 passed |
| enterprise-blueprint | https://primecare-enterprise-blueprint.pages.dev/ | 37/37 passed |

Deployment: https://github.com/shaikhrais/primecare-platform/actions/runs/38077403325

Successful E2E: https://github.com/shaikhrais/primecare-platform/actions/runs/38078610394

The workflows are manual after rollout to prevent incidental redeployments or production test loops. Native Windows, Android, iOS, Linux, and macOS packages were not built or device-tested in this web rollout. This verifies authentication, not completion of all business screens. Release branch: deploy/email-inbox-20261010; no main merge was performed.
