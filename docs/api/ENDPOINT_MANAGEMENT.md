# Endpoint management

The existing inventory-authorized Governance APIs report registered endpoint declarations and their evidence. Read access requires a bearer session and the inventory grant. The API rejects a mismatched tenant header and write methods.

Open **API Health Dashboard** at `/common/api-health-dashboard` from an authorized workspace. The Endpoint management panel searches and pages through the inventory and displays operation, service, implementation, protection, readiness and maintenance. The panel shows access denied when the account lacks the API inventory grant.

| View | URL | Use |
| --- | --- | --- |
| Operation inventory | `GET /v1/governance/api-execution-status` | Search by method and path. Each row carries its governance ID, linked screens, verification evidence and management status. |
| Service summary | `GET /v1/governance/api-service-status` | Count ready, blocked, maintenance and unverified declarations by service. Filters apply before aggregation. |
| Verification summary | `GET /v1/governance/api-verification-summary` | Review test stage and missing permission, schema and screen links. |

The dashboard shows the historical **Offline HTTP result** when an observation matches both the declaration ID and the exact method and path. The response includes the audited commit and scope. The reviewed snapshot matches 1,156 of 1,485 declarations. Local 404s call for route reconciliation, and local 401s show that the unauthenticated request was denied. Both require separate production and authorization evidence before marking the operation ready.

The inventory defaults to 25 rows per page. Use `limit` (up to 100), `offset`, `search`, `app`, `role` and `screen`. Role filters operate on linked screen metadata. The same method and path can occur in multiple governance declarations, so retain the row ID when reviewing a discrepancy.

| Management field | Interpretation |
| --- | --- |
| Implementation | Blocked, partial, declared implemented, or unknown. An active registration by itself does not establish implementation. |
| Protection | Permission metadata missing, or enforcement unverified. A permission key or linked role does not prove runtime authorization. |
| Readiness | Ready, blocked, recorded maintenance, or unverified. Verification requires endpoint-specific success, denial and production evidence. |
| Maintenance | Recorded, scheduled, active, or unknown. A scheduled or active window includes its UTC times and reason. |

### Readiness evidence

Ready requires a declared implementation, complete permission and request/response metadata, and a current [reviewed release receipt](../../cloudflare/workers/src/endpoint-readiness-receipts.json). Each receipt must identify the exact `id` and `api`, `releaseId`, `verifiedAt`, `expiresAt` and GitHub Actions `runId`. It must record passing success, access-policy and scope checks. For a public endpoint, the access-policy and scope checks verify the declared public behavior and permitted projection. For a protected endpoint, they must verify denial and tenant or resource isolation.

The release operator sets the Governance Worker binding `ENDPOINT_RELEASE_ID` to the independently verified identifier for the currently serving release, including its gateway and service versions. Clear the binding during a rollout or rollback until deployment identities can be verified again. The application matches the configured release ID against the receipt. Infrastructure still needs to supply an independent live identity check or a receipt publisher. Future-dated, expired or duplicate receipts do not grant readiness. Receipts expire within 24 hours. Active maintenance and blockers take precedence. The checked-in receipt list is empty.

### Maintenance windows

Release maintainers record reviewed windows in [the Worker maintenance schedule](../../cloudflare/workers/src/endpoint-maintenance-windows.json). Each entry contains `id`, the exact `api` method and path, `startsAt`, `endsAt`, and a short operator-facing `reason`. Use UTC timestamps including milliseconds, for example `2026-12-01T14:00:00.000Z`. Windows for the same declaration cannot overlap.

The inventory shows the next window as scheduled, marks it active from the start time up to the end time, and clears it after expiry. Blocked endpoints remain blocked. The checked-in schedule contains no windows. Production display requires deploying the Worker and dashboard with the reviewed schedule. These windows communicate maintenance status. Traffic continues through the existing handlers.

This read-only inventory uses the Worker catalog snapshot. Use the [delivery checklist](API_DELIVERY_CHECKLIST.md) and [route audit](API_REACHABILITY_AUDIT.md) for operation-specific follow-up.
