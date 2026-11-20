# Shared shell and Fuse reference review

Reference inspected: the checked-in Fuse React v17 Vite skeleton archive, Layout1Config, Layout2/Layout3 component inventory, and FuseNavVerticalItemBase. These vendor components are not imported into the PrimeCare TypeScript renderer. The following changes apply through the shared PrimeCare web library.

| Independent surface | PrimeCare owner | Review/action |
| --- | --- | --- |
| Page identity | MasterDashboard / SpaceManager | Visually hidden h1; no visible page title or subtitle block; screen-reader identity and focus targets retained |
| Breadcrumb/title bar | Navigation / SpaceManager | Visible repeated title removed; search remains |
| Vertical navigation | Sidebar / SpaceManager | 216px expanded sidebar; compact desktop icon rail at 64px |
| Mobile navigation | Sidebar | Existing labelled drawer, focus trap, backdrop and Escape preserved |
| Navigation item | Sidebar | Existing permitted links retained; native tooltips added for icon rail; current permitted link scrolled into the navigation viewport |
| Navigation groups | SpaceManager | Smaller group gaps; group labels removed only in desktop icon mode |
| Brand/header | SpaceManager | 56px brand area replaces 112px block |
| Account/sidebar footer | AdminSidebarMenu / SpaceManager | Reduced footer; rail utility menu remains visible and popover escapes rail clipping |
| Main toolbar | SpaceManager | 56px desktop bar; mobile keeps two 44px control rows within 104px |
| Search | Navigation | Existing search, keyboard interaction and server-projected entries preserved |
| Tenant switcher | PlatformAdmin | Existing control and tenant isolation retained |
| Language menu | Shared shell | Existing control retained |
| Account utility menu | Shared shell | Existing control retained |
| Appearance drawer | Theme Center | Existing layout/colour/type/saved-theme controls retained; viewport adapter retained |
| Form/control surfaces | Theme tokens / SpaceManager | Active themes own button/input/select colours; dark-theme contrast checked by recorder |
| Footer | Shared shell / SpaceManager | Compact padding; empty footer removed |
| Dashboard cards/charts | PrimeEmsDashboardControls | Existing shared widgets and theme tokens retained |
| Screen registration | ScreenManager | Registration and presentation ownership remain required; visual changes grant no routes or permissions |
| Panels and advanced docking | WorkspaceLayout / WorkspaceCustomizer | Separate existing workspace host capability; not newly enabled on Code Admin |
| Horizontal navigation, tabbed Fuse navbar, standalone left/right side panels | Fuse reference | Not equivalent to the Code Admin shell's left/right sidebar; not implemented by this change |

Browser recorder checks title space, icon-rail width, density, dark mode, opening Theme Center from the rail menu, desktop/tablet/mobile captures, and every registered preview page. Generated browser-report.json records the actual execution result; this document alone does not establish a test pass.

No data/API/authentication contracts change. Preview content remains synthetic; the registry templates remain explicitly labelled structural previews rather than completed business workflows.
