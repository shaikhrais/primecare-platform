# TypeScript production route presentation boundary

Status: isolated candidate, not deployed or production-approved.
Baseline: fad8a62e1a32c642df26f50c7b45b2c521c62800.

## Scope and ownership

The nine projects in websites/typescript/projects.json use the TypeScript entry selected by the production runtime policy. A Flutter-only manager does not cover this entry. main.ts now goes through the shared web ScreenManager for every existing route dispatch. The manager is presentation-only and cannot authenticate, authorize, choose tenants, call APIs or manufacture grants.

The existing route selection is retained, including its precedence and aliases. Public login, forgot/reset password and enquiry routes do not require a workspace session. Specialized feature routes retain their existing authentication and service policies. The fallback workspace host may load the authenticated workspace but its registration does not authorize a page. An unknown route still goes to the existing workspace denial path.

The TypeScript adapters are necessary because these renderers produce DOM/HTML, not Dart widgets. Their names describe existing dispatch implementations, not new production-governance records. No governance rows, routes, grants, endpoints, roles or production data are created by this change.

## Registration and connections

ScreenManager owns immutable screen identifiers, exact routes, kind and explicit adapter identifiers. Duplicate identifiers and duplicate routes within one snapshot fail. Snapshot replacement validates atomically. Entry-host and authorized-page snapshots are distinct scopes because the workspace host is only a loader, not a grant to display its target.

Every entry requires layout, theme, language and responsive connections before invoking the renderer. Connections must be synchronous; thenables are rejected rather than silently letting content render before a promise settles. The website bridge reuses:

- ShellEnvironment for scoped direction and route/scroll lifecycle.
- The existing portal/solid theme tokens and applyMediaTokens. Theme custom-property names use the same grammar as the governed exporter (--[A-Za-z0-9_-]+), including uppercase letters, underscores and digits. Existing shell renderers retain their BaseLayoutManager, account-scoped Theme Center, validated preferences and customization behavior. The bridge does not create a second personal-profile store or reset personal themes on each workspace draw.
- LiveScreenText and the existing en/fr/es locale selection. These currently supported languages are LTR. This change does not add RTL languages or missing translations.
- The actual shared production stylesheet through an explicit computed-style handshake. Missing CSS fails before route content is rendered; breakpoints are not copied into a new manager.

Raw HTML feature renderers now use a default-only BaseLayoutManager from the same ownership map as Theme Center. The manager applies real layout/theme values to the raw root without injecting navigation or chrome. Public defaults do not read/write personal profile storage. Shell composition reuses this owner, and an account-scoped Theme Center replaces it only after the existing renderer supplies its verified profile scope. Subsequent route checks attach the account owner without resetting personal/tenant tokens. Raw layout CSS consumes content width and compact-spacing values; bespoke feature CSS may still override inherited tokens.

Recovery now uses LiveScreenText label-only bindings for its existing auth catalog and matching password_recovery keys, preserving input values, handlers and in-flight submission state. Unregistered policy keys retain bundled fallback text. Public enquiry uses the same binding service and normalizes the incoming locale instead of unconditionally resetting to English. Catalog updates touch explicit leaf text only; locale-change redraws retain drafts and consent checkboxes. Versioned consent/sharing statements and the health-information/emergency guidance in enquiry_note remain sourced from the bundled contract, not cached or live editable overlays. Replaced roots and non-BFCache pagehide unsubscribe bindings. growth_enquiry is not registered in the current server text manifest: its translations are bundled fallbacks unless a validated local catalog exists; this patch does not create governance rows or enable a server editor for it.

This remains an incremental migration, not complete localization/theme coverage. Raw PSW workspace/request content and several specialized shell bodies still contain hard-coded English or fixed colors. Their layouts now have shared default ownership, but translating every label and replacing every bespoke color requires explicit adapter work and browser review.

## Authenticated workspace boundary

Only the authenticated workspace response's screens array is registered, using governed:<existing code> identifiers and the existing exact routes. Neither the broader inventory nor public portal manifest supplies authorization. The existing special /success account view remains an explicit feature adapter after the workspace session and tenant checks. Internal calls require their permitted communication screen before their existing renderer is invoked.

Every workspace redraw, including Back/Forward and in-page navigation, re-enters the manager. Missing registration or connection replaces prior content with a text-only developer error. A refresh first removes the old workspace registration snapshot. A per-root load generation prevents older same-session responses, error callbacks and draw/subscription callbacks from replacing a newer authorization snapshot or failure. Account changes also remove the snapshot and clear content before reloading.

The server workspace handler is unchanged: it still validates token syntax, active session, active account, tenant presence, cross-tenant headers, allowed query fields and screen grants. API-specific renderers retain their own backend policies. Registration never adds a page to the server-filtered list or changes an HTTP 401/403 into success.

## Verification

- 17 boundary Node tests cover missing registration, each required connection, exact-route matching, duplicate/atomic snapshots, mutation isolation, old-actor snapshot removal, every production entry dispatch, public-auth separation, asynchronous errors, authorized workspace navigation, forbidden inventory-only routes, calls, /success, failed refresh and changed session.
- The main.ts and workspace.ts integration tests execute those actual modules with stubbed renderer/DOM dependencies. These are not real-browser end-to-end tests.
- 24 existing tests pass across auth-client, auth-session-tenant, workspace server authorization and screen-text cache.
- Seven additional DOM-fixture tests cover shared default/account ownership, raw theme/profile application, non-persistence of public defaults, escaping, subscription teardown, BFCache handling, actual recovery duplicate-submit/state preservation and actual enquiry draft/locale/consent preservation and rejection of persisted/live safety-copy overrides. They are not real-browser tests.
- The complete main.ts esbuild bundle passes. The three new TypeScript modules pass strict typechecking.
- Full-entry strict typechecking reports ten diagnostics identical to the pinned baseline. The diagnostics concern existing growth counts, missing .mjs declarations, maintenance text indexing and nullable tenant-dashboard values.
- Existing direct-workspace browser/audit harnesses now explicitly install their required presentation setup. The JSDOM test cannot run in the current environment because jsdom is missing. Review located Chromium 156 at /usr/bin/chromium, but both permitted launch attempts failed on environment socket/ptrace EPERM restrictions. This is a launch restriction, not a missing executable. Visual/responsive screenshots, keyboard behavior, end-to-end MFA and real browser Back/Forward remain unverified.
- The new Node suite is included in the TypeScript publication verification and existing release verification workflows. Neither workflow was run remotely.

No production build/export was attempted: it requires the pinned governance authority and release setup. No live production route, PostgreSQL tenant integration, deployment, full repository aggregate CI or complete screen inventory was verified here. This candidate must not be described as complete production coverage or ready for release without those checks and adapter review.
