# PrimeCare Theme Center

## Read and reused

The implementation follows the shared desktop top bar/sidebar, mobile single-column behavior and language consistency in `docs/primecare_master_role_screen_layout.html` and `docs/primecare_master_role_screen_layout_en_fr_common.html`, the runtime XML layout managers in `docs/ui/runtime-layout-manager.md`, existing theme settings and the 37 presets in `scripts/fuse_presets.json`. The catalog remains the source for the website palette gallery and generated Flutter preset names. Existing app-specific branding remains the default until the user selects a personal style.

DevExpress documentation informed palette inheritance, named color roles, a theme selector/editor, runtime application and restored user preferences:
- https://docs.devexpress.com/WPF/403707/common-concepts/customize-your-application-appearance
- https://docs.devexpress.com/WPF/400728/common-concepts/themes/palettes
- https://docs.devexpress.com/WindowsForms/2399/build-an-application/skins

No DevExpress controls, assets, binaries or proprietary theme files are copied or required. This adapts the approach into PrimeCare's TypeScript and Flutter components.

## User workflow

Open Theme Center from the shared website top bar or Flutter settings drawer. Choose any of the 37 palettes; preview named semantic color overrides, system/serif/monospace fonts, text scale .875–1.5 and corner radius 0–24. The palette supplies unset fields. Preview does not replace unfinished website form input or role navigation. Layout settings remain in the existing layout controls and XML contract.

Save a unique name to create a personal theme, apply a saved theme, update it from the current draft, rename, duplicate or delete its saved copy. Deleting a copy retains the current appearance; Reset restores the default. A maximum of 20 named themes per scope keeps persistence bounded. Themes export/import as the same versioned JSON descriptor on both website and Flutter; native export uses the clipboard and import accepts pasted JSON. Imported themes preview first and require explicit named saving to enter the collection. User names render as text, never markup.

## Shared appearance contract

`PersonalTheme` version 1: name (1–60 characters), registered preset, fontFamily (system/serif/monospace), finite fontScale (.875–1.5), integer radius (0–24), optional colors. The allowed color keys are primary, primaryContainer, secondary, background, surface, text, muted, border, sidebar and topbar; each must be #RRGGBB. Unknown keys, permissions/routes, invalid catalog IDs, oversized JSON and bad numeric values are rejected. Background/surface combinations must allow a readable common foreground. Runtime adapters choose contrasting text for buttons, sidebar, top bar and surfaces. Theme style contains no account identity, credentials or domain records.

The shared Flutter application root resolves the selected style into Material ThemeData; themed roots also update PrimeTheme colors, typography and radii, and GovernanceMasterLayout uses the same resolver. Theme changes do not create a separate auth/navigation pipeline. Existing unrelated ThemeData extensions are retained. Native settings and the website manager derive from the same registered palette IDs and portable personal-style schema; generated preset names are checked for drift.

## Persistence and isolation

Website libraries store one atomic validated record per authenticated account and role, with active style and named collection, in localStorage. Flutter settings and named collection use separate validated SharedPreferences records scoped by tenant, account and role. Storage failure must not report success or commit an unsaved in-memory library mutation. Account changes rebuild scoped providers; an in-flight old-account write cannot update the next account's visible state. Unvalidated or oversized records fall back to safe defaults.

Legacy Flutter global theme preference keys are not copied into each user's namespace: their ownership was unknown and copying would leak one account's settings to another. Users can choose and save their preference again in the scoped Theme Center. Existing website XML layout preferences remain intact; named theme JSON is a separate appearance contract.

Saving is local to this browser/device. JSON export/import transfers a style manually. There is no cloud sync, tenant-wide publishing, central administration of other users' themes, remote fonts, arbitrary CSS or DevExpress skin loading. Required form fields and permissions cannot be changed by a theme. Legacy screens that hardcode colors rather than consuming shared Material/PrimeTheme tokens are not converted into a new design system by this change.

## Legacy consumer migration

The follow-up migration replaces fixed dashboard card surfaces, hero/insight gradients, neutral text and panel borders with shared theme values. Explicit shared component font sizes honor the saved scale; quick-action tiles grow with text and the hero heading wraps. Admin reality-check, role-carousel and screenshot-gallery surfaces/buttons use their current theme. Filled input backgrounds and enabled-border radii no longer retain the original branding after a personal style is applied.

Branded application roots expose the same personal PrimeTheme tokens as Material when a personal theme is active. The enterprise blueprint demo also consumes the personal Material appearance and offers the theme drawer; it remains a demo, with authenticated account requirements unchanged for named theme saving.

The SQLite screen generator now emits runtime appearance tokens and scaled text. Existing generated screen files are not regenerated in bulk: doing so could overwrite their individual API and authorization work. Older direct color literals outside these shared components remain for subsequent screen-specific migration. Status colors and audit labels retain their meaning.

## Verification

Dedicated browser coverage exercises all 37 palettes, live state retention, named CRUD, persistence across reload, per-account isolation, collection bounds and JSON rejection/export/import at mobile/desktop sizes. Shared Flutter tests exercise all catalog presets, personal theme validation, scoped settings/collection CRUD, restart restoration, role/account switching, malformed preferences and collection bounds. Shared app tests and platform compilation must pass before merge.

## Solid default appearance — 2026-10-27

The website now merges `packages/shared/src/solid-theme.json` over the exported portal presentation defaults before restoring scoped personal preferences. This is a checked-in presentation default, not a governance database update. The navy navigation, teal actions, white panels, cool grey background, strong borders and dark text are shared across the portals. Authenticated personal palettes and theme reset remain supported; no saved user preferences are erased. Solid surface treatment removes card shadows and decorative gradients without altering permission or status meanings.

The existing native `navyTealPalette` and application defaults use the same colours through the generated ThemeConfig. Shared Material cards have zero elevation, transparent surface tint and explicit outlines. Other saved native presets remain available. Source and CI coverage do not imply an updated APK or physical-device acceptance.
