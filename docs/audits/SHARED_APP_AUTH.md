# Shared authentication in every application

The user approved a shared, embedded authentication module on 2026-09-28. Clinic, corporate, business development, franchise, marketing, client, support, governance and the auth preview reuse authentication screens from primecare_ui and the central AuthNotifier/ApiClient. Each application owns its URL and API configuration. The enterprise_blueprint counter demo has no governed application or auth workflow yet.

Shared entry routes: /login, /signup, /forgot-password, /reset-password, /mfa, /language. /consent and /success require an authenticated session. Legacy /sso-redirect stays local. No app sends login users or session tokens to an external authentication website. Guest routing does not register protected modules.

Sign-up currently explains administrator provisioning; this change does not enable anonymous account creation or role selection. Recovery delivery, reset redemption, MFA challenge verification and consent persistence are not implemented. Reset and MFA fail closed and cannot report simulated success. Consent no longer forwards a token to a supplied redirect URL. These features must not be reported as production-ready.

Existing auth screen contracts and routes are reused. scripts/apply-shared-auth-routes.py records the shared route inventory and honest flow status in governance.db; the existing governance workflow applies it on merge. No new permission grants or API endpoints are introduced.

CI checks each production app's actual route composition and checks that recovery/MFA cannot claim simulated success. Full signed-in browser journeys and final web deployments remain pending.
