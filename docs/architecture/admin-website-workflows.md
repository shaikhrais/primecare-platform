# Admin website workflow acceptance

The TypeScript website now mounts the shared report panel only on report surfaces returned by the authenticated workspace API. It uses the existing governed catalog, report generation, PDF and email endpoints. Labels and capabilities come from the server; English, French and Spanish are supported. Reports include provenance and a bounded, escaped table preview. Browser downloads validate the PDF signature. Changing filters or language invalidates the preview and consent. Recipient or message changes invalidate consent.

An email request carries an idempotency key and explicit recipient consent. A pending marker is saved before sending, scoped to user and report. Unknown outcomes remain blocked across redraws, navigation and refresh; successful acceptance clears the marker. The UI reports provider acceptance without claiming inbox delivery. Known validation failures permit correction; uncertain responses do not trigger automatic resends.

Browser acceptance tests use the real website bundle, governed portal theme and actual PDF renderer with synthetic data. All browser requests are restricted to the loopback test server. Backend report policy, PostgreSQL integration and API regression tests run independently. The fixture recording is not evidence of live production delivery.

## Unresolved domain contracts

These remain unresolved rather than being replaced with fabricated actions:

| Task | Existing authority or contract | Required decision/implementation |
| --- | --- | --- |
| Account creation, role/status changes, session administration | Auth APIs explicitly restrict mutations to CEO in the actor's tenant | Define delegation for admin in the central account policy before exposing or widening mutations |
| Tenant creation | No verified admin tenant-provisioning API | Define platform versus tenant administrator authority, tenant ownership, provisioning and audit/rollback semantics |
| Master records | No defined admin master-record entity contract | Define entity registry, schema, scope, validation, duplicate handling, audit and delete semantics |
| Invoice, claim, payment, refund and reconciliation pages | Pages exist but domain data/actions are not wired | Define transaction, approval, accounting and reconciliation contracts; preserve authorization and idempotency |

A successful page-navigation test does not mark a business workflow complete. Existing governance readiness values are preserved. The website reporting integration is an additive fix; it does not complete tenant provisioning or billing workflows.
