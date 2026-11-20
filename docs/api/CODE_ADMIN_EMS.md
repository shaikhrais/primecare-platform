# Code Admin Endpoint Management System

Open **Endpoint management · EMS** in Code Admin's System navigation, or use `/platform/administration#ems`. The panel is a registered child of the existing administration host. It uses the same shell, theme, language selection and session lifecycle. Only Code Admin sees this navigation entry; hashes do not grant access to other roles.

## New read APIs

Every route below requires a current active Code Admin session, an active tenant, the pinned governance manifest, and an explicit view grant for `CODE_ADMIN_EMS_DASHBOARD` plus the exact registered API grant. Missing, revoked, duplicate or inconsistent metadata denies access. All six endpoints reject writes. Responses disable caching, query options are bounded, and tenant overrides are rejected.

| Method | Route | Purpose |
| --- | --- | --- |
| GET | `/v1/governance/platform/ems/summary` | Catalog declaration/unique-operation counts and implementation, protection, readiness and maintenance totals. |
| GET | `/v1/governance/platform/ems/endpoints` | Search and paginate operation status and evidence, including the EMS routes' live registration metadata. |
| GET | `/v1/governance/platform/ems/services` | Per-service coverage and readiness counts using the same underlying records. |
| GET | `/v1/governance/platform/ems/traffic` | Timestamped, sample-weighted gateway request, declared-transfer, status and latency metrics when the approved reader is configured. |
| GET | `/v1/governance/platform/ems/capacity` | An explicit unmeasured state or validated, expiring reference benchmark and bottleneck-specific scaling guidance. |
| GET | `/v1/governance/platform/ems/maintenance` | Paginated recorded, scheduled and active maintenance declarations. These windows do not block business traffic. |

`endpoints`, `services` and `maintenance` accept the existing `limit` (1–100), `offset`, `search`, `app`, `role` and `screen` options. Other EMS reads accept no query options. Role/app/screen filters describe inventory metadata; they do not change the caller's authority. Metadata reads use a read-only database transaction. The optional existing Workspace source limiter applies before database access.

## Understand the evidence

The baseline operation inventory remains a governed source snapshot. The six new EMS registrations are reconciled live by method, path and metadata identity, so they appear without invented numeric IDs or waiting for the next snapshot export. A future export replaces the matching entries without duplicate counting. The gateway also recognizes the exact EMS operation paths for traffic buckets. Other new or changed business registrations still require the normal governed snapshot export.

“Declared implemented” does not mean protected or ready. Readiness uses the same existing exact-operation, current-release receipts as the rest of the inventory. A permission field alone does not prove runtime enforcement. Anonymous denial is useful boundary evidence, but does not prove successful authenticated behavior or tenant isolation in production.

HTTP 2xx throughput is not successful business workflow throughput. Gateway observations exclude direct service traffic. Known transfer bytes use declared body lengths; missing lengths and sampling remain visible. Headers, transport overhead, completed transfers and billable network usage require independent edge measurements. No request bodies, credentials or caller identifiers are stored in the new traffic projection.

## Traffic and capacity configuration

EMS traffic additionally requires `ENDPOINT_ANALYTICS_READER_ROLE=code_admin` and the caller's exact approved `ENDPOINT_ANALYTICS_READER_TENANT_ID`. The provider account and dedicated Analytics Read secret must be configured on governance, and the gateway's existing opt-in collection and dataset binding must be active. These settings grant platform-wide gateway usage within the explicit Code Admin reporting tenant. The legacy inventory API's role grants are unchanged. Existing configuration preparation and preflight helpers now recognize the separately registered Code Admin EMS reader.

`ENDPOINT_CAPACITY_EVIDENCE` may hold the JSON benchmark produced by the existing reviewed staging load-test process. Oversized, invalid, expired or failing evidence is unavailable. Valid evidence is a **reference** with its workload, environment, expiry and serving-release match; it never marks full-system production capacity verified. Staging read benchmarks are labelled as such. Without evidence, the dashboard says **unmeasured**, rather than inventing a request limit.

Measure the first resource bottleneck before scaling: database query/connection waits, Worker CPU per operation, queue age, downstream quotas and response bytes. Apply the corresponding query/index/pooling, projection/pagination/compression, safe caching or bounded-concurrency improvement, then repeat the same representative profile. The capacity API returns the measured bottleneck's next action when supplied, or asks for resource measurements when the bottleneck is unknown.

## Registration and release

`packages/shared/src/endpoint-management/contract.json` is the source contract. `ems_registration.py` uses an exact definition hash and dedicated write opt-in to add one screen, its **view-only** Code Admin grant, six GET endpoint declarations and their links/permissions. It does not create users, assign accounts, change schemas or write business data. Conflicting registrations are preserved and rejected; repeated registration is idempotent. Production registration is first dry-run in a transaction and rolled back, then applied after tests through the existing production store.

The `Code Admin EMS APIs and registration` workflow follows the existing pilot release-scope gate. After tests and registration, it can publish the governance Worker through the existing binding-preserving deployment script and publish only the governance Pages project. Its public probes require 401 for every EMS GET without a session. Those receipts are not authenticated Code Admin acceptance or capacity evidence. It does not configure a provider credential, enable gateway collection, seed demo data or claim any business endpoint ready.

## Validation

Focused API, native PostgreSQL permission-join, metadata registration, navigation/session cleanup, dashboard rendering/pagination and existing endpoint regressions accompany the change. The SQL fixture can use a disposable PostgreSQL `ems_test` database; the explicit in-memory PostgreSQL engine is test-only and refuses production connection variables. Live telemetry activation, authenticated Code Admin acceptance and a representative full-system load test remain separate operational evidence.

## Existing-secret activation

The separately scoped `Activate EMS analytics using existing GitHub secrets` workflow resolves the existing registered Code Admin control tenant in a read-only database transaction, checks analytics access, preserves unrelated live Worker bindings, then publishes only governance and gateway with the analytics configuration. It follows the existing release-scope gate and verifies exact deployed versions and anonymous EMS denial. It creates no accounts, changes no role assignments and sends no email.

At the user's explicit request, when no `ENDPOINT_ANALYTICS_READ_TOKEN` GitHub secret exists, activation uses the existing `CLOUDFLARE_API_TOKEN` after verifying its Analytics Engine read access. That credential stays encrypted on the governance Worker and is excluded from generated configs, logs and artifacts. A dedicated Analytics Read secret can replace it later. Collection and sampled reports do not establish full-system capacity or authenticated production acceptance. Missing control-tenant registration blocks activation before provider writes.

## Streamed response body measurements

The separate `ENDPOINT_BODY_ANALYTICS` binding writes `primecare_endpoint_body_v1` completion events. Response streams count application bytes as pulled before gateway compression, without cloning, whole-body buffering or payload retention. Completed and interrupted bodies have separate counts and byte totals. Pre-encoded responses, WebSockets and event streams are excluded. HEAD/no-body responses record zero. Completion events never add to request counts and can fall in a different reporting window than request arrivals. These measurements exclude headers, edge encoding and billable network overhead. Existing declared-length metrics remain separate, with unknown sizes explicit.

Deployment verification first matches the exact Wrangler-reported version. When provider version identities differ, an explicit alternate receipt compares all emitted executable/resource modules with hashes of the active Worker content, requires the latest listed version to equal the sole 100% active version, and rechecks that lineage afterward. The receipt records the active and Wrangler-reported IDs separately; it never claims those IDs match or grants workflow readiness credit. Unrelated bindings are still checked independently.

## Activation receipt and remaining acceptance

The [2026-11-20 activation run](https://github.com/shaikhrais/primecare-platform/actions/runs/44747123038) reported both governance and gateway deployed from `928639630d25c5c3d64108c3367b7058d206894f`, with independent version readback, all six telemetry configuration checks passing, response-body collection enabled, all 12 service health checks healthy, and six anonymous EMS reads denied. The activation receipt explicitly recorded live data pending ingestion. This supersedes the earlier missing-configuration preflight; it does not prove populated traffic reports or authenticated Code Admin acceptance.

The capacity panel warns when `servingReleaseMatches` is false or missing. An otherwise valid reference benchmark remains labelled as a reference and must be repeated against the current release before it informs capacity planning. Even a matching reference does not certify full-system production capacity.

The [live telemetry verification](https://github.com/shaikhrais/primecare-platform/actions/runs/44743298178) observed a completed five-minute report at `2026-11-20T13:52:37.636Z`: 13 sample-weighted gateway requests (about 0.043 requests/s), with 10 completed response bodies totalling 476 application bytes and no interrupted bodies. Counts, latency and body queries all returned HTTP 200. All 13 declared outbound lengths were unknown; streamed body measurements are separate and must not be confused with declared-length totals or billable network transfer. These observations establish populated production telemetry, not full-system throughput, current traffic or authenticated dashboard acceptance.

## HTML5 charts

The Code Admin EMS host now includes responsive SVG charts for readiness distribution, request rate, the six busiest observed operations, and HTTP status families. Each chart provides an expandable data table. Traffic uses the same validated report as the operation table. The request trend holds at most 24 distinct completed windows in memory, deduplicates refreshes, and breaks the line across missing windows. Unavailable traffic clears the charts and session history; exiting the host disposes it. No historical observations are invented or stored in browser persistence.

Refresh EMS also refreshes traffic and service totals. The readiness selector filters the current inventory page, as labelled; endpoint search remains server-paginated. All three existing locales are supported. The production panel inherits the shared theme and existing authenticated APIs.


## Central UI ownership

`packages/primecare_ui/web/ems-charts.ts` owns the six metric widgets, accessible chart cards and session trend controls through `PrimeEmsDashboardControls`, using the shared `ThemeControlBase` lifecycle. `ems-dashboard-styles.ts` owns their presentation and installs one stylesheet per document. Colors, surfaces, typography, spacing and card shadows inherit the active central theme; there is no EMS palette or separate theme instance. The Code Admin host imports the central control group directly. The former website chart module is a compatibility export, and feature CSS has been removed from the website stylesheet.

Traffic validation and calculations are owned by `packages/domain/src/endpoint_traffic.ts`; the website traffic module preserves its existing import API through a compatibility export. The EMS dashboard accepts data only from its authenticated APIs. Existing API authorization and reporting scopes remain owned by the EMS host and service.

## API-only dashboard

The synthetic standalone HTML and its generator have been removed. Code Admin EMS has no demo mode, simulated traffic or local report import. The central inventory control hides and disables file imports when mounted with the EMS API paths. Summary, endpoints, services, traffic, capacity and maintenance come from the six authenticated EMS reads. Missing or unavailable data remains explicitly unavailable or unmeasured. Synthetic fixtures are restricted to automated tests and are not bundled into the dashboard.

`packages/primecare_ui/web/endpoint-management-panel.ts` also owns inventory search, paging, readiness filters and traffic display. The website module is only a compatibility export. The existing common API Health panel retains its separately scoped report-import feature; it is not enabled in Code Admin EMS.

The complete EMS screen is now owned by `packages/primecare_ui/web/code-admin-ems.ts`. The administration host imports it directly, while the former website screen module preserves compatibility through a re-export. Central EMS styles also control buttons, form inputs, selects, focus treatment and tables through the scoped `data-pc-ems-dashboard` marker. The marker is removed on disposal. All six reporting reads retain bearer authentication and current-session ownership checks; no demo source or import control is available in this screen.

## Compact dashboard composition

The central EMS layout now uses a six-widget desktop row, a wide traffic trend next to readiness, and compact operational-status, namespace-traffic and HTTP-status panels. The status mix uses a stacked chart. Namespace traffic is explicitly grouped by the `/v1/{namespace}` prefix, with unmatched traffic retained; it is not a claim of independently measured service utilization. Busiest-operation details remain available in a collapsed disclosure. The endpoint table starts with eight operational columns, method/status badges and a detailed-column toggle. Capacity and maintenance are separate compact panels; no utilization gauge is inferred from an unmeasured or mismatched benchmark.

The trend area follows only observed adjacent windows and retains gaps. It does not manufacture a 60-minute history or comparison series. Widget/row values remain projections of authenticated API reports. The latest source passed 32 focused checks, followed by five UI regressions after presentation changes, plus browser TypeScript checking. Internal static layout inspection covered the access-denied state; authenticated live browser acceptance remains outstanding. The generated design concept is a visual target, not acceptance evidence.
