# Shared sidebar and care alert styling recovery

The recovered source applied sidebar background and mobile hiding rules to every `aside` element. Existing care staffing warnings, coverage exception notices and correction notices also render as `aside` elements inside the content area. The component regression reproduced a hidden staffing warning at 320px before the fix.

Sidebar background and responsive visibility now apply to `.app-shell > aside` only. The existing shared shell, top bar, content view, governed alert identifiers, theme tokens and EN/FR/ES resources are reused. No role, permission, route, API, component or translation was created.

`test-sidebar-content-browser.mjs` renders the real shared shell and care detail components with synthetic component data and theme values read from the local governance database. All 15 locale/viewport combinations pass: EN/FR/ES at 320, 768, 1024, 1025 and 1440 pixels. Each combination checks all three alert types, for 45 alert renders. Mobile cases also check sidebar toggling, Escape dismissal, focus return, close-button dismissal and continued alert visibility. Desktop cases check the visible sidebar and hidden mobile toggle. Every case checks horizontal overflow and uncaught page errors.

Run `node scripts/test-sidebar-content-browser.mjs` with the project Playwright browser environment. The source-bound result and a synthetic 320px mobile recording are written under `test-results/care/sidebar-content/`; CI runs the check and uploads that directory through its existing care evidence artifact.

This is component-level evidence, with `wholeTaskVerified=false`. It does not establish role login, API/database workflow effects, full accessibility acceptance, PWA acceptance or release readiness. No whole-workflow or role-duty count is advanced. Remote CI has not run here, and the deleted historical verification receipts are not restored by this increment.
