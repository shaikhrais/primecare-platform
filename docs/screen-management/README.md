# Screen inheritance candidate inventory

`direct-widget-exceptions.json` records classes named `*Screen`, `*View` or
`*Page` that directly extend common Flutter or Riverpod widget bases in app and
shared UI/core library directories. Run `python3 scripts/check_screen_inheritance.py`
to report additions and removals by file, class and base. Review the changes and
run the same command with `--update-baseline` only when the inventory change is
intentional. CI checks the inventory on pull requests and main.

These are candidates for manual review, not approved adapters or a list of
verified route screens. Some are reusable components, public authentication
pages, or deliberately standalone views. The scan is textual: it can miss
indirect inheritance, other class names, generated routes and adapters, and can
match comments. It does not check registration, manager connections, routing,
permissions, translations or runtime behaviour. A clean result does not prove
that the application is managed or safe.

The current governed bases enforce an `AppShellBoundary` and apply inherited
feature settings. `ScreenInheritanceManager` reads theme, locale and direction;
`PrimeScreenInheritanceManager` additionally reads `PrimeTheme`. Neither is a
screen registration boundary. `GovernanceRouter` filters module routes by role,
but shared workspace routes and public authentication routes also need separate
review. Do not equate registration with authorization or migrate these candidates
by changing parent classes without testing their layout and behaviour.

`screen_manager.dart` contains a first, opt-in registration boundary. It checks
for a shell, a Flutter theme ancestor, locale/direction and media query before
building, and supplies the registered feature settings. These checks establish
only that those Flutter contexts exist; they do not prove PrimeCare-specific
providers or controls are connected. Shared authentication route builders use
an explicit adapter and route registrations. The shared workspace builder uses
registrations derived from `governedWorkspaceRoutes` and the application's
module definitions. A route missing from both sources fails closed. Standalone
governance uses an adapter for its shell and registry routes. Other route entry
points remain outside this boundary.
This first batch has not yet been validated by Flutter CI. Do not treat it as
enforcement for all existing screens.

## Known work requiring manual review

| Location | Class or generator | Reason and next action |
| --- | --- | --- |
| `apps/primecare_governance/lib/core/governance/route_registry.dart` | `appRouterProvider` | The shell has a registration adapter; verify native and dynamic workflows, access behavior and accessibility before release. |
| `packages/flutter_core/lib/routes/governance_router.dart` | `GovernanceRouter` | Module routes use the app registration catalog and the callback has an adapter. Test role redirects, callback and errors, including independently supplied public routes. |
| `packages/primecare_ui/lib/src/features/auth/shared_auth_router.dart` | `SharedAuthRouter`, `SharedAuthRoutes` | Additional public routes now use the managed adapter; test real login, recovery, platform and workspace workflows. Registrations do not authorize users. |
| `tools/mvc_generator/generate_screen.dart` | `_generateViewContent` | Generates a governed base view but still needs its owner to register a route. The generated scaffold, hardcoded text and inherited layout need workflow-specific review. |
| `scripts/implement_screens_from_db.py` | `generate_custom_screen_widget` | Generates governed views with hardcoded labels, including `Execute Action`. Connect the generator to route registrations and localization, preserving governance inputs. |
| `packages/primecare_ui/lib/src/screens/common/governed/governed_screen.dart` | `Governed` | Direct `ConsumerWidget` with a standalone scaffold and hardcoded labels. Confirm whether it is used by a route and migrate without changing state or behavior. |
| `packages/primecare_ui/lib/src/components/prime_components.dart` | `DashboardErrorWidget` | Heading and retry text now use locale-aware shared text; verify the remaining shared control strings and live-text catalog coverage before claiming complete localization. |
| `packages/primecare_ui/lib/src/application/base_primecare_app.dart` | `BasePrimeCareApp`, `BaseThemedPrimeCareApp` | The corporate base intentionally lacks a `PrimeTheme` scope until a personal theme is selected. Preserve its existing default branding while migrating it before requiring this provider globally. |
