# Fuse reference and PrimeCare Theme Center

Inspected the checked-in Fuse React v17 skeleton, without importing vendor runtime code:

- `src/configs/settingsConfig.ts`
- `src/components/theme-layouts/layout1/Layout1Config.ts`
- `src/components/theme-layouts/layout2/Layout2Config.ts`
- `src/components/theme-layouts/layout3/Layout3Config.ts`
- `FuseSettings.tsx` and `FuseSettingsProvider.tsx` for control generation and settings precedence.

There are three layout families, four theme regions (main/navbar/toolbar/footer), and four ZIP distributions (Next.js/Vite, demo/skeleton). These are different counts.

| Reference capability | Shared Dart implementation |
|---|---|
| Vertical navigation, left/right, folded | Shared layout controls; 64px rail or adjustable width |
| Two horizontal families | Page-scroll and content-scroll presets |
| Toolbar above/below navigation | Top or directly below top navigation; bottom remains available |
| Boxed/full-width/content container | Supported with bounded maximum width |
| Toolbar/footer fixed/static | Sticky/static controls; footer can be hidden |
| Four independent palette regions | Main plus navbar/toolbar/footer overrides; each can inherit main |
| Text direction | LTR/RTL, included in complete file |
| Font, scale, corners and custom colors | Existing validated personal theme model, included in complete file |
| User settings over defaults | Account/role device settings; v1 appearance remains readable |
| Complete portable settings | New `primecare-theme-settings.json`: appearance and workspace layout |
| Slide versus tabbed navigation | Slide/tabbed module navigation supported; compact rails expose authorized destinations |
| Left/right utility panels | Engine supports authorized registered panels; the master does not invent panel content |
| Route overrides and URL settings | Not imported from user files; authorization and routing stay host-controlled |
| Scrollbar preference | Controls shared ScrollConfiguration; scrollbar appearance follows the active Flutter theme on supported platforms |

## File contents and limits

The strict `primecare-theme-center` envelope has `version`, `kind`, `appearance`, and `layout`. Appearance v3 stores navigation style, main theme, optional navbar/toolbar/footer themes, direction, scrollbar preference and legacy layout selection (v1/v2 remain readable). Workspace stores the effective bar positions, widths, container/scroll mode and permitted panel geometry. Imports are bounded to 64KB and validate the whole profile before applying either controller. Unknown authority fields and unregistered panels are rejected.

Named saved-theme library entries are deliberately separate from the current active settings file. This is a portable current profile, not a database backup. Save all also saves workspace layout for next launch and writes the complete device snapshot; Load all restores that snapshot. Import applies settings; Save all retains the imported layout. File export uses the web download or desktop save dialog; Copy all settings provides JSON on other targets.

## Limits of matching

This is an owned Dart equivalent of the settings structure and supported layouts. It is not a pixel-identical React/MUI port. Native file-picker interaction and authenticated production appearance need device/browser acceptance beyond widget tests and web compilation.

## Personal ownership

Every signed-in user has separate device preferences. Keys encode tenant, user and role as an unambiguous JSON tuple; complete workspace snapshots also include the application scope. Existing unambiguous authenticated keys remain readable. Guests may preview appearance but do not persist account settings. Complete-profile controls check that the current user owns the supplied workspace before reading, saving or importing it.

Exported files contain presentation choices, not an owner identifier. Import intentionally creates a copy in the importing user's current profile; it cannot address or replace the exporting user's stored profile. Theme and named-library dialogs capture their opening account and reject late mutations after an account switch. This is device-local persistence and file transfer, not cross-device account synchronization.

## Visual configurator rebuild

The public Fuse React reference was checked online at https://fusetheme.com/admin-templates/react/ and its published palette editor at https://fusetheme.com/static/assets/react/theming/palette-editor.png. Public layout/settings documentation was checked at https://fuse-react-nextjs-demo.fusetheme.com/documentation/user-interface/theme-layouts and https://fuse-react-nextjs-demo.fusetheme.com/documentation/configuration/settings. Interactive demo sign-in was rejected by automatic approval, so it was not used.

The v17 skeleton's `SettingsPanel.tsx` specifies a 380px side panel capped to 90vw, square edges, an outlined grouped form and visual palette previews. The shared Dart configurator now follows that structure: layout first; grouped navbar, toolbar and footer controls; a 2×2 set of main/navbar/toolbar/footer palette previews; radio choices; and a palette editor with light/dark modes, primary/secondary/paper/default colors and a live preview. Long transfer descriptions and duplicate preset forms are removed from the primary view. Personal import/export and named themes remain available in collapsed sections.

Slide/tabbed navigation is now persisted in appearance v3; v1/v2 files still load as Slide. Toolbar display is persisted in the existing layout contract; a recovery gear remains available if the toolbar is hidden. These are real presentation controls, not inactive placeholders. Registered utility panels remain host-supplied. No route authorization or login policy is imported from these settings.
