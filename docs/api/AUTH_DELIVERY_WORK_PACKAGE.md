# Auth delivery work package

**14/14 reviewed; 4/14 resolved.** Four existing handlers now have accurate governance contracts and unit evidence. The remaining ten declarations are explicitly unresolved. They are not counted as working APIs.

| Declared operation | Outcome | Finding |
| --- | --- | --- |
| POST /v1/auth | Unresolved | Service status only; no authentication workflow |
| POST /v1/auth/ | Unresolved | Service status only; no authentication workflow |
| POST /v1/auth/forgot-password | Existing handler verified and governance reconciled | Public, enumeration-resistant recovery with rate limits and configured mail |
| POST /v1/auth/impersonate | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/login | Existing handler verified and governance reconciled | Credential login with active-user/password revalidation and session persistence |
| POST /v1/auth/logout | Existing handler verified and governance reconciled | Idempotent own-session logout; optional bearer/cookie |
| POST /v1/auth/onboard-business | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/osm | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/osm/callback | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/profile | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/refresh | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/reset-password | Existing handler verified and governance reconciled | Secret-code reset with user lock, revocation and confirmed audit |
| POST /v1/auth/switch-role | Unresolved | No registered auth handler; returns route-not-found without business execution |
| POST /v1/auth/whoami | Unresolved | No registered auth handler; returns route-not-found without business execution |

Unit-evidence counter: **340/1,415 unique operations** (previously 336). Remaining contract/verification work: **1,065** (previously 1,069), plus **10 registered blockers**. The eight unsupported feature routes return 404 without SQL; the two service-root entries return only status metadata and cannot be treated as authentication workflows. No new handler, role grant, production mutation or deployment was added.

Four focused positive regressions cover credential login, own-session logout, non-enumerating unknown-account recovery and secret-code reset with session revocation. Ten route regressions document unresolved behavior. Authority regressions reject late drift before the first write. Local validation: **3,597 API fixtures**, four counting regressions, authority guards, Worker typechecks and 100% governance compliance. Exact-head [CI run 37680700500](https://github.com/shaikhrais/primecare-platform/actions/runs/37680700500) passed UUID/text PostgreSQL and security on `72aada99f6a87fdcea0b968980c4b620888392d8`. [PR #135](https://github.com/shaikhrais/primecare-platform/pull/135) merged as `75d3d2882503e710ae03af49d7018395421b55ea`.
