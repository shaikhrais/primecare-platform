# Shared queued-action lifecycle repair

Batch summary: guard queued component catalogue and shell utility callbacks at invocation time. Reuse both existing shared factories for all current consumers; no per-screen copies, routes, grants or business adapters.

Previously a click synchronously queued a promise callback, but disposal before the next microtask did not prevent the action itself from running. Both factories now recheck their owner before invocation. The catalogue also checks its captured epoch; shell utility buttons reject disabled controls before queuing. Already started operations retain their existing behavior and late error/success writes remain suppressed after disposal.

Validation: seven Node lifecycle tests pass and shared TypeScript compilation passes. Running the same tests against the previous implementations fails exactly the two queued-action regression groups. Tests also cover normal invocation, catalogue duplicate-click serialization, rejection and retry, owner replacement, and late fulfilled/rejected callbacks. Shell callback tests exercise the real button method in an isolated owner fixture; they do not claim authenticated host or full browser acceptance. Existing countdown and async-region checks remain intact.

The catalogue workflow now watches its shell utility test dependencies. GitHub browser/native acceptance for this publication is pending. No full feature-adoption credit: 72 tracked, 45 source mapped, 27 needing reconciliation, zero fully accepted and 72 pending. Existing strict scan count remains zero; this is a lifecycle repair, not a new bulk replacement count.
