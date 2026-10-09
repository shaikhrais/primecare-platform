# Personal authorship, assigned tasks and audit-signoff metadata — batches 76–80

These APIs read metadata attached directly to the active User in the actor's matching tenant. Registered Prisma relationships distinguish User IDs from ProviderProfile IDs. Every database query binds the actor User and tenant; no caller-selected author, assignee, role, group or tenant is accepted.

| Batch | Root under `/v1/auth/me` | Table / owner | Projection |
| --- | --- | --- | --- |
| 76 | `/narrative-note-records` | `narrative_progress_notes.provider_id` → User | id, recorded_at |
| 77 | `/care-plan-follow-up-records` | `care_plan_follow_ups.provider_id` → User | id, recorded_at |
| 78 | `/assigned-task-records` | `staff_tasks.assignee_id` → User | id, status, priority, due_date, created_at, updated_at |
| 79 | `/assigned-task-records/summary` | Same direct assignee ownership | status groups and counts |
| 80 | `/audit-signoff-records` | `daily_audit_signoffs.rn_id` → User | id, status, signed_at |

Each root except the summary supports GET list and GET `/{recordId}`. Lists return the registered `records`, `tasks` or `signoffs` collection plus `pagination`; details return `record`, `task` or `signoff`. Summary `pagination.total` counts groups, not task records. Stored status/priority labels and signing timestamps do not certify completion, payroll, compliance, licensure or access privileges. Clinical narratives, care-plan task contents, patient/client/visit IDs, task title/description/group IDs and clinical comments remain excluded. These routes cannot supply a clinical chart.

Task ownership means direct current assignee only. Unassigned and group-only tasks are excluded; group membership does not grant access. Reassignment removes the former assignee's access and permits the new assignee within the same tenant. `due_date` may be null. Reading never marks a task done or signs an audit.

Lists use bounded paging (`limit` default 25, 1–100; `offset` default 0, 0–100000), sorted newest by registered recorded_at, created_at or signed_at followed by id. Details accept no query. An empty owned list returns 200; missing or foreign detail returns 404. Malformed queries/IDs return 400, missing/inactive bearer 401, absent/mismatched tenant 403, writes 405, source throttle 429, unavailable/malformed projected data 503. Responses are no-store; reads run in a read-only repeatable-read transaction with rollback on all paths.

Governance registration precedes runtime allowlist generation. The companion OpenAPI document supplies schemas, examples, paging, authentication and errors. Existing execution-status/page-blueprint mechanisms receive the registered contracts; metadata readiness does not mark a page complete. No new role grants, schema migrations, business transitions or clinical writes are included.

Local fixtures validate direct ownership SQL, registered projections, gateway forwarding, detail IDs, ordering, status summaries, invalid inputs, active session and tenant checks, throttling and error sanitization. Disposable PostgreSQL CI tests UUID and text auth identities, other authors/assignees, foreign tenants, null assignees, assignment changes, nullable dates, empty results and expired/inactive sessions. PostgreSQL and production evidence remain separate from local fixtures.
