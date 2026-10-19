# Visible-state contrast follow-up

Owner: platform QA. Scope: the rendered admin, growth and paginated-history states in the existing local browser suites. The review uses synthetic records, headless Chromium on Linux, EN/FR/ES and 320/1440 CSS-pixel widths. These state counts are repeated role/language/viewport combinations, not counts of unique application screens or physical devices.

## Method and evidence

The normal accessibility report remains intact. With `ACCESSIBILITY_CONTRAST_REVIEW=1`, the test obtains live element references for incomplete colour-contrast findings, brings each element into view, and reruns the contrast rule against that element. It restores the window and affected scroll containers afterward, preserving the workflow being tested. The engine inspects discovered element references; workflow interactions retain their governed test IDs.

| Outcome | Meaning |
| --- | --- |
| `axe_pass_after_scroll` | The engine classified the original element as passing after it was brought into view |
| `axe_pass_with_control_probe` | The engine passed an editable textarea with temporary sample text |
| `supplemental_control_measurement` | A separate computed-colour measurement of a temporarily filled textarea; the original finding stays incomplete |
| `supplemental_graphic_measurement` | A separate computed-colour measurement for the known menu glyph; the original engine finding stays incomplete |
| `supplemental_text_measurement` | A separate computed-colour measurement for plain HTML text; the original engine finding stays incomplete |
| `unresolved` | Reliable classification or measurement was unavailable; retain for review |
| `violation` | A contrast failure was found; the test and summary fail |

Supplemental measurements accept opaque sRGB colours and reject opacity, filters, blending, background images, generated pseudo-content, unsupported colour formats, text shadows/strokes and table column styling that the calculation does not model. The target must contain simple content, with visible text-line sample centres that hit the actual element. This sampling is supplementary evidence, not a complete assessment of every rendered pixel or a human approval.

The calculation follows W3C's [relative luminance definition](https://www.w3.org/TR/WCAG22/#dfn-relative-luminance). The known menu glyph uses the [non-text contrast threshold](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html); plain text uses the [text contrast requirements](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html), including the large-text distinction. Comparisons use the unrounded ratio. Black/white and identical-colour reference calculations are checked during the run. SVG paint/background combinations remain for review when the engine cannot classify them.

Empty, editable textareas also receive a temporary sample of at most four characters, respecting the maximum length. The probe does not dispatch input events or submit the form. Value, selection and internal scroll are restored afterward; the existing draft and keyboard checks then continue. A native control measurement uses its computed text/background colours and a visible hit-tested control sample, with the original incomplete result retained.

## Reproduction

Run against standard PostgreSQL in CI, or use the repository's explicit local PGlite adapter for compatible local SQL checks:

```bash
ACCESSIBILITY_CONTRAST_REVIEW=1 PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-platform-history.mjs
ACCESSIBILITY_CONTRAST_REVIEW=1 PLATFORM_TEST_DATABASE_URL=postgresql://… node --test scripts/test-admin-growth-accessibility.mjs
node scripts/summarize-contrast-review.mjs
```

Per-state follow-up reports and their aggregate are saved under `test-results/contrast/`. The acceptance workflow enables the review for both suites and uploads that directory. The summary rejects missing outcomes, unknown statuses, inconsistent measurements and confirmed violations. Repeated occurrences across states are counted separately. Unresolved findings remain explicit; the workflow does not treat them as passes or change production-readiness tags.

The original scan history and broader limits are documented in [Histories and accessibility](HISTORIES_AND_ACCESSIBILITY.md). Manual SVG/overlap review, screen readers, physical devices/native parity, PostgreSQL CI execution and release/provider access remain separate gates.

## Local result — 2026-10-16

All **38 admin/growth checks** and **12 history checks** passed with contrast follow-up enabled. The completed runs reviewed **204 states** and **1143 candidate occurrences**:

| Outcome | Occurrences |
| --- | ---: |
| Engine pass after scrolling | 506 |
| Engine pass with temporary textarea text | 0 |
| Supplemental menu-glyph measurement | 98 |
| Supplemental plain-text measurement | 7 |
| Supplemental filled-textarea measurement | 62 |
| Unresolved | 470 |
| Confirmed contrast failure | 0 |

The lowest supplemental ratios were **5.47:1** for menu glyphs, **5.88:1** for plain text and **13.81:1** for filled textareas. Calculations use unrounded values. The engine still classified the textarea probes as incomplete; their passing computed-colour measurements remain separate from engine passes. All 62 temporary textarea probes restored the prior field state, and the existing draft/focus workflows continued successfully.

Unresolved candidates occur in 20 states: 464 SVG text labels, 2 paragraphs and 4 menu-button occurrences. Map text over layered geometry and content covered by open search overlays remain explicit review items. This queue contains unclassified findings, not confirmed contrast failures.

The summary gate was also checked with invalid evidence: empty input, missing outcomes, a confirmed failure and a below-threshold measurement all failed as intended. Workflow YAML parsing confirmed that both suites enable follow-up and publish its summary/artifacts.

Coverage uses the default governed theme. Custom themes, other engines, screen readers and physical devices have separate acceptance needs. Original findings and human-pending readiness tags remain intact. The work adds verification and CI evidence; no production record or deployment changed.

## Map readability continuation — 2026-10-16

The subsequent [map readability review](MAP_READABILITY.md) corrects visible city-name collisions, retains caption size while scaling and enlarges service-checkbox targets after a newly scanned selected-area view exposed target-size failures. It adds 18 overview/zoom/resize scans. The refreshed admin/growth reports and these map reports, combined with the prior unchanged history evidence, now total 222 states and 1,978 candidate occurrences: 1,093 engine passes after scrolling, 247 supplemental passing measurements, 638 unresolved and zero confirmed contrast failures. The unresolved queue includes 602 SVG text, 27 labels, 3 selects, 2 paragraphs and 4 menu-button occurrences. Broader selected-area coverage is why these totals are not directly comparable with the earlier run. Hidden/decluttered labels do not count as contrast passes, and manual acceptance remains pending.
