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
python3 scripts/summarize-endpoint-traffic.py --interval-seconds 3600 \
  --window-ended-at 2026-11-20T15:00:00Z < endpoint-traffic.log > endpoint-traffic.json
```

The report shows observed requests, observed requests per second, response status counts, error rate, p95 response latency, known bytes in each direction and the number of missing lengths. Retention or sampling can reduce the observed counts. Lengths represent declared body bytes and exclude headers, transport overhead and WebSocket traffic after the upgrade. Compressed or streaming responses may have unknown lengths. Transfer completion and billable network usage require edge metrics. Use **Open traffic report** in the API Health Dashboard to load this JSON and see whole-gateway observed totals alongside each operation’s traffic. The report stays in the current dashboard view and is read locally in the browser. Per-operation metrics use the exact method and path, so duplicate governance declarations may display the same operation’s numbers. The dashboard total counts each observed invocation once. Missing operation rows display a dash. A configured Analytics Engine integration can now deliver traffic automatically through the authenticated service summary; see Automatic traffic below. Manual imports remain available.

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

### Capacity benchmark dashboard

The Endpoint management panel accepts a separate, locally read JSON file with **Open capacity benchmark**. Supply results from a reviewed, representative sustained-load test. No benchmark is bundled, and importing a file does not independently verify its claims. Match the release, environment and workload against the traffic export before comparing them.

```json
{
  "releaseId": "replace-with-tested-release",
  "environment": "staging",
  "workload": "replace-with-load-profile",
  "evidenceUrl": "https://example.com/replace-with-test-evidence",
  "measuredAt": "2026-11-20T10:00:00Z",
  "expiresAt": "2026-11-21T10:00:00Z",
  "sustainableRequestsPerSecond": 100,
  "p95LatencyMs": 150,
  "errorRate": 0.01,
  "targetP95LatencyMs": 200,
  "targetErrorRate": 0.02,
  "bottleneck": "database"
}
```

The values above illustrate the format; they are not PrimeCare measurements. Accepted bottlenecks are `database`, `transfer`, `downstream`, `worker`, and `unknown`. The panel rejects expired or future-dated evidence and benchmarks that miss their declared latency or error targets. It displays sustained and successful benchmark throughput, measurement expiry, observed average utilization, average rate margin (including negative margin), an evidence link, and a bottleneck-specific next action. Recommendations are operator guidance, not automatic infrastructure changes. Interval averages, incomplete logs and mismatched traffic mixes cannot establish peak headroom or full-system capacity. Re-test after a deployment or topology change.

Traffic imports also display HTTP 2xx responses, 5xx/exception counts, status coverage and unknown request/response length counts. HTTP 2xx responses are transport-level observations, not proof of successful business workflows. Legacy reports without status counts show zero status coverage. Status totals are validated before display.

Validation: `node --test scripts/test-endpoint-capacity.mjs` (Node 24+).

### Management overview and operation efficiency

The dashboard also reads the inventory-authorized service summary to show total registered declarations and counts ready, blocked, in maintenance and unverified. These totals cover the full inventory independently of the current search page. The reader rejects truncated summaries, duplicate service groups and inconsistent counts.

Imported traffic adds per-operation requests/second, HTTP 2xx counts, 5xx/exception counts and error rates. Denied requests are not classified as server errors. Missing status coverage stays unknown, and an empty interval has no error percentage. Whole-gateway totals include known inbound/outbound bytes per second and observed HTTP 2xx per second. All rates use the report interval. They do not include unobserved requests, transport overhead or direct service traffic.

### Remaining production connections

1. Deploy the reviewed gateway and dashboard versions through the existing release process.
2. Configure gateway `ENDPOINT_TRAFFIC_ENABLED=1` and retained Workers Logs, then verify metadata events contain no caller data.
3. Configure the Analytics Engine binding and authorized reader described below, or use local traffic imports until that connection is deployed.
4. Record the deployed gateway and service versions, then run representative sustained load in a production-like environment with sanitized data. Capture database waits, Worker CPU, queues and provider limits alongside latency and errors.
5. Import reviewed capacity evidence and compare only the same deployment and workload mix. Repeat after tuning the measured bottleneck.

The source changes alone do not activate these production connections or establish whole-system capacity.


## Automatic traffic

The gateway can also write caller-free metric events to the `ENDPOINT_ANALYTICS` Analytics Engine binding while `ENDPOINT_TRAFFIC_ENABLED=1`. The dataset is `primecare_endpoint_traffic_v1`. The projection contains only the registered operation (or `unmatched`), HTTP status, gateway response latency, declared byte counts and missing-length indicators. It does not include tenant identifiers, request headers, query strings, bodies or credentials. Writes are non-blocking; a writer failure cannot change the business response. These events are best-effort observability, not billing records.

The existing `GET /v1/governance/api-service-status` response now includes a separate `traffic` envelope. Existing authentication, tenant checks and inventory permission still apply. Remote usage access additionally requires an exact match to **both** `ENDPOINT_ANALYTICS_READER_ROLE` and `ENDPOINT_ANALYTICS_READER_TENANT_ID`. This is an explicit platform-wide reporting grant within the configured tenant. Inventory access alone does not expose usage from other tenants. Unconfigured, denied or unavailable usage reports leave inventory status accessible.

The Governance Worker uses a server-only `ENDPOINT_ANALYTICS_READ_TOKEN` with Account Analytics Read permission and `ENDPOINT_ANALYTICS_ACCOUNT_ID` to query the fixed dataset. No provider token reaches the browser. The query uses a completed five-minute window with a two-minute ingestion allowance, weights counts and byte totals by `_sample_interval`, and computes weighted P95 latency. Responses are bounded and validated; duplicate groups, invalid totals and truncated results fail closed. Analytics estimates cannot prove exact invocation counts, completed transfers, billable usage or capacity. Sampling and event loss can affect accuracy. The dashboard labels these figures as estimates.

The dashboard refreshes its summary and available traffic report every 60 seconds while visible. Local file import takes precedence over automatic reports until the file selection is cleared or the view is reopened. A failed automatic refresh clears earlier usage figures instead of displaying them as current. The report shows its actual observation window. Direct service calls remain outside gateway coverage.

Prepare separate configurations for release review, using configuration files that already preserve the live bindings and settings:

```sh
node scripts/prepare-endpoint-analytics-config.mjs CONFIG_DIRECTORY ACCOUNT_ID READER_ROLE PLATFORM_TENANT_ID
```

This writes `gateway-analytics.jsonc` and `governance-analytics.jsonc` in the same directory. It preserves existing services, observability and variables, adds the dataset binding and opt-in flag, and configures the reader account, role and tenant. It does not deploy, change provider settings or handle secrets. Configure the read token through the approved secret mechanism. Review the additional binding against live settings and the existing release-preservation checks before deployment. Existing generic deploy configurations do not enable this integration automatically.

Provider references: [Analytics Engine SQL API](https://developers.cloudflare.com/analytics/analytics-engine/sql-api/), [sampling](https://developers.cloudflare.com/analytics/analytics-engine/sampling/), [writing events](https://developers.cloudflare.com/workers/examples/analytics-engine/).

Local verification: `node --test scripts/test-endpoint-analytics.mjs scripts/test-endpoint-capacity.mjs scripts/test-endpoint-traffic.mjs scripts/test-governance-api.mjs`. The Analytics and capacity TypeScript unit tests require Node 24+; the bundled governance and gateway tests retain their existing esbuild dependency.

Validation for the automatic-traffic change: 41 focused gateway, governance authorization, report parsing, capacity and config-preservation tests passed. Worker and browser TypeScript checks passed separately. A DOM smoke check verified automatic report rendering, readiness totals, clearing stale usage after an unavailable response, and stopping refresh after disposal. No live provider query, production deployment or full-system load test was performed.
