# Active full-render matching queue

The user retired the 200-microtask completion approach. Do not count isolated
width/height/test/capture passes as full rendered-view matches. Work on up to
five full-render tasks per iteration; report fewer completions when blocked.
Demo remains blocked until all required skeleton views/states are accepted.

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
