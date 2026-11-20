# OpenAPI specification and comment review

Baseline source commit: `152b6649d0744c7622818b6363fa5686f50a0516`. Counts use the checked-in governance export. The comparison is by exact HTTP method and path, with server prefixes and path parameter names preserved as written.

| Measure | Count |
| --- | ---: |
| OpenAPI documents read, including the generated governance catalog | 103 |
| Exact operations in the generated governance catalog | 1,273 |
| Exact operations with endpoint-specific comments in the previous export | 152 |
| Exact catalog operations with a matching source after this review | 209 |
| Exact catalog operations with no matching source after this review | 1,064 |
| Source-documented operations absent from the exact catalog key set | 282 |

The documentation exporter reads YAML and JSON, includes inherited security requirements and path parameters, and retains conflicting sources individually. Proposal labels remain visible. The contract-factory placeholders contribute zero endpoint documentation matches because their operation records explicitly require contract decisions.

## Priority follow-through

| Operation | Evidence | Remaining work |
| --- | --- | --- |
| `GET /v1/clinical/dashboard` | [OpenAPI](../../tests/fixtures/clinical-director-api-candidate/api-only-contract.openapi.json) and [route fixture](../../tests/fixtures/clinical-director-api-candidate/route.test.mjs) cover the assigned verified branch count, role and tenant scope, denial, throttling and dependency failures. | Verify the candidate against production governance and the deployed gateway and Worker. |
| `POST /v1/user/preferences` | [YAML contract](account-preferences.openapi.yaml) documents supported actions, versioned request scope and response errors. | Confirm the exact production contract, scoped grants and activation before trusting a live call. |
| `GET /v1/admin/users/privileged` | [Authority review](ADMIN_READ_AUTHORITY_AUDIT.md) records generic user-detail routing and a missing endpoint permission key. | Define the permitted roles, scope and response contract for a privileged-user listing. |
| Care Delivery | [OpenAPI](../care/openapi.json) documents tenant-scoped reads and commands. [Care acceptance notes](../care/README.md) record test and release evidence. | Confirm the live API and the remaining clinical, privacy and accessibility acceptance gates. |

## Per-file inventory

The response and security columns count declarations in each document. Missing response or security declarations may be intentional in patch documents. Explicit empty security is recorded separately because it overrides inherited security. Catalog and draft entries are included in this table.

| Document | OpenAPI | Operations | Summaries | Descriptions | Explicit 2xx | Security declared | Explicit empty security |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| [docs/api/account-batch-2.openapi.json](../../docs/api/account-batch-2.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/account-batch-3.openapi.json](../../docs/api/account-batch-3.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/account-batch-4.openapi.json](../../docs/api/account-batch-4.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/account-count-validation-batches-203-204.openapi.json](../../docs/api/account-count-validation-batches-203-204.openapi.json) | 3.1.0 | 5 | 5 | 5 | 5 | 5 | 0 |
| [docs/api/account-preferences.openapi.yaml](../../docs/api/account-preferences.openapi.yaml) | 3.1.0 | 1 | 0 | 1 | 1 | 1 | 0 |
| [docs/api/account-read-validation-batches-249-253.openapi.json](../../docs/api/account-read-validation-batches-249-253.openapi.json) | 3.1.0 | 5 | 5 | 5 | 5 | 5 | 0 |
| [docs/api/admin-reports.openapi.json](../../docs/api/admin-reports.openapi.json) | 3.1.0 | 4 | 0 | 4 | 4 | 4 | 0 |
| [docs/api/api-execution-status-batch-20.openapi.json](../../docs/api/api-execution-status-batch-20.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/api-service-status-batch-207.openapi.json](../../docs/api/api-service-status-batch-207.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/auth-body-bounds-batches-254-258.openapi.json](../../docs/api/auth-body-bounds-batches-254-258.openapi.json) | 3.1.0 | 6 | 0 | 6 | 6 | 6 | 3 |
| [docs/api/auth-delivery-work-package.openapi.json](../../docs/api/auth-delivery-work-package.openapi.json) | 3.1.0 | 4 | 0 | 4 | 4 | 4 | 4 |
| [docs/api/auth-lifecycle-openapi.json](../../docs/api/auth-lifecycle-openapi.json) | 3.1.0 | 11 | 0 | 11 | 11 | 11 | 2 |
| [docs/api/auth-rate-validation-batches-264-268.openapi.json](../../docs/api/auth-rate-validation-batches-264-268.openapi.json) | 3.1.0 | 6 | 0 | 6 | 6 | 6 | 3 |
| [docs/api/auth-result-validation-batches-259-263.openapi.json](../../docs/api/auth-result-validation-batches-259-263.openapi.json) | 3.1.0 | 6 | 1 | 6 | 6 | 6 | 1 |
| [docs/api/auth-session-tenant.openapi.json](../../docs/api/auth-session-tenant.openapi.json) | 3.1.0 | 5 | 0 | 5 | 5 | 0 | 0 |
| [docs/api/authored-message-batch-220.openapi.json](../../docs/api/authored-message-batch-220.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/booking-collection-delivery.openapi.json](../../docs/api/booking-collection-delivery.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/booking-payment-batches-23-25.openapi.json](../../docs/api/booking-payment-batches-23-25.openapi.json) | 3.1.0 | 4 | 4 | 4 | 4 | 4 | 0 |
| [docs/api/booking-requests-delivery.openapi.json](../../docs/api/booking-requests-delivery.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/booking-submission-delivery.openapi.json](../../docs/api/booking-submission-delivery.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/client-booking-lifecycle-batch-19.openapi.json](../../docs/api/client-booking-lifecycle-batch-19.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/client-booking-requests-batch-18.openapi.json](../../docs/api/client-booking-requests-batch-18.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-bookings-batch-9.openapi.json](../../docs/api/client-bookings-batch-9.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-count-validation-batch-195.openapi.json](../../docs/api/client-count-validation-batch-195.openapi.json) | 3.1.0 | 0 | 0 | 0 | 0 | 0 | 0 |
| [docs/api/client-family-notification-summary-batch-223.openapi.json](../../docs/api/client-family-notification-summary-batch-223.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/client-family-notifications-batch-222.openapi.json](../../docs/api/client-family-notifications-batch-222.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-feedback-batches-36-38.openapi.json](../../docs/api/client-feedback-batches-36-38.openapi.json) | 3.1.0 | 4 | 4 | 4 | 4 | 4 | 0 |
| [docs/api/client-feedback-summaries-batches-37-39.openapi.json](../../docs/api/client-feedback-summaries-batches-37-39.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-invoices-batch-12.openapi.json](../../docs/api/client-invoices-batch-12.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-operational-projections-batches-191-194.openapi.json](../../docs/api/client-operational-projections-batches-191-194.openapi.json) | 3.1.0 | 10 | 10 | 10 | 10 | 10 | 0 |
| [docs/api/client-payment-history-batches-209-211.openapi.json](../../docs/api/client-payment-history-batches-209-211.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/client-record-summaries-batch-22.openapi.json](../../docs/api/client-record-summaries-batch-22.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/client-records-batch-21.openapi.json](../../docs/api/client-records-batch-21.openapi.json) | 3.1.0 | 6 | 6 | 6 | 6 | 6 | 0 |
| [docs/api/client-self-batch-7.openapi.json](../../docs/api/client-self-batch-7.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-thread-family-batches-46-48.openapi.json](../../docs/api/client-thread-family-batches-46-48.openapi.json) | 3.1.0 | 4 | 4 | 4 | 4 | 4 | 0 |
| [docs/api/client-thread-family-summaries-batches-47-49.openapi.json](../../docs/api/client-thread-family-summaries-batches-47-49.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/client-visits-batch-11.openapi.json](../../docs/api/client-visits-batch-11.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/contract-factory/openapi-drafts.json](../../docs/api/contract-factory/openapi-drafts.json) | 3.1.0 | 1063 | 1063 | 0 | 0 | 0 | 0 |
| [docs/api/contract-gaps-batches-101-105.openapi.json](../../docs/api/contract-gaps-batches-101-105.openapi.json) | 3.1.0 | 5 | 5 | 5 | 5 | 5 | 0 |
| [docs/api/existing-auth-batches-242-247.openapi.json](../../docs/api/existing-auth-batches-242-247.openapi.json) | 3.1.0 | 6 | 1 | 6 | 6 | 6 | 0 |
| [docs/api/generated-record-count-validation-batches-199-200.openapi.json](../../docs/api/generated-record-count-validation-batches-199-200.openapi.json) | 3.1.0 | 69 | 69 | 69 | 69 | 69 | 0 |
| [docs/api/governance-batch-1.openapi.json](../../docs/api/governance-batch-1.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/governed-read-aliases-batches-106-110.openapi.json](../../docs/api/governed-read-aliases-batches-106-110.openapi.json) | 3.1.0 | 5 | 5 | 5 | 5 | 5 | 0 |
| [docs/api/governed-read-aliases-batches-106-115.openapi.json](../../docs/api/governed-read-aliases-batches-106-115.openapi.json) | 3.1.0 | 10 | 10 | 10 | 10 | 10 | 0 |
| [docs/api/governed-read-aliases-batches-106-120.openapi.json](../../docs/api/governed-read-aliases-batches-106-120.openapi.json) | 3.1.0 | 15 | 15 | 15 | 15 | 15 | 0 |
| [docs/api/governed-read-aliases.openapi.json](../../docs/api/governed-read-aliases.openapi.json) | 3.1.0 | 72 | 72 | 72 | 72 | 72 | 0 |
| [docs/api/legacy-domain-batch-17.openapi.json](../../docs/api/legacy-domain-batch-17.openapi.json) | 3.1.0 | 10 | 10 | 10 | 0 | 0 | 0 |
| [docs/api/live-screen-text.openapi.json](../../docs/api/live-screen-text.openapi.json) | 3.1.0 | 4 | 0 | 3 | 4 | 2 | 0 |
| [docs/api/own-audit-events-batches-158-159.openapi.json](../../docs/api/own-audit-events-batches-158-159.openapi.json) | 3.1.0 | 4 | 4 | 4 | 4 | 4 | 0 |
| [docs/api/own-client-care-counts-batches-175-177.openapi.json](../../docs/api/own-client-care-counts-batches-175-177.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/own-client-care-events-batches-179-187.openapi.json](../../docs/api/own-client-care-events-batches-179-187.openapi.json) | 3.1.0 | 18 | 18 | 18 | 18 | 18 | 0 |
| [docs/api/own-client-care-metadata-batches-172-174.openapi.json](../../docs/api/own-client-care-metadata-batches-172-174.openapi.json) | 3.1.0 | 6 | 6 | 6 | 6 | 6 | 0 |
| [docs/api/own-client-shift-counts-batch-188.openapi.json](../../docs/api/own-client-shift-counts-batch-188.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/own-patient-metadata-batches-166-168.openapi.json](../../docs/api/own-patient-metadata-batches-166-168.openapi.json) | 3.1.0 | 6 | 6 | 6 | 6 | 6 | 0 |
| [docs/api/own-patient-status-summaries-batches-169-171.openapi.json](../../docs/api/own-patient-status-summaries-batches-169-171.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/own-provider-work-batches-160-163.openapi.json](../../docs/api/own-provider-work-batches-160-163.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/owned-commerce-authoring-batches-225-231.openapi.json](../../docs/api/owned-commerce-authoring-batches-225-231.openapi.json) | 3.1.0 | 11 | 11 | 11 | 11 | 11 | 0 |
| [docs/api/owned-patient-observations-batches-236-239.openapi.json](../../docs/api/owned-patient-observations-batches-236-239.openapi.json) | 3.1.0 | 6 | 6 | 6 | 6 | 6 | 0 |
| [docs/api/owner-session-count-validation-batches-201-202.openapi.json](../../docs/api/owner-session-count-validation-batches-201-202.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/owner-summaries-batch-14.openapi.json](../../docs/api/owner-summaries-batch-14.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/personal-authorship-task-batches-76-80.openapi.json](../../docs/api/personal-authorship-task-batches-76-80.openapi.json) | 3.1.0 | 9 | 9 | 9 | 9 | 9 | 0 |
| [docs/api/personal-care-metadata-batches-71-75.openapi.json](../../docs/api/personal-care-metadata-batches-71-75.openapi.json) | 3.1.0 | 10 | 10 | 10 | 10 | 10 | 0 |
| [docs/api/personal-metadata-batches-41-45.openapi.json](../../docs/api/personal-metadata-batches-41-45.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/personal-operational-audit-batches-96-97-100.openapi.json](../../docs/api/personal-operational-audit-batches-96-97-100.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/personal-report-audit-batches-81-85.openapi.json](../../docs/api/personal-report-audit-batches-81-85.openapi.json) | 3.1.0 | 10 | 10 | 10 | 10 | 10 | 0 |
| [docs/api/personal-review-telehealth-batches-86-90.openapi.json](../../docs/api/personal-review-telehealth-batches-86-90.openapi.json) | 3.1.0 | 9 | 9 | 9 | 9 | 9 | 0 |
| [docs/api/personal-status-summaries-batches-91-95.openapi.json](../../docs/api/personal-status-summaries-batches-91-95.openapi.json) | 3.1.0 | 5 | 5 | 5 | 5 | 5 | 0 |
| [docs/api/personal-work-log-batches-66-70.openapi.json](../../docs/api/personal-work-log-batches-66-70.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/platform-admin.openapi.json](../../docs/api/platform-admin.openapi.json) | 3.1.0 | 11 | 11 | 11 | 11 | 11 | 0 |
| [docs/api/provider-availability-batch-16.openapi.json](../../docs/api/provider-availability-batch-16.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/provider-documents-batch-13.openapi.json](../../docs/api/provider-documents-batch-13.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/provider-event-fleet-match-batches-61-65.openapi.json](../../docs/api/provider-event-fleet-match-batches-61-65.openapi.json) | 3.1.0 | 7 | 7 | 7 | 7 | 7 | 0 |
| [docs/api/provider-metadata-batches-51-55.openapi.json](../../docs/api/provider-metadata-batches-51-55.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/provider-metadata-batches-56-60.openapi.json](../../docs/api/provider-metadata-batches-56-60.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/provider-operational-projections-batches-196-198.openapi.json](../../docs/api/provider-operational-projections-batches-196-198.openapi.json) | 3.1.0 | 10 | 10 | 10 | 10 | 10 | 0 |
| [docs/api/provider-review-availability-batches-98-99.openapi.json](../../docs/api/provider-review-availability-batches-98-99.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/provider-self-batch-8.openapi.json](../../docs/api/provider-self-batch-8.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/provider-timesheet-items-batches-213-215.openapi.json](../../docs/api/provider-timesheet-items-batches-213-215.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/provider-training-batches-217-218.openapi.json](../../docs/api/provider-training-batches-217-218.openapi.json) | 3.1.0 | 3 | 3 | 3 | 3 | 3 | 0 |
| [docs/api/provider-visits-batch-10.openapi.json](../../docs/api/provider-visits-batch-10.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/self-device-wellness-batches-31-35.openapi.json](../../docs/api/self-device-wellness-batches-31-35.openapi.json) | 3.1.0 | 8 | 8 | 8 | 8 | 8 | 0 |
| [docs/api/self-password-history-batch-50.openapi.json](../../docs/api/self-password-history-batch-50.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/self-records-batches-26-30.openapi.json](../../docs/api/self-records-batches-26-30.openapi.json) | 3.1.0 | 7 | 7 | 7 | 7 | 7 | 0 |
| [docs/api/self-reputation-batch-40.openapi.json](../../docs/api/self-reputation-batch-40.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/api/self-sessions-batch-6.openapi.json](../../docs/api/self-sessions-batch-6.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/visit-document-summaries-batch-15.openapi.json](../../docs/api/visit-document-summaries-batch-15.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/api/workspace-count-validation-batches-205-208.openapi.json](../../docs/api/workspace-count-validation-batches-205-208.openapi.json) | 3.1.0 | 3 | 2 | 3 | 3 | 3 | 0 |
| [docs/api-openapi.yaml](../../docs/api-openapi.yaml) | 3.0.3 | 4 | 4 | 0 | 4 | 0 | 0 |
| [docs/appearance/look-provider.openapi.json](../../docs/appearance/look-provider.openapi.json) | 3.1.0 | 1 | 0 | 1 | 1 | 1 | 1 |
| [docs/appearance/look.openapi.json](../../docs/appearance/look.openapi.json) | 3.1.0 | 5 | 5 | 5 | 5 | 5 | 0 |
| [docs/appearance/pc10-section2-help-proposal.openapi.json](../../docs/appearance/pc10-section2-help-proposal.openapi.json) | 3.1.0 | 1 | 1 | 1 | 1 | 1 | 0 |
| [docs/auth-openapi.json](../../docs/auth-openapi.json) | 3.1.0 | 7 | 7 | 7 | 7 | 7 | 1 |
| [docs/care/coordinator-charge.openapi.json](../../docs/care/coordinator-charge.openapi.json) | 3.1.0 | 2 | 2 | 0 | 2 | 2 | 0 |
| [docs/care/openapi.json](../../docs/care/openapi.json) | 3.1.0 | 9 | 9 | 9 | 9 | 9 | 0 |
| [docs/care/tenant-dashboard.openapi.json](../../docs/care/tenant-dashboard.openapi.json) | 3.1.0 | 2 | 2 | 0 | 2 | 2 | 0 |
| [docs/marketing/admin-hierarchy.openapi.json](../../docs/marketing/admin-hierarchy.openapi.json) | 3.1.0 | 2 | 2 | 2 | 2 | 2 | 0 |
| [docs/marketing/growth.openapi.json](../../docs/marketing/growth.openapi.json) | 3.1.0 | 32 | 32 | 18 | 32 | 32 | 2 |
| [docs/platform-bundle/openapi.json](../../docs/platform-bundle/openapi.json) | 3.1.0 | 12 | 12 | 0 | 12 | 12 | 0 |
| [docs/platform-operations/openapi.json](../../docs/platform-operations/openapi.json) | 3.1.0 | 1 | 1 | 0 | 1 | 1 | 0 |
| [docs/territories/openapi.json](../../docs/territories/openapi.json) | 3.1.0 | 2 | 2 | 0 | 2 | 2 | 0 |
| [packages/contracts/communications.openapi.json](../../packages/contracts/communications.openapi.json) | 3.1.0 | 32 | 32 | 32 | 31 | 32 | 0 |
| [packages/contracts/openapi.json](../../packages/contracts/openapi.json) | 3.1.0 | 1273 | 1273 | 1273 | 0 | 0 | 0 |
| [tests/fixtures/clinical-director-api-candidate/api-only-contract.openapi.json](../../tests/fixtures/clinical-director-api-candidate/api-only-contract.openapi.json) | 3.1.0 | 1 | 0 | 1 | 1 | 1 | 0 |

## Regenerate endpoint comments

The [documentation workflow](../../.github/workflows/document-all-api-endpoints.yml) uses the approved read-only production catalog connection through `PRODUCTION_DATABASE_URL` and generates the [endpoint reference](../../packages/contracts/ENDPOINT_REFERENCE.md), [navigation index](../../packages/contracts/API_DOCUMENTATION_INDEX.md), [coverage](../../packages/contracts/api-documentation-coverage.json) and the draft [OpenAPI catalog](../../packages/contracts/openapi.json). Local verification runs `python scripts/test-api-documentation.py` and `python scripts/test_governed_openapi.py`. Ensure `PyYAML` is available for YAML input.

The [delivery checklist](API_DELIVERY_CHECKLIST.md), [route audit](API_REACHABILITY_AUDIT.md) and [per-operation backlog](API_COMPLETION_BACKLOG.csv) track implementation and verification separately from these source counts.
