# Native login error localization

## Bounded change

The shared LoginView continues to use the real LoginController and AuthNotifier.
The empty-credentials branch displays the existing nested app resource
`auth.enter_credentials_to_continue`. A false result from AuthNotifier displays
`auth.authentication_failed`. BuildContext resolves these resources when the
Notice renders, including after a language switch while the error is visible.
The live semantic region and all existing form controls remain in place.

The public LoginState constructor, copyWith parameters and literal errorMessage
values remain compatible. Only the controller's private error creation attaches
a typed display reason. Clear or explicit replacement of errorMessage removes
that reason. A literal string, including a resource-looking string supplied by a
caller, is not inferred to be a localization key.

This is existing bundled resource reuse, not new translation content or proof
of approved production database rows. No catalog, resource registration, API,
permission, session, route or failure-classification contract changes.
AuthNotifier still returns false for HTTP rejection and guarded transport
exceptions. The separate LoginController catch text, forgot-password text and
simulation text remain outside this two-message localization scope.

## Reachable resources

Pinned source review at `cb0ceb4f3e55fe8e58fe1c67b2fa651447d2ff18` found both
nested keys in EN/FR/ES for clinic, governance, business development, marketing,
corporate, client, support and franchise. Those apps use the existing
PrimeCareAppRunner localization setup and app translation assets. The regression
loads each of those actual asset sets with the existing TestTranslations loader.

The enterprise blueprint's only Dart application source is its counter-demo
main.dart; it does not route to shared login. It still uses PrimeCareAppRunner,
and both keys also exist in all three blueprint locales. The governance Worker
root is not a Flutter app. No broader product-auth implementation is claimed.

## Validation status and GitHub plan

All cases in `auth_login_localization_test.dart` are newly authored and unrun at
preparation time. No local tests, helper execution, syntax checks, analyzer,
generator or build were run. GitHub Actions is the only validation environment.

The existing Native auth Material surface job adds strict analysis of
login_controller.dart and the new test. Its positive suite adds the focused
test after the existing source restoration check. The 12-fixture Material oracle,
pinned historical Material source, negative proof, capture limits, timeouts,
cleanup and restoration are unchanged. There is no new localization baseline
replay or failure oracle.

The new tests mount the actual governed LoginView with real LoginController and
AuthNotifier, isolated ApiClient and preference storage. Coverage includes:
- All eight product assets in EN/FR/ES: missing/blank credentials without API
  traffic, rejected HTTP and real transport exceptions through the bool result,
  live-region text, credential trimming, retries and password clearing.
- Clinic and governance visible errors switching EN/FR/ES without resubmission.
- Pending duplicate prevention, failure-to-success retry, and late successful
  response after logout remaining unauthenticated with issued-token revocation.
- MFA cancellation retaining the existing false-result path.
- Public state construction/copy compatibility and metadata invalidation.
- Existing literal simulation and catch behavior. The catch test deliberately
  uses a throwing notifier and is not evidence of real transport classification.

Existing shared MFA/design/recovery/maintenance tests remain in the same job.
Existing auth-routing and transport workflows remain unchanged. Passing these
focused tests alone would not certify production rollout or release readiness.

## Historical provenance boundary

The unchanged promoted manifest
`tools/auth-verification/auth-lifecycle-candidate.json` records older source:
- auth_experience.dart expected SHA256
  `3c2b4e9812ad3bd70508bb17e1ded9390c495705a96ea114c675a5fad8415269`.
  Before this change, cb0ceb4f already has
  `ff0cb8426f31acdb021cf8ce0937f11a53ec74ad0b19d5c637e8d25aae9dad35`.
- login_controller.dart expected SHA256
  `81a6cc01ad41dd5980f4d13ea8c15467897c46fe38c6f5104a885fc49e9e84d0`,
  which matches cb0ceb4f. This localization change introduces a new mismatch
  for that controller. It does not silently refresh the historical approval.

The historical verifier checks these hashes in both foundation and Flutter
jobs when invoked. It is triggered by manual dispatch or main pushes changing
its own workflow, manifest or candidate patch, not by this PR's source changes
alone. It also contains release work and is not dispatched by this change.
A future invocation against changed source would still reject unmatched pins.
The theme/auth release provenance document explicitly distinguishes its
historical accepted release from later candidate source and records existing
promoted-manifest drift; it is not new-head acceptance.

This is a bounded comparison of the two changed runtime paths, not a fresh
whole-manifest audit. No protected evidence, hash pins or gates are changed.
Independent review must assess this documented source-provenance boundary
before publication. The historical lifecycle proof is not claimed for this head.
