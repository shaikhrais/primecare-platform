# Tenant preference conflict fixture synchronization

Batch summary: remove a confirmed stale-form race in the actual tenant portal layout acceptance fixture. Production behavior and the conflict assertions are unchanged.

Exact source36a0ea042d9b2e2521bce21f74358f73d3b067ed passed workflow contract review43141530313 and strict boundary43141530366. Combined closure43141530327/job130929409632 failed at test-tenant-workspace-layout.mjs:68 waiting for the retained-draft conflict notice. Dependency installation completed; the failing command shared the install step.

Before saving, the fixture submitted the search form and waited only for value audit. That value was already present in the old form, so this condition did not prove the asynchronous refresh had completed. Save could run before redraw; the refreshed response could then replace the submitting form and invalidate its render generation.

The fixture now captures the old preference node before search and waits for a distinct replacement node with the same retained audit draft. This mirrors the existing node-replacement synchronization used earlier for save/readback. Conflict status, retained value, independent database view, explicit refresh cancel/accept, later in-flight draft and lost-acknowledgement checks remain unchanged. No timeout is raised, assertion removed or production code altered.

Validation: Node syntax check passes locally. Actual browser/PostgreSQL acceptance is pending GitHub Actions for this publication. Feature adoption counts remain0fully accepted/72pending,45source-mapped/27unreconciled; no source-migration removal credit.
