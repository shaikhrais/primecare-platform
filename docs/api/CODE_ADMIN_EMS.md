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
