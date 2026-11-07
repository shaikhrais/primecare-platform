# Workspace handoff to existing production renderers

Status: isolated candidate extension, not published, deployed, or release-approved.

## Reproduced integration gap

The current exported workspace registry and actual workspace response producer expose two concrete CEO destinations:
- look_review_manager at /appearance-review is a view-granted screen.
- MAINTENANCE_CONFIGURATION at /maintenance/configuration is an account-type action. It is intentionally excluded from generic screens and exposed through the actions collection.

The existing main dispatcher already has dedicated renderers for both routes. The generic workspace previously performed a full-document handoff only for care and growth. Its Look sidebar therefore rendered a generic governed description, while its Maintenance command-palette action pushed a path that had no generic screen registration and showed a false forbidden view.

The pre-fix actual-module regression run had one control pass and two reproduced failures. It uses the real exported registry and workspace response producer with an isolated fake PostgreSQL adapter, not fabricated grants or a live database.

## Implementation boundary

Only websites/typescript/src/workspace.ts changes production behavior:
- Sidebar and command-palette navigation reuse resolveManagedRoute, the existing main dispatcher classification, instead of maintaining a second two-route list.
- Existing dedicated destinations use a document navigation. Generic authorized screens remain in the workspace, and inventory-only/unknown destinations are still denied.
- Authorized default landings and Back/Forward transitions use history-neutral handoffs. User choices create one navigation; repeated callbacks do not duplicate it.
- Generation and session checks run before history or location mutation. Replaced workspace generations and superseded requests cannot navigate the newer workspace.
- Canonical same-origin route checks run for authorized screen/action targets before registration. Dot-segment normalization, foreign/scheme-relative targets, query/fragment characters, backslashes and control characters cannot become an external navigation.
- Unreadable session storage revokes the presentation scope and removes protected content.
- A persisted pageshow after Back/Forward cache restoration fetches a fresh workspace authorization snapshot. It does not reactivate cached grants. Old lifecycle listeners are replaced; persisted pageshow ignores detached or stale roots.

No route definitions, registry records, roles, grants, API endpoints, backend authorization or generated metadata were added or changed. Existing tenant/platform admin redirects, account entry and permitted calls behavior remain explicit. The current-source registry is evidence for the integration defect, not proof of current production database state.

## Tests and CI

- 26 focused actual-module route fixtures pass.
- The final combined candidate passes 314 selected Node unit/fixture checks.
- Ten independent actual-module probes pass, including the initially reproduced URL/session defects, BFCache authorization revocation, denied refresh, detached owners and inventory boundaries.
- Strict TypeScript checking of workspace.ts and managed-routes.ts passes.
- The actual main.ts browser bundle succeeds with 247 inputs and no warnings.
- Full-entry strict TypeScript still has the same ten baseline diagnostics. No new diagnostics were added.

The existing JSDOM test expectations now distinguish dedicated handoffs from generic screens and preserve grant assertions. That suite could not run because jsdom is unavailable; one permitted official-registry retrieval attempt failed with DNS EAI_AGAIN. Syntax checking passed. This is not a claim of real-DOM or real-browser acceptance.

Both existing deployment/release workflows gain only one separate required test invocation:
    env -i PATH="$PATH" HOME="$RUNNER_TEMP" node --test scripts/test-workspace-route-handoffs.mjs

The clean child environment strips inherited database and Cloudflare credentials. A synthetic-sentinel probe passed all 26 tests. Existing verification/build/metadata-registration commands, confirmation inputs, production environments, expected-head checks, and deployment locks are unchanged. No workflow was dispatched.

## Reproduction and dependencies

Run in the combined candidate, with Node 24 and no production credentials:
    node --test scripts/test-workspace-route-handoffs.mjs scripts/test-typescript-screen-manager.mjs

This patch is an additive eighth patch after the seven patches in primecare-screen-preview-20261107.tar.gz (SHA256 2cf0fde4588eeba234db003718d676be227f955f3c9aaf34a599cf4305fd6685). That preserved candidate starts at fad8a62e1a32c642df26f50c7b45b2c521c62800. Current main was separately reverified as df27a32822e6255709c48bfcf71be5f9bbccc6ac before this work.

Apply only to a fresh copy of that candidate with git apply --check first. The previous preview archive remains unchanged. Applying the source patch does not regenerate its prebuilt login/recovery preview. This patch has no dependency on the separate localization draft batch.

## Remaining acceptance

The official JSDOM suite, real browser navigation/history/accessibility checks, live governed metadata verification, full monorepo CI and release approval remain outstanding. These changes connect existing implemented renderers; they do not make every exported screen production-ready.
