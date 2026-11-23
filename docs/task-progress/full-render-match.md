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
