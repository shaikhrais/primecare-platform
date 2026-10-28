# Standard dashboard navigation

Reference: Tabler's [vertical dashboard](https://preview.tabler.io/layout-vertical.html) and [open-source project](https://github.com/tabler/tabler). The PrimeCare renderer remains in place; the reference informs navigation proportions and hierarchy.

- A 248px navy sidebar with a compact brand, role badge, clear group headings and 44px navigation rows.
- A white 72px desktop utility bar: search, visible organization selector, language flag and account/utility menu.
- Mobile uses two compact rows: search and utilities first, then the full-width organization selector. Navigation opens in a separate rail.
- Each destination has a specific 24px outline SVG instead of unrelated home icons or text symbols. Menu, close, search and account controls also use SVGs.
- Selected Tabler SVGs are vendored in `websites/typescript/src/shell-icons.ts`, with their MIT notice in `TABLER_ICONS_LICENSE.txt`. No icon font or external CDN is used.
- Existing action handlers, permissions, tenant scope and translations remain authoritative. Theme customizations still use the existing Theme Center.

Validation: appearance screenshots in three languages and four viewport widths; keyboard/menu and page/workflow regression suites. Appearance tests require every administrative navigation link to have an SVG and the header to fit within the intended height.

## Verification

- [Appearance review and publication](https://github.com/shaikhrais/primecare-platform/actions/runs/40621013578): passed; desktop/mobile screenshots inspected.
- [Page/tool and Account database audit](https://github.com/shaikhrais/primecare-platform/actions/runs/40621013572): all three jobs passed.
- [Password browsers](https://github.com/shaikhrais/primecare-platform/actions/runs/40621013540): Chromium, Firefox and WebKit passed.
- [Administrative workflows and accessibility](https://github.com/shaikhrais/primecare-platform/actions/runs/40621013543): passed, including 27 browser workflows and 64 accessibility scenarios.

Released web source: `53f7c63157fc4f79d1d8acbb1a41410b7587bbe5`.
