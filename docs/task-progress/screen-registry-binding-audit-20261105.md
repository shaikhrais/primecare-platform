# Screen registry binding audit

The PrimeCare UI registry audit checks whether each metadata key resolves through
exactly the same alias precedence as `getWidget`. Missing bindings and explicit
`ScreenNotImplementedView`, `ScreenNotImplementedScreen`, or Flutter `Placeholder`
widgets are unhealthy. Navigation and its fallback remain unchanged.

`ScreenAuditReport.isHealthy` describes only the static widget binding. A mapped
widget can still contain generated templates, missing APIs, broken permissions,
or incomplete actions. This audit does not build widgets, contact APIs, validate
production registrations, or certify runtime behavior or production readiness.

Regression coverage: `packages/primecare_ui/test/screen_registry_audit_test.dart`
checks missing metadata bindings, registered placeholders, prefixed/unprefixed
aliases, unprefixed binding precedence over a prefixed placeholder, empty
metadata, honest mapped-result wording, and non-mutating audits.

Run with Flutter 3.41.5, matching existing repository Flutter checks:

```sh
cd packages/primecare_ui
flutter pub get
flutter analyze --no-fatal-infos lib/src/registry/screen_registry.dart test/screen_registry_audit_test.dart
flutter test test/screen_registry_audit_test.dart
```

The implementation container has no Flutter or Dart executable. Flutter analysis
and tests were not run there; source checks are not runtime verification.

The Shared screen inheritance workflow runs these checks in an independent
`registry-bindings` job on pull requests, so failures in other Flutter jobs do
not skip this regression test. The job is also included for matching main pushes.
