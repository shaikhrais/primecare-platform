# Endpoint management release checks

This batch addresses the remaining repository checks seen on endpoint-management commit `cdce775f31551db52b528a6e77654ea0887bd2ff`. Its endpoint-management and workflow-contract CI checks had already passed. Cloudflare rejected the selected Google sign-in during activation, so this batch does not claim a production configuration change or deployment.

## Repairs

- PSW actions and summary sections now use shared theme spacing. The actions use the shared `PrimeButton`; all four disconnected actions remain disabled and their unavailable messages stay visible.
- A receipt records the exact unavailable-actions source and the pinned historical palette-migration output. Historical tests can reconstruct that output without replacing the runtime file. Original palette hashes, migration counts and strict checks remain unchanged. Tests reject altered source, tampered receipts and duplicate records.
- Seven inspected specialist dashboard wrappers already extend `StatelessWidget` and render the shared unavailable shell with no actions. Only those seven candidate-inventory records change from `ConsumerWidget` to `StatelessWidget`. The generated clinic Physician screen is a separate declaration and is unchanged. This candidate classification is not registration, permission or readiness evidence.

## Validation

The 284 conservative migration tests, three replay receipt tests, shared UI boundary check and screen candidate scan pass locally. The committed-tree screen-style check must show zero new violations. Flutter runtime rendering has not been exercised by these Python checks. GitHub CI remains the remote release-check record.

## Remaining operational work

Live telemetry still requires the collection flag, Analytics Engine binding, reader account, approved role and tenant, and a dedicated Analytics Read credential. The prior production preflight captured all six as missing. No production/full-system capacity figure has been measured. The checked-in load harness must be run against a reviewed staging deployment and representative fixtures before its results can be used as capacity evidence.
