# Shared authentication presentation

The eight product apps render the same PrimeAuthExperience inside their own auth routes. Login remains connected to the central LoginController/AuthNotifier; the presentation does not select roles, grant access, or forward tokens.

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
- `apps/primecare_auth` has been removed. Shared design/language tests live in
  `packages/primecare_ui/test`; products never depend on a separate auth website.
  Production builds no longer supply `SSO_PORTAL_URL`.
- Existing shared-package change triggers rebuild product apps independently.
  A failed product build cannot be repaired by deploying the auth preview.
- The enterprise blueprint remains a demo, not a product auth implementation.

Earlier September 28 audit (before PR #19): seven live origins still served the
older portal because their Flutter analysis gates failed. PR #19 repaired those
build blockers and deployed embedded auth to all eight product origins.

## Standalone application removal

The user approved removal of apps/primecare_auth and its website. Its 85 auth
design/language tests now live in packages/primecare_ui/test and use clinic
translations. CI analyzes, route-tests and builds all eight product apps.
Deployment matrices and legacy scripts no longer deploy a standalone auth app.
The auth backend remains deployed; shared screens and auth_route_registry remain.
The governance migration retires only the standalone app identity.

Generated Riverpod providers use the Riverpod 3 compatibility import. Client
integration fixtures follow their moved sources and current synchronous Notifier
contract. Governance database imports point to the actual connection directory.
The unimplemented remote D1 client fails explicitly rather than referencing a
nonexistent executor or embedding server credentials in a browser. Governance
database-backed features remain unavailable until a server transport exists.

PR #19 verification run 36500399735 passed shared design/language tests (85),
core auth tests (266), clinic tests (3), all eight product analysis/route-test/web
build jobs, and PostgreSQL login/logout runtime smoke. All eight production web
deployments succeeded. Live verification subsequently found a Governance deep-link
issue; PR #21 adds route exception handling and eight guest navigation regressions.
The remaining /dashboard problem was a legacy web/dashboard.html report served
before the SPA. PR #23 removes that public asset and strengthens tests with the
production registry and platform initial deep links. Its Governance CI job passes
all 11 tests and the release web build (run 36504503811, job 109202758467).

Removal does not implement recovery, MFA or consent APIs and does not establish
a successful production real-account login or signed-in business workflows.


## Website retirement — September 29, 2026 UTC

Manual workflow 36504613528 completed successfully at 00:51 UTC. It removed
146 historical deployments and the primecare-auth Pages project, then verified
the project API returned 404. The old /login URL no longer serves the auth UI.
The script is constrained to the exact primecare-auth Pages project and does not
address auth API Workers or product projects. Three scoped Node tests run before
retirement. PRs #22 and #24 handle the Cloudflare deployment-history limit and
pagination.

## Final live verification

Governance deployment 36504804525 (58b6a779e4a78d775a07c36c59a325821b7d5207)
succeeded. The eight production apps passed 96 guest auth-route checks, 16
French/Spanish reload-persistence checks, and 24 local navigation-link checks.
All eight login pages also rendered after deletion of the old auth website.
Detailed results are in `docs/verification/EMBEDDED_AUTH_2026-09-29.json`.

Cache caveat: the previously visited exact Governance /dashboard test URL still
served a stale response in the existing browser session. The current production
URL with a release query and the immutable deployment both reached local login.
Existing tabs should be hard-refreshed. This is not a claim that every cached
client has already refreshed.

Scope remains web auth presentation and guest routing. Real production credential
sign-in, signed-in business workflows, recovery delivery/token redemption, MFA
verification and consent persistence are not certified by these checks. The
GitHub AI review for PR #21 failed because its requested model was unsupported;
it was not a reported code finding. The relevant analysis, tests and builds passed.
