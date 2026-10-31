# Fuse web and Flutter native compatibility

## Approved boundary

The user approved the actual Fuse React v17 skeleton preview and directed that licensed Fuse stay separate from the public `shaikhrais/primecare-platform` repository. The original purchased ZIP remains unchanged. No vendor source, purchase code, bundled environment file or vendor demo authentication is to be published in that public repository. Distributing the finished application is distinct from freely redistributing the template source. The provided certificate is a Regular License; the license applicable to paid tenant access needs vendor confirmation before that commercial release.

## What is shared

| Concern | Web | Native | Authority |
|---|---|---|---|
| UI renderer | Licensed Fuse React skeleton / Material UI | Existing Flutter/Dart PrimeCare widgets | Separate platform adapters |
| Identity and permissions | Existing PrimeCare session and API policy | Existing PrimeCare native transport/session | Existing server contracts; no vendor demo identity |
| Workflows and data | Existing tenant-scoped APIs | Same API/domain contracts through Dart clients | PostgreSQL and pinned governance |
| Theme profile | `PersonalTheme`, validated by `theme_center.ts` | `PersonalTheme.fromJson` | Existing version-1 JSON shape |
| Colors and sizing | `toFuseAppearance` maps main/navbar/toolbar/footer | Existing generated palettes and native theme adapters | Existing preset catalogue and validated overrides |
| Theme library | Existing Theme Center profile operations | Existing native profile operations | Current appearance storage; cross-device database sync is not claimed |
| Layout | Fuse responsive layouts, browser navigation and focus | Flutter responsive shell, native navigation and semantics | Common intent and role metadata; platform-specific widgets |

The React components do not become native Flutter widgets. Flutter web embedding is possible, but it adds lifecycle, focus, sizing and communication concerns. Native widgets remain the intended native interface; a WebView wrapper is not evidence of a native UI conversion.

## Implemented bridge and evidence

`packages/domain/src/fuse_theme_adapter.ts` is PrimeCare-owned integration code, not copied Fuse source. It accepts only the existing validated theme profile, returns the four Fuse theme region configurations, maps typography/radius and ensures readable foregrounds. It does not contain business permissions, endpoints or credentials. The same profile remains suitable for the existing Dart parser.

`node --test scripts/test-fuse-theme-adapter.mjs` verifies every current preset, four-region mapping, custom colors and sizing, immutable input, unsupported field/value rejection and parity of the generated Dart preset/field names. These are adapter/contract checks, not native Flutter rendering or whole-platform workflow proof.

## Issues and release gates

1. **Existing application is not React everywhere.** The current website controllers render HTML. They must be adapted into the common Fuse shell or replaced with registered React presentation adapters while retaining API commands, idempotency, permissions, errors and audit. The approved preview still uses fictional in-memory content.
2. **Native styling is not fully inherited yet.** `PrimeCareColors`, `AppTheme` and some native widget defaults still contain legacy values. Existing personal-theme adapters override many values, but complete pixel/semantic parity has not been established. Do not rename those defaults “fully centralized” without a separate native audit.
3. **Platform functionality needs explicit mapping.** Browser fullscreen, DOM search, browser history and keyboard shortcuts need native equivalents or honest platform-specific availability. Calendar, charts, editor, files, notifications, calls and deep links need their existing registered native workflows verified; vendor demos do not implement PrimeCare operations.
4. **Theme persistence is currently scoped.** Existing browser theme preferences are local/account-role scoped. Sharing the profile format does not automatically synchronize settings between a phone and web browser.
5. **Native SDK unavailable in this workspace.** Flutter/Dart executables were not found. The initial bridge checks did not run native analyze/widget/device builds; the shared-library update adds separate SDK-equipped native CI tests. Device builds and visual parity remain unverified. Use the existing SDK-equipped CI and device validation before release.
6. **Bundle size.** The first isolated vendor-skeleton preview build reports a large-chunk warning (about 2.9 MB uncompressed main JS). Measure startup and split unnecessary provider/editor/demo dependencies before rollout; do not ship the full vendor demo.
7. **Private source/release access.** Licensed source is separate locally. A protected private GitHub source location and CI fetch/deployment arrangement remain to be configured; no separate private remote has been created by this work. Public-safe adapter tests can run independently. Never commit licensed vendor source into public main to bypass this dependency.
8. **Registry and acceptance.** Preserve registered components, routes, languages, test IDs and implementation tags. Validate login, action, API, database readback, reload, denied roles, tenant isolation, failure/retry and audit for each migrated surface. Preserve the approved Fuse screenshot as the visual baseline. No production release occurred in this phase.

## Rollout order

Start with Tenant Admin and Code Admin, then coordinator/PSW, growth/business plans and remaining registered surfaces. Keep the existing runtime available until each migrated route passes its acceptance gates. Shared styling is a prerequisite, not proof of complete business workflows. Maintain the separate synthetic-workspace backup/clear/restore process documented in `dashboard-system.md`; never convert fictional preview achievements into live metrics.

## Shared library migration update

The metadata inventory is now `packages/primecare_ui/catalogs/fuse-skeleton.inventory.json`, reproducible with `FUSE_SKELETON_DIR=/private/licensed/skeleton node scripts/scan-fuse-skeleton.mjs`. It scans 389 source files in the current licensed skeleton working copy, 24 core families and three layout families. Counts refer to source files and module families, not a count of proven production widgets. The private `src/primecare-ui` facade exposes 205 lazily loadable TSX component modules, branded common component aliases, all MUI exports, three Fuse layouts and the original Fuse settings/theme-selector controls. The existing example view now imports the shared facade. Page/auth/example sources are catalogued separately and are not automatically registered business screens.

The private `PrimeThemeCenter` uses actual `FuseSettings` and `FuseThemeSelector` controls. It intentionally avoids the vendor demo `updateUserSettings` path. Its save operation is appearance-only and browser/profile scoped; it does not claim database synchronization or modify authentication. Full settings import and native support for every web layout option are not claimed. Current preview Theme Center IDs remain candidates until registered for a production screen.

Native `PrimeFuseTheme` reuses the existing generated preset/profile contract. `BaseThemedPrimeCareApp` now defaults to that adapter; the shared themed root applies that profile even when a product supplies legacy base tokens; direct branded roots remain explicit overrides. `PrimeCareCard` inherits the selected surface instead of forcing white. Native appearance resolution is extracted to one shared resolver, preserving the existing public function export. Widget/contract checks cover palette inheritance and card surface/radius. They do not prove all native pages or every component visually matches Fuse. These changes introduce no new routes, APIs, users, grants, clinical writes or business processes.

Still pending: migrate remaining web presentation pages into the private facade, integrate registered PrimeCare sessions and saved appearance transport, register candidate UI mappings against production governance, configure the separate private source remote/release pipeline, and compare native/web screenshots across roles/devices. The earlier unapproved web CSS consolidation and demo lifecycle draft remain uncommitted work; they are not silently bundled into this shared-library change.
