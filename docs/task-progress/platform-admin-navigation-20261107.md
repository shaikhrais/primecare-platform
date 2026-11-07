# Platform administration navigation integration: 2026-11-07

## Scope and authority

This isolated candidate connects existing `platform-admin.ts` sidebar destinations to initial URLs and browser history. The source inventory is the already rendered sidebar, not a new screen catalog or permission source. The existing platform administration response supplies `role`, `canCreateTenant`, `canViewReports`, `canViewTerritories`, `canViewOperations`, `canViewBundle`, `extended`, and `canViewTraining`; the existing call capability and code-admin demo availability still control calls. Vapi remains code-admin-only. Server authorization remains authoritative.

No database records, routes, roles, grants, screen metadata, themes, translations, approval controls or mutation confirmation fields were added or changed. This batch does not claim that the entire Screen Management System or production governance cutover is complete.

## Reproduced defects

Before implementation, three actual-module fixtures failed:

- Initial `#appearance` rendered the tenants dashboard rather than appearance.
- Clicking the appearance sidebar link changed the view but not the URL.
- Clicking a sidebar link during a pending parent operation changed the eventual view despite the operation's busy guard.

The preserved pre-fix evidence is `pre-fix-navigation.log` in this batch's sibling evidence directory.

## Implemented behavior

- Sidebar rendering and navigation share the existing filtered list. Initial hashes, normal clicks, command-palette entries, dashboard links and history traversal use the same capability and tenant checks.
- Existing hash destinations include tenants, tenant-selection, launch, onboarding, documents, support, accounts, masters, audit, reports, territories, operations, bundle, text, training, appearance, and role/capability-controlled Vapi and calls. No new hash alias is introduced. `tenant-selection` continues to render the existing organizations view; `#organizations` and `#account` remain unknown.
- Unknown, noncanonical and hidden destinations retain their supplied hash without calling the protected destination. They show the existing permitted landing view (tenants when creation is available, otherwise organizations). They do not silently default to bundle, territories or another protected feature.
- Accounts, masters and audit require a selected tenant. A direct hash without one renders organization selection and keeps the hash, allowing selection to complete the requested navigation. The existing tenant-admin initial selection remains intact.
- Accepted explicit tab navigation pushes at most one new entry and preserves unrelated query context, current language and the semantics query. Repeated same-view navigation does not reload or create duplicate history entries. Actual native tab hrefs identify `/platform/administration` even while embedded account is open, so modifier/new-tab navigation reaches the correct dispatcher.
- The existing embedded account rendering is preserved. Its accepted navigation uses the existing `/success` URL in same-document history and retains sidebar close, scroll and heading focus behavior. Back returns to the admin view. Fresh `/success` loads still use the unchanged main/workspace dispatcher and existing role redirects.
- Parent operations and existing bundle, operations and territory operations own the current view and selected tenant until settled. The three nested controllers expose only a read-only getter for their existing busy state. Mutation code, draft capture/restore, confirmation payloads, idempotency and permission logic are unchanged.
- Busy explicit clicks are rejected before modifying tenant, view, URL or controller workflow. Native Back/Forward already changes the browser's history index, so it is deferred rather than rewritten. The latest traversed URL is reconciled after parent work settles, or by a 50 ms owner-scoped check while a nested controller remains busy. During that wait the URL may differ from the operation-owned visible view. Existing entries are not replaced and no new entry is added. Mutation-success navigation cannot overwrite a queued native traversal. A newer accepted explicit click after work settles supersedes the queued traversal.
- Same-root remounts retire old history/live-text/input listeners. Detached roots and unrelated paths release ownership. Retained handlers and late parent responses cannot render over a replacement owner or clear a replacement session. A persisted BFCache restoration disposes and clears the old view, then reloads for fresh server capabilities; it does not assume that an unchanged token means unchanged permissions or replay mutations.

## Validation

Run the focused fixture without inherited secrets:

```sh
env -i PATH="$PATH" HOME=/tmp node --test scripts/test-platform-admin-navigation.mjs
```

The focused suite passed 63/63 tests. Running the same suite against the unchanged preceding candidate produced 54 expected failures and 9 passes (exit 1), preserving a broad negative control in addition to the original three pre-fix reproductions.

The suite executes the actual platform-admin module with deterministic peripheral HTML/HTTP fixtures and the actual nested-controller `run()`/busy lifecycle with isolated clients and panels. It covers initial/rendered destination equivalence, hidden/unknown destinations, tenant requirements, repeated and interrupted navigation, real history-stack indexing, deferred parent and nested mutations, rapid Back/Back/Forward and duplicate popstate/hashchange events, account/native hrefs, locale/query preservation, capability downgrade, late reads, session replacement, remount, detachment and persisted restoration.

The existing deploy and release workflow test blocks now each contain a separate `env -i PATH="$PATH" HOME="$RUNNER_TEMP" node --test scripts/test-platform-admin-navigation.mjs` invocation. All inherited production database and Cloudflare environment values are absent from those fixture processes. Existing approval, build and deployment controls are unchanged.

## Limits and remaining release work

- Synthetic fixtures prove bounded navigation/control-flow behavior. They are not JSDOM, real browser, Cypress, visual layout, accessibility acceptance or production evidence. JSDOM was not installed/cached and the previous official registry attempt failed DNS; no retry or alternate install was used.
- Peripheral mounting and form rendering are intentionally stubbed in the navigation fixture. The nested busy lifecycle runs actual controller code, but full nested forms, network mutation transports and confirmation UI remain subject to their existing suites and browser acceptance.
- Parent owner/session checks guard navigation entry and late parent responses only. They are not a migration of every legacy raw transport, background dashboard, embedded account, reports, dialer, Vapi or screen-text controller to a unified cancellation/session boundary. Those transport/lifecycle gaps require separate scoped work.
- No live database, production credential, real tenant/user data, schema write, install, commit, branch, push or deployment was used. Full required CI, production metadata gates and browser acceptance still need to run on an authorized release candidate before release readiness can be claimed.
