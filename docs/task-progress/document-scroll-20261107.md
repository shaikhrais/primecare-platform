# Portal document scroll at screen boundaries

Status: isolated, unpublished candidate. This is not a production-readiness claim.
Date: 2026-11-07.
Predecessor: the verified administrator presentation extension on fad8a62e1a32c642df26f50c7b45b2c521c62800 plus fourteen unpublished patches.

## Reproduced defect

The TypeScript entry point installs ScreenManager on #app. The production body and application shell use normal document flow, while ShellEnvironment resets only its own element. Moving between governed workspace paths could therefore leave the document viewport at the previous page's vertical and horizontal position. The browser document is outside the reusable shell's ownership and must not be passed as one of its scroll roots.

The focused regression suite imports the actual production presentation bridge and its layout, theme, language and shell dependencies. The exact predecessor fails 20 of its 31 tests, with 11 retained-behavior passes and no skipped or cancelled tests. Several tests assert a preserved position followed by a later ordinary reset, so these failures are not counts of distinct defects.

## Bounded implementation

The portal-specific PortalDocumentScroll helper owns document scrolling. screen-presentation.ts invokes it at the end of the responsive connection, after the existing layout, theme, language and responsive checks succeed. It does not change ScreenManager or ShellEnvironment.

- Only the connected canonical #app directly beneath its original document body can own that document's viewport. Embedded, duplicate-ID sibling, detached, reparented or adopted roots cannot scroll it. A replacement canonical root retires the previous document owner.
- A successful transition between different accepted screen paths resets that document's window to top 0 and left 0 with instant behavior. It never uses the ambient window or loops over nested panels.
- The helper compares the registered screen route, not the screen ID. The initial dispatcher and governed screen can have different IDs for the same path without resetting the viewport. Initial workspace-host resolution from / or /dashboard to its canonical governed landing also preserves position.
- Same-path redraws, language changes, query changes and hash navigation retain their existing behavior. Fragment destinations are left to the browser and renderer. Existing administrator tab scrolling is unchanged. Administrator account clicks retain their explicit top-only window reset; the helper additionally performs one instant, both-axis reset at the accepted changed pathname.
- The presented path must match the current document pathname. Pending work for an older mounted view cannot consume a newer browser location.
- popstate and hashchange protect the current URL through asynchronous reconciliation and later redraws. Protection ends when another matching, accepted URL arrives, rather than on a timer. The helper does not patch pushState or replaceState, write history state, or change scrollRestoration.
- BFCache pagehide suspends document effects. A persisted pageshow preserves the restored URL through delayed rendering. Non-persisted pagehide removes the helper's event listeners. The existing shell/layout cleanup remains in place.
- While any element is fullscreen, document scrolling is preserved and the accepted route is recorded. Leaving fullscreen does not cause a delayed same-screen jump.
- If a required document reset throws, the previous route remains current so a later attempt can retry. Missing registration or failed presentation checks do not reset the document.

No screen, route, component, governed row, permission, API, business rule or user-facing text is introduced. Authentication, tenant scope, navigation permissions, account preferences, nested panel scrolling and native history ownership remain unchanged. The reusable shell still rejects scroll roots outside its subtree and retains its existing initial/same-identity behavior.

## Validation

Credential-free focused command:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-typescript-document-scroll.mjs
```

The focused suite passes 31 tests, including three repeat runs. Together with the unchanged ScreenManager and administrator-manager suites, it passes 97 tests. The complete selected regression command passes 721 tests. Independent review also passes 46 additional checks covering the helper, actual main/administrator modules and actual workspace renderer. The new suite uses synthetic DOM, CSS services, history event delivery and viewport observations. No existing test assertion or fixture is changed. These checks exercise production code but are not real-browser acceptance.

Coverage includes document resets, repeat entries, dispatcher/governed identities, initial canonical landing resolution, fragments, queries, delayed and repeated Back/Forward, pending-view mismatch, all three later presentation checks, unregistered routes, nested and sibling isolation, embedded roots, root replacement and detachment, BFCache, final disposal, owner-document selection, fullscreen and failed-scroll retry. Direct ShellEnvironment assertions retain its contained-root rejection and original behavior.

The existing TypeScript deployment and release workflows each add exactly one invocation of the focused suite with the credential-free environment above. No approval, credential, publication or deployment control changes, and neither workflow has been run remotely for this candidate.

## Remaining release gates

This extends the preserved unpublished patch sequence, not the newer remote main last checked at df27a32822e6255709c48bfcf71be5f9bbccc6ac. The original repository is untouched. No commit, branch, push, PR, deployment, production secret or live database operation is part of this repair.

Chromium previously failed before navigation because process-singleton socket creation was denied with EPERM; the supported retry also failed. No browser retry or safeguard bypass was attempted here. Actual viewport behavior, native Back/Forward and fragment restoration, BFCache, fullscreen, visual layout, keyboard/accessibility and screenshots remain browser acceptance gates.

The production main entry bundles successfully with 248 inputs and zero warnings (2,333,618 bytes). Release-compatible non-strict TypeScript checking passes. Strict checking still reports the same ten baseline diagnostics, byte-for-byte unchanged; strict checking does not pass. Exact final source manifests and independent review accompany the preserved artifact. Latest-main integration, PostgreSQL/tenant validation, governance registration, complete Screen Management inventory, required CI and release review remain separate gates. This bounded change does not establish that the complete Screen Management System is ready for release.
