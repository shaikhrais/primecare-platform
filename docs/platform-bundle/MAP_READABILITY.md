# Territory map readability review

Owner: platform UI and QA. Scope: the existing platform/tenant administration territory board. Requirement: review actual screens, correct visual problems and retain before/after evidence. This is a local implementation with human acceptance pending.

## Corrections

| Finding | Correction |
| --- | --- |
| City names become tiny as the SVG shrinks | Resolve the governed caption size into rendered CSS pixels and compensate for the map scale |
| A city name can sit beneath a numbered marker | Measure rendered label and marker bounds; try nearby positions and omit a city name if none fits |
| Resizing or switching zoom can invalidate label placement | Recalculate on map resize; dispose observers and measurement elements when replacing the map or leaving the view |
| Selected-area service checkboxes have 13 × 13 pixel targets | Use the existing 24 pixel spacing token for checkbox width and height |

Labels remain within the map frame and clear of other visible city names and territory markers. The implementation uses governed caption, spacing and border tokens, including when they resolve from relative units. It does not move territory boundaries or numbered markers. Stable city, marker and measurement IDs are registered by `register-territory-governance.py` using the existing approved web image component adapter.

The picker, detail table and selected-area zoom remain the ways to inspect every territory. The compact mobile full map provides geographical context; numbered markers can still be small in that overview. Dense city names are omitted rather than stacked. Place-label placement is presentation logic. Allocation, permissions, tenant ownership, validation, audit and sale locks remain API-owned.

## Verification and evidence

The six EN/FR/ES browser cases start at 320 or 1440 CSS pixels. Each checks full overview, selected-area zoom and a resize to the other width. Assertions check readable city-label size, map containment, no label/marker intersections, no horizontal page overflow, preserved selection and the existing sold-area lock. Refresh checks ensure only the current measurement element remains. Every state also runs the normal accessibility scan and optional contrast follow-up.

Reproduce with the standard PostgreSQL fixture:

```bash
ACCESSIBILITY_CONTRAST_REVIEW=1 PLATFORM_TEST_DATABASE_URL=postgresql://… node --test --test-name-pattern='territory label readability' scripts/test-admin-growth-accessibility.mjs
```

CI already runs this entire suite and uploads its screenshots and scan reports. After-state screenshots are `test-results/platform-bundle/map-{language}-{startingWidth}-{overview|zoom|resize}.png`. The local before-state screenshots and the confirmed checkbox-target finding are retained under `test-results/territories/review-before/`.

Automated evidence covers headless Chromium on Linux, not physical devices or a human approval. Original SVG contrast findings remain incomplete when the scanner cannot classify layered paint. Decluttering is not evidence that all colour-contrast findings passed. Screen readers, other engines, custom themes, real PostgreSQL race verification and production deployment retain separate acceptance gates.

## Local result — 2026-10-16

The six final map cases passed all 18 overview/zoom/resize states, with zero automated accessibility violations. This includes a rerun after the selected-area scan exposed and prompted correction of the checkbox target-size failures. The broader admin/growth suite also passed all 44 cases; six of those are the same map workflows, so repeated runs are not additional unique checks. TypeScript validation, the main application bundle and governance export checks against both working and committed database copies passed.

The updated contrast aggregate combines the new map-state evidence and refreshed admin/growth evidence with the previous unchanged history evidence: 222 states, 1,978 candidate occurrences, 1,093 engine passes after scrolling, 247 supplemental passing measurements and 638 unresolved findings; zero confirmed contrast failures. Expanded selected-area coverage adds labels and selects to the unresolved queue. These are repeated occurrences across states, not unique screens or confirmed violations.

The final allocation regression rerun passed 16 checks with the independent-connection race explicitly skipped under the local single-connection PGlite adapter. The checks cover actual API writes, draft retry, sale locks, refresh, tenant read scope, audit rollback, uncertain responses and EN/FR/ES browser workflows. Together with the 44 admin/growth cases, this is 60 unique local passing checks; repeated map runs are counted once. Real PostgreSQL contention remains a CI gate. No live sales or production records were created.
