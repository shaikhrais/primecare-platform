# Branch merge reconciliation — 19 October 2026

Main inspected at `cdd23f5777e98a162de81dc407b5c64379f4c582`.
Local integration branch: `work/merge-all-20261019`.
Combined implementation candidate: `365622d1d49f028cc2bf8216c1d4c8ff16cf22b0`.

## Changes prepared

The three open PR heads (#154, #163 and #171) are ancestors of the local candidate. Conflicts are resolved while retaining the current lazy governance router, current operation identities and evidence stages, and all model exports. Read-only source-bound contract artifacts were regenerated. The skeleton inheritance checker now recognizes generic class declarations. No production database changes were made.

## Validation

- 26 Worker lifecycle, ordering and inheritance tests passed.
- 31 workflow-plan, contract-factory and bulk-generation tests passed.
- Worker TypeScript checking passed with Cloudflare and Node types.
- Current skeleton structure passed: 1,161 controllers, eight application roots and 13 service hosts.
- Custom-state and runtime-contract extraction checks passed.
- Technical-document consistency and whitespace checks passed.
- Flutter/Dart runtime parity, analysis and compilation are not yet verified on the combined candidate; the SDK is not installed locally. Current-candidate CI must pass before main is updated.
- The full pinned historical controller parity check needs additional objects from this partial Git clone; it is not counted as passing.

## Older branches

The companion JSON inventories every fetched remote branch and associates its PR evidence. Previously merged PR history must not be blindly reintroduced: much of it precedes repository history reconciliation. A prior GitHub merge alone does not establish byte-for-byte equivalence with current main.

Two deployment branches have no associated PR and still require individual reconciliation: `deploy/client-auth-20261010` and `deploy/email-inbox-20261010`. In particular, the client deployment's first commit includes over 13,000 file changes and large deletions, so it cannot be treated as a small auth-only merge. Three older aliases share the same May 2026 head and require historical/reset review. Closed PRs #62 and #126 have later replacement evidence in current main; their old progress records must not overwrite newer results.

## Publication blocker

Automatic approval review rejected publishing the integration branch, including after destination verification. GitHub reports `shaikhrais/primecare-platform` as public. The review requires explicit authorization to publish the assembled changes to that public repository. No push or remote main merge from this integration branch succeeded. User confirmation is required before resuming publication and current-candidate CI.
