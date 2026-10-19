# Care loading and retry recovery

The recovered care renderer displayed initial loading outside the shared layout. Initial failure had no retry control, and a cached refresh error could remain visible after a later successful response. The new regression reproduced the missing shared shell before the fix.

The shared shell now supports optional `hideChrome` presentation state. Sidebar and top bar remain part of the layout but are hidden when requested, and content uses the available width. Subsequent renders can restore chrome without rebuilding the entire shell for the same identity. Existing callers retain the default visible chrome behavior.

Care loading and initial errors reuse this shared layout with chrome hidden. Loading exposes `aria-busy=true`; the error state sets it false and offers the existing governed `care-refresh` button and workspace link. Retry returns to loading and then displays the usual authenticated layout when a response succeeds. A successful refresh clears a previous generic load-error notice. Existing permission/session handling, routes, controls and EN/FR/ES resources are preserved.

Six browser renderer cases pass: EN/FR/ES recovered-screen states at 320 and 1440 pixels. They use controlled synthetic HTTP responses with the real renderer and session client. A delayed first response allows checking the loading layout; 503 checks initial error/retry; a valid empty response restores chrome; a transport error keeps existing content visible; successful retry clears the notice; 403 removes cached content before another permitted response. Initial startup uses the existing default EN locale. Recovered pages and subsequent errors exercise EN/FR/ES. Every case checks six requests and uncaught page errors.

The shared-shell regression also passes 15 locale/viewport combinations and 45 alert renders, with new same-identity chrome hiding/restoration checks. Worker and website TypeScript checks and governance reproduction validation pass.

Run `node scripts/test-care-loading-browser.mjs` and `node scripts/test-sidebar-content-browser.mjs` in the project browser environment. Source-bound results and a synthetic mobile diagnostic recording are under `test-results/care/loading/`; shared-shell results are under `test-results/care/sidebar-content/`. CI runs both checks and uploads these directories through its existing care artifact.

These are renderer/component tests, with `wholeTaskVerified=false`. Synthetic sessions and HTTP responses do not establish real role login, database-backed workflow effects, full accessibility, native PostgreSQL concurrency, PWA acceptance or release readiness. No completed role-duty or full-workflow count is advanced. Remote CI has not run here. The deleted historical branch and evidence remain unavailable.
