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
| Slide versus tabbed navigation | Tabbed module navigation is not implemented by this change |
| Left/right utility panels | Engine supports authorized registered panels; the master does not invent panel content |
| Route overrides and URL settings | Not imported from user files; authorization and routing stay host-controlled |
| Scrollbar preference | Controls shared ScrollConfiguration; scrollbar appearance follows the active Flutter theme on supported platforms |

## File contents and limits

The strict `primecare-theme-center` envelope has `version`, `kind`, `appearance`, and `layout`. Appearance v2 stores main theme, optional navbar/toolbar/footer themes, direction, scrollbar preference and legacy layout selection. Workspace stores the effective bar positions, widths, container/scroll mode and permitted panel geometry. Imports are bounded to 64KB and validate the whole profile before applying either controller. Unknown authority fields and unregistered panels are rejected.

Named saved-theme library entries are deliberately separate from the current active settings file. This is a portable current profile, not a database backup. Save all also saves workspace layout for next launch and writes the complete device snapshot; Load all restores that snapshot. Import applies settings; Save all retains the imported layout. File export uses the web download or desktop save dialog; Copy all settings provides JSON on other targets.

## Limits of matching

This is an owned Dart equivalent of the settings structure and supported layouts. It is not a pixel-identical React/MUI port. Native file-picker interaction and authenticated production appearance need device/browser acceptance beyond widget tests and web compilation.
