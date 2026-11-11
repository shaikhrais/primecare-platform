# Shared button families — 2026-11-11

## Summary before migration

75 constructor/style calls in 25 libraries. 67 are current strict boundary findings;
eight are in the existing shared implementation or theme definition. Do not count
those eight as backlog removals. Supported default/icon constructors and styleFrom
calls retain all parameters, layout, callbacks, focus, disabled states and styles.

Three foundation delegates own the Material implementations; existing PrimeButton
uses the same delegates. Public UI exports preserve the core -> foundation and
UI -> core/foundation graph. The public API was read from official Flutter 3.41.5
source, the exact version pinned in CI. SDK defaults are retained rather than
recreated, including icon layout and clip defaults. No theme/color defaults are
introduced; existing fixed colors remain visible.

Whole-file SHA-256 hashes plus exact edits reject source drift. Review, dry run,
apply, idempotence and exact reverse-byte validation precede main publication.
Native style/state/interaction/geometry parity and actual consumer compile tests
are required. The gate allows only the three underlying Material button families
inside their exact shared delegate file; all other controls/colors remain errors.

Starting findings: 1,060 = 279 direct controls + 781 colors.
Expected final: 993 = 212 direct controls + 781 colors.

## Verified source validation

All 75 exact edits applied in 25 libraries. Original whole-file hashes reproduce
from final source using reverse edits; callbacks, argument expressions and styles
remain unchanged. Existing trailing spaces on four touched lines are explicitly
represented in the reversible manifest. Full second utility pass has zero calls.
Earlier core primitive replay tests reverse the exact later button edits before
replaying their original text/icon batch; both historical hashes remain checked.

219 migration tests, 18 boundary tests and seven import-cleanup tests pass. The
three generated delegates reproduce exactly from the pinned public SDK API data.
Strict findings: 1,060 -> 993 = 212 direct controls + 781 fixed colors. No fixed
colors were hidden or removed in this batch. Native geometry/state/style/focus
parity tests and actual imports/references for every changed consumer are wired
into the existing core, UI, foundation and app CI jobs. Native execution is pending,
not accepted from local source validation. Source publication parts: 12/13 files.
