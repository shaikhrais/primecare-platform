# Three small auth repairs — 2026-10-21

Base: main `96d4b093b6c3fe32d68aed98da39986c902e3ea2`.

1. Legacy AuthNotifier.register now uses the existing central created-account acknowledgement: exact 201, matching email, requested role, active status and actor tenant, with nonempty ID. A replaced actor cannot receive stale success. It preserves the existing actor session. No new grants or API contracts.
2. PrimeAuthTextField owns/disposes a text controller and synchronizes changed external values. An external credential replacement clears password visibility. Identical values do not reset typing/cursor state.
3. Password fields and recovery codes request disabled IME personalized learning. This platform hint does not guarantee third-party keyboard behavior.

Regression coverage extends existing CI-selected auth session, design and localized recovery tests. Empty 200/201 provisioning is denied; matching 201 succeeds; foreign tenant is denied; externally cleared password updates and hides; recovery secrets disable personalized learning.

Research before implementation: Flutter TextEditingController docs explain programmatic value updates; TextFormField controller docs explain initialValue initialization; TextInputConfiguration.enableIMEPersonalizedLearning controls keyboard learning. Existing ApiResponse.confirmsCreatedAccount is the registered maintenance/provisioning contract reused here.

- https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
- https://api.flutter.dev/flutter/material/TextFormField/controller.html
- https://api.flutter.dev/flutter/services/TextInputConfiguration/enableIMEPersonalizedLearning.html

Validation at publication: git diff --check passed. Flutter SDK unavailable locally; CI runtime results pending. Earlier 72c94c2a run had successful runtime-smoke and dart-services jobs; remaining jobs were superseded/cancelled after the next main commit. Do not count cancelled jobs as passed. These changes do not resolve the deployed source-probe 403/1010, missing policy decisions, independent reviews or full auth acceptance.
