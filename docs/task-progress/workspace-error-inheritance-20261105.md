# Workspace error inheritance

`GovernedWorkspaceScreen` now stores an unavailable flag instead of the translated
error message. The existing `workspace.unavailable` resource is resolved while
rendering, so an already-visible failure follows the current locale and live-text
catalog without another workspace request. This changes presentation only. The
route catalog, authentication boundary, server grants and API endpoint are unchanged.

The corporate router regression cases exercise HTTP failure, a malformed success
payload and a transport exception. Each starts with a permitted fixture dashboard,
fails its refresh, verifies that old workspace content disappears, changes the
theme and cycles French, Spanish and English without refetching or replacing the
router/scaffold, then retries successfully through the visible shared button.

The test harness mounts the existing corporate router, governed shell and shared
workspace renderer. It uses fixture authentication and API responses, not the
production application entry point, live authentication or server authorization.
It does not exercise live-text notifications; those are distinct from locale
changes and remain covered only where existing live-text tests apply.

Source review also rechecked the inventory's `GovernedWorkspaceEntry` declaration
and delegation at lines 9 and 13. Its abstract-presentation-base classification
and cited lines remain correct; only this file's source hash was refreshed.
The inventory remains 438/1,396 statically classified and zero runtime-verified.

Validation commands:

```sh
python3 scripts/check_screen_inheritance.py
python3 scripts/check_module_screen_registrations.py
python3 scripts/check_route_sites.py
python3 scripts/check_reviewed_screen_inventory.py
python3 scripts/test_reviewed_screen_inventory.py
git diff --check
cd apps/primecare_corporate
flutter analyze --no-fatal-infos test/managed_workspace_navigation_test.dart
flutter test test/managed_workspace_navigation_test.dart
```

Flutter/Dart are not installed in the implementation executor. Flutter analysis
and widget tests were not run locally. The existing Shared screen inheritance
workflow runs the corporate test file on pull requests; its result must be
checked on the eventual integration commit before reporting runtime verification.
