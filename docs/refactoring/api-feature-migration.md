# API feature skeleton migration

Seven existing Dart route libraries now compose 255 feature route classes through
`server_core.BaseModularApiRoutes`. Each feature inherits `BaseApiRoutes` and owns
its existing handlers. The service composition root retains its public `ApiRoutes`
class, database client instance, and ordered module list. Scheduling retains the
public `ApiRoutes.screenPaths` list and all 26 existing HTTP 501 responses.

The move covers 533 route bindings, not 533 completed business workflows. The
legacy generated reads and simulated actions remain unfinished. No routes,
permissions, request fields, database operations, or deployment entrypoints were
added. Middleware and authorization remain at the existing host boundary.

Feature files use Dart `part` libraries so handler imports and symbol identity stay
the same. Both GET and action handlers for a feature live together, avoiding one
large service file. Registration order is preserved, including first-match behavior.
The common parent controls composition and router construction; security and
business rules must be extracted only after the actual workflow is reviewed.

## Existing shared layers

| Responsibility | Canonical package |
| --- | --- |
| Dart business models used by API and UI | primecare_models |
| HTTP service lifecycle and modular API routing | server_core |
| Database connections and SQL adapters | database_client |
| Flutter network services, controllers and telemetry | flutter_core |
| Flutter app composition and presentation | primecare_ui |
| TypeScript wire contracts | packages/domain |
| TypeScript Worker lifecycle | cloudflare/workers/src/core |

The archive's sample ClientProfile contract must not replace a production wire
schema without checking fields and callers. Dart objects cannot be inherited by
TypeScript Workers; equivalent wire contracts need schema generation and parity.

## Verification

`scripts/refactor_api_features.py --check` compares every generated file with a
deterministic transformation of source commit b41d21be2ac6de9ae8b32e4adadf24c66081c440.
The earlier route compatibility checker still compares the handlers to its own
pre-inheritance source. Together they cover both structural migration steps.

`scripts/verify_api_feature_parity.py` runs all 533 bindings against both the original
and migrated libraries and compares status, headers and body, plus unknown-route
behavior for all seven services. It resolves the libraries' direct dependencies in
a temporary harness and cleans up baseline source files even if checks fail.
This is in-process handler parity, not production/database integration testing.

Shared parent tests exercise fresh routers, registration order, first-match routing,
and concurrent body/status/header forwarding. Central inheritance CI runs these
checks and analyzes service entrypoints before merge.

## Remaining conversion work

Structural inheritance does not finish the full project conversion. Legacy
placeholder handlers still need governance-defined workflows, server permission
and tenant checks, actual storage adapters, and UI integration tests. The production
Worker business operations remain separate from these Dart route modules. Those
operations must migrate with their own response, authorization and transaction
tests rather than by copying sample use cases from the archive.
