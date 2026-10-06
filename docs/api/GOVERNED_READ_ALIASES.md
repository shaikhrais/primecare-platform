# Governed compatibility reads — batches 106–120

Fifteen previously ungoverned GET declarations now route through existing ownership-scoped handlers. The collection names retain their old URLs; responses use canonical metadata shapes rather than unrestricted ORM collections.

| Batch | Existing GET route | Canonical owned metadata route |
| --- | --- | --- |
| 106 | `/v1/premium/appnotification` | `/v1/auth/me/notifications` |
| 107 | `/v1/premium/stafftask` | `/v1/auth/me/assigned-task-records` |
| 108 | `/v1/premium/booking` | `/v1/client/bookings` |
| 109 | `/v1/premium/bookingrequest` | `/v1/client/booking-requests` |
| 110 | `/v1/premium/providerdocument` | `/v1/provider/documents` |
| 111 | `/v1/premium/dailyactivity` | `/v1/auth/me/activities` |
| 112 | `/v1/premium/wellnesspulse` | `/v1/auth/me/wellness-pulses` |
| 113 | `/v1/premium/iotevent` | `/v1/auth/me/device-events` |
| 114 | `/v1/premium/provideravailability` | `/v1/provider/availability` |
| 115 | `/v1/premium/availabilityoverride` | `/v1/provider/availability-overrides` |
| 116 | `/v1/premium/dailyauditsignoff` | `/v1/auth/me/audit-signoff-records` |
| 117 | `/v1/premium/incident` | `/v1/auth/me/reported-incident-records` |
| 118 | `/v1/premium/medicationrecon` | `/v1/auth/me/medication-reconciliation-records` |
| 119 | `/v1/premium/performancereview` | `/v1/auth/me/authored-review-records` |
| 120 | `/v1/premium/technicalaudit` | `/v1/auth/me/technical-audit-records` |

The gateway matches exact collection paths and forwards GET with the original bearer, tenant header and query. It rejects other methods before forwarding, including booking creation requests. Nested/detail/summary paths and other premium collections remain unhandled. CORS preflight uses existing gateway policy.

Canonical handlers require active explicit bearer and a matching non-null actor tenant. Notifications bind actor user_id; assigned tasks bind actor assignee_id, excluding group-only assignments. Bookings and requests require a unique actor-owned client profile and client/tenant-bound queries. Documents require a unique actor-owned provider profile and join that profile in every document query to enforce profile tenant and owning User.

The canonical bounded paging, response projections, no-store headers, read-only repeatable-read transactions, source limits and sanitized errors remain active. These routes confer no new grants. Notifications retain their own stored title/message text; tasks expose stored status/priority/times only, bookings/requests expose owned metadata, and documents exclude file/storage keys. Metadata access does not establish approved bookings, completed care, patient-record access or document verification.

Registration copies the canonical permission and schemas into the fifteen existing declarations and reuses canonical screen links. It does not create extra operation declarations or infer new page readiness. The OpenAPI specification records exact GET contracts. Legacy consumers expecting generic ORM response shapes must adopt these canonical metadata shapes.

Fixtures test exact routing, bearer/query forwarding, owner/tenant SQL predicates, unsupported writes, nested paths, profile ambiguity, paging, source limits and sanitized errors. Disposable PostgreSQL gateway tests verify UUID/text sessions, own/foreign users and tenants, document profile-tenant revocation, projections and inactive/expired sessions. Production verification remains a separate release gate.

Batches 111–115 bind activities, wellness pulses and device events to actor user_id and tenant_id; provider availability and overrides bind the unique owned provider profile and tenant_id. Wellness and device reads exclude notes and raw telemetry. Stored scores, statuses and availability flags do not establish diagnoses, attendance, device trust or bookability.

Batches 116–120 bind the actor User to rn_id for signoffs and reconciliations, reporter_user_id for incidents, reviewer_id for authored reviews, and performed_by_id for technical audits, alongside tenant_id in every query. Responses include only the canonical IDs, stored statuses and timestamps; they exclude clinical contents, incident descriptions, medications, review ratings and audit findings. These reads do not grant clinical access or prove approval, resolved incidents, completed reconciliation or successful audits.
