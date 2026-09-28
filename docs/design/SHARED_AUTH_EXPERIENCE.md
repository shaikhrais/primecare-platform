# Shared authentication presentation

The nine production apps render the same PrimeAuthExperience inside their own auth routes. Login remains connected to the central LoginController/AuthNotifier; the presentation does not select roles, grant access, or forward tokens.

The desktop layout pairs a navy brand panel with a restrained form card. Mobile uses a compact brand mark, a single scrolling column and wrapping navigation. Inputs support password-manager autofill, keyboard actions, visible focus and explicit password visibility. Login errors use a live semantic region. There are no invented certification or uptime claims.

Routes: /login, /signup, /forgot-password, /reset-password, /mfa, /language, /auth/error, plus authenticated /consent and /success. Navigation remains local and preserves validated return paths. Account registration remains administrator-provisioned. Recovery delivery, reset redemption, MFA challenges and consent persistence remain unavailable and are labelled as such; these pages collect no unusable credentials or codes.

Design components, English copy and dimensions are registered by scripts/apply-auth-design.py from design/auth-experience.json. The migration writes governance.db before generating presentation assets. French/Spanish use existing app fallback behavior; this change does not claim a reviewed translation set.

Automated design checks cover mobile/desktop layout, password visibility and local recovery navigation. Final CI and live visual verification must be recorded before marking the release verified.
