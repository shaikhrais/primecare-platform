# Governed compatibility reads — batches 106–152

Forty-seven previously ungoverned GET declarations now route through existing ownership-scoped handlers. The collection names retain their old URLs; responses use canonical metadata shapes rather than unrestricted ORM collections.

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

| 121 | `/v1/premium/userdevice` | `/v1/auth/me/devices` |
| 122 | `/v1/premium/healthid` | `/v1/auth/me/health-ids` |
| 123 | `/v1/premium/surveyresponse` | `/v1/auth/me/survey-submissions` |
| 124 | `/v1/premium/staffgroupmember` | `/v1/auth/me/group-memberships` |
| 125 | `/v1/premium/providershiftlog` | `/v1/auth/me/shift-logs` |
| 126 | `/v1/premium/dailyentry` | `/v1/auth/me/daily-entry-records` |
| 127 | `/v1/premium/adlcarelog` | `/v1/auth/me/adl-log-records` |
| 128 | `/v1/premium/providervitalsign` | `/v1/auth/me/vital-sign-records` |
| 129 | `/v1/premium/behaviornote` | `/v1/auth/me/behavior-note-records` |
| 130 | `/v1/premium/nutritionrecord` | `/v1/auth/me/nutrition-records` |
| 131 | `/v1/premium/mobilitylog` | `/v1/auth/me/mobility-records` |
| 132 | `/v1/premium/infectioncontrolchecklist` | `/v1/auth/me/infection-control-records` |
| 133 | `/v1/premium/narrativeprogressnote` | `/v1/auth/me/narrative-note-records` |
| 134 | `/v1/premium/careplanfollowup` | `/v1/auth/me/care-plan-follow-up-records` |
| 135 | `/v1/premium/clinicalassessment` | `/v1/auth/me/assessment-records` |
| 136 | `/v1/premium/supervisionlog` | `/v1/auth/me/supervision-records` |
| 137 | `/v1/premium/careplan` | `/v1/auth/me/authored-care-plan-records` |
| 138 | `/v1/premium/telehealthsession` | `/v1/auth/me/telehealth-records` |
| 139 | `/v1/premium/consentform` | `/v1/client/consents` |
| 140 | `/v1/premium/serviceauthorization` | `/v1/client/service-authorizations` |
| 141 | `/v1/premium/waitlistentry` | `/v1/client/waitlist` |
| 142 | `/v1/premium/feedback` | `/v1/client/feedback` |
| 143 | `/v1/premium/carefeedback` | `/v1/client/care-feedback` |
| 144 | `/v1/premium/familymember` | `/v1/client/family-links` |
| 145 | `/v1/premium/messagethread` | `/v1/client/conversation-threads` |
| 146 | `/v1/premium/timesheet` | `/v1/provider/timesheets` |
| 147 | `/v1/premium/mileagelog` | `/v1/provider/mileage-logs` |
| 148 | `/v1/premium/payout` | `/v1/provider/payouts` |
| 149 | `/v1/premium/visitcheckevent` | `/v1/provider/visit-check-events` |
| 150 | `/v1/premium/visitmatch` | `/v1/provider/visit-matches` |
| 151 | `/v1/premium/invoice` | `/v1/client/invoices` |
| 152 | `/v1/premium/visit` | `/v1/client/visits` |

The gateway matches exact collection paths and forwards GET with the original bearer, tenant header and query. It rejects other methods before forwarding, including booking creation requests. Nested/detail/summary paths and other premium collections remain unhandled. CORS preflight uses existing gateway policy.

Canonical handlers require active explicit bearer and a matching non-null actor tenant. Notifications bind actor user_id; assigned tasks bind actor assignee_id, excluding group-only assignments. Bookings and requests require a unique actor-owned client profile and client/tenant-bound queries. Documents require a unique actor-owned provider profile and join that profile in every document query to enforce profile tenant and owning User.

The canonical bounded paging, response projections, no-store headers, read-only repeatable-read transactions, source limits and sanitized errors remain active. These routes confer no new grants. Notifications retain their own stored title/message text; tasks expose stored status/priority/times only, bookings/requests expose owned metadata, and documents exclude file/storage keys. Metadata access does not establish approved bookings, completed care, patient-record access or document verification.

Registration copies the canonical permission and schemas into the 47 existing declarations and reuses canonical screen links. It does not create extra operation declarations or infer new page readiness. The OpenAPI specification records exact GET contracts. Legacy consumers expecting generic ORM response shapes must adopt these canonical metadata shapes.

Fixtures test exact routing, bearer/query forwarding, owner/tenant SQL predicates, unsupported writes, nested paths, profile ambiguity, paging, source limits and sanitized errors. Disposable PostgreSQL gateway tests verify UUID/text sessions, own/foreign users and tenants, document profile-tenant revocation, projections and inactive/expired sessions. Production verification remains a separate release gate.

Batches 111–115 bind activities, wellness pulses and device events to actor user_id and tenant_id; provider availability and overrides bind the unique owned provider profile and tenant_id. Wellness and device reads exclude notes and raw telemetry. Stored scores, statuses and availability flags do not establish diagnoses, attendance, device trust or bookability.

Batches 116–120 bind the actor User to rn_id for signoffs and reconciliations, reporter_user_id for incidents, reviewer_id for authored reviews, and performed_by_id for technical audits, alongside tenant_id in every query. Responses include only the canonical IDs, stored statuses and timestamps; they exclude clinical contents, incident descriptions, medications, review ratings and audit findings. These reads do not grant clinical access or prove approval, resolved incidents, completed reconciliation or successful audits.

Batches 121–152 cover the remaining supported collection aliases. Records without tenant_id (devices, health IDs, survey responses and memberships) bind their owning User and its current tenant in every query. Other account records use the canonical registered owner field plus tenant_id. Client and provider collections require exactly one actor-owned profile. The generic timesheet alias returns provider-owned timesheet metadata, while the generic message-thread alias returns client-owned thread metadata; authored/reviewed alternatives remain explicitly named canonical APIs. Invoice decimal values remain exact strings. Clinical record aliases expose timestamps/status metadata only, never clinical measurements or notes. See `governed-read-aliases.openapi.json` for the current complete contracts.
