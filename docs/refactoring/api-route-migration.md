# Shared API route skeleton

Seven service ApiRoutes classes now inherit BaseApiRoutes from server_core.
The parent owns router construction; children register their existing handlers.
Each router access still creates a fresh instance. Middleware, authorization,
request parsing, response payloads, registration order, and routes stay in their
existing service implementations.

The pinned migration manifest and byte comparison check cover all seven files.
Lifecycle tests verify fresh router instances, method/path matching, body
forwarding, and unchanged status/header behavior. The central inheritance CI
runs these alongside existing service and shared model checks.

This is a structural migration, not completion of business workflows. Existing
empty reads and simulated actions remain placeholders. Scheduling continues to
return 501 for its 26 unavailable screen endpoints. GovernanceRoutes has a
separate static interface and remains unchanged for compatibility.

Shared business models remain in primecare_models. Flutter presentation stays
in flutter_core/primecare_ui; HTTP routing stays in server_core. TypeScript
contracts remain in packages/domain and are not Dart subclasses.
