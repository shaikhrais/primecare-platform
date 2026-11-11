# Tenant dashboard ScreenManager entry boundary

Status: isolated, unpublished candidate. Not production-ready or browser-accepted.

## Existing behavior and bounded change

The specialized tenant dashboard previously entered ScreenManager only through the initial main.ts dispatch. Its authorized reads, hash navigation, refresh, forms, and delayed callbacks did not recheck presentation. Actual-module regressions reproduce missing entry registration, lost language/responsive connections, detached controls, stale replies and child transport ownership failures.

The existing tenant document entry now re-enters ScreenManager before protected reads, rendering and actions, and after awaited responses. It uses the existing catalog route and main.ts entry registration. Hash views do not become new registrations. Server allowedViews, canManage, canCreate, task actions, tenant/dataset selection and API authorization remain authoritative. The shared manager's existing ID and exact-route contract is unchanged.

Initial delayed reads honor the newest server-allowed hash, including repeated navigation while the first response is pending. Invalid hashes do not expand allowed views.

Per-root ownership, per-render handlers, session identity, document path/search, and rendered hash prevent old controls and callbacks from affecting a replacement. An old HTTP 401 cannot clear a replacement session or redirect a replacement owner. Current HTTP 401/403 retain their existing sign-in/denied behavior. A terminal presentation failure disposes child hosts and dialogs before showing the shared text-only configuration error.

A refresh response arriving after a task dialog opens does not replace its shell or strand its draft. The next explicit refresh fetches a newer snapshot. Work-host unsaved-change locks and dialog navigation guards remain in force. Preference drafts retain their existing tenant/user/role/dataset keys, durable retry body and request identity, original revision and demo workspace version, and newer edits during acknowledgment.

Persisted pagehide suspends actions and result processing without destroying task dialogs or work drafts. Restored pages recheck ownership, session and presentation before resuming. Nonpersisted pagehide retires the owner. These are simulated lifecycle checks, not real-browser BFCache certification.

The existing work host and theme preference host receive optional ownership/resume callbacks. Their actual transports check before dispatch and after completion. The work host reuses PrimeWorkModule through a local guarded render override; it does not fork its rendering, policies or session implementation. Theme migration save/retry cannot dispatch from a revoked parent. Standalone callers retain the prior behavior when optional ownership callbacks are omitted.

## Verification and fixture limits

- scripts/test-tenant-manager-entry.mjs executes the real entry, ScreenManager, tenant catalog/view, BaseSessionClient and TenantPreferenceDraft with controlled shell/theme/work-host boundaries.
- scripts/test-tenant-manager-children.mjs executes the real work host, PrimeWorkModule, WorkModuleSession, task adapter/streamed transport, theme host, preference client/transport and migration controls. Its DOM is an explicit synthetic fixture.
- Together these contain 117 checks. The same tests against the predecessor report 30 pass and 87 fail; the isolated candidate passes all 117.
- Existing tests/assertions are preserved. The direct-render tenant browser harness only gains the presentation setup that main.ts normally supplies, using the existing catalog preview theme, shared stylesheet and tenant entry. Its assertions and test scenarios are unchanged.
- Both existing TypeScript publication/release workflows include the new suites. Workflow inclusion is not evidence that CI or publication ran.

All project commands use an isolated environment without production database credentials. The final evidence records exact commands, source hashes, focused repeats, aggregate results, type checking, bundling and independent review. The full-entry strict type check still has the ten inherited diagnostics, with tenant entry line numbers shifted by this change. This is not a strict typecheck pass.

No browser launch was retried: the prior supported Chromium attempt was blocked by the execution environment before navigation, and jsdom is unavailable. Visual/responsive, keyboard/accessibility, real browser history/BFCache, complete aggregate CI, live PostgreSQL integration, production governance export, and release/deployment verification remain open. No routes, APIs, grants, governance records, production credentials or database data were created or changed. Nothing was committed, pushed or deployed.
