# Active full-render matching queue

The user retired the 200-microtask completion approach. Do not count isolated
width/height/test/capture passes as full rendered-view matches. Work on up to
five full-render tasks per iteration; report fewer completions when blocked.
Demo remains blocked until all required skeleton views/states are accepted.

Use the [Fuse component coverage inventory](fuse-component-coverage.md) within
each active R task. A complete-view review includes every applicable visible
component variant and interaction state identified in the supplied sources.

For every view: align account/navigation/content/viewport/theme/language/scroll;
render the complete region; inspect screenshots and overlay/differences; fix
visible discrepancies; verify interaction/accessibility; retain commit/case/hash
and recorded review. Use NOT MATCHED / IN PROGRESS / BLOCKED / MATCHED only.

| Task | Complete rendered view | Status |
|---|---|---|
| R01 | Expanded left sidebar | IN PROGRESS |
| R02 | Folded sidebar | IN PROGRESS |
| R03 | Right sidebar | IN PROGRESS |
| R04 | Mobile sidebar drawer | IN PROGRESS |
| R05 | Horizontal navbar | IN PROGRESS |
| R06 | Header/toolbar and action menus | NOT MATCHED |
| R07 | Footer | NOT MATCHED |
| R08 | Left-side panel | NOT MATCHED |
| R09 | Right-side panel | NOT MATCHED |
| R10 | Complete Layout 1 | NOT MATCHED |
| R11 | Complete Layout 2 | NOT MATCHED |
| R12 | Complete Layout 3 | NOT MATCHED |
| R13 | Theme Center layout panel | NOT MATCHED |
| R14 | Theme/palette tiles | NOT MATCHED |
| R15 | Palette editor and color picker | NOT MATCHED |
| R16 | Menus/dropdowns/popovers/tooltips | NOT MATCHED |
| R17 | Dialogs/drawers/notifications | NOT MATCHED |
| R18 | Forms and input/button controls | NOT MATCHED |
| R19 | Tables/lists/cards/avatars | NOT MATCHED |
| R20 | Loading/empty/error/disabled views | NOT MATCHED |
| R21 | Icons/fonts/images/assets | NOT MATCHED |
| R22 | Light/dark and palette combinations | NOT MATCHED |
| R23 | Responsive/breakpoint/enlarged-text views | NOT MATCHED |
| R24 | RTL and localized views | NOT MATCHED |
| R25 | Final whole-screen/state review | NOT MATCHED |

## R01 work and limits

- The former empty native capture was not usable sidebar-match proof. The
  isolated fixture now contains existing registered host 2534's /tenant-dashboard
  route, using a fixture-only admin policy and synthetic account. It grants no
  real user authority, creates no runtime route and proves no live navigation.
- The explicit reference Navbar palette is now selected in the fixture. A
  baseline test passed before the proposed palette-resolver change: that proposed
  runtime change was removed. The gray-background discrepancy was fixture state.
- The actual sidebar now has a tenant-name/brand header using the existing
  registered prime_asset brand binding (control 730), a 24px shared brand concept,
  reference-sized header padding and default Geist text. PrimeCare naming is
  preserved. The brand concept is not a claim of approved final branding.
- A single module no longer gets a duplicate group caption. Multiple module
  headings remain. Row geometry uses reference-derived 32px rows, 16px icons,
  8px gaps, 12px outer inset, 4px row spacing and 6px corners, retaining SDK
  keyboard/hover behavior and existing route/permission checks.
- R01 remains IN PROGRESS: reference has Fuse branding/project selector and
  Example navigation; native has PrimeCare branding and a tenant-dashboard sample.
  Selected/hover/focus/expanded/folded state comparison and final branding/header
  decision remain open. No full-render approval is claimed.

## Sidebar state continuation

R01–R04 remain IN PROGRESS; zero complete views accepted. The exact slogan
Home service is registered and rendered through the verified existing resource
helper (production registration/readback run 45111378438). This does not grant
full-render acceptance.

The existing sidebar now compares the current URI path so accessibility query
parameters do not remove selection. Its row Material ink renders above the opaque
sidebar background; selected, hover and settled keyboard-focus colors are visible.
The folded header centers its existing logo without the expanded 20px inset,
removing a one-pixel overflow. Folded entries expose their existing registered
screen title in semantics, with the tooltip excluded from duplicate semantics.
No new routes, resources, role grants, APIs, layout schema or public interfaces.

Eight populated fixture cases (left/folded/right/mobile × light/dark) capture
selected/hover/focus states. Checks include selected semantics and accessible name,
keyboard reachability/activation, the existing route callback and mobile drawer
closure. The capture policy remains synthetic and isolated, not live authority.
41 workspace/default/metrics/full-shell regression cases and 13 exact-history
checks pass locally; shared UI/theme boundary has zero violations. Reference
account/navigation alignment, same-state comparison, remaining scrolling,
transition, localization and visual acceptance are still open. Native screenshots
and state differences are diagnostic evidence, not approved Fuse match pairs.

The latest explicit typography request is applied: brand 18px/700, slogan
11px/400 at normal saved scale. Typography and row padding moved to the existing
shared shell theme metrics to resolve the observed screen-local-style CI failure;
no boundary exemption was added. The stale legacy option-check path now checks
the exact production-pinned export without database writes. Three checks reject
pin/export drift and confirm no file/database creation. Other pre-existing CI
failures (source revision/preflight and replay dependency proofs) remain open;
no full CI, review, deployment or readiness claim is made from local tests.

## Horizontal navbar and reference cases

The native horizontal navbar uses a centered content band with the registered
PrimeCare mark and tenant name at the leading edge. Authorized module menus
occupy the trailing edge and still scroll horizontally when space runs out.
The brand and menu use the navbar palette. Desktop light and dark captures
include the opened menu. The fixture checks the registered destination and
Escape dismissal.

The isolated cloud reference now requests expanded navigation at the existing
Example URL, the folded tabbed sidebar, a right sidebar and the open mobile
drawer in both modes. The supplied reference components remain in place. The
guest Example entry differs from the PrimeCare tenant fixture, and the native
module popup and reference direct entry require separate review. R01–R05 stay
IN PROGRESS pending equivalent states and recorded visual acceptance.

## Sidebar presentation follow-up

The native folded rail occupies 48px in the governance shell. The saved profile
continues to encode folded navigation as 64. The native mobile drawer occupies
280px at the reviewed phone viewport. Desktop sidebar widths still come from
the saved expanded layout. The divider now faces workspace content whether the
sidebar is docked at the leading or trailing edge.

The selected row fill is derived from the sidebar palette and the foreground is
contrast checked against that fill. The navigation section palette also reaches
the drawer. The existing registered logo, tenant name and Home service wording
retain their current hierarchy. The native navbar capture uses Tab and Enter to
open the authorized module menu, then Escape to dismiss it.

The private reference now requests the existing Example path for the right and
mobile cases, like the expanded selected case. The drawer still opens through the
original toolbar button. R01–R05 remain IN PROGRESS. The account and menu content
still differ and the folded rail and navbar have distinct interaction patterns.

## Navigation interaction renders

The cloud reference now records screenshots of the visible Example link under
pointer hover and real Tab focus for R01–R05, where those states are reachable.
Its manifest records the visible destination, selected marker, language, scroll
and whether the browser reports visible focus. Missing interactions carry a
reason and do not stand in for a screenshot. The PrimeCare navbar fixture now
also saves its hover and keyboard focus views alongside the open menu. The four
sidebar fixtures already save these states. This extends diagnostic comparison
coverage. The reference and tenant fixtures still have different content and
the reference navbar link has no matching popup.

## Navigation hover and focus visibility

PrimeCare sidebar hover and focus ink now derives from the same readable palette
foreground as the selected row. This keeps light-mode hover visible against the
sidebar surface in the expanded, folded, right and mobile variants. The horizontal
navbar paints the same interaction ink above the bar background and confines it
to the rounded menu trigger. Existing routes, permissions and saved layouts are
unchanged.

The folded reference capture now requests the Example destination, as the native
fixture also starts on its selected destination. The fixtures retain their
different accounts and menu content. The two forms of navigation still require
review and R01–R05 remain IN PROGRESS.

## Folded alignment and navigation accessibility

The folded PrimeCare rail now positions its brand mark and first item four pixels
higher in the reviewed desktop viewport. A compact, centered row preserves the
existing route label and keyboard semantics. The saved folded marker and rendered
rail width remain the same.

The expanded sidebar, right sidebar and mobile drawer resolve the Home service
text foreground against the actual sidebar surface. The existing registered
wording, brand hierarchy and destination data remain in place. The screenshot
fixture disables its debug ribbon, and the horizontal module menu check verifies
keyboard focus returns to the trigger after Escape. R01–R05 remain IN PROGRESS.

## Route activation evidence

The four PrimeCare sidebar fixtures save their full-screen result after keyboard
activation. The mobile fixture opens the drawer through the existing toolbar
button and verifies the drawer closes on activation. The desktop horizontal
fixture verifies Escape returns focus, then uses the keyboard to open the
existing module menu and select its registered Tenant dashboard destination.
It records the destination and a full-screen post-activation capture.

The reference capture measures Enter on its original Example link after the
focus capture, records the resulting destination, and observes whether the
mobile drawer closes. Missing activation evidence keeps a reason. The isolated
capture host keeps its original shell mounted when the link changes the URL.
R01–R05 remain IN PROGRESS. The reference and native menu content differ.

The first navigation activation review exposed a desktop fixture defect. Two
separate route builders rebuilt the shell when the keyboard selected the
destination, losing the configured navbar position. The fixture now mirrors the
registered router's shared shell, and verifies the same workspace and navbar
position survive child-route activation in both themes. The blank child pages
stay outside focus traversal so the check reaches the visible shell controls
using Tab.

## Direct navbar destination and folded tabbed rail

The master shell uses the same authorized rows for expanded, folded, right,
mobile and horizontal navigation. Groups with no visible destination are
omitted. A horizontal group with one visible destination renders a named,
keyboard-activatable direct link. Groups with multiple destinations keep their
menus. The link shows its selected state after navigation.

The folded tabbed style now shows the existing PrimeCare mark in the compact
rail and exposes the tab name to assistive technology. Its selected marker
uses the shared sidebar palette and rounded row treatment. The two-line header
keeps its registered name and slogan hierarchy. The shared sidebar selected
fill and label weight were adjusted in the rendered expanded, right and mobile
cases. Existing saved layout formats, routes, metadata and grants are unchanged.

The capture suite exercises slide and tabbed folded cases in both themes.
The Fuse guest and PrimeCare tenant fixture still contain different menu data.
R01–R05 remain IN PROGRESS. Demo work remains blocked.

## Sidebar minimize control and horizontal chrome

The desktop toolbar exposes the existing sidebar fold setting beside the
left or right rail. The control uses the registered localized Sidebar label
and announces its expanded state. Tab and Enter fold to the existing saved
marker and restore the former width. The mobile toolbar keeps its drawer
button. Keyboard captures verify restoration of a custom 312px width.

The horizontal navbar and toolbar keep their edge-to-edge backgrounds and
align their contents within a shared centered column. The navbar owns the
brand display. A single authorized destination shows selection with the
navbar accent and retains one-step activation. Existing controls continue
to use the active PrimeCare account and permission data. No catalogue change
or saved layout migration is involved.

## Shared navigation capture

The native renderer exports the role, locale and already-filtered navigation
from its existing isolated shell fixture. Additional Fuse cases use that
same presentation input through the original navigation provider. The
original guest and Example cases remain in the capture set. The shared cases
must show the expected route, label where visible, locale and initial scroll
before their frames enter comparison. No production session or grant is
issued by either fixture.

The desktop minimize control has a visible boundary in both themes. A
single authorized destination in the folded tabbed rail now activates once
with Enter and exposes its destination name and link semantics. Multi-entry
tabs keep their chooser. Horizontal navigation controls use the shared 48px
row inside the existing 64px navbar.

R01–R05 remain IN PROGRESS. Shared fixture inputs resolve the previous
navigation-label discrepancy for diagnostic comparison. Differences in
brand, account controls and full view behavior still require review.

## Layout 2 toolbar controls

The Fuse toolbar source renders the responsive drawer trigger, navigation
shortcuts, language, font size, fullscreen, navigation search, Quick Panel
and an account menu. The bookmark opens the Quick Panel. The star opens
navigation shortcuts. Layout saving is a separate PrimeCare action.

| Reference or requested action | PrimeCare horizontal toolbar |
|---|---|
| Language | Existing EN/FR/ES selector and account preference path; local registered US/French/Spanish flag geometry replaces the unsupported emoji glyph |
| Font size | Toolbar access in each non-handheld layout to the existing Theme Center text scale, using its validated range and account scope |
| Save layout | Toolbar access to the existing local workspace save used by the footer, with no account sync grant |
| Drawer trigger and account menu | Existing PrimeCare controls retain routing and permissions; the former separate role pill and avatar are one bordered account trigger with role switching inside its menu |
| Fullscreen, navigation search and shortcuts | The current native master has no approved host binding. Existing shared B08 controls were registered on the Tenant Admin web pilot only. |
| Quick Panel (bookmark) | Native host and authorized resource bindings are absent. The B08 pilot does not grant Tenant Admin preference API access. |

The EN/FR/ES menu, text scale selection and workspace save are captured in
light and dark through the actual horizontal host. These controls are part of
the open R05 comparison. Broader toolbar and utilities acceptance stays gated.

## Selected focus and horizontal source alignment

The same populated `Tenant dashboard` fixture was reviewed again in R01-R05,
in light and dark, at the recorded desktop/mobile viewports and zero scroll.
R01, R03 and R04 now keep the selected Fuse fill unchanged on hover/focus and
add the source-observed 1px keyboard outline: `#d1d5db` in light mode and 12%
white in dark mode. R02 preserves the source behavior with no focus outline and
uses the observed 8px folded corner. Route activation, right placement and
mobile drawer closure remain verified through the existing callbacks.

R05 now applies the source horizontal link rules rather than the vertical row
rules: 12px/400 text, 36px painted height, square corners, 4%/5% light
hover/focus and 5%/6% dark hover/focus. The activated native destination is
151.916px wide at x=1096.084; the recorded Fuse case is 151.953px at
x=1096.047. Both end at x=1248 and retain the 48px accessible target. The
selected painted pixel remains the registered navbar secondary color in both
modes. This is measured evidence, not a similarity percentage or acceptance.

Twenty-eight full native render cases, 45 workspace/navigation checks and 55
exact-history/boundary checks pass locally. The licensed source audit still
indexes 4,701 source files, 55 component families and 1,187 named examples.
R01-R05 remain IN PROGRESS because complete header/account controls, menu
behavior and whole-screen visual review still contain differences. R06-R25
remain NOT MATCHED; demo implementation remains blocked.

## Shared toolbar and language asset review

The R01–R05 native toolbar no longer repeats the PrimeCare tenant name beside
the navbar-owned brand. Desktop Layout 1, right-sidebar and folded views expose
the existing Theme Center text-size control, as the Layout 1 source does. The
horizontal view retains PrimeCare's separately requested save action. The
settings cog was removed from the toolbar because the existing footer Theme
Center action already opens the same registered drawer.

The language trigger now uses three locally authored, generated vector assets
(`language-flag-en-us`, `language-flag-fr-fr`, `language-flag-es-es`) through
the existing registered `prime_asset` illustration binding. This removes the
missing-glyph boxes seen in the first native render and avoids network images.
The account trigger is local and deterministic: it shows the active role mark,
label, info and chevron, and keeps role switching, maintenance authorization
and logout in the existing menu and handlers. No route, role grant, API,
account sync or production permission changed.

Source identities reviewed in this run:

| Source/case | SHA-256 |
|---|---|
| Fuse `ToolbarLayout1.tsx` | `d7ac110fbf4f36f378b495053abe38444bced392e788805b18e3c42e658d1711` |
| Fuse `ToolbarLayout2.tsx` | `a8b9e11f04fefee493156e71ccee30c1d90301ede42ccc8b73ec501dec7a5f4a` |
| Native Layout 1 desktop light capture | `5dfb7a392a9b5357627eff37621a989e90694c06d10636b378a62846eab655ee` |
| Native Layout 2 desktop light capture | `58230dc20a1c49a408d2579b79c779c4fb3f22c811499a217f2a413b4ff9d227` |
| Native left/folded/right/mobile selected cases | `cccbcf708fa9c5d27c55023a2d18554bf35103775389e99fa7f398cba0ceef3b`, `3776b8abfad59e755c6c9669b0359e7965a2de342bc162e5a92a4ea6225f070b`, `9e4e74f30d9a725f449869d207f6311898fa67292235619edc5f1d4fb834e866`, `13f48ff06213e8330177df3a77a56fcd116d22eb83aeea9971b6f72004a0e5d2` |
| Fuse Layout 2 desktop light capture | `b53a2ef96df0936472fe71e7f5c5226a28554ac124fbc0cfd4a44789bfedf37e` |

The current native toolbar still lacks the registered native host contracts for
fullscreen, navigation search, navigation shortcuts and the Quick Panel
bookmark. Those controls are BLOCKED; they were not rendered as decorative or
nonfunctional buttons. R01–R05 therefore remain IN PROGRESS, not MATCHED.

## Sidebar account placement continuation

The existing authorized account trigger now follows the complete Fuse shell
placement instead of appearing in every toolbar. Expanded, folded and right
desktop navigation render it at the sidebar footer. The mobile drawer includes
the same footer, while horizontal and hidden-navigation layouts retain the
toolbar trigger. The menu still uses the existing role-switch, maintenance gate
and logout handlers; no account, route, role, API or resource authority changed.

The expanded footer shows the active role, information control and upward
chevron beside the avatar. The folded footer keeps the compact avatar treatment.
Shared shell metrics own the divider, padding and spacing. Twenty-eight full-host
and sidebar render cases, 19 exact replay checks and the 32-test shared UI/theme
boundary suite pass locally. The screen-style unit suite also passes; its local
git comparison command cannot run against the checkout's absent historical
baseline object and remains a CI verification item.

This corrects a visible R01-R04 placement discrepancy but is not full-render
acceptance. R01-R05 remain IN PROGRESS pending aligned reference/native account
state, interaction review and complete side-by-side/overlay inspection. R06-R25
remain NOT MATCHED and demo work remains blocked.

## Authorized account-menu state capture

R01–R04 now open the existing authorized account menu from the sidebar or
mobile-drawer footer and retain the entire shell in the captured frame. R05
opens the same account state from the horizontal toolbar. Each fixture verifies
that the account trigger is on the expected surface, that the registered
`Sign out` action is visible, and that Escape closes the menu. The logout row uses the common Lucide
`square-arrow-right` equivalent and the registered `workspace.sign_out`
resource. Isolated test hosts fall back to the same English display text only
when no localization scope exists; a resource key is never accepted as visible
screenshot text.

The licensed source review uses `UserMenu.tsx` SHA-256
`97d42175449187df285f3a876e24fbc84c64ae91ff443bf44c0f234e91ca22af`.
The reviewed native light-state capture hashes are:

| Task | Complete account-menu frame SHA-256 |
|---|---|
| R01 | `8c0bffb77d280071cae865f75a16dd79d69e76d8ce0e27564780f24ab0f9f101` |
| R02 | `acc0d8fffbff47ae37195812fa8712dc299876d79e881cb6b7ccf70b4d39cdd5` |
| R03 | `12529929d4d6e0a6ff236b5ce123f36deab3ed2ac18361fa1e45f3f78fe62494` |
| R04 | `bc2bc7d755e3734208e4a3138f3e1c5eeb20771da9a8e3c851aa21b9d9375039` |
| R05 | `f58720ff94f357e1c04aefa61cf621e530df8f27a9e071a9bd224b1be75bcd04` |

The authenticated fixture now follows the source menu's single 128px-minimum
`Sign out` row, four-pixel corner, common `square-arrow-right` icon and neutral
foreground. The former registry-wide `Switch role` action was removed from the
shell because the layout receives no user-authorized role grant list. Removing
that ungranted action preserves the existing tenant boundary; a cross-role UI
must remain absent until it has an approved authorization source. Maintenance
remains restricted to its existing CEO/maintenance role condition.

The browser capture now records the actual visible popover paper rather than
the full-screen modal root, plus the trigger, text and full frame. Twenty-eight
native render cases, 22 exact replay checks and 40 shared-boundary checks pass.
The licensed component audit still records 4,701 sources, 55 families and 1,187
named examples. These are implementation and discovery checks, not visual
acceptance. R01–R05 remain IN PROGRESS; R06–R25 remain NOT MATCHED and demo work
remains blocked.

## Account trigger and popover geometry review

The R01–R05 account trigger now uses the exact visible source variants: a 56px
vertical trigger with a 40px avatar, a 40px folded trigger, and a 36px horizontal
trigger with a 32px avatar. The popover uses an 8px radius, a 128px minimum
width, zero internal menu padding, a 16px common Lucide sign-out icon and an 8px
icon gap. Desktop rows are 32px high; the mobile row is 48px high. The complete
native frames keep the registered PrimeCare name and smaller Home service slogan.

The following origins are asserted from the complete 1440x1000 desktop and
390x844 mobile captures, after opening the real account menu:

| Task | Reference trigger | Native trigger | Reference menu | Native menu | Status |
|---|---|---|---|---|---|
| R01 | `12,932 255x56` | `12,932 255x56` | `267,932 128x31.5` | `267,932 128x32` | IN PROGRESS |
| R02 | `4,952 40x40` | `4,952 40x40` | `44,952 128x31.5` | `44,952 128x32` | IN PROGRESS |
| R03 | `1173,932 255x56` | `1173,932 255x56` | `1296,932 128x31.5` | `1296,932 128x32` | IN PROGRESS |
| R04 | `12,776 256x56` | `12,776 255x56` | `246,776 128x48` | `246,776 128x48` | IN PROGRESS |
| R05 | `1113.484,78 134.516x36` | `1116.08,78 131.92x36` | `1117,114 128x31.5` | `1117,114 128x32` | IN PROGRESS |

R04 now uses the source panel's 16px right inset in the reviewed light and dark
390×844 cases. The shared metrics calculate a bounded launcher offset and retain
Flutter's menu route. The native drawer divider still consumes one pixel of
trigger width. The earlier native captures suppressed account-menu elevation.
The later overlay review restores a subtle shadow and records its remaining
differences.

R05's trigger is right-aligned to the same x=1248 content edge and its menu
origin matches the source. With the 16px info icon, the full native trigger is
about 2.6px narrower than the source account fixture. Text and trigger width
remain visibly different.

Source identities reviewed for this geometry pass:

| Source | SHA-256 |
|---|---|
| Fuse `UserMenu.tsx` | `97d42175449187df285f3a876e24fbc84c64ae91ff443bf44c0f234e91ca22af` |
| Fuse `FuseDefaultSettings.ts` | `5153b458e2c932b63c2c041e121cee94887b22f6fcee6dff8604b0e4a0473db5` |

This is measured component progress inside complete frames. It is not a
whole-view match claim. R01–R05 remain IN PROGRESS; R06–R25 remain NOT MATCHED,
and demo work remains blocked.

## Account menu CI repair and right-edge theme controls

GitHub run 45255382075 reported 28 screen-style violations on the account
geometry commit. The shell now retains the prior source around unchanged
presentation code and uses a shared frame for the account trigger decoration.
The fixed screen-style baseline comparison reports zero new findings in the
shell. All 28 existing render tests pass against their existing captures.

The reported pair of red buttons is visible in the authenticated Fuse frames
for R01–R05. The gear opens Settings and the swatch book opens color schemes.
Both launchers are BLOCKED pending their production control registration and
readback. The [component coverage](fuse-component-coverage.md) records the
source hashes, native counterparts and open behavior checks. R01–R05 remain
IN PROGRESS for complete-view acceptance.

## Account avatar, information icon and sign-out row

R01–R05 share the corrected avatar fill, using the active navigation or
toolbar background darkened by 5% per channel. R01, R03, R04 and R05 use the
source's 16px account info icon. R02 retains its avatar-only trigger. All five
opened menus use the source's 8px horizontal item inset. The reference icon
sizing comes from `FuseSvgIcon.tsx` SHA-256
`75d7f596bb4a1e60733bcd8286fc7e2904bf27a66ccc5ef5b0593251b53564d2`.

Render tests check glyph size or its folded absence, the sign-out icon inset,
and the existing account popover position and Escape dismissal. Sampled
avatar interior pixels match in the reviewed mobile and horizontal cases
in both themes. Remaining differences include account typography, menu shadow,
native host controls and incomplete whole-view state coverage. R01–R05 remain
IN PROGRESS.

## Account typography refinement

The desktop left, right and mobile drawer account labels use the shared Geist
default, 13px semibold text and the reference tight tracking. Folded navigation
keeps the avatar-only account trigger. Avatar initials and sign-out labels use
13px regular text across R01–R05. Native theme font-family and scale choices
remain in effect. The R05 toolbar role label retains its current token because
the 12px reference text alone increased the visible trigger-width difference
while its spacing was still unmatched.

The exact sources are `UserMenu.tsx`, `FuseDefaultSettings.ts` (hashes above)
and Vite skeleton `src/styles/index.css` SHA-256
`c4c6abe0fabc2ae5badffe65d57f2d069d65a8b8d6cc015a787d9f1cafdda85e`.
The native account menu shape, location, content, authorization and dismissal
remain unchanged. Typography progress keeps all five complete views IN PROGRESS.

## Drawer backdrop and account popover shadows

R04 now uses the same measured 50% black backdrop in the shared governance
scaffold. At (335,490) the populated 390×844 reference and native captures
both measure RGB (123,123,124) in light mode and (7,8,10) in dark mode.
Backdrop tap dismissal, drawer reopening, selected navigation activation and
the open account menu are exercised. The shared scaffold parameter is
optional and the governance scaffold applies it to both of its drawers.

The existing account popover uses a subtle native shadow in R01–R05. Capture
tests enable normal Flutter shadow rendering while opening that popover, then
restore their previous setting. All known menu rectangles and Escape behavior
remain asserted. The native shadow falloff still differs from the source's
multi-layer CSS shadow.

The source drawer is `NavbarStyle1.tsx` SHA-256
`97c2bc2a960c47c5a13f34d9a3eee1c83b72e998e983f893db368bed248190bf`.
The source popover and shadow tokens are in the previously hashed
`UserMenu.tsx` and `FuseDefaultSettings.ts`. All five views remain IN PROGRESS.

## Account keyboard interaction across the five views

The native render tests now reach each registered account trigger with Tab,
capture the visible focus state, open it with Enter and capture the menu.
They check that keyboard traversal reaches the existing Sign out item, the
unapproved Switch role item is absent, and Escape returns focus to the same
trigger. The cases cover R01–R05 in both light and dark. They do not execute
sign-out or use a live session.

The original Fuse browser capture now requests the corresponding keyboard
focus and keyboard-open frames, records focus return, and records an explicit
unavailable reason when the original renderer does not produce a state.
Those reference frames require a completed cloud run before paired keyboard
review. The existing pointer-open, navigation focus, hover and activation
comparisons remain separate. All five views remain IN PROGRESS.

The first Fuse R05 focus frames showed the Search overlay even though the
account trigger was the DOM focus target. The licensed Search trigger handles
Tab as an opening key. The capture now takes one reverse tab before re-entering
the trigger when Escape restored focus. It also checks the hit-test at the
center of the focused trigger before recording evidence. This applies to the
ten account cases and leaves the licensed source and key behavior intact.

### R01–R05 visible native account focus

PrimeCare's account trigger now paints a rounded keyboard focus outline using
the shared navigation focus color. The focus frame observes the existing
trigger and adds no tab stop. The test above still exercises Tab, Enter and
Escape through the registered control and checks focus return.

GitHub candidate `c1c0d9b47a491c372dd8257ec4dd7c0164a73616` passed
28 shell cases during capture and again during image replay in run
`45322223896`. Artifact `14888357285` supplies the ten changed focus goldens.
Inspection found the outline visible in light and dark across all five views.
The pixel changes are local to the focused account buttons. The menu frames
and other tracked shell states have no pixel changes. The registered
navigation fixture SHA-256 remains
`6c912c0164b5864f5af61aa03fd8fc60875eb011aed372ac1af287bfc92a0bae`.

The focus fill and R05 corner radius still differ visibly. R01 header spacing
and utilities, R02 alternate tabbed coverage, R03 right-rail and light popover,
R04 scrim contents and wider/RTL cases, and R05 missing toolbar controls and
trigger width remain open. All five views remain IN PROGRESS.

### Folded tabbed account control

The authorized account button is available at the bottom of the folded
tabbed rail. It uses the existing compact avatar, account menu, resources,
and permission checks. The rail scrolls its destinations independently of
the footer. No saved-layout values or navigation destinations were added.

The light and dark fixtures verify the 40px trigger, keyboard opening,
Sign out focus, Escape dismissal and return to the same control. Candidate
`83664894d83bd59efdb785a7d02ab937423ade15` passed the 28 shell fixture tests in
capture and replay, GitHub run `45328880802`. Artifact `14891022029` contains
the twelve folded-tabbed captures. The rest of the tracked shell images
showed no pixel changes. R02 and the other four active views remain IN PROGRESS.

### Folded tabbed row and horizontal account geometry

The selected folded-tabbed destination now starts at y=60 in the light and
dark desktop fixture. The previous PrimeCare row starts at y=64. The
shared 40px destination row aligns the selected tile with the reference
position and leaves the brand header in place. The desktop horizontal
account trigger now uses an 8px corner radius for its shape and focus
frame. Handheld account controls keep their existing compact shape.

Run `45335946807` completed successfully for pinned app commit
`57060a1581bea6be0d88ad39ac6c8d037a8bbf6f`. It captured and replayed 28
shell fixture cases. Artifact `14894017663` supplies the 18 changed native
images, all in the folded-tabbed or desktop horizontal cases. Decoded R01,
R03 and R04 pixels match the previously captured native fixtures. The
registered navigation fixture SHA-256 is
`6c912c0164b5864f5af61aa03fd8fc60875eb011aed372ac1af287bfc92a0bae`.

The folded multi-destination panel and horizontal account width and fills
still need review. The two theme launcher controls still need
production registration and independent readback before adoption. R01 through R05 remain
IN PROGRESS.

### Account keyboard focus across R01–R05

The original Fuse account button leaves the trigger interior unchanged on
keyboard focus. PrimeCare's extra Material focus fill is now suppressed on the
existing account trigger. Its separate outline uses the readable shell
foreground, which is stronger than the reference stroke. Menu rows keep their
existing keyboard highlight. The capture test checks the outline contrast
against the shell surface and exercises Tab, Enter, Sign out focus, Escape
dismissal and focus return.

Candidate `002b48cf89426bfc6314dde06afab2188b27c697` passed capture and replay
of all 28 shell fixture cases in GitHub run `45342762807`. Artifact
`14896024516` contains the 12 changed keyboard-focus frames. The changes are
confined to the account trigger bounds, including the folded-tabbed alternate.
The other tracked shell images had no pixel changes. The fixture SHA-256 is
`6c912c0164b5864f5af61aa03fd8fc60875eb011aed372ac1af287bfc92a0bae`.

The remaining differences include the R01 header and utilities, R02
multi-destination panel, R03 rail placement and menu hover, R04 wider and
RTL drawer states and scrim contents, and R05 toolbar surface, account width and
a right-clipped outline. The right-edge Settings and color-scheme launchers
still require production registration and independent readback. All five
views remain IN PROGRESS.

### Folded tile, drawer divider and horizontal focus edge

R02's regular folded navigation tile now occupies 32×32 px at (8, 60).
It previously lost one pixel of width to padding beside the divider. The
folded tabbed rail keeps its separate layout. The same tile correction is
visible after folding either expanded side. In R01 and R03 the expanded
selected rows remain 255×32 px at (12, 64) and (1173, 64), respectively,
as in the shared fixture's reference captures.

R04's 280 px mobile drawer uses the full drawer interior, as the licensed
NavbarStyle1 separates drawer paper from the divided desktop rail. The
selected tile and account button are 256 px wide in the 390px fixture. Its
existing menu remains at (246, 776) with size 128×48 px. R05's desktop
horizontal toolbar allows the existing keyboard outline to paint past its
inner edge. The 1px focus stroke now reaches x=1250 at y=96 in both themes
without moving the account trigger or menu.

Candidate `e8d4af7e803be2548211ca1ad10d67f325f167cb` passed all 28 shell
cases in capture and replay. Run `45350504375`, artifact `14899887710`.
The paired review uses Fuse artifact `14891323355` and shared fixture
SHA-256 `6c912c0164b5864f5af61aa03fd8fc60875eb011aed372ac1af287bfc92a0bae`.
The archive has 28 updated pairs and four native-only fold-toggle images
with their before frames. Those four still lack aligned Fuse toggle
captures.

All five views remain IN PROGRESS. Header and utility presentation,
multi-destination folded panels, the right menu shadow and hover, wider
and RTL drawer views, and R05's toolbar surface and account width remain
open. The two edge launchers still require production registration and
independent readback. Demo work remains BLOCKED.

### Account menu hover and the shared Sign out glyph

R01–R05 now have paired pointer-hover captures of the existing Sign out
row in both themes. The fixture keeps the same authorized destination,
account, locale, viewport and scroll state. The original menu item reports
a 4px corner radius and a hovered state. The shared native account row
now clips the highlight to 4px and uses the same
`lucide:square-arrow-right` identifier as Fuse. Account and routing
behavior are preserved. Keyboard opening, item focus, Escape dismissal
and focus return pass.

The light interior hover sample is RGB (229, 231, 235) on both platforms in
all five paired views. The dark sample is (43, 46, 51) in Fuse and
(44, 47, 51) in PrimeCare. PrimeCare keeps the registered palette.
Popover shadows, some label styling and the broader view differences
still need review. The alternate folded-tabbed hover has no matched
reference case.

Fuse hover evidence was captured from `4090f67e452548ba03c91cc05d2ebee5175ce967`
in run `45358757172`, artifact `14903203997`. The native final glyph candidate
`7ae7c00bf6717d5e8894d526c0e3e8a795cf636a` passed all 28 shell cases in
capture and replay, run `45359541145`, artifact `14904376010`. The same
licensed capture source, reference archive and navigation fixture were
used. The fixture SHA-256 is
`6c912c0164b5864f5af61aa03fd8fc60875eb011aed372ac1af287bfc92a0bae`.

The archive adds ten hover pairs and refreshes 22 open-menu pairs. Each
retains the exact source, case, hashes, full renders and difference images.
All five active views remain IN PROGRESS. Right-edge launchers and demo work
remain BLOCKED under their existing gates.
