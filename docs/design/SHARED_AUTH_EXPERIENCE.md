# Shared authentication presentation

The nine production apps render the same PrimeAuthExperience inside their own auth routes. Login remains connected to the central LoginController/AuthNotifier; the presentation does not select roles, grant access, or forward tokens.

The desktop layout pairs a navy brand panel with a restrained form card. Mobile uses a compact brand mark, a single scrolling column and wrapping navigation. Inputs support password-manager autofill, keyboard actions, visible focus and explicit password visibility. Login errors use a live semantic region. There are no invented certification or uptime claims.

Routes: /login, /signup, /forgot-password, /reset-password, /mfa, /language, /auth/error, plus authenticated /consent and /success. Navigation remains local and preserves validated return paths. Account registration remains administrator-provisioned. Recovery delivery, reset redemption, MFA challenges and consent persistence remain unavailable and are labelled as such; these pages collect no unusable credentials or codes.

Design components, English copy and dimensions are registered by scripts/apply-auth-design.py from design/auth-experience.json. The migration writes governance.db before generating presentation assets. French/Spanish use existing app fallback behavior; this change does not claim a reviewed translation set.

Automated design checks cover mobile/desktop layout, password visibility and local recovery navigation. Final CI and live visual verification must be recorded before marking the release verified.

## Verified release — September 28, 2026

PR #16 merged as 749895db5ca0b2fd5c5eea0286891c90dbbb07ac. Auth Gateway Verification run 36493734031 passed 309 Flutter tests: 29 responsive design/navigation checks (including 320px at 200% text), 263 core auth tests, 3 clinic checks and 14 shared app routing checks. Governance migration run 36494158877 succeeded.

Clinic deployment 36494992307 and auth preview deployment 36495076331 succeeded. Browser review confirmed the new login design on both production domains and clinic-local account access, recovery, language and error screens. The clinic account-access link remained on the clinic origin. Desktop screenshot was inspected; mobile layout was tested through Flutter widget checks. No credential sign-in or signed-in browser journey was performed.

Other app production rollout is not verified: initial deployments were cancelled or failed; support failed on pre-existing generated StateNotifier code. Recovery delivery/reset redemption, MFA and consent persistence remain unavailable. Sign-up remains administrator-provisioned. These limitations are independent of the shared presentation release.
