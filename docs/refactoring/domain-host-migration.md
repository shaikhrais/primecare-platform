# Domain host conversion

Ten service hosts now delegate route construction to service-specific `BaseApiRoutes` subclasses. Billing, client, compliance, provider, scheduling, and visit services separate HTTP handlers into `BaseController` subclasses and ten existing database operations into `BasePlatformRepository` subclasses. Franchise reporting, notes, notifications, and verification retain their existing greeting or placeholder handlers in route classes. This conversion adds no completed business workflow.

Application startup, database initialization, middleware, route order, generated route mounts, JSON behavior, exceptions, status codes, and database parameters are preserved. In particular, generated routes remain mounted before the manually written routes where the original code did so; this change does not silently change that routing behavior.

`refactor_domain_hosts.py --check` checks every extracted file against the pinned source. `verify_domain_host_parity.py` executes original and converted handlers using identical recorded database results, empty results, and failures, comparing status, headers, bodies, SQL, parameters, and exceptions. Service-layer analysis covers the changed classes; the existing generated feature files retain their historical warnings.
