# Administration read authority review

36 unique pending GET operations reviewed, zero resolved. The companion JSON lists exact declaration IDs, endpoint rows, current caller lines, stored routing probes, and joined permission keys. Regenerate with `python scripts/audit-admin-read-authority.py`.

All 36 have no endpoint `permission_key`. This is evidence of a contract gap, not permission to grant an administrator tenant-wide reads. Joined `api_permissions` data also needs reconciliation: audit-logs endpoint 833 has 64 grant rows keyed `api_permission_api_v1_ceo_approvals_list_get`; roles/matrix endpoint 856 has 64 keyed `api_permission_api_v1_credential_tracking_list_get`; GET governance/dashboard endpoint 888 has 64 keyed `api_permission_api_v1_cto_api_monitoring_list_get`. These unrelated keys must not be accepted as operation authority.

34 stored unauthenticated probes miss the gateway; governance/dashboard misses the Worker. `/v1/admin/users/privileged` reaches a protected dynamic `/admin/users/:id` handler. That response does not establish a privileged-user inventory workflow.

Current concrete callers exist for audit-logs, devices, policies, registry, system-events, and governance/dashboard. Absence of a direct Dart string caller is not proof that a catalog declaration is obsolete: governed runtime contracts can be consumed dynamically. None are retired solely for lacking a direct caller.

Existing alternatives have different contracts. `GET /v1/governance/overview` enforces the registered organization gate and supplies tenant account/session/domain counts. Legacy dashboard consumers request metrics, insights, timelines, and trends; the Flutter mock contains fabricated telemetry, which must not become production evidence. `GET /v1/auth/me/audit-event-records` enforces actor ownership, while the admin audit viewer promises a system-wide transaction ledger. Aliasing these routes would silently change either scope or response shape.

The safe disposition is to register explicit scoped business and authority contracts before implementation. This review does not mutate grants, change routes, mark health, or increase completed-operation counts. The 36 operations remain pending until the authoritative checklist registers blockers or supplies valid contracts.

## Grant ID-domain root cause

`scripts/migrate_architecture_tables.py` generated permission keys from `api_endpoint_registry.endpoint_code`, and used that registry row's `id` as `api_permissions.api_id`. The declared foreign key targets `api_endpoints.id`. The registry itself was hydrated from `api_registry`, so its `api_id` also cannot be presumed to be an endpoint ID.

The read-only integrity audit finds 79,936 permission rows: 57,984 reference a different endpoint identity, and 21,952 have no target endpoint. Among currently pending unique operations, 52,608 mismatched grant rows reference 822 operations. All remain unaccepted as authority. Reproduce with `python scripts/audit-api-grant-integrity.py`.

The migration source now resolves a unique exact HTTP method/path in `api_endpoints`, rejecting missing or ambiguous identities with an explicit exception before API-linked inserts. Numeric IDs from other catalogs are never guessed. Six isolated SQLite regression tests cover correct identity, ID collisions, missing/ambiguous targets, and method drift. The migration was not run against the current database; existing invalid grants remain unchanged. Fixing this generator prevents recurrence but does not establish scoped business permissions or repair existing grants.
