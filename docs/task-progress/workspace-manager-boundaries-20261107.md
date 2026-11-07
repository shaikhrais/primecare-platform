# Workspace Screen Manager ownership boundaries

Date: 2026-11-07
Status: implemented and tested with isolated synthetic integration fixtures; not released.

## Purpose and existing scope

Keep the existing generic TypeScript workspace, account settings, registered report panels and internal calls attached to the screen owner that created them. A missing layout, theme, language or responsive connection must leave a terminal configuration error, not active callbacks or a later successful repaint.

This changes lifecycle and presentation integration only. Workspace screens, actions, role grants, tenant filtering, account permissions, report contracts and call authorization still come from the existing authenticated server responses and registered policies. No screen, route, API, permission, localization resource, design token or governance record is introduced. The broader inventory remains informational and never grants navigation.

The affected business flow is the existing authorized workspace: load its granted screen snapshot, enter the selected screen, use its controls, and navigate or leave without an old screen acting on its replacement. Existing account security, report export/email and communication flows retain their server contracts.

## Confirmed defects

Before this change, a Screen Manager connection failure cleared the workspace HTML but did not retire its owner. Retained training, refresh, logout, export and navigation callbacks could still run. A repaired connection followed by history traversal could repaint the failed owner. Live-text subscriptions accumulated across remounts, and the workspace assigned the global history-handler property.

A pending logout could remove the active same-token session after a remount. Actual report PDF completion and password-change completion could also download or redirect after their workspace had failed. Calls startup could continue after losing a presentation connection.

These were reproduced with real application modules and deterministic synthetic peripherals. They were not discovered through, or accepted by, a real browser run.

## Implementation

- Terminal configuration failure retires the current owner, clears only its workspace registration scope, closes owned calls, invokes available account/panel disposers, and removes its live-text, input and history bindings.
- Parent controls capture their render version and accepted route. They check ownership, session and the exact current governed/account presentation before acting. Retained controls from a replaced render cannot act on the replacement.
- Async parent logout completion cannot remove a session, redirect, change a removed control or overwrite the current error after losing ownership.
- Workspace history uses an owned event listener. It does not replace or clear another component's `onpopstate` handler.
- Initial grant reads and their completion/error paths validate the existing dispatcher entry installed by `main.ts`. A per-root cache is populated only after successful validation. That original document entry remains fixed across workspace SPA paths; current governed/account registrations continue to enforce accepted screen paths. Missing registrations are never silently recreated.
- Cached reports accept an optional owner/presentation callback and lifecycle hooks. Same-screen shell redraws and navigation return preserve report state and drafts. Hidden or retired report work cannot download files, send new requests or commit accepted-email state. Terminal retirement disposes the panel. An uncertain email delivery marker remains uncertain when its old completion is discarded.
- Only a report definitions GET discarded while its panel is hidden is automatically resumed on return. Pending reads coalesce, existing drafts survive, active network/permission failures retain explicit Refresh, and terminal owners never restart. PDF/email and other user actions are never automatically replayed.
- `bindAccount` adds a backward-compatible optional owner callback and returns an idempotent disposer. Password completion is checked before local changes, and a confirmed current password change treats synchronous session cleanup/navigation separately so it does not trigger an extra reload. Bindings are disposed after accepted navigation; local cleanup/navigation errors retain feedback and an enabled control. Existing callers may continue ignoring the return value.
- The existing calls-owner callback also re-enters its accepted governed presentation. Lost connections during actual startup fulfillment or rejection close the panel without restarting it.

Presentation checks use the active governed/account registration during ordinary actions, rather than alternating that registration with the original document entry. This preserves the existing same-screen scroll policy. The existing portal document-scroll implementation is unchanged.

## Tests and fixture compatibility

New focused suite: `scripts/test-workspace-manager-boundaries.mjs`.

Its deterministic fixture covers real workspace/ScreenManager behavior and, for child cases, the real portal bridge, reports, account form and password client. Unrelated panels, network and DOM operations are synthetic. The new suite has 102 passing cases, including terminal failure, all four connection types, missing entries, stale parent controls, current controls, same-token remounts, session replacement, history, live text, delayed responses, report drafts, uncertain email state, password completion, and fourteen read-resumption controls covering hidden completion, fetch/body boundaries, pending-read coalescing, active failures, disposal and non-replay of user actions.

Eight additional cases in `scripts/test-workspace-calls-resume.mjs` cover all four connection failures during actual calls startup fulfillment and rejection. The original 31 calls restoration cases remain intact, for 39 passing cases in that suite.

Four pre-existing direct-render fixtures now install the same document entry as `main.ts` and deliver history as browser events instead of assuming that the implementation owns `window.onpopstate`. Mock account binders return the real API's disposer. Original assertions are unchanged:

| Existing fixture | Original assertions preserved | Runtime control on unchanged predecessor |
| --- | ---: | --- |
| `test-typescript-screen-manager.mjs` | 67 | 17 cases passed |
| `test-workspace-route-handoffs.mjs` | 143 | 26 cases passed |
| `test-workspace-calls-resume.mjs` | 99 | Original 31 cases passed |
| `test-workspace-browser.mjs` | 51 | Blocked at import: `jsdom` is unavailable |

Thus the three dependency-supported adapted suites passed 74 unchanged-predecessor cases. The fourth passed syntax checking only; neither its predecessor nor candidate run provides DOM runtime acceptance. Added calls assertions are separate from those original assertions.

The final focused command covering the 102 new boundary cases, 39 calls cases, 17 report-session cases and one account-client case passed 159/159. The complete selected command passed 831/831: the previous 721 cases, eight additional calls cases, and 102 new boundary cases. The non-strict `main.ts` TypeScript check passed. Independent final validation and artifact reconstruction remain separate release checks.

Both existing TypeScript deploy and release workflows include exactly one credential-free invocation of the new suite. This change does not run or authorize those workflows or any deployment.

## Remaining limits and release gates

- No production credentials or database were used. Governance registration and live grant/configuration review are not claimed.
- Synthetic DOM/transport coverage does not establish layout, accessibility, real navigation, media or Cypress/browser acceptance. Chromium remains blocked before navigation by the known environment socket/ptrace restriction; this change did not retry or bypass it.
- Discarding an obsolete response prevents local side effects. It cannot undo a logout, password change, email request or other operation already dispatched to the server.
- Existing SMS, voice-pairing and session-panel disposers are invoked, but their deeper transport races are not comprehensively audited here. Transport-level same-token stale 401 handling is outside this change. No claim is made that every descendant transport is now owner-aware.
- Specialized tenant/dashboard renderers outside the generic workspace still require their own route/connection integration review.
- This unpublished candidate is not integrated with current remote `main`, and no commit, push, PR or deployment is included. Full required checks, browser evidence, production governance review and a conflict-safe integration are still needed before release readiness can be claimed.
