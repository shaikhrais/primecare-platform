# Shared table header ownership

Batch summary: retire sort callbacks when the existing PrimeDataControls table rebuilds headers. Reuse the existing abort-scope design; preserve current sorting, filtering, row replacement, columns, focus, theme, metadata IDs and host authorization.

## Confirmed defect and repair

Header listeners previously shared one controller for the entire table lifetime. Rebuilding headings detached old buttons but left their callbacks active, unlike the per-render row callbacks. Retained old sort buttons could change the current table's sorting after filtering or replacing data.

Each heading render now aborts the old header scope, creates a new scope and captures its signal. A callback rejects an aborted scope or disposed owner before sorting. Disposal still aborts the current controller through the existing cleanup. This also bounds retained event-listener ownership across repeated filtering, sorting, column configuration and paging resets.

## Evidence

Two new public-API Node DOM regressions fail on exactc44bc6f8 source: an old sort button changes model.sortKey after filter and after replace. Both pass after repair and prove current buttons still sort. Existing lifecycle, model, rich-range and upload-removal suites total28 passing checks (6+6+8+8). Shared TypeScript compiles; actual browser script parses; whitespace check passes.

The actual browser fixture retains a sort button before its first redraw, dispatches a click on that detached button, verifies both current sort key and direction are unchanged, and verifies focus on the replacement sort button. Existing large-table, selection, pagination, filtering, editor and upload checks remain. Real-browser and native execution stays in GitHub Actions; local DOM checks are not browser acceptance.

Pre-repair exactmainc44bc6f8 appearance43167904437,security43167904376,platform43167904362,boundary43167904404,contract43167904574 and workspace43168552825 all succeeded. Previous autocomplete sourceff749fed data-controls43167742398 and ThemeCenter43167741951 succeeded. These are predecessor receipts, not acceptance of this new code.

Strict findings previous0/current0/new removals0. All72 mappings remain reconciled;0fully accepted/72pending,0/344screens and0/147workflows promoted. Historical replay pins, source identities, native repair receipts and all thresholds remain unchanged.
