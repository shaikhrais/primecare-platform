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

The current static scan records 477 construction sites in 18 source files,
including 426 `PrimeCareScreen` declarations and router containers so changes
to their error builders are flagged. The following review concerns the six
primary router and navigator source locations only; module metadata, nested builders,
indirect registrations and runtime behavior can still escape a textual scan.

| Route source | Current managed entry point | Verification still needed |
| --- | --- | --- |
| `packages/flutter_core/lib/routes/governance_router.dart` | Module, workspace, callback and fallback/error views use a boundary, including caller-provided guest errors. | Exercise redirects, roles, permission failures and parameterized routes. |
| `packages/primecare_ui/lib/src/features/auth/shared_auth_router.dart` | Shared public/protected pages and additional public-route adapters use the catalog. | Exercise real authentication, recovery and role transitions. |
| `apps/primecare_governance/lib/core/governance/route_registry.dart` | Governance shell wraps native and registry-driven route children. | Verify each native workflow, authorization and accessibility. |
| `apps/primecare_clinic/lib/core/routing/app_router.dart` | Additional settings route uses `ManagedPublicRoute`. | Verify settings access and behavior for allowed and denied roles. |
| `packages/primecare_ui/lib/src/features/training/admin_training_launcher.dart` | Both navigator pages use standalone adapters. | Verify session changes, training interactions and localization. |
| `packages/primecare_ui/lib/src/routes/shared_routes.dart` | Screenshot inventory uses a standalone adapter. | Confirm its eventual owning router applies the correct authorization. |

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
registrations from independent workspace and module-route catalogs. A route
missing from all relevant registrations fails closed. Workspace metadata is
not itself a Screen Manager registration. Standalone
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

`scripts/check_module_screen_registrations.py` compares statically declared
application `PrimeCareScreen` routes with the independent module catalog. It
reports the file, line and screen builder class when one can be identified;
unresolvable route expressions fail for manual review. It is a textual scan,
not a Dart parser: indirect constructors, dynamic dispatch, builder aliases,
authorization and actual screen behavior require separate checks. The current
422 declaration sites pass this check; this is not a count of verified screens.

| Location | Class or generator | Reason and next action |
| --- | --- | --- |
| `apps/primecare_governance/lib/core/governance/route_registry.dart` | `appRouterProvider`, `buildGovernanceScreenManager` | The shell has a registration adapter. Dynamic metadata no longer registers itself; its paths must be in the independent catalog. Verify native and dynamic workflows, access behavior and accessibility before release. |
| `apps/primecare_governance/lib/core/governance/route_registry.dart` | `appRouterProvider` redirect | The existing redirect requires authentication but does not itself enforce a per-route role or permission decision after login. Review the authoritative policy for native and dynamic governance routes, enforce it at the correct existing layer, and test unauthorized roles; presentation registration must not be treated as authorization. Server/API checks still require separate verification. |
| `apps/primecare_client/lib/core/routing/client_routes.dart` | `ClientPatientModule`, `ClientFamilyModule` | Their 13 directly declared screen classes use governed bases, but `SharedAuthRouter` currently dispatches those module paths to `GovernedWorkspaceScreen`. Confirm intended workflows before changing dispatch or claiming those specific screen classes render. |
| `apps/primecare_client/lib/features/patient/screens/patient_dashboard_screen.dart` | `PatientDashboardScreen` | The scaffold now displays an unavailable state with EN/FR/ES fallbacks instead of claiming completion. Verify the Flutter test and implement actual dashboard requirements before connecting this class. |
| `apps/primecare_client/lib/features/patient/screens/patient_book_appointment_screen.dart` | `PatientBookAppointmentScreenController` | The scaffold initializes optimistic status text and `runComplianceScan` logs a timed action without an audit service. Review the real appointment and audit contracts, remove misleading status and test the workflow before connecting this class. |
| `packages/flutter_core/lib/routes/governance_router.dart` | `GovernanceRouter` | Module and dynamic platform registry paths now use the separate `module_screen_registrations.dart` snapshot instead of being registered automatically at runtime. The snapshot was derived from route declarations, not individual screen verification; review each route and test role redirects, callback and errors before release. |
| `packages/primecare_ui/lib/src/features/auth/shared_auth_router.dart` | `SharedAuthRouter`, `SharedAuthRoutes` | Additional public routes now use the managed adapter; test real login, recovery, platform and workspace workflows. Registrations do not authorize users. |
| `tools/mvc_generator/generate_screen.dart` | `_generateViewContent` | Generates a governed base view and adds a presentation registration. Its owner must still add route wiring and authorization. The generated scaffold, hardcoded text and inherited layout need workflow-specific review. The catalog supports root, literal and simple named-parameter paths; custom route patterns need separate handling. |
| `scripts/implement_screens_from_db.py` | `implement_creative_screens_from_db`, `generate_custom_screen_widget` | Supported new templates receive presentation registrations and existing files are skipped. Hardcoded labels such as `Execute Action`, route authorization and actual workflows still need review. |
| `scripts/generate_and_verify_planned_screens.py` | `generate_planned_screens` | New scaffolds receive presentation registrations, omit fabricated metrics and guessed API calls, and leave import, route, export and rendering checks pending. Preflight rejects duplicate routes, unsupported custom patterns and existing output. Existing screens and database flags need separate re-verification; template text and route authorization still need review. |
| `scripts/scaffold_30_empty_screens.py` | `main` | Disabled: its legacy template invents status and API actions without managed registration. Migrate the template and add isolated generator tests before re-enabling. |
| `tools/governance/generate_all_screen_code.py` | `main` | The legacy generator fails to parse because of an f-string brace error and does not add managed registration. Repair, migrate and test it before use. |
| `packages/primecare_ui/lib/src/screens/common/governed/governed_screen.dart` | `Governed` | Direct `ConsumerWidget` with a standalone scaffold and hardcoded labels. Confirm whether it is used by a route and migrate without changing state or behavior. |
| `packages/primecare_ui/lib/src/components/prime_components.dart` | `DashboardErrorWidget` | Heading and retry text now use locale-aware shared text; verify the remaining shared control strings and live-text catalog coverage before claiming complete localization. |
| `packages/primecare_ui/lib/src/application/base_primecare_app.dart` | `BasePrimeCareApp`, `BaseThemedPrimeCareApp` | The corporate base now provides its previous fallback tokens through an explicit scope. Verify default branding and personal-theme propagation in its real workflows. |
| `packages/primecare_ui/lib/src/components/governance_components.dart` | `GovDashboardHero`, `GovMetricCard`, and upload controls | The hero status and metric label now use shared locale-aware text; upload status and other strings still require translation and interaction tests. |
| `packages/primecare_ui/lib/src/features/training/getting_started_guide.dart` | `GettingStartedGuide` | Navigation, accessibility labels and the seven lesson texts have English, French and Spanish fallbacks. Flutter locale-switch tests need CI verification, and the shared website guide still needs localization. |

The governance workspace endpoint's generated `workspace-registry.json` maps
16 of the 23 `governanceNativeScreenRoutes` paths. The following seven have no
exact mapping there: `/admin/reality-check`, `/admin/role-screen-carousel`,
`/admin/screenshot-gallery`, `/generated/corporate/ceo/growth-pipeline`,
`/generated/corporate/ceo/region-performance`,
`/generated/corporate/ceo/leadership-reports`, and `/governance/placeholder`.
The placeholder is a fallback, not a business screen. The other six need a
reviewed source of grants or an explicit access policy before a workspace-based
authorization guard can be applied without inventing access or silently
blocking existing routes. API permission enforcement remains a separate check.
`scripts/audit_governance_screen_grants.py` can query only screen and role grant
metadata for those paths and potential aliases through the pinned read-only
production governance reader. Its output contains role-grant details and must
not be published to public workflow logs or artifacts. The query has an isolated
SQLite unit test; production execution and secure results handling are not yet
verified. It does not resolve ambiguous aliases or grant access automatically.

### Client module declared-screen review

All 13 declarations below inherit `GovernedConsumerWidget`. The production shared
auth router currently builds `GovernedWorkspaceScreen` for their module paths,
so these are static inheritance and dispatch findings, not verified workflows.
For each entry, the next action is to establish the intended dispatch, inspect
the actual data/actions and authorization, and run the corresponding workflow
before connecting the class. Do not simply swap the builder.

| File | Class | Status |
| --- | --- | --- |
| `apps/primecare_client/lib/features/patient/screens/patient_dashboard_screen.dart` | `PatientDashboardScreen` | Governed; localized unavailable state added. Verify it and implement data and actions before dispatch. |
| `apps/primecare_client/lib/features/patient/screens/patient_book_appointment_screen.dart` | `PatientBookAppointmentScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/patient/screens/patient_my_appointments_screen.dart` | `PatientMyAppointmentsScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/patient/screens/patient_care_team_screen.dart` | `PatientCareTeamScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/patient/screens/patient_treatment_history_screen.dart` | `PatientTreatmentHistoryScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/patient/screens/patient_payments_screen.dart` | `PatientPaymentsScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/patient/screens/patient_profile_screen.dart` | `PatientProfileScreen` | Governed; localized unavailable state added. Verify it and implement data and actions before dispatch. |
| `apps/primecare_client/lib/features/family/screens/family_dashboard_screen.dart` | `FamilyDashboardScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/family/screens/family_loved_one_schedule_screen.dart` | `FamilyLovedOneScheduleScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/family/screens/family_care_updates_screen.dart` | `FamilyCareUpdatesScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/family/screens/family_billing_screen.dart` | `FamilyBillingScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/family/screens/family_emergency_contacts_screen.dart` | `FamilyEmergencyContactsScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |
| `apps/primecare_client/lib/features/family/screens/family_profile_screen.dart` | `FamilyProfileScreen` | Governed; contains timed audit and optimistic security text. Verify service, labels and actions before dispatch. |


On this draft the existing `scripts/audit-ui-localization.py` reported 38,653
literal candidates in 11,054 files. It is a textual review aid, not a verified
count of untranslated screens; dynamic strings and false positives need manual
inspection.

Generator preflight checks reduce accidental overwrites but file and database
writes are not one atomic transaction. Run generation against an isolated
fixture first and review all generated code, registrations and database changes
before using it with authoritative data.

The two Python generators reserve source, extracted-state and route-catalog
destinations before writing a batch. Distinct routes or screen codes that map
to the same file fail preflight, including path aliases and source/state
collisions. File targets cannot also serve as directories for another output,
and existing parent paths must be directories. State and catalog paths outside
the project are rejected. Isolated
regression tests verify that rejected batches preserve database bytes, exports
and source files; this is file-generation safety, not workflow verification or
permission to use historical fixtures as live governance authority.

## Reviewed subset and remaining work

[Reviewed candidate inventory](reviewed-candidates/README.md) records 438 exact
file/class/base identities, source evidence, classification reasons and next
review actions. Another 958 of the 1,396 scanner candidates remain unclassified.
Run `python3 scripts/check_reviewed_screen_inventory.py` to verify the reviewed
source hashes and reproduce the counts. This is static review, not production
dispatch, behavior testing, migration approval or completion evidence.
