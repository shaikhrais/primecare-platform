# PrimeCare package responsibility audit

Source baseline: 2c51d67400e212dfcd0be603b7a5947b152e1fc7. This inventory evaluates tracked source paths and representative exports, not production readiness. Package counts include source-only directories; a name or catalog entry is not proof of functionality.

| Package | Source evidence and responsibility | Verdict |
|---|---|---|
| contracts | API contract JSON, bindings/index exports | aligned |
| database | Prisma schema, SQL migrations and database utilities | aligned |
| database_client | Dart repository adapters, PlatformDatabase | aligned |
| domain | 137 TypeScript files; domain contracts, 76 registry files, theme and UI definitions | split |
| factory_system | four scattered Dart files (locale keys, responsive layout, Riverpod check); no package manifest | not a coherent package |
| flutter_core | 433 Dart files; auth, network, route/registry, communication, theme/UI, services and models | split |
| infrastructure | audit, rate limits, Prisma, telemetry, billing, Stripe, financial and user services | split business services |
| messaging | event_bus.ts and index | narrower name: event bus |
| primecare_kitchen_sink | Flutter component gallery | aligned |
| primecare_kitchen_sink_catalog | generated story metadata, labels, reference mapping | aligned |
| primecare_kitchen_sink_web | browser component gallery, package-manager preview | aligned |
| primecare_master | composition entry and generated public web gateways | aligned; must remain facade |
| primecare_models | Dart models, typed screen states, view models | aligned, review domain-specific grouping |
| primecare_package_base | package dependency catalog, composition, impact and entry status | aligned |
| primecare_pagination | JavaScript immutable page state, tests | aligned; Dart counterpart pending |
| primecare_ui | 13,052 Dart files incl 9,127 under screens and 3,731 under features; components, theme, web rendering | split component and screen ownership |
| primecare_ui_foundation | shared Material controls, text, icons, scaffold, snack bar, card, app bar | aligned |
| security | auth utilities, RBAC, ownership utilities | aligned |
| server_core | HTTP host/controller and modular route bases | aligned |
| shared | 249 tracked files, 114 communications paths plus business, care, dashboard/preferences | split |
| worker-api | only src/routes/.gitkeep; deployed Worker implementation lives in cloudflare/workers | placeholder, not an implemented API package |

## Target package families

- Keep primecare_master as the only public integration entry. Children depend on lower-level packages, never on their own master facade.
- Split UI foundations by responsibility: buttons/actions, fields/forms, icons/assets, feedback, navigation, layout/shell, dialogs/overlays, data table/pagination, charts/dashboard widgets, theme/preferences.
- Separate business-facing dashboard composition from synthetic demo fixtures, sample hosts and kitchen-sink component reference previews. Keep demo data out of production routes.
- Extract auth, API transport, communication contracts/adapters, localization, route registration, business service and reporting ownership in separate reviewed steps.
- Keep canonical exports/type identity while migrating consumers. Do not replace a package with duplicated source. Remove a legacy package only after all supported consumers and tests use its replacement.

## Dependency accuracy

The manifest graph alone omits physical source imports (including the browser gallery into primecare_ui and the master gateways into shared and primecare_ui). The reviewed source ledger and existing master gateway ledger supplement manifest-derived build-impact edges. The catalog remains source-composition metadata; it does not attest production readiness. More source relationships need review, especially those not expressed through manifests or registered gateways.
