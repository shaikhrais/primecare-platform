# PrimeCare package structure

This is the current committed package naming scheme with the new kitchen-sink packages added. Existing names and implementations are retained. Source-only entries are not automatically buildable or deployed services.

## Public entry and private ownership

```mermaid
flowchart TD
  H["Developer preview hosts"] --> M["primecare_master"]
  M --> W["primecare_kitchen_sink_web"]
  M --> F["primecare_kitchen_sink"]
  W --> C["primecare_kitchen_sink_catalog"]
  F --> C
  W --> U["Existing browser UI factories"]
  F --> N["Existing Flutter factories"]
```

Hosts import the master. The master re-exports the canonical package APIs, keeping class names, methods, aliases and type identity unchanged. Private implementations keep their existing declared dependencies and never import the master back.

| Public use | Entry |
|---|---|
| JavaScript composition | `@primecare/master` |
| Generated source package graph | `@primecare/master/catalog` |
| Browser kitchen sink | `@primecare/master/kitchen-sink` |
| Browser styles and canonical theme | `@primecare/master/kitchen-sink.css`, `@primecare/master/kitchen-sink-theme.css` |
| Flutter kitchen sink | `package:primecare_master/kitchen_sink.dart` |
| Dart composition source | `package:primecare_master/primecare_master.dart` |

The new Dart master manifest is a Flutter developer profile. This does not complete migration of the existing native apps or Dart service hosts. Their full headless/server profile integration remains separate. Browser API gateways and production business routes are unchanged by these developer packages.

## Source packages

35 source directories are recorded under `packages/`, including 32 manifest-bearing packages and three source-only directories. The table describes ownership, not production acceptance.

| Package | Responsibility | Declared package dependencies |
|---|---|---|
| `contracts` | Shared API contracts | `database` |
| `database` | TypeScript database schema and utilities | — |
| `database_client` | Dart database adapter | — |
| `domain` | Business and presentation contracts | `database` |
| `factory_system` | Existing factory definitions | — |
| `flutter_core` | Canonical Flutter implementations | `primecare_assets`, `primecare_component_factory`, `primecare_data_controls`, `primecare_layout`, `primecare_models`, `primecare_navigation`, `primecare_ui_foundation`, `primecare_preferences`, `primecare_theme` |
| `infrastructure` | Infrastructure adapters | `database` |
| `messaging` | Communication adapters | `database` |
| `primecare_kitchen_sink` | Flutter showcase using existing factories | `flutter_core`, `primecare_assets`, `primecare_component_factory`, `primecare_dashboard`, `primecare_data_controls`, `primecare_kitchen_sink_catalog`, `primecare_ui_foundation` |
| `primecare_kitchen_sink_catalog` | New generated stories, labels and reference inventory | — |
| `primecare_kitchen_sink_web` | Browser showcase using existing factories | `domain`, `primecare_assets_web`, `primecare_component_factory_web`, `primecare_dashboard`, `primecare_data_controls_web`, `primecare_kitchen_sink_catalog`, `primecare_package_base`, `primecare_pagination`, `primecare_samples` |
| `primecare_master` | Sole public PrimeCare entry and compatibility gateways | `contracts`, `database`, `domain`, `infrastructure`, `messaging`, `primecare_assets`, `primecare_assets_web`, `primecare_component_factory`, `primecare_component_factory_web`, `primecare_dashboard`, `primecare_data_controls`, `primecare_data_controls_web`, `primecare_demo`, `primecare_kitchen_sink`, `primecare_kitchen_sink_catalog`, `primecare_kitchen_sink_web`, `primecare_layout`, `primecare_navigation`, `primecare_navigation_web`, `primecare_package_base`, `primecare_pagination`, `primecare_samples`, `primecare_ui`, `security`, `shared`, `primecare_preferences`, `primecare_theme` |
| `primecare_theme` | Native personal theme, presets and advanced theme model | `primecare_layout`, `primecare_navigation` |
| `primecare_preferences` | Native preference protocol, cache and transport | `primecare_layout`, `primecare_theme` |
| `primecare_models` | Canonical Dart models | — |
| `primecare_package_base` | Composition registry, dependency impact and composition status | — |
| `primecare_assets` | Canonical Flutter original asset rendering and generated asset data | — |
| `primecare_assets_web` | Web original asset facade | `primecare_ui` |
| `primecare_component_factory` | Canonical Flutter component factory, models and tests | `primecare_ui_foundation` |
| `primecare_component_factory_web` | Web component factory facade | `primecare_ui` |
| `primecare_data_controls` | Canonical Flutter table, field, rich editor and upload controls | `primecare_assets`, `primecare_component_factory`, `primecare_ui_foundation` |
| `primecare_data_controls_web` | Web data controls facade | `primecare_ui` |
| `primecare_navigation` | Canonical Flutter workspace navigation renderer and model | `primecare_assets`, `primecare_layout`, `primecare_ui_foundation` |
| `primecare_navigation_web` | Web workspace navigation facade | `primecare_ui` |
| `primecare_layout` | Native workspace layout models, controller, preferences and file adapter | — |
| `primecare_dashboard` | Dashboard presentation facade forwarding canonical widgets and layout contracts | `domain`, `flutter_core`, `primecare_ui` |
| `primecare_demo` | Source-owned synthetic demo row and chart fixtures | — |
| `primecare_samples` | Reusable component sample configurations | `primecare_demo` |
| `primecare_pagination` | Pure, immutable paging range and navigation state for Fuse-inspired controls | — |
| `primecare_ui` | Shared public UI exports and canonical browser implementations | `flutter_core`, `primecare_models`, `primecare_ui_foundation` |
| `primecare_ui_foundation` | Shared Flutter Material primitives | — |
| `security` | Security adapters | `database` |
| `server_core` | Dart service lifecycle and route foundations | `primecare_models` |
| `shared` | Shared browser/server contracts and state protocols | — |
| `worker-api` | Existing worker source package | — |

These graph edges come from manifests. Browser UI files currently belong to the `primecare_ui` source tree; private showcase imports retain that physical owner rather than copying its implementation. This is a private monorepo build, not a standalone npm publication.

## Service hosts

13 existing service host directories are recorded in the source catalog. Their presence is not proof of implemented remote APIs or a completed server migration.

| Host | Path | Hosting contract |
|---|---|---|
| `api_gateway` | `services/api_gateway` | `explicit-adapter-required` |
| `auth_api` | `services/auth_api` | `explicit-adapter-required` |
| `billing_api` | `services/billing_api` | `explicit-adapter-required` |
| `client_api` | `services/client_api` | `explicit-adapter-required` |
| `compliance_api` | `services/compliance_api` | `explicit-adapter-required` |
| `franchise_reporting_api` | `services/franchise_reporting_api` | `explicit-adapter-required` |
| `governance_api` | `services/governance_api` | `explicit-adapter-required` |
| `notes_api` | `services/notes_api` | `explicit-adapter-required` |
| `notification_api` | `services/notification_api` | `explicit-adapter-required` |
| `provider_api` | `services/provider_api` | `explicit-adapter-required` |
| `scheduling_api` | `services/scheduling_api` | `explicit-adapter-required` |
| `verification_api` | `services/verification_api` | `explicit-adapter-required` |
| `visit_api` | `services/visit_api` | `explicit-adapter-required` |

## Kitchen-sink package responsibilities

| Package | Owns | Does not duplicate |
|---|---|---|
| `primecare_kitchen_sink_catalog` | 36 story descriptors, EN/FR/ES preview labels, existing control snapshots and 72 source-audited reference entries; generated Dart/JSON views | Component implementations, roles or grants |
| `primecare_kitchen_sink_web` | Browser gallery, filters, package-impact preview and canonical examples | Component implementations, business data or grants |
| `primecare_kitchen_sink` | Flutter component gallery and theme demonstration | Canonical widgets, business routes or permissions |

The 72 reference entries retain their historical proposal dispositions and audited mapping scopes. A working component example does not close full application, backend, authority, accessibility, device or business acceptance. No Fuse vendor source is copied.

## Preview and verification

- Web build: `node tools/kitchen_sink/build.mjs`.
- Web output: `packages/primecare_kitchen_sink_web/dist/index.html` (serve the directory over HTTP).
- Flutter host: `examples/kitchen_sink_flutter`; its internal dependency is only `primecare_master`.
- Generated catalog check: `python tools/kitchen_sink/generate.py --check`.
- Master import boundary: `node tools/package_master/web_boundary.mjs`.
- CI: `.github/workflows/kitchen-sink-packages.yml` builds both previews and runs browser/widget checks. It has no deployment job or production secrets.

Local browser execution requires a host that supports Chromium's Unix socket/process sandbox. A failed launch is not a failed application assertion. Browser verification runs on the prescribed GitHub Actions host when this workspace cannot launch it.

## Package management and independent controls

Use `PackageCatalog.impact(changedIds)` for the declared reverse dependency closure in build order and `PackageMaster.status()` for local composition status. These are not deployment or runtime health evidence. The pagination package is available as `paginationState` and `movePagination` from `@primecare/master`. It accepts page, page size and an already-authorized total, clamps a stale page after the result count changes, and returns immutable view state. It does not fetch records. Existing portal controls are unchanged pending an independent integration and release review.

The browser kitchen-sink now consumes the independent demo and samples packages through its declared lower-level dependencies. External hosts consume demos and samples via the master root, or dashboard presentation via @primecare/master/dashboard. The dashboard facade forwards the original implementation; it does not migrate live business dashboard ownership yet.

The next cross-platform facade group uses existing canonical implementations: primecare_component_factory, primecare_data_controls, primecare_assets, and primecare_navigation. primecare_dashboard now also exposes its Dart implementation. External Dart and TypeScript hosts use the master scoped entries; private gallery imports its lower-level dependencies. This is an incremental facade migration, not deletion of flutter_core or primecare_ui.

The native component factory implementation and its native tests are now owned by primecare_component_factory. The former flutter_core/component_catalogue source paths contain temporary export-only compatibility files. The web facade is separate to keep the dependency graph acyclic across platform implementations. No production publish is part of this transfer.

Native original assets and data controls now own their implementations, model fixtures and tests. The original asset generator writes directly to the named owner. Old core paths remain temporary exports, and the web facades are separate to avoid mixed-language graph cycles.

Workspace model ownership is independent of core; the old renderer and scroll header remain in core until legacy production navbar registration is separated into an explicit release. Navigation uses the new named layout/model and asset packages.

Native theme model and preference protocol ownership now lives in the named packages. Legacy core paths temporarily export their canonical implementations for existing callers. Theme renderer and navbar registration paths are unchanged.
