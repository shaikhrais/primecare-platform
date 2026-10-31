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
