# Original PrimeCare shared skeleton

The user changed the direction on October 31, 2026: write original PrimeCare
code inspired by the approved light dashboard; do not copy or depend on Fuse.
The proposed licensed archive upload is cancelled. The private Fuse package is
a discarded integration direction, not an application dependency.

`packages/primecare_ui/web/prime-skeleton.css` is newly authored PrimeCare CSS.
It reuses existing shell markup, registered navigation, controls, and governed
theme variables. It imports no vendor source, fonts, icons, images or layouts.
`scripts/lib/primecare-styles.mjs` appends it after existing styles so shared
components and the existing PrimeCare Theme Center inherit personal colors.
No business routes, permissions, database records or API contracts change.

This is the first presentation migration, not proof that every legacy page has
been converted. Active TypeScript and Dart generators now read `scripts/primecare_presets.json`,
an original PrimeCare light/dark palette. Old preset IDs remain aliases to avoid
rejecting saved profiles; they do not retain the old palette values.
`PrimeCareTheme` and `primecare_appearance.ts` own active resolution. Earlier
Fuse-named files provide compatibility exports only. The old preset source and
vendor inventory remain historical files and are not application dependencies.
This does not assert a legal audit of the whole repository. The vendor inventory is historical,
not a registry of newly authored components. Native screenshot parity, live
governance mapping and full workflow verification remain pending.

## Shared Theme Center skeleton

The web implementation now belongs to `packages/primecare_ui/web/theme-center.ts`;
`web/index.ts` is its public entry. The earlier website entry reexports it for
compatibility. Layout, colors, typography and saved themes group the existing
registered controls in one original side panel. Styles have one shared owner
and inherit the same runtime tokens. Existing layout XML and personal theme
JSON formats, validation, account/role scope and storage keys remain intact.
Preferences save on the current browser, not to PostgreSQL or other devices.
No business routes, permissions or new governance IDs are introduced.

Secure UUID fallback uses Web Crypto when randomUUID is unavailable. Tests cover
CRUD, reload, account isolation, failed storage writes and invalid imports.
Browser verification confirms save/reload restores a theme with radius 16.
The preview uses fictional records. Complete page migration and native visual
parity remain separate work; this change does not port the web panel to Dart.

## Core package ownership

`packages/primecare_ui/web/index.ts` exports Theme Center, BaseThemeManager,
BaseLayoutManager, XmlLayoutManager and PersonalThemeLibrary. Implementations
reside in that package, without imports from website pages. Former website
module paths remain reexports for compatibility. Domain JSON validators stay
in `packages/domain`; Flutter settings stay in `packages/flutter_core`.

Functional appearance support: live palette changes and contrast adjustment;
light/dark mode; separate sidebar/topbar/content colors; font family and size;
corner radius; left/right sidebar; compact navigation; comfortable/compact
density; bounded content width; layout undo/redo/reset; XML layout validation,
import/export and local persistence; named theme save/update/apply/rename/
duplicate/delete; JSON import/export; account/role storage isolation.

This is not completion of Fuse-like horizontal layout variants, widgets,
notifications, calendar, full-text search, database preference synchronization
or complete native visual parity. Existing PrimeCare auth remains authoritative.
