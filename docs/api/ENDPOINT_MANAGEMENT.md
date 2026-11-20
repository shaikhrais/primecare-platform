# Endpoint management

The existing inventory-authorized Governance APIs report registered endpoint declarations and their evidence. Read access requires a bearer session and the inventory grant. The API rejects a mismatched tenant header and write methods.

Open **API Health Dashboard** at `/common/api-health-dashboard` from an authorized workspace. The Endpoint management panel searches and pages through the inventory and displays operation, service, implementation, protection, readiness and maintenance. The panel shows access denied when the account lacks the API inventory grant. Use **Check live health** to get a timestamped service health snapshot from the gateway using its public health endpoint. This check sends no credentials, does not invoke business endpoints and does not alter endpoint readiness.

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

## Request volume and transfer

The gateway records one metadata event per invocation when the release operator sets `ENDPOINT_TRAFFIC_ENABLED=1` and Workers Logs retains the event. The event contains the registered method and route template, response status, gateway response latency, and declared inbound and outbound body lengths. Paths without a unique catalog match use one `unmatched` bucket. Events omit raw URLs, query strings, identifiers, credentials, headers and bodies. Requests sent directly to a service Worker are outside this gateway measurement.

Export only the `primecare_endpoint_traffic_v1` console message lines from a known interval. For a one-hour export, run:

```sh
python3 scripts/summarize-endpoint-traffic.py --interval-seconds 3600 < endpoint-traffic.log
```

The report shows observed requests, observed requests per second, response status counts, error rate, p95 response latency, known bytes in each direction and the number of missing lengths. Retention or sampling can reduce the observed counts. Lengths represent declared body bytes and exclude headers, transport overhead and WebSocket traffic after the upgrade. Compressed or streaming responses may have unknown lengths. Transfer completion and billable network usage require edge metrics. The dashboard has no automatic feed from these logs yet.

## Full-system capacity and efficiency

Service health reports availability at the time of the check. Sustained request capacity, peak throughput and latency headroom require measurement against a representative environment with the deployed topology and sanitized test data.

| Measure | How to establish it |
| --- | --- |
| Sustainable throughput | Replay the observed mix of reads, writes, uploads and workflows in a production-like environment. Increase the request rate in steps and hold each step long enough to expose queues and connection saturation. Record the highest sustained rate that meets the agreed latency, error and throughput targets. |
| Effective throughput | Track successful business operations per second, p95 and p99 latency by operation, and error and retry rates. Reconcile writes against expected persistence and audit records. |
| Resource efficiency | Measure Worker CPU per successful operation, PostgreSQL connection waits and query time, queue age, third-party limits and transfer bytes per successful operation. |
| Headroom | Compare sustainable throughput with the observed peak request rate for the same workload mix. Record the interval, deployment version, load profile and measured bottleneck. |

Use the first measured bottleneck to choose the capacity change. For PostgreSQL saturation, inspect slow and repeated queries, add verified indexes and reduce connection churn through pooling. For oversized responses, paginate and project fewer fields, then measure compression and transfer coverage. For slow independent downstream work, use bounded concurrency or an asynchronous queue where the business contract permits it. Cache public, safe responses with a defined staleness limit. Check third-party quotas before scaling callers. Repeat the same load profile after each change to measure the gain and detect regressions.

Cloudflare publishes platform limits separately from the application's measured capacity. [Workers limits](https://developers.cloudflare.com/workers/platform/limits/) · [Workers Logs](https://developers.cloudflare.com/workers/observability/logs/workers-logs/)
