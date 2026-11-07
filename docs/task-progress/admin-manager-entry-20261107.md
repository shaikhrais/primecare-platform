# Administrator presentation re-entry

Status: isolated, unpublished candidate. No production readiness claim.
Date: 2026-11-07.
Predecessor: the verified workspace-calls-resume extension on fad8a62e1a32c642df26f50c7b45b2c521c62800 plus thirteen unpublished patches.

## Reproduced defect

The main dispatcher installs ScreenManager and enters the initial administrator route. The administrator renderer then handles its own account links, tab changes, history and redraws. Those transitions previously bypassed ScreenManager entirely. An embedded account at /success could therefore display without checking the existing layout, theme, language and responsive connections. Direct administrator mounting also accepted a missing manager and started data access.

The exact predecessor fails 43 of the final 49 regression tests, with six passes for behavior intentionally retained and no skipped or cancelled tests. The first six focused reproductions all failed before the runtime repair. These are test outcomes, not counts of independent defects.

## Bounded repair

Only platform-admin.ts changes at runtime.

- Require the manager installed by the existing production entry point. Never create a replacement or fallback manager in the renderer.
- Use resolveManagedRoute for the existing /platform/administration and /success paths. Recheck presentation before the text subscription, data loads, administrator actions, account navigation, history reconciliation and each redraw.
- Validate both fulfillment and rejection at existing asynchronous current-owner boundaries. A connection lost during fetch, body parsing or the capability probe cannot start a later read, consume a mutation receipt or appear as a generic network error.
- Recheck the initial failure path too. A rejected nested-controller load must not replace a configuration failure with an ordinary service error.
- Retire the mounted owner and clear old content through showScreenConfigurationError when registration or a presentation connection fails. Stale handlers and late responses cannot restore the previous content.
- During pending work, validate the route belonging to the still-owned view. Browser Back/Forward may already have changed the URL, but it must not enter the account presentation for content still belonging to the previous administrator view. Existing pending-work reconciliation handles the final navigation.

No screen, route, grant, API, governed row, permission or business rule is added. The server capability filter, tenant selection, mutation payloads, endpoint paths, retry identities, session restrictions and history entries are retained. Already-dispatched mutations cannot be cancelled or rolled back by a presentation check; their uncertain retry identity remains intact if the mounted owner can no longer consume the result.

### Registration ownership

The administrator continues the main dispatcher's single entry scope. On initial mount and a real path transition, it replaces that scope with the canonical registration for the current existing route:

- /platform/administration: typescript:platform:/platform/administration, adapter platform.
- /success: typescript:workspace:/success, adapter workspace. The existing embedded account markup is still displayed by the administrator; a fresh document at /success still uses the unchanged workspace dispatcher.

Same-route redraws only enter the existing registration. They do not silently reconstruct a missing registration. This deliberately changes the entry snapshot as presentation moves between the two paths, rather than creating a second scope that competes with the main entry. Workspace-owned typescript:account and all other scopes are untouched.

Disposal leaves the last static dispatcher entry in place, matching the original main-entry lifetime. It contains presentation metadata, not an identity or authorization snapshot. An old owner's cleanup does not erase a replacement renderer's entry. Remount starts a new mounted owner and updates the canonical entry for its existing route.

## Regression coverage and evidence

scripts/test-platform-admin-manager.mjs passes 49 isolated Node tests, including three repeat runs. It bundles the actual administrator module, ScreenManager, route resolver and production presentation bridge. DOM, CSS services, transport and unrelated rendering panels remain synthetic. This is not real-browser or production acceptance.

Coverage includes initial presentation before subscription/data access; missing installation and missing, throwing or asynchronous connections; account clicks and return tabs; Back/Forward; same-route refresh, history, language and live-text redraw; missing registration; repeated mounts; stale owners and sessions; pending parent and nested-controller work; fulfilled and rejected transport; mutation retry identity; unchanged workspace/other scopes; and the actual bridge's layout, language, theme and responsive stylesheet checks.

The existing scripts/fixtures/platform-admin.mjs setup is explicitly adapted to bundle and install the real manager in the same module instance as the administrator, seed the existing main-dispatcher registration, expose connection observations and optionally use the production bridge. All pre-existing test bodies and every other existing fixture remain byte-for-byte unchanged. No assertion is weakened or deleted. The two existing administrator suites still pass their original 130 tests with that setup.

The final combined suite passes 690 tests: all 641 predecessor tests plus the 49 new tests, with no failures, skips or cancellations. The focused suite passes again, three repeated runs pass, and the environment-isolation run passes all 49 tests. Separate independent acceptance checks pass 80 cases, including actual main-dispatcher and production-bridge integration, retained controls, personal layout preservation and connection loss during mutation hashing.

The complete main entry bundles successfully with 247 inputs and zero warnings. Release-compatible non-strict main-entry TypeScript checking passes. Strict checking still reports exactly the same ten diagnostics as the predecessor, with no new diagnostics; strict checking does not pass.

The initial negative evidence is baseline-negative.log. The final exact-predecessor comparison is exact-baseline-negative.log, with its exit code. pre-freeze-focused.log and focused-repeat-{1,2,3}.log record the focused successes. existing-test-preservation.json records the fixture exception and unchanged old test sources. Final source and changed-file manifests identify the exact reviewed candidate.

## Workflow gates

The existing TypeScript deployment and release verification workflows each add one credential-scrubbed invocation:

```sh
env -i PATH="$PATH" HOME=/tmp TMPDIR=/tmp node --test scripts/test-platform-admin-manager.mjs
```

No deployment, credential, approval or release control is changed. Neither workflow was run remotely.

## Remaining release gates

This repair extends the preserved unpublished candidate; it has not been integrated into the newer remote main, last checked at df27a32822e6255709c48bfcf71be5f9bbccc6ac. The original repository is untouched. No commit, branch, push, publication, deployment, dependency installation, production credential or live database operation was used.

Real Chromium could not launch in the previous batch because process-singleton socket creation was denied with EPERM. No new browser launch or restriction bypass was attempted. Actual history/BFCache behavior, visual layout, responsive rendering, keyboard/accessibility and screenshots remain browser acceptance gates. The presentation bridge's previously identified document-scroll limitation is unchanged.

The entire Screen Management inventory, latest-main integration, strict TypeScript diagnostics, authenticated browser validation, PostgreSQL/tenant validation, governance registration, full required CI and release review remain separate gates. The complete Screen Management System must not be marked release-ready from this bounded repair.
