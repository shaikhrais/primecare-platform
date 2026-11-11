# TypeScript tenant dashboard token inheritance

Isolated review candidate based on `fad8a62e` plus the cumulative TypeScript manager patch SHA256 `c853a44e829960dfad648b7a7cf98a56229c93f6ab47bbd582717a5797dc0841`. Not committed, published, deployed or production-approved.

## Scope

The existing main dispatcher selects `renderTenantDashboard` at the exact `/tenant-dashboard` path for all nine TypeScript project entries. Its shared shell already uses `BaseLayoutManager`; this patch connects the specialized tenant body and task dialogs to that manager's existing CSS tokens. It adds no route, registry row, permission, API, feature control or language resource.

- Body, headings, table text, captions and task dialogs consume the shared font family and size tokens. Theme Center font scale reaches these tokens through the existing theme manager.
- Cards, ordinary controls and dialogs consume the existing radius tokens. Cards and grids consume spacing tokens; the shell's compact density selects its existing medium spacing.
- Only a direct tenant root inside `.tenant-dashboard-main` loses its catalog width cap. The shell still owns content width. Standalone preview/error roots retain the catalog cap; dialogs retain their viewport width and scrolling limits.
- Cards, surface-backed controls and dialogs use their surface foreground/muted tokens. Main-background content retains the main foreground pair. Existing primary-action and status-badge semantics remain.
- Only the exported `tenantStyles` string changes in runtime code. All rendered markup, escaping, form event handlers, draft persistence, tenant/account guards, navigation/history, permission filters, transport and mutation logic are unchanged.

The style export is shared with existing standalone HTML consumers. They gain compatible token support and retain catalog fallbacks. This is not a new manager or a profile-storage mechanism.

## Verification

`node --test scripts/test-typescript-screen-manager.mjs scripts/test-typescript-presentation-bindings.mjs scripts/test-tenant-dashboard-preference-draft.mjs scripts/test-tenant-presentation-tokens.mjs scripts/test-auth-client.mjs scripts/test-auth-session-tenant.mjs scripts/test-screen-text-cache.mjs scripts/test-workspace.mjs`

Result: 71/71 pass, including six new focused contracts. They parse the CSS, exercise the actual shared manager on a deterministic element fixture, check token wiring and existing visibility/focus/scroll rules, and render escaped forms and permitted controls. They are not browser computed-style or full tenant runtime tests. Existing tests cover draft retry/account isolation and presentation boundary guards. Both existing TypeScript release workflows include the new focused suite.

The actual main.ts browser-target esbuild bundle passes with zero warnings. Full-entry strict TypeScript still reports the same ten pre-existing diagnostics as the cumulative baseline; logs match after normalizing the candidate path. It is not a green full typecheck.

No browser was launched for this patch. Prior environment evidence records Chromium socket/ptrace EPERM, and this work did not retry through a different route. Real visual geometry/contrast, mobile at large font scales, keyboard/focus, Back/Forward and interrupted authenticated tenant forms remain unverified. Existing PostgreSQL/browser suites were not run. No production governance export, aggregate repository checks, remote CI, deployment or live credentials were used.

## Remaining gaps

Tenant feature text remains largely English; this patch does not add localization. Fixed inner margins, some control padding, icon sizes, pill/avatar shape and the existing mobile breakpoint remain. Nested optional work modules have their own styles and are not a complete migration in this patch. No full cross-renderer or website-completion claim is supported.

## Follow-up: root banner and neutral-badge contrast

A separate overlay after the original tenant token candidate fixes a pre-existing contrast gap. For a permitted personal theme with background `#ffffff`, surface `#777777`, text `#172033` and muted `#526078`, root-level paragraph banners previously selected main-background muted text (about 1.42:1), and neutral badges selected main-background text (about 3.63:1). Cards/dialogs already selected the safe surface pair.

The overlay uses `--color-surface-text` for `.td-root .td-banner` and neutral `.td-badge` text. The banner selector outranks `.td-root p`, so the generic paragraph rule cannot restore the unsafe muted text. Both now resolve to black on `#777777` (about 4.69:1). Backgrounds, warning copy, border cues, markup and handlers are unchanged. Good-status badges retain the existing primary/on-primary pair. No new theme token or manager behavior was introduced.

Two added executable tests use the actual shared manager and contrast helper, plus a restricted source-selector cascade fixture. They cover the reported theme, all 37 accepted presets, default/light/dark profiles, good-badge precedence and legacy foreground fallback. They are not browser computed-style evidence or a whole-screen accessibility audit. The combined local suite passes 73/73. Browser, authenticated tenant journeys and production limits above remain unchanged.
