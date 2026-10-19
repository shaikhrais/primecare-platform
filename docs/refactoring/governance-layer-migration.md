# Governance business-layer extraction

The twenty existing governance list/create handlers now use an injected
`GovernanceHttpController` inheriting `server_core.BaseController`. SQL and named
parameters live in `GovernanceRepository`, which inherits the canonical
`database_client.BaseRepository`. Controllers parse HTTP input and serialize
responses; the repository owns storage calls.

The existing static `GovernanceController` handlers and old core imports remain
compatibility facades. They refer to the same shared parent types. Existing
repository maintenance and event methods remain unchanged. Create responses retain
their exact original JSON bytes, including whitespace.

`GovernanceApiRoutes` inherits the shared routing parent and accepts a controller
factory. `GovernanceRoutes.router` remains the public static entrypoint. Controller
creation stays lazy until a business request, preserving root/echo and router
construction before database initialization. Each router remains independent.

## Evidence

The deterministic extraction checker is pinned to commit
b41d21be2ac6de9ae8b32e4adadf24c66081c440 and compares every moved class and compatibility
facade. Runtime parity injects a recording PostgreSQL connection into a verbatim
baseline controller and the new repository. It compares twenty handlers across
200 normal, malformed-input, missing-field and database-error scenarios, including
the exact SQL, parameter maps, response bodies, headers and propagated error types.
Twenty-four route/method cases also compare dispatch and error behavior.

Shared-parent tests check compatibility type identity, fresh routers, and sanity
routes without an initialized database. Server-core tests check success/error JSON.
Central inheritance CI runs parity, analysis and tests before merge.

## Scope and remaining work

This conversion adds no new endpoints, fields or permissions, and completes no
new business workflows. The governance host currently exposes global metadata
queries and has an offline mock-connection fallback. Extracting these classes does
not establish production authorization, tenant scoping, durable auditing or actual
database integration coverage. Those changes need explicit governance contracts
and independent security/storage tests. The archive's example policy engine is not
wired into these handlers because their authority and context contracts are not
defined here.
