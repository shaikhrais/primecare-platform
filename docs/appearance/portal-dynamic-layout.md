# Dynamic Dart portal layout

The checked-in Fuse v17 Vite skeleton was reviewed as a behavior reference: `Layout1Config.ts`, `Layout2Config.ts`, and `Layout3Config.ts`. PrimeCare uses its own Dart shared components; no vendor React implementation is imported.

## Configuration and rendering

`GovernanceMasterLayout` supplies authorized navigation, its existing toolbar actions, `AppShellBoundary`, and a shared footer to `PrimeWorkspaceLayout`. `PortalWorkspace` owns the validated controller for the authenticated tenant, user, active role and application. Theme Center edits that controller rather than maintaining a second layout state.

- Navigation: left, right, top, bottom, hidden; 64px folded rail or 160–400px width.
- Toolbar: top/bottom and sticky/static.
- Footer: sticky/static/hidden; undo, device save, Theme Center access.
- Container: full width, boxed, or constrained content; 960–1920px maximum width.
- Scrolling: page/content. Handheld navigation stays in the drawer.
- Existing form state remains owned by the renderer slots during presentation changes.

The toolbar remains available to recover a hidden footer/navigation. There is no page-title banner introduced by this shell. Tenant identity and role/account actions remain in the compact toolbar.

## Save, load and transfer

Save writes to SharedPreferences, partitioned by tenant/user/role/application. Load validates the same data-only v1 contract. Account changes dispose the old controller; late loads cannot overwrite newer edits. No business data, credentials, routes or access grants are imported from layout JSON. The existing theme/palette persistence remains separate.

Export file downloads JSON on web or opens a desktop save dialog. Import file opens a file picker and enforces the 32KB bound and current authorized panel registry. Copy/paste JSON is also available, including for mobile export. File-picker cancellation does not change the layout. Device persistence is not cloud synchronization.

## Scope

This change connects the shared master shell. Screen-specific action sections are still owned by their screens. The renderer supports registered draggable utility panels, but this master does not invent utility panels or register business content. It is not a wholesale recreation of every Fuse component or application.

## Validation

Run `node scripts/workspace-native-contract-fixtures.mjs`, Flutter workspace contract/controller/widget tests, targeted shell analysis, and Flutter web smoke compilation. The contract fixtures cover 360 combinations including folded navigation. Deployment and authenticated production browser acceptance must be reported separately from these checks.
