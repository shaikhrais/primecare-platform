# Shared authentication in every application

The user approved a shared, embedded authentication module on 2026-09-28. Clinic, corporate, business development, franchise, marketing, client, support, governance and the auth preview reuse authentication screens from primecare_ui and the central AuthNotifier/ApiClient. Each application owns its URL and API configuration. The enterprise_blueprint counter demo has no governed application or auth workflow yet.

Shared entry routes: /login, /signup, /forgot-password, /reset-password, /mfa, /language, /auth/error. /consent and /success require an authenticated session. Legacy /sso-redirect stays local. No app sends login users or session tokens to an external authentication website. Guest routing does not register protected modules.

Sign-up currently explains administrator provisioning; this change does not enable anonymous account creation or role selection. Recovery delivery, reset redemption, MFA challenge verification and consent persistence are not implemented. Reset and MFA fail closed and cannot report simulated success. Consent no longer forwards a token to a supplied redirect URL. These features must not be reported as production-ready.

Existing auth screen contracts and routes are reused. scripts/apply-shared-auth-routes.py records the shared route inventory and honest flow status in governance.db; the existing governance workflow applies it on merge. No new permission grants or API endpoints are introduced.

PR #15 merged as 1dd65d332f14e5ad79c34331410e8bcb15f6a482. Auth Gateway Verification run 36490077115 passed: 263 core auth tests, three clinic tests, and two route tests in each of seven other product apps (280 Flutter tests total), plus Dart service checks and PostgreSQL login/logout. It verifies shared route composition and fail-closed recovery/MFA behavior. Full signed-in browser journeys and final web deployments remain pending.

Release limitation: the last corporate web deployment (36483101617) failed with 891 errors and 311 warnings before this refactor. Some router warnings are removed by this change; broader app build readiness is not claimed. Source merge and passing auth tests do not establish live deployment or full clinical-feature readiness.
