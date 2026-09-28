# Clinic authentication ownership

Clinic owns its /login route and renders the existing shared LoginView from primecare_ui. AuthNotifier and ApiClient continue to call the central auth API for credentials, session restoration and logout. Server authorization remains authoritative; route guards and governed role modules continue to restrict presentation.

No external auth website is required by clinic login. The legacy /sso-redirect route resolves to local /login. Unknown guest routes render the shared login form through the clinic-specific router fallback instead of launching an external portal. Other applications retain their current router fallback.

Return destinations must be local paths and cannot point back to auth routes. Query parameters are already decoded by GoRouter and must not be decoded again. Role validation runs before a return destination is accepted.

Existing governance contracts: clinic_login, auth.login, /login, /sso-redirect and the existing login/me/logout APIs. No new screen, API, role or permission is introduced.

Validation: the Auth Gateway Verification workflow analyzes clinic routing and tests shared-login composition, local legacy routing and unsafe return destinations. Production deployment and a signed-in clinic journey must still be verified before marking this flow complete. Account recovery and permanent CEO provisioning remain separate open items.
