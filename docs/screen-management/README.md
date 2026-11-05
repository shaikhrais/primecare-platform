# Screen inheritance candidate inventory

`direct-widget-exceptions.json` records classes named `*Screen`, `*View` or
`*Page`, and classes in `*_screen.dart`, `*_view.dart` or `*_page.dart` files,
that directly extend common Flutter or Riverpod widget bases in app and shared
UI/core library directories. Run `python3 scripts/check_screen_inheritance.py`
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

Class names are not unique. For example, the governance router imports
`apps/primecare_governance/lib/features/audit/screens/audit_log_screen.dart`,
where `AuditLogScreen` uses `GovernedConsumerWidget`; a different file,
`apps/primecare_governance/lib/features/audit/screens/audit_log/audit_log_screen.dart`,
defines a direct `StatelessWidget` with the same class name. Resolve imports and
actual route builders before classifying an inventory entry as a live route.

In the governance router, a static import-and-constructor review found 18 native
route classes using `GovernedConsumerWidget`. Four shared admin pages below use
direct widget bases and are currently reached through the governance shell's
managed adapter; their parent classes were not changed. This is not runtime
proof of each page's workflow or permissions.

| File | Class | Review still needed |
| --- | --- | --- |
| `packages/primecare_ui/lib/src/screens/admin/admin_screen_health/admin_screen_health_screen.dart` | `AdminScreenHealthScreen` | Verify health-screen actions, permission checks and responsive layout through the governance router. |
| `packages/primecare_ui/lib/src/screens/admin/admin_reality_check_screen.dart` | `AdminRealityCheckScreen` | Verify state, filter interactions, localization and authorization through the adapter. |
| `packages/primecare_ui/lib/src/screens/admin/admin_role_carousel_screen.dart` | `AdminRoleCarouselScreen` | Verify carousel state, controls, localization and authorization through the adapter. |
| `packages/primecare_ui/lib/src/screens/admin/admin_screenshot_gallery_screen.dart` | `AdminScreenshotGalleryScreen` | Verify gallery state, accessibility and authorization through the adapter. |

`route-sites.json` records textual route-constructor sites. Run
`python3 scripts/check_route_sites.py` to flag new or changed sites for review;
the output includes the file, line, constructor and a screen class when the
simple pattern can identify one. Review the actual route, its registration,
adapter and authorization before updating with `--update-baseline`. A match
may report an adapter or a dynamic builder rather than the final screen class.
It can miss indirect or generated routes and can match comments or strings; it
does not evaluate routing behavior, enforce permissions or prove that existing
sites are approved. A changed shell can also flag nested routes conservatively.

The current governed bases enforce an `AppShellBoundary` and apply inherited
feature settings. `ScreenInheritanceManager` reads theme, locale and direction;
`PrimeScreenInheritanceManager` additionally reads `PrimeTheme`. Neither is a
screen registration boundary. `GovernanceRouter` filters module routes by role,
but shared workspace routes and public authentication routes also need separate
review. Do not equate registration with authorization or migrate these candidates
by changing parent classes without testing their layout and behaviour.

`packages/flutter_core/lib/models/screen_manager.dart` contains the reusable
manager and registration boundary. The shared catalog and standalone-page
adapter live in `packages/primecare_ui/lib/src/screens/screen_manager_catalog.dart`.
The boundary checks
for a shell, a Flutter theme ancestor, locale/direction and media query before
building, and supplies the registered feature settings. These checks establish
that those Flutter contexts exist; a required PrimeTheme connection is also
checked for shared application routes. They do not prove every provider or
control is connected. Shared authentication route builders use
an explicit adapter and route registrations. The shared workspace builder uses
registrations derived from `governedWorkspaceRoutes` and the application's
module definitions. A route missing from both sources fails closed. Standalone
governance uses an adapter for its shell and registry routes. Other route entry
points remain outside this boundary.
Earlier batches passed Flutter CI; check the current PR head for the latest
results. Do not treat this as enforcement for all existing screens.

Registrations currently identify routes by path; the boundary does not
independently verify that a builder returned a particular widget class or base.
Route-site review and representative workflow tests are still required for
each adapter. Per-screen feature settings are consumed by governed bases; a
direct-widget adapter needs explicit review before applying layout overrides.

## Shared responsibilities

| Responsibility | Existing system and current connection |
| --- | --- |
| Screen configuration | `ScreenManager` and `ScreenFeatureScope` hold registration and presentation settings; they do not authorize access. |
| Layout | `AppShellBoundary` marks an approved shell or standalone adapter; `GovernanceMasterLayout` owns the governed shell. The marker alone does not validate every layout detail. |
| Theme | Flutter `Theme`, `PrimeTheme` and `themeSettingsProvider` own material and PrimeCare appearance. Managed routes require the two theme contexts; individual controls still need migration review. |
| Language | Easy Localization and Flutter `Localizations` own the active locale; existing live-screen text supports overrides. The boundary checks locale and direction, not translation completeness. |
| Navigation and access | `GoRouter`, existing redirects, `RouteGuard` and server authorization own navigation and access. Registration does not grant permission. |
| Responsive behavior | Existing `MediaQuery`, breakpoints and `ResponsiveScreenWrapper` provide sizing and scaling. The boundary checks for `MediaQuery`; it does not prove that every adapter uses the wrapper correctly. |
| Accessibility and controls | Flutter semantics and `primecare_ui` controls are the existing shared systems. No duplicate accessibility manager was introduced; screen-specific semantics, focus order and control migration need verification. |

## Known work requiring manual review

| Location | Class or generator | Reason and next action |
| --- | --- | --- |
| `apps/primecare_governance/lib/core/governance/route_registry.dart` | `appRouterProvider` | The shell has a registration adapter; verify native and dynamic workflows, access behavior and accessibility before release. |
| `packages/flutter_core/lib/routes/governance_router.dart` | `GovernanceRouter` | Module routes use the app registration catalog and the callback has an adapter. Test role redirects, callback and errors, including independently supplied public routes. |
| `packages/primecare_ui/lib/src/features/auth/shared_auth_router.dart` | `SharedAuthRouter`, `SharedAuthRoutes` | Additional public routes now use the managed adapter; test real login, recovery, platform and workspace workflows. Registrations do not authorize users. |
| `tools/mvc_generator/generate_screen.dart` | `_generateViewContent` | Generates a governed base view and adds a presentation registration. Its owner must still add route wiring and authorization. The generated scaffold, hardcoded text and inherited layout need workflow-specific review. The catalog supports root, literal and simple named-parameter paths; custom route patterns need separate handling. |
| `scripts/implement_screens_from_db.py` | `implement_creative_screens_from_db`, `generate_custom_screen_widget` | Supported new templates receive presentation registrations and existing files are skipped. Hardcoded labels such as `Execute Action`, route authorization and actual workflows still need review. |
| `scripts/generate_and_verify_planned_screens.py` | `generate_planned_screens` | New scaffolds receive presentation registrations, omit fabricated metrics and guessed API calls, and leave import, route, export and rendering checks pending. Preflight rejects duplicate routes, unsupported custom patterns and existing output. Existing screens and database flags need separate re-verification; template text and route authorization still need review. |
| `packages/primecare_ui/lib/src/screens/common/governed/governed_screen.dart` | `Governed` | Direct `ConsumerWidget` with a standalone scaffold and hardcoded labels. Confirm whether it is used by a route and migrate without changing state or behavior. |
| `packages/primecare_ui/lib/src/components/prime_components.dart` | `DashboardErrorWidget` | Heading and retry text now use locale-aware shared text; verify the remaining shared control strings and live-text catalog coverage before claiming complete localization. |
| `packages/primecare_ui/lib/src/application/base_primecare_app.dart` | `BasePrimeCareApp`, `BaseThemedPrimeCareApp` | The corporate base now provides its previous fallback tokens through an explicit scope. Verify default branding and personal-theme propagation in its real workflows. |
| `packages/primecare_ui/lib/src/components/governance_components.dart` | `GovDashboardHero`, `GovMetricCard`, and upload controls | The hero status and metric label now use shared locale-aware text; upload status and other strings still require translation and interaction tests. |
| `packages/primecare_ui/lib/src/features/training/getting_started_guide.dart` | `GettingStartedGuide` | The route is managed, but labels such as `Detailed training and self-assessment` remain hardcoded English. Move them to the shared text system and test all supported locales. |

On this draft the existing `scripts/audit-ui-localization.py` reported 38,653
literal candidates in 11,054 files. It is a textual review aid, not a verified
count of untranslated screens; dynamic strings and false positives need manual
inspection.
