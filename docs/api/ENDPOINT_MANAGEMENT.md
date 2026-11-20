# Endpoint management

The existing inventory-authorized Governance APIs report registered endpoint declarations and their evidence. Read access requires a bearer session and the inventory grant. The API rejects a mismatched tenant header and write methods.

Open **API Health Dashboard** at `/common/api-health-dashboard` from an authorized workspace. The Endpoint management panel searches and pages through the inventory and displays operation, service, implementation, protection, readiness and maintenance. The panel shows access denied when the account lacks the API inventory grant.

| View | URL | Use |
| --- | --- | --- |
| Operation inventory | `GET /v1/governance/api-execution-status` | Search by method and path. Each row carries its governance ID, linked screens, verification evidence and management status. |
| Service summary | `GET /v1/governance/api-service-status` | Count blocked, maintenance and unverified declarations by service. Filters apply before aggregation. |
| Verification summary | `GET /v1/governance/api-verification-summary` | Review test stage and missing permission, schema and screen links. |

The dashboard shows the historical **Offline HTTP result** when an observation matches both the declaration ID and the exact method and path. The response includes the audited commit and scope. The reviewed snapshot matches 1,156 of 1,485 declarations. Local 404s call for route reconciliation, and local 401s show that the unauthenticated request was denied. Both require separate production and authorization evidence before marking the operation ready.

The inventory defaults to 25 rows per page. Use `limit` (up to 100), `offset`, `search`, `app`, `role` and `screen`. Role filters operate on linked screen metadata. The same method and path can occur in multiple governance declarations, so retain the row ID when reviewing a discrepancy.

| Management field | Interpretation |
| --- | --- |
| Implementation | Blocked, partial, declared implemented, or unknown. An active registration by itself does not establish implementation. |
| Protection | Permission metadata missing, or enforcement unverified. A permission key or linked role does not prove runtime authorization. |
| Readiness | Blocked, recorded maintenance, or unverified. Verification requires endpoint-specific success, denial and production evidence. |
| Maintenance | A recorded maintenance declaration is surfaced. Unknown means the inventory has no recorded maintenance state for the row. |

This read-only inventory uses the Worker catalog snapshot. It does not probe production, schedule maintenance, or change routing. Use the [delivery checklist](API_DELIVERY_CHECKLIST.md) and [route audit](API_REACHABILITY_AUDIT.md) for operation-specific follow-up.
