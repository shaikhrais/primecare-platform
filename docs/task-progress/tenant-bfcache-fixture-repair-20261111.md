# Tenant browser lifecycle fixture repair

Batch summary: pair the tenant browser fixture's persisted pagehide with pageshow before attempting active layout and preference interactions. Preserve the production suspension, authorization and ownership guards.

Exact main 2f1631b9 browser and PostgreSQL jobs 130843327168/130843327134 reached the failed preference-save assertion and timed out. The fixture had dispatched persisted pagehide but never restored pageshow. The real tenant owner correctly ignored save actions while suspended. The preceding shared palette/bootstrap repairs remain necessary and unchanged.

The browser fixture now asserts that a suspended save creates no write or preference request, restores the same input node with persisted pageshow, and continues all existing failure, durable-draft, retry and database readback checks. A Node regression exercises the actual tenant entry and transport: suspended save is ignored, restored owner receives the 503 error, the tasks draft survives, and the saved overview/version remain unchanged. No timeouts or acceptance assertions are relaxed.

This is an acceptance-fixture repair, not a new capability. Source findings remain 0; feature acceptance remains 0/72 fully accepted and 72 pending. Browser/PostgreSQL acceptance requires fresh GitHub Actions execution. Native and other earlier-head successes are not promoted to this head.
