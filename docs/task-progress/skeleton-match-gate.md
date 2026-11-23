# Skeleton matching gate

User directive: match every part of the Fuse skeleton before implementing demo dashboards.
Demo implementation remains blocked. Capture success, source registration and compile/test
success do not grant visual acceptance. Compare the same state, viewport, theme, language,
scroll position and data. Keep reference, native screenshot, overlay/difference and source
identity for each review. Do not silently accept typography or spacing differences.

Required scope: full shell/header/navbar/sidebar/toolbar/footer/content; every shared
component and asset; dialogs/drawers/menus/notifications; normal/hover/selected/focus/
disabled/loading/empty/error states; responsive layouts, light/dark, RTL/LTR; navigation,
scroll, resize, keyboard, save/restore and account isolation. Full-shell captures and
all-component/state acceptance remain open; the 42 settings captures cover only a subset.

First concrete correction: horizontal settings match the reference Above/Below baseline.
The existing extra Bottom toolbar choice is available under Advanced layout. If a saved
Bottom value is active, its selected option remains visible in the normal toolbar group.
No persisted value, public interface, route, permission or API changes. Existing tests now
exercise the advanced Bottom action and verify navbar independence.

Local validation: 22 targeted behavior tests plus 18 layout/device/mode capture cases
passed, producing 42 fresh native PNGs. Full skeleton visual acceptance remains open.

Second correction: the registered host now uses the reference shell bar metrics:
horizontal navbar 64px; toolbar/footer 64px from 768px, 48px below. Explicit
PrimeAppBar height and PreferredSize agree with the outer slot. Shared renderer
defaults and persisted layouts are unchanged. Four geometry tests at 390, 767,
768 and 1440px plus existing workspace/navbar checks pass (28 tests total).
Full-shell reference/native screenshot acceptance is still pending.

Tasks 6–7 continuation: original-shell capture host prepared with original
providers and unchanged Layout1/2/3 sources; 18 reference cases awaiting cloud
execution. Actual GovernanceMasterLayout fixture renders all 18 cases locally
and records shell/content/toolbar/sidebar bounds. Its account/navigation state
is not aligned with the reference. Avatar resource errors are retained, not
silently turned into successful image or matching evidence. Task 7 remains
partial and task 8 state alignment is open. Demo remains blocked.
