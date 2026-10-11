# Shared administration reports

Requested purpose: all administrative roles use centrally controlled reports, downloadable PDFs and email delivery to a entered recipient. Extend the existing ReportData parent without duplicating role-specific controllers.

## Implemented scope

- A governance-derived catalog covers every active role with an existing page-view grant. Page-readiness reports include only pages visible to that role, with search and readiness filters. Catalog, generation, PDF export and email have separate registered grants.
- Organization summary requires both an explicit report grant and the existing organization permission. Currently CEO only. Uses tenant-scoped account/session counts and schema-verified operational totals; absent tenant bindings remain unavailable. No clinical record export, financial calculations or invented zero totals.
- Shared TypeScript AdminReportDefinition parents, ReportPolicy, ReportService, PdfReportRenderer and ReportDeliveryService. Dart AdminReportResult extends ReportData; one shared transport and Flutter panel serve governed dashboard/report surfaces.
- English, French and Spanish labels. Governance translations are recorded as unreviewed. Report names, role codes and historical requirement text retain their source language.
- Filtered JSON preview (first 50 rows in UI), PDF download/share, all report rows in the PDF, repeated headings, wrapping, page numbers, generation time, classification and scope. PDF uses landscape A4 and WinAnsi fonts; unsupported scripts require a future embedded Unicode font. Dates currently use ISO generation time; there is no financial currency conversion.
- Enter one external/internal recipient, subject and plain-text message; confirm recipient and sharing authority. Native Cloudflare delivery includes a server-generated PDF attachment; caller-uploaded PDFs, raw SQL, HTML and arbitrary tenant overrides are rejected. Sender uses validated tenant configuration or deployment default, and respects the allowed sender.
- Durable recipient/delivery records; idempotency payload binding; commit sending claim before external send. Duplicate keys replay acceptance or return conflict. Ten new email requests per actor/tenant/hour, serialized with PostgreSQL advisory locks. Provider acceptance is not confirmed inbox delivery. Unknown sends require investigation; neither the API nor UI automatically resends them.
- Sensitive responses are no-store. Active explicit bearer session and tenant checks apply to all operations. Errors never disclose database or mail details; Flutter report paths cannot use the legacy mock/cache fallback.

## Registration and deployment

Run `python3 scripts/register-admin-reports.py` against the local governance source database before implementation generation. It registers definitions, requirements, role grants, surfaces, localized labels and four API contracts, then exports report-registry.json and OpenAPI. `--check` verifies exact runtime-policy parity. Registration is idempotent and versioned as an executable migration; the 81 MiB legacy database snapshot is not duplicated in this change. Run registration after restoring that snapshot to obtain the new governance state.

Apply `cloudflare/workers/contracts/admin-reports.sql` through the database migration process before enabling production generation and delivery. Report run/download requires durable audit; without the migration it fails unavailable. Catalog still functions. No production database migration or email has been executed by the tests.

Worker routes belong to governance: GET /v1/governance/reports, GET /v1/governance/reports/{reportId}, GET /v1/governance/reports/{reportId}/pdf, POST /v1/governance/reports/{reportId}/email. Existing gateway service routing forwards these paths; the business-module registry invokes reporting only for governance. The current reportId values are page_readiness and organization_summary.

Configure an onboarded outbound sending domain and native EMAIL binding on the governance Worker. EMAIL_FROM is the fallback sender; tenant configuration can override it within EMAIL_ALLOWED_SENDER. Account provisioning, provider limits and region/data-residency approval must be verified at deployment. Attachments are capped at 3 MiB raw bytes to allow overhead within the general 5 MiB mail limit. Tests use fake recipients and transport fixtures, never real emails.

Report audit stores actor, tenant, report and operation. Delivery audit additionally stores recipient, key, payload fingerprint and provider acceptance ID. Restrict access and define operational retention. Current attachment reports contain page metadata or aggregate counts; patient/employee detail sharing needs approved disclosure rules and recipient-bound secure access before addition.

## Planned maximum-feature catalog

| Area | Subsequent features | Required input |
|---|---|---|
| Finance | Revenue, invoices, receivables aging, refunds, reconciliation, payroll, taxes | Validated ledgers, currency/time rules and finance permissions |
| Operations | Visits, staffing, no-shows, utilization, service delays, branch comparisons | Tenant and branch scoped workflow sources |
| HR/training | Attendance, onboarding, credential expiry, training and turnover | Employment/privacy rules and verified HR records |
| Clinical/quality | Documentation, care-plan reviews, outcomes, incidents, follow-ups | Approved clinical metrics and disclosure rules |
| Executive | Targets, variance, growth, franchise/regional consolidation | Explicit cross-organization scope; no inferred global access |
| IT/support/marketing | Health, failures, access reviews, tickets, leads, conversion and campaigns | Verified event sources and metric definitions |
| Builder | Approved fields, grouping, charts, formulas, saved templates and presets | Field registry and safe query compiler |
| Formats | CSV, Excel, branded PDF templates, accessible tagged PDF, Unicode fonts | Format adapters and export tests |
| Scheduling | Daily/weekly/monthly, timezone/DST, pause, expiry, skip-empty and event triggers | Durable scheduler, permission revalidation and cancellation |
| Sharing | Recipient-specific variants, expiring/revocable links, recipient verification | Storage, token binding and disclosure policy |
| Jobs | Large background exports, progress, cancellation, history and retention | Durable jobs/storage and resource budgets |
| Delivery | CC/BCC, recipient groups, bounces, complaints, delivery events and suppression | Recipient policy and authenticated provider-event ingestion |
| Analytics | Drill-down, trends, cohorts, benchmarks and anomaly alerts | Verified historical snapshots and metric semantics |

These features are planned, not implemented. No unresolved workflow from the existing finite API checklist is credited as completed by this reporting change. Updated source hashes describe the additive report integration; prior operation stages remain intact.

## Validation

Node API fixtures test catalogs, every role grant, search/locales, tenant denial, unavailable data, complete PDFs, escaping, bounded input, consent, claims, replay, payload conflicts, mail failures and quotas. An independent PDF parser verified a 27-page fixture, including its final row and French accents. PostgreSQL integration tests exercise actual migrations, six concurrent duplicate requests, cross-tenant denial, run audit, uncertain delivery, stuck claims and quotas. Flutter tests exercise shared model inheritance, real failure propagation, byte validation, email request headers, server capabilities and controls at 320/768/1440/3840 logical widths. CI validates registration parity and runs existing workspace/email tests. Full native platform builds, live delivery and patient-data disclosure are outside these tests.

CI also exposed an existing image/archive dependency mismatch (image 4.11.0 with archive 4.0.9). The shared Flutter dependency now pins corrected image 4.11.1, whose published constraint requires compatible archive 4.4.0. This is necessary to compile the report PDF/share package and existing UI tests.
