# Shared page construction cleanup

Batch summary: release a failed page-template construction's resize subscription while retaining all metadata, slot ownership and route authorization checks. Both simple and carded presentations use this existing shared PageTemplateView.

Three public-API regressions failed on f7b875a3: rejected actor scope, malformed route metadata and overlapping content/sidebar slots each left an un-aborted window listener. Construction had subscribed before validating the initial update, and its caller could not dispose the object because construction threw. The constructor now aborts its render events and inherited control scope on failure, then rethrows the same error. No route, permission, palette or native implementation is changed.

Four Node checks now pass: the three failed constructors release their subscriptions, and a valid owner remains recoverable after a rejected update until explicit disposal. Recovery still requires a fresh authorized content slot; the old rejected slot is not silently reused. The original page route/model checks and all 288 oracle cases remain unchanged.

The actual browser acceptance suite adds the same three rejection paths using captured real AbortSignals and confirms the existing business input survives. Targeted page-template and cross-batch CI run the new lifecycle checks, with the pinned DOM test dependency and existing Playwright/native suites retained. Browser/native acceptance on the published head remains pending. Source violations stay 0; full feature acceptance stays 0/72 complete and 72 pending. No registration, grant, business data or readiness credit is created.
