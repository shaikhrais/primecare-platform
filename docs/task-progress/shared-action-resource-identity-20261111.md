# Shared action resource identity

Batch summary before implementation: preserve the existing registered action identity when Flutter reuses its widget for another item. The control suffix is part of the registered semantics/test ID, but PrimeCatalogueAction currently invalidates asynchronous feedback only for scope, control and operationKey changes. Include suffix changes in that same epoch boundary. Clear old busy/status state for the new resource and ignore old completion feedback; do not cancel or replay already-started operations. Preserve SDK styles, focus ownership, callbacks, labels and authority.

Base main: 1c5fc4525bd8d15cc37f98ac9ebe393381f9c57f. Its boundary and contract gates pass; fresh workspace acceptance is running. The earlier workspace acceptance passed and publication correctly refused a stale head. Source reconciliation is complete (72 mappings); full acceptance remains 0/72. This batch adds behavior, not mapping or removal credit.

## Implementation and evidence

The existing action epoch now also changes when suffix changes. Four native regression cases cover pending old success/error while a new resource action is pending, and completed old success/error when a new resource is displayed. They require the new action to be enabled after identity replacement, old completion to leave new busy/status untouched, each callback to run once, and old feedback to clear. The shared controller does not cancel already-started operations. No API, data, registration, role decision or palette is changed.

The existing exact native source receipt is extended without changing its original SHA or any replay/amendment limit. Local historical migration, boundary and exact contract checks are recorded before publication; native execution must run in GitHub Actions. The scan remains 0 direct controls + 0 literal colors, previous0/current0/new removals0. Source mappings remain72/72, unreconciled0; fully accepted0/72,pending72; readiness0/344 screens and0/147 workflows. No feature/production acceptance credit comes from these source checks.
