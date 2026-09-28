# Shared authentication presentation

The eight product apps and the optional auth preview render the same PrimeAuthExperience inside their own auth routes. Login remains connected to the central LoginController/AuthNotifier; the presentation does not select roles, grant access, or forward tokens.

The desktop layout pairs a navy brand panel with a restrained form card. Mobile uses a compact brand mark, a single scrolling column and wrapping navigation. Inputs support password-manager autofill, keyboard actions, visible focus and explicit password visibility. Login errors use a live semantic region. There are no invented certification or uptime claims.

Routes: /login, /signup, /forgot-password, /reset-password, /mfa, /language, /auth/error, plus authenticated /consent and /success. Navigation remains local and preserves validated return paths. Account registration remains administrator-provisioned. Recovery delivery, reset redemption, MFA challenges and consent persistence remain unavailable and are labelled as such; these pages collect no unusable credentials or codes.

Design components, English copy and dimensions are registered by scripts/apply-auth-design.py from design/auth-experience.json. The migration writes governance.db before generating presentation assets. French/Spanish use existing app fallback behavior; this change does not claim a reviewed translation set.

Automated design checks cover mobile/desktop layout, password visibility and local recovery navigation. Final CI and live visual verification must be recorded before marking the release verified.

## Verified release — September 28, 2026

PR #16 merged as 749895db5ca0b2fd5c5eea0286891c90dbbb07ac. Auth Gateway Verification run 36493734031 passed 309 Flutter tests: 29 responsive design/navigation checks (including 320px at 200% text), 263 core auth tests, 3 clinic checks and 14 shared app routing checks. Governance migration run 36494158877 succeeded.

Clinic deployment 36494992307 and auth preview deployment 36495076331 succeeded. Browser review confirmed the new login design on both production domains and clinic-local account access, recovery, language and error screens. The clinic account-access link remained on the clinic origin. Desktop screenshot was inspected; mobile layout was tested through Flutter widget checks. No credential sign-in or signed-in browser journey was performed.

Other app production rollout is not verified: initial deployments were cancelled or failed; support failed on pre-existing generated StateNotifier code. Recovery delivery/reset redemption, MFA and consent persistence remain unavailable. Sign-up remains administrator-provisioned. These limitations are independent of the shared presentation release.

## Language switching correction — September 28, 2026

PR #17 (5d8c5147aa60a31afffdbbc98d74f6ca6431eb81) fixes raw auth_design_* keys after switching to French or Spanish. The original redesign had English copy only; per-key fallback was disabled. Governance now generates all three language resources for the shared auth experience. Copy observes the current localization context, and LocaleRebuildWrapper alone applies the saved language, including startup synchronization. The selector no longer competes with the wrapper to set the locale.

Selection flows through languageProvider -> auth_preferred_language in SharedPreferences -> LocaleRebuildWrapper -> EasyLocalization -> locale JSON resources. Per-key English fallback is enabled. Local browser preference persistence is verified; cross-device/profile synchronization is not claimed.

Auth Gateway Verification 36496155222 passed 365 Flutter tests, including 85 layout/language checks and an actual language-selection/restart regression. Clinic deployment 36496649290 and auth deployment 36496649240 succeeded. Browser checks confirmed French and Spanish text, persistence after reload, and return to English on both origins. A French login screenshot was visually inspected. Other app source resources are updated, but their production rollout is not claimed here.

## Package ownership and deployment

Authentication is a shared capability, not a separate product application.
The eight product applications are clinic, corporate, business development,
franchise, marketing, client, support and governance.

- `packages/primecare_ui` owns auth presentation and shared route registration.
- `packages/flutter_core` owns auth/session state, API access and route guards.
- Each product app composes those packages into its own router. Its `/login`,
  signup guidance, recovery, reset, MFA and language routes remain on its origin.
- The API gateway/auth backend remains necessary for credential and session
  verification. Sharing pages does not replace the backend.
- `apps/primecare_auth` is retained only as an optional preview and test harness.
  Product apps do not depend on that application or its website. Its deployment
  is manual; the production build no longer supplies `SSO_PORTAL_URL`.
- Existing shared-package change triggers rebuild product apps independently.
  A failed product build cannot be repaired by deploying the auth preview.
- The enterprise blueprint remains a demo, not a product auth implementation.

September 28 audit: clinic and the preview render shared auth locally.
The other seven live origins still serve the older portal because their Flutter
analysis gates fail. Package reuse is implemented in source; deployment completion
and unavailable backend features must not be marked ready.
