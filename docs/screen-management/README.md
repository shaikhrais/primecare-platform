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
registrations derived from `governedWorkspaceRoutes`; any module route missing
from that catalog fails closed. Standalone governance and other routes remain
outside this boundary.
This first batch has not yet been validated by Flutter CI. Do not treat it as
enforcement for all existing screens.

## Known work requiring manual review

| Location | Class or generator | Reason and next action |
| --- | --- | --- |
| `apps/primecare_governance/lib/core/governance/route_registry.dart` | `appRouterProvider` | Independent router with native and dynamic routes. Map its route IDs and layout adapter, then verify existing access behavior before enabling the boundary. |
| `packages/flutter_core/lib/routes/governance_router.dart` | `GovernanceRouter` | Compare every active module route with the workspace catalog and test role redirects and errors. Public callback and externally supplied routes still need explicit adapters. |
| `packages/primecare_ui/lib/src/features/auth/shared_auth_router.dart` | `SharedAuthRouter`, `SharedAuthRoutes` | Test real login, recovery, platform and workspace workflows; audit `additionalPublicRoutes` and callback/error paths. Registrations do not authorize users. |
| `tools/mvc_generator/generate_screen.dart` | `_generateViewContent` | Generates a direct `ConsumerWidget` with hardcoded text. Update generation and registration together after choosing the route and layout contract. |
| `scripts/implement_screens_from_db.py` | `generate_custom_screen_widget` | Generates governed views with hardcoded labels, including `Execute Action`. Connect the generator to route registrations and localization, preserving governance inputs. |
| `packages/primecare_ui/lib/src/screens/common/governed/governed_screen.dart` | `Governed` | Direct `ConsumerWidget` with a standalone scaffold and hardcoded labels. Confirm whether it is used by a route and migrate without changing state or behavior. |
