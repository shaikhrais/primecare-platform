# Shared autocomplete result ownership

Batch summary: bind existing shared autocomplete pointer selection to the exact request generation that rendered the option and require a currently visible result list. Preserve the public API, metadata IDs, theme, query/abort behavior, current pointer and keyboard selection, and host-owned selection callback.

Two public-API Node DOM regressions fail on a07fb2b0's shared source. A detached old option invokes its handler against the current result array, selecting a different result at the same index. A hidden option can also invoke selection after Escape/blur. The shared choose function now rejects stale request generations, hidden lists and dead owners; each pointer handler carries its rendering request number. Keyboard selection uses the current request through the same function.

Both regressions pass after repair, alongside the two existing table/retry lifecycle tests. The actual browser form fixture now retains an initial option, changes queries, dispatches its detached pointer event and verifies no selection or input mutation; the existing current-result keyboard selection still follows. No local browser/native execution; existing data-controls CI runs the Node and browser suites and all three native OS suites.

Local evidence:4 lifecycle +6 model +8 rich-range +8 upload-removal =26 Node checks pass. Shared TypeScript compiles; browser script syntax/whitespace pass. Source findings previous0/current0/new removals0;72mapped/0unreconciled,0fully accepted/72pending,0screen/workflow readiness credit. Native repair receipts and historical replay dependencies remain untouched.
