# Shared populated-calendar density

Batch summary before implementation: repair the shared calendar's seven-column layout when populated task cards, buttons and enlarged text cannot fit seven narrow cells. Give day cells usable content width inside a calendar-owned horizontal scroll region in both web and native renderers. Preserve the 42 date identities, first weekday, localized labels, task data, all task actions and adapter permissions. This is a responsive foundation change, not an appointment workflow or full adoption claim.

Base main: `24107568c56866ce2fd89fa9941d8e4fa30788b8`, the native calendar metadata declaration repair. Earlier exact-head Windows analyzer failure was two test declaration errors; it did not execute the calendar widgets. New native/browser acceptance must run in GitHub Actions. Source findings remain zero and all 72 features remain pending full acceptance.

## Confirmed accessibility failure and repair

On exact metadata-repair head `24107568`, Windows job 130899590169 compiled and ran 26 existing tests successfully, but all six new locale/weekday cases failed because no independent full-date semantics node existed. Date number Text semantics were merged into their surrounding region. Each rendered date label now has its own semantics container. The regression scrolls that actual date into view, then reads its rendered semantics node and requires its exact full localized date, not just a source property or a substring of a combined label.

The same shared calendar now gives populated day cells minimum usable width inside its own horizontal scroll viewport. Web width is relative to inherited text size (`10em`); native width scales through MediaQuery's text scaler. The accessible web region uses the already localized displayed month as its name, is keyboard focusable, and has a real-browser ArrowRight scrolling assertion. No page-wide horizontal overflow is accepted by the browser fixture. The native populated regression retains the actual task and checks horizontal scrolling/no overflow at 320/600px and 1x/2x/3x text. Locale/date regressions still cover all 24 native locale/weekday/width/scale combinations; none are removed.

Local validation: 21 public web-renderer checks, 284 exact historical migration regressions and 28 boundary tests pass; strict findings remain 0. Native and real-browser checks are authored and wired for GitHub Actions, pending execution on this batch. The existing native source receipt is extended reversibly, preserving its original SHA and all underlying historical hashes.

Counts remain source previous 0/current 0/new removals 0; fully accepted features previous 0/current 0/new 0, pending 72. Source mappings 45/unreconciled 27. Release readiness 0/344 screens and 0/147 workflows. These responsive/accessibility changes do not create appointment scheduling or authorize any business operation.

## Native semantics test cleanup

Exact `a09e91c9` Windows job 130901882704 reports no analyzer issues and 27 passing tests, including the populated-calendar regression. All six localized-date cases reach the end with their date/layout assertions passing, then fail Flutter's end-of-test check because the explicit SemanticsHandle is still active. A registered addTearDown callback runs too late for that check. Dispose the handle in a test-body finally block, after unmounting the module and disposing its session. All exact date, locale, layout and mutation assertions remain unchanged; no production change or acceptance credit is added. A fresh native run is required.
