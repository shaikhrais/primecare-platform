# PrimeCare developer catalogue and adoption inventory

This is a reproducible source catalogue, not a claim of production activation or complete reference parity. Each of the 72 proposal features has an owner package, source paths and declared symbols, a usage recipe where available, and an explicit missing/blocked disposition. Human disposition review and app migration remain open.

| Feature | Batch | Owner | Disposition | Usage |
|---|---|---|---|---|
| FuseAuthProvider (`core.FuseAuthProvider`) | B16 | `packages/primecare_ui` | blocked | [Recipe](dashboard-pages-usage.md) |
| FuseAuthorization (`core.FuseAuthorization`) | B04 | `packages/primecare_ui` | blocked | [Recipe](workspace-navigation-usage.md) |
| FuseCountdown (`core.FuseCountdown`) | B09 | `packages/primecare_ui` | missing | [Recipe](component-catalogue-usage.md) |
| FuseDialog (`core.FuseDialog`) | B09 | `packages/primecare_ui` | blocked | [Recipe](component-catalogue-usage.md) |
| FuseExample (`core.FuseExample`) | B17 | `packages/primecare_ui` | missing | Batch contract/evidence |
| FuseHighlight (`core.FuseHighlight`) | B09 | `packages/primecare_ui` | missing | [Recipe](component-catalogue-usage.md) |
| FuseLayout (`core.FuseLayout`) | B04 | `packages/primecare_ui` | blocked | [Recipe](workspace-navigation-usage.md) |
| FuseLoading (`core.FuseLoading`) | B09 | `packages/primecare_ui` | missing | [Recipe](component-catalogue-usage.md) |
| FuseNavigation (`core.FuseNavigation`) | B04 | `packages/primecare_ui` | blocked | [Recipe](workspace-navigation-usage.md) |
| FusePageCarded (`core.FusePageCarded`) | B05 | `packages/primecare_ui` | missing | [Recipe](page-template-usage.md) |
| FusePageSimple (`core.FusePageSimple`) | B05 | `packages/primecare_ui` | missing | [Recipe](page-template-usage.md) |
| FuseScrollbars (`core.FuseScrollbars`) | B08 | `packages/primecare_ui` | blocked | [Recipe](shell-utilities-usage.md) |
| FuseSearch (`core.FuseSearch`) | B08 | `packages/primecare_ui` | blocked | [Recipe](shell-utilities-usage.md) |
| FuseSettings (`core.FuseSettings`) | B06 | `packages/primecare_ui` | blocked | [Recipe](advanced-theme-usage.md) |
| FuseShortcuts (`core.FuseShortcuts`) | B08 | `packages/primecare_ui` | blocked | [Recipe](shell-utilities-usage.md) |
| FuseSidePanel (`core.FuseSidePanel`) | B08 | `packages/primecare_ui` | blocked | [Recipe](shell-utilities-usage.md) |
| FuseSplashScreen (`core.FuseSplashScreen`) | B09 | `packages/primecare_ui` | missing | [Recipe](component-catalogue-usage.md) |
| FuseSuspense (`core.FuseSuspense`) | B09 | `packages/primecare_ui` | missing | [Recipe](component-catalogue-usage.md) |
| FuseSvgIcon (`core.FuseSvgIcon`) | B12 | `packages/primecare_ui` | blocked | [Recipe](original-assets-usage.md) |
| FuseTheme (`core.FuseTheme`) | B06 | `packages/primecare_ui` | blocked | [Recipe](advanced-theme-usage.md) |
| FuseThemeSelector (`core.FuseThemeSelector`) | B06 | `packages/primecare_ui` | blocked | [Recipe](advanced-theme-usage.md) |
| Link (`core.Link`) | B05 | `packages/primecare_ui` | blocked | [Recipe](page-template-usage.md) |
| NavLinkAdapter (`core.NavLinkAdapter`) | B05 | `packages/primecare_ui` | blocked | [Recipe](page-template-usage.md) |
| withRouter (`core.withRouter`) | B05 | `packages/primecare_ui` | blocked | [Recipe](page-template-usage.md) |
| Three complete layout compositions (`capability.layout-families`) | B04 | `packages/primecare_ui` | blocked | [Recipe](workspace-navigation-usage.md) |
| Docked and floating panel interaction (`capability.docking`) | B02 | `packages/primecare_ui` | blocked | [Recipe](native-workspace-usage.md) |
| Flutter panel docking and resizing (`capability.native-docking`) | B03 | `packages/primecare_ui` | missing | [Recipe](native-workspace-usage.md) |
| Route-specific layout policies (`capability.per-route`) | B05 | `packages/primecare_ui` | blocked | [Recipe](page-template-usage.md) |
| Horizontal dropdown navigation renderer (`capability.horizontal-menus`) | B04 | `packages/primecare_ui` | missing | [Recipe](workspace-navigation-usage.md) |
| Tabbed navigation rail (`capability.tabbed-rail`) | B04 | `packages/primecare_ui` | missing | [Recipe](workspace-navigation-usage.md) |
| Fold, hover-expand and pin controls (`capability.fold-pin`) | B04 | `packages/primecare_ui` | blocked | [Recipe](workspace-navigation-usage.md) |
| Independent region palette editing (`capability.region-palettes`) | B06 | `packages/primecare_ui` | blocked | [Recipe](advanced-theme-usage.md) |
| Palette previews and derived shades (`capability.palette-shades`) | B06 | `packages/primecare_ui` | blocked | [Recipe](advanced-theme-usage.md) |
| Schema-driven layout setting forms (`capability.schema-forms`) | B06 | `packages/primecare_ui` | missing | [Recipe](advanced-theme-usage.md) |
| Configuration viewer and copy controls (`capability.settings-code`) | B06 | `packages/primecare_ui` | blocked | [Recipe](advanced-theme-usage.md) |
| Cross-device preference persistence (`capability.cloud-preferences`) | B07 | `packages/primecare_ui` | missing | [Recipe](preference-sync-usage.md) |
| Events, notes and quick-settings drawer (`capability.quick-panel`) | B08 | `packages/primecare_ui` | missing | [Recipe](shell-utilities-usage.md) |
| Account-saved navigation favourites (`capability.favourites`) | B08 | `packages/primecare_ui` | missing | [Recipe](shell-utilities-usage.md) |
| Shared web fullscreen control (`capability.fullscreen`) | B08 | `packages/primecare_ui` | missing | [Recipe](shell-utilities-usage.md) |
| Cross-renderer RTL layout parity (`capability.rtl`) | B08 | `packages/primecare_ui` | blocked | [Recipe](shell-utilities-usage.md) |
| Full base component and feedback catalogue (`capability.base-widgets`) | B09 | `packages/primecare_ui` | blocked | [Recipe](component-catalogue-usage.md) |
| Advanced grids, forms, editors and uploads (`capability.tables-editors`) | B10 | `packages/primecare_ui` | missing | [Recipe](data-controls-usage.md) |
| Charts and configurable widget grid (`capability.charts-widgets`) | B11 | `packages/primecare_ui` | missing | [Recipe](dashboard-widgets-usage.md) |
| Complete original visual asset migration (`capability.assets`) | B12 | `packages/primecare_ui` | blocked | [Recipe](original-assets-usage.md) |
| Role, tenant, platform and device verification (`capability.verification`) | B18 | `packages/primecare_ui` | blocked | Batch contract/evidence |
| calendar (`app.calendar`) | B13 | `packages/primecare_ui` | missing | [Recipe](work-modules-usage.md) |
| contacts (`app.contacts`) | B13 | `packages/primecare_ui` | missing | [Recipe](work-modules-usage.md) |
| tasks (`app.tasks`) | B13 | `packages/primecare_ui` | missing | [Recipe](work-modules-usage.md) |
| notes (`app.notes`) | B13 | `packages/primecare_ui` | missing | [Recipe](work-modules-usage.md) |
| scrumboard (`app.scrumboard`) | B13 | `packages/primecare_ui` | missing | [Recipe](work-modules-usage.md) |
| mailbox (`app.mailbox`) | B14 | `packages/primecare_ui` | missing | [Recipe](communication-modules-usage.md) |
| messenger (`app.messenger`) | B14 | `packages/primecare_ui` | missing | [Recipe](communication-modules-usage.md) |
| notifications (`app.notifications`) | B14 | `packages/primecare_ui` | missing | [Recipe](communication-modules-usage.md) |
| file-manager (`app.file-manager`) | B14 | `packages/primecare_ui` | missing | [Recipe](communication-modules-usage.md) |
| academy (`app.academy`) | B15 | `packages/primecare_ui` | missing | [Recipe](application-modules-usage.md) |
| e-commerce (`app.e-commerce`) | B15 | `packages/primecare_ui` | missing | [Recipe](application-modules-usage.md) |
| ai-image-generator (`app.ai-image-generator`) | B15 | `packages/primecare_ui` | missing | [Recipe](application-modules-usage.md) |
| profile (`app.profile`) | B15 | `packages/primecare_ui` | missing | [Recipe](application-modules-usage.md) |
| settings (`app.settings`) | B15 | `packages/primecare_ui` | missing | [Recipe](application-modules-usage.md) |
| help-center (`app.help-center`) | B15 | `packages/primecare_ui` | missing | [Recipe](application-modules-usage.md) |
| project (`dashboard.project`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| analytics (`dashboard.analytics`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| finance (`dashboard.finance`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| crypto (`dashboard.crypto`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| invoice (`page.invoice`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| pricing (`page.pricing`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| activities (`page.activities`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| search (`page.search`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| authentication (`page.authentication`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| coming-soon (`page.coming-soon`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| maintenance (`page.maintenance`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |
| error (`page.error`) | B16 | `packages/primecare_ui` | missing | [Recipe](dashboard-pages-usage.md) |

## Shared API entry points

Known reference inventory: 1200 records across skeleton, chart/demo and component-family audits. All receive explicit blocked dispositions until reviewed; these audits have different logical/physical scopes and their counts must not be added as a unique vendor-feature total.

The JSON catalogue records source-level public symbols and content digests. Examples and adapter contracts are linked from the usage column. An unchanged proposal digest is not proof that a source was tested or approved.

Native app inventory: 9 apps with pubspecs; 9 have direct shared-package imports. Web portals: 9 using the central TypeScript host. Import presence does not establish a working authenticated screen or absence of duplicate old implementations.

For app-by-app importer paths and feature source APIs, read [developer-catalogue.json](../../packages/primecare_ui/catalogs/developer-catalogue.json). Preserve old paths until live compatibility and migration acceptance pass.

Reproduce with `python scripts/build-theme-developer-catalogue.py --check`. No registrations, permissions, provider calls, dependency removals or production changes are performed.
