# Shared data action states

Batch summary: preserve actual shared table first/last-page disabled states after a pagination action and restore polite status semantics during retry/success after a failed data action. Reuse `PrimeDataControls`, its existing `pc-idle` reconciliation event and domain table model. No new component factory, palette, API, business permission or metadata registration.

## Regression and implementation

The common button completion handler temporarily re-enables a button before emitting `pc-idle`. Upload consumers already reconcile their domain state on this event; pagination did not. After clicking Next to the last page, the table's correct disabled state was overwritten. Both pagination buttons now redraw from the actual model on the same event, using the existing owner abort signal. Disabled controls reject further actions; filters and paging data remain unchanged.

A failed data action marks its feedback `role=alert`. Retry reused that span without resetting the role, so loading and successful feedback remained urgent errors. Action start now restores `role=status`; rejection still sets `role=alert`. Busy serialization, late completion suppression, callbacks and unbound controls retain their behavior.

## Evidence

Two public-API Node DOM regressions fail on the exact previous shared source: last-page Next is enabled, and retry still has the alert role. Both pass after repair. The tests construct the real shared table/form, check first and last page boundaries, reject clicks on disabled boundaries, and verify error/loading/success roles, busy state and serialized retry.

Local checks:2 new lifecycle +6 existing model +8 rich-range +8 upload-removal =24 passing Node checks. Shared TypeScript compiles and browser script syntax checks. Actual browser cases now check the same pagination boundaries and error-to-success role through the existing fixture. CI installs pinned Linkedom0.18.12 for model regressions and retains its real browser plus native three-OS suites. No local real browser or native execution.

Strict findings previous0/current0/new removals0. All72 source mappings remain reconciled; full acceptance0/72,72pending. No screen/workflow readiness credit. Historical source replay pins and native repair receipts are untouched; this is a web shared behavior repair.
