# API completion audit

Source checkpoint: `0e0be4d2e4775dd1542d552dd25bacc4e2365e66`. Scope: all 12 gateway bindings, all 12 legacy Dart server entry points, all seven service route libraries and the complete governance operation inventory. Static source audit; no production probe.

| Legacy route source | Route declarations | Placeholder action success responses |
| --- | ---: | ---: |
| services/auth_api/lib/routes.dart | 2 | 1 |
| services/billing_api/lib/routes.dart | 14 | 7 |
| services/client_api/lib/routes.dart | 309 | 154 |
| services/compliance_api/lib/routes.dart | 34 | 17 |
| services/franchise_reporting_api/lib/routes.dart | 142 | 71 |
| services/governance_api/lib/routes.dart | 6 | 3 |
| services/scheduling_api/lib/routes.dart | 26 | 13 |

The seven libraries declare 533 routes and contain 266 `action_completed` placeholder responses. Commented Prisma calls, empty arrays and missing inserts do not establish business workflows. These source counts are not equated with governance operation counts. Active Cloudflare generic screen handlers return 501. Notes and notification Dart entry points contain root greetings; verification contains health/placeholder routing. Real TypeScript auth email recovery does not establish a complete notification service.

Remaining requirements: reconcile PRISMA declarations with canonical Worker routes; establish endpoint permissions and tenant/profile relationships; define request/response validation, workflow transitions and audit semantics; implement and test missing writes. Booking approval/assignment, invoice/payment writes, availability writes, document upload/verification, clinical notes/consent/medication, compliance and franchise reporting require these contracts. Family access, support tickets, referrals, training assignments, API keys and subscriptions lack explicit needed relationships or authority. Model names and screen grants are insufficient endpoint authority.

Batches 205–208 repair live workspace/organization counts and strict workspace query handling, and expose `/v1/governance/api-service-status` under existing inventory authority. It reports 12 gateway service groups plus unassigned labels; operation filters precede aggregation. No inferred grants or readiness flags.

`API_COMPLETION_BACKLOG.csv` records every pending/blocked declaration and required next action. Unit, disposable UUID/text PostgreSQL and production verification remain distinct. No deployment or production database mutation. Full completion remains dependent on explicit business contracts; health routes and passing fixture totals do not establish it.

