# Separate service application classes

All thirteen Dart service executables now contain only their original main function
and the import/export of a service application library. Each host class lives in
`services/<service>/lib/src/application/<service>_host.dart` and inherits the existing
shared HTTP/CORS service parent.

This covers auth, gateway, governance, client, provider, scheduling, notes, visit,
verification, billing, compliance, notifications and franchise reporting. Application
classes, helper functions, SQL, routing, middleware order, startup messages and
database initialization retain their original implementation. Relative imports are
relocated to the same original files. Old bin imports continue exposing public host
classes and helpers through exports; main signatures and bodies stay unchanged.

`scripts/refactor_service_entrypoints.py --check` verifies the complete inventory
and exact extraction against b41d21be2ac6de9ae8b32e4adadf24c66081c440. The existing
host/controller compatibility checks inspect the canonical application libraries
and still enforce route/method/order, SQL, ports and central-parent invariants.
CI analyzes every existing service executable to verify the new import boundaries.

Moving an application class does not finish its workflows. Auth/provider SQL and
other service-specific business rules still need independently reviewed repository
and use-case extraction. Existing placeholder handlers remain placeholders, and the
TypeScript Worker applications remain a separate implementation.
