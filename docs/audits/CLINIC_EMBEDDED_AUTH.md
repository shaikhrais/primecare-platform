# Clinic authentication ownership

Clinic owns its /login route and renders the existing shared LoginView from primecare_ui. AuthNotifier and ApiClient continue to call the central auth API for credentials, session restoration and logout. Server authorization remains authoritative; route guards and governed role modules continue to restrict presentation.

No external auth website is required by clinic login. The legacy /sso-redirect route resolves to local /login. Unknown guest routes render the shared login form through the clinic-specific router fallback instead of launching an external portal. All production applications now use the same local auth module; see SHARED_APP_AUTH.md.

Return destinations must be local paths and cannot point back to auth routes. Query parameters are already decoded by GoRouter and must not be decoded again. Role validation runs before a return destination is accepted.

Existing governance contracts: clinic_login, auth.login, /login, /sso-redirect and the existing login/me/logout APIs. No new screen, API, role or permission is introduced.

Validation: Auth Gateway Verification run 36490077115 passed clinic analysis, 263 core auth tests, three clinic tests and two routing tests in each of seven other product apps. Production deployment and a signed-in clinic journey must still be verified before marking this flow complete. Account recovery and permanent CEO provisioning remain separate open items.
