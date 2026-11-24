# Fuse component coverage for R01–R25

The supplied Fuse React v17 archive has 4,701 source files across the Vite and Next.js skeletons and demos. The source index records file paths, hashes and review assignments. It includes 55 Material UI component families with 1,187 TypeScript and TSX example files. Those counts describe sources and examples.

The historical Vite inventory anticipated 389 files. The untouched Vite archive contains 396. All 389 indexed paths exist there, and 11 have different bytes in the historical preview. Full-render comparisons use the archive source hashes. The historical [72 capability mappings](../appearance/shared-skeleton-equivalents.md) remain useful for finding PrimeCare APIs.

## Required visual coverage

Keep the five-view work limit and use the component families under the applicable active R task. Record each visible variant and state with its source identity, approved PrimeCare counterpart, matched fixture inputs, screenshots, visual review, interaction checks and accessibility evidence. File names, wrapper exports and test counts give discovery or implementation evidence. A component requires a complete recorded visual review for a MATCHED status.

Keep the original PrimeCare brand and registered resources. Use matching common icon identifiers where the project already integrates the same library. Review and retain any differences in asset, role, host or available control. Demo and dashboard files stay BLOCKED for implementation until skeleton acceptance. Their reusable component families remain in scope for skeleton review.

| Review task | Fuse family | Example files | Existing candidate in family audit | Visual status |
|---|---|---:|---|---|
| R06 | app-bar | 29 | prior shared navigation/page factories | NOT MATCHED |
| R06 | bottom-navigation | 9 | prior shared navigation/page factories | NOT MATCHED |
| R06 | breadcrumbs | 18 | prior shared navigation/page factories | NOT MATCHED |
| R16 | accordion | 17 | accordion | NOT MATCHED |
| R16 | menus | 31 | menus | NOT MATCHED |
| R16 | popover | 11 | Candidate review required | NOT MATCHED |
| R16 | popper | 15 | Candidate review required | NOT MATCHED |
| R16 | tabs | 41 | tabs | NOT MATCHED |
| R16 | tooltips | 35 | tooltip | NOT MATCHED |
| R17 | alert | 21 | feedback | NOT MATCHED |
| R17 | backdrop | 5 | Candidate review required | NOT MATCHED |
| R17 | dialogs | 27 | dialog | NOT MATCHED |
| R17 | drawers | 25 | modal(drawer) | NOT MATCHED |
| R17 | modal | 15 | modal | NOT MATCHED |
| R17 | snackbars | 23 | feedback(toast) | NOT MATCHED |
| R18 | autocomplete | 59 | Candidate review required | NOT MATCHED |
| R18 | button-group | 17 | controls | NOT MATCHED |
| R18 | buttons | 39 | button | NOT MATCHED |
| R18 | checkboxes | 23 | checkbox | NOT MATCHED |
| R18 | floating-action-button | 11 | Candidate review required | NOT MATCHED |
| R18 | links | 9 | prior shared navigation/page factories | NOT MATCHED |
| R18 | number-field | 11 | Candidate review required | NOT MATCHED |
| R18 | radio-buttons | 23 | radio | NOT MATCHED |
| R18 | rating | 17 | Candidate review required | NOT MATCHED |
| R18 | selects | 35 | select | NOT MATCHED |
| R18 | slider | 39 | PrimeSlider | NOT MATCHED |
| R18 | speed-dial | 13 | Candidate review required | NOT MATCHED |
| R18 | steppers | 21 | Candidate review required | NOT MATCHED |
| R18 | switches | 19 | switch | NOT MATCHED |
| R18 | text-fields | 49 | input/multiline | NOT MATCHED |
| R18 | toggle-button | 23 | button(pressed) | NOT MATCHED |
| R18 | transfer-list | 7 | Candidate review required | NOT MATCHED |
| R19 | avatars | 29 | Candidate review required | NOT MATCHED |
| R19 | badges | 21 | badge | NOT MATCHED |
| R19 | cards | 21 | card | NOT MATCHED |
| R19 | chips | 27 | badge + dismiss action | NOT MATCHED |
| R19 | dividers | 17 | Candidate review required | NOT MATCHED |
| R19 | image-list | 21 | Candidate review required | NOT MATCHED |
| R19 | lists | 31 | PrimeListTile | NOT MATCHED |
| R19 | pagination | 24 | Candidate review required | NOT MATCHED |
| R19 | paper | 11 | card | NOT MATCHED |
| R19 | table | 27 | PrimeDataTable | NOT MATCHED |
| R19 | timeline | 25 | Candidate review required | NOT MATCHED |
| R20 | progress | 33 | loading | NOT MATCHED |
| R20 | skeleton | 17 | loading | NOT MATCHED |
| R20 | transitions | 17 | Candidate review required | NOT MATCHED |
| R21 | typography | 7 | PrimeText | NOT MATCHED |
| R22 | css-baseline | 3 | Candidate review required | NOT MATCHED |
| R22 | init-color-scheme-script | 3 | Candidate review required | NOT MATCHED |
| R23 | box | 7 | Candidate review required | NOT MATCHED |
| R23 | container | 7 | form | NOT MATCHED |
| R23 | grid | 35 | form | NOT MATCHED |
| R23 | grid-legacy | 29 | Candidate review required | NOT MATCHED |
| R23 | masonry | 21 | Candidate review required | NOT MATCHED |
| R23 | stack | 17 | form | NOT MATCHED |

## Current navigation icons

| Surface | Reference identifier | PrimeCare result | Full-view status |
|---|---|---|---|
| R01–R03 desktop sidebar | `lucide:panel-left` | Same glyph on both sides and in both fold states, with a 28 px visible outline | IN PROGRESS |
| R04 mobile drawer | `lucide:panel-left` | Same glyph and outline on the existing drawer opener | IN PROGRESS |
| R01–R05 language and account actions | Fuse flag image, account avatar/info/chevron | Registered local flag vectors plus the existing role/account handlers; no network avatar | IN PROGRESS |
| R01–R05 account popover | MUI popover paper, menu item hover and layered CSS shadow | Ten pointer-hover pairs cover the regular five views in light and dark. Both use a 4px row corner and the shared lucide:square-arrow-right icon. The sampled Sign out ink color agrees in both themes. Dark hover fill and native shadow falloff still differ. Folded-tabbed hover requires aligned reference evidence. | IN PROGRESS |
| R01–R05 account keyboard states | `UserMenu.tsx` trigger and MUI popover keyboard behavior | Paired Fuse and PrimeCare keyboard captures cover the five views in both themes and the folded-tabbed alternate. Native Tab, Enter, focused menu item and Escape return pass. The native outline is stronger than the reference for keyboard visibility. R05 now paints the complete trailing stroke. | IN PROGRESS |
| R02 regular folded destination | Fuse 32×32 px selected tile | Both themes confirm the 32×32 px native tile at (8, 60). The multi-destination panel remains open. | IN PROGRESS |
| R04 drawer backdrop | MUI SwipeableDrawer backdrop | Measured light/dark scrim pixels agree. Backdrop tap closes the drawer and the registered navigation opens again. The drawer has no desktop divider and its selected tile and account control use the full 256 px fixture width. | IN PROGRESS |
| R05 text size and fixture destination | `lucide:a-large-small`, `lucide:star` | Existing Lucide glyphs retained | IN PROGRESS |
| R05 fullscreen and Quick Panel | `fullscreen`, `lucide:bookmark` | Native host bindings require registration and approval | BLOCKED |
| R01–R05 right-edge Theme Settings launcher | `lucide:settings` | Existing Theme Center drawer is a candidate. The separate authenticated shell launcher is absent from the checked production control receipt. | BLOCKED |
| R01–R05 right-edge color schemes launcher | `lucide:swatch-book` | Existing account-scoped color combinations are a candidate. The separate launcher and picker entry are absent from the checked production control receipt. | BLOCKED |

PrimeCare workspace save keeps its own action. The Fuse bookmark opens the Quick Panel. PrimeCare brand imagery stays tied to its existing registered asset.

### Right-edge configurator evidence

Untouched Vite skeleton SHA-256 values:

| Source | SHA-256 |
|---|---|
| `Configurator.tsx` | `9b28fe4e6f14ec1f1cd7f4615ed66ce5c0e5b1c7b3307016fffc9dc0f1662c54` |
| `SettingsPanel.tsx` | `fddc74b49ca4ea221fff84d5b56d3b5eabe997b1ada5c5e5aa32108a69efb7b8` |
| `ThemesPanel.tsx` | `228e306d092e80fbdfc43c79c8bf41faf78bd6bbdf12561301549b1ff0f1ac93` |

The authenticated reference displays two separate actions in a shared right-edge
rail. The gear opens layout and theme settings. The swatch book opens scheme
selection. The reference hides the rail for guests. The current PrimeCare
footer opens Theme Center, and its hidden-toolbar recovery action opens the
same drawer. Those entry points do not cover either separate launcher.

Use the existing account scope and actions for the proposed launchers. Verify
production registration for the two distinct shell elements and their accessible
labels before exposing them in runtime. Review closed, opened and dismissed
states, keyboard focus and activation, guest absence, drawer overlay, and theme
selection scoped to the authenticated account. Check both themes and each
active shell, including the mobile scrim and right-docked sidebar.

## Reproduce

Run `python3 scripts/audit-full-render-component-coverage.py ARCHIVE --csv Fuse_Component_Source_Coverage.csv` with the supplied licensed archive. `scripts/audit-component-reference.py ARCHIVE --check` verifies the named component-family example hashes. The generated CSV contains source paths and hashes, with fixture and example registration handled independently.
