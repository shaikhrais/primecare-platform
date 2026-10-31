# Tenant Admin dashboard and task workspace

The Tenant Admin HTML preview is `docs/care/previews/tenant-admin-dashboard.html`. Its data is explicitly fictional and browser-memory-only. The integrated `/tenant-dashboard` route renders the same view through the shared session transport and PostgreSQL API. Tenant Admin login now lands here. Existing `/platform/administration` remains available for account, role, master-record and reporting actions. Hash links initialize the appropriate existing admin section.

## Dashboard scope

Seven sections: Overview, Work & Tasks, Workflow Library, People & Clients, Care Operations, Business Growth, Activity & Audit. The shared PrimeCare shell, existing Tabler icons and solid-theme tokens are reused. Dashboard label and component metadata is registered in pinned production governance before exposure. Existing care, account, coordinator-charge, PSW request and business-plan modules are linked; their original permissions and approval rules remain authoritative.

Live tenant aggregates use scoped SQL for active staff, clients, today’s Toronto visits, PSW requests, pending time, care review and business-plan cycles. Missing optional tables produce null/unavailable; they never become fictional zeroes. Staff task access does not grant tenant-wide metrics or client-directory access. The displayed directory is limited to 500 staff and 100 clients and reports truncation.

The workflow library reads the pinned PostgreSQL `govt_virtual_workflow_definitions` and `govt_virtual_workflow_steps`, validates the source manifest, filters actor-role grants, pages 100 entries at a time and retains original definition/test/verification states. Business processes and supporting screen journeys are distinguished. No business process is marked verified by completing a task. Registered workflow content is not proof that all platform business processes execute successfully.

## Task lifecycle

Tenant Admin creates a task tied to a registered tenant workflow with active same-tenant staff owner, date, priority and instructions. The owner sees assigned tasks in this workspace. Staff can start, block or submit evidence for their work; Tenant Admin can also record operational progress. Independent Tenant Admin review completes submitted work. The owner and the submitting administrator cannot approve their own result. Return and cancellation retain history. Editing is restricted to unsubmitted, unclosed tasks. New versions and actor-scoped idempotency prevent stale replacement and duplicate creation.

Due dates are calendar dates evaluated in America/Toronto; they do not assign appointments or claim worked hours. Task evidence is operational. Clinical records, approvals and payroll remain in the original modules. No staff notification, email or SMS is sent by this task feature; workers use the My work & tasks link.

## Data and access

GET/POST `/v1/governance/tenant-dashboard`. Active session/account/tenant required. Tenant Admin manages their own tenant; staff can read and update only their own assigned live tasks. Central administrators have database demo access only. Tenant overrides are rejected for noncentral roles. Account or role suspension is checked on every request.

Operational tables: `tenant_work_tasks`, `tenant_dashboard_demos`, `tenant_dashboard_preferences`, `tenant_dashboard_events`, `tenant_dashboard_requests`. Events are immutable. Live tasks are cancelled, not hard-deleted. Per-account starting-view preferences are versioned. Search and task/workflow paging run through the API; no frontend localStorage business-data fallback.

Each active tenant receives a marked shared demo template: three fictional staff, two fictional directory entries, three sample tasks and illustrative metrics stored in the demo JSON only. No real staff, patients, visits, clearances, payments or live tasks are seeded. Staff practice workspaces are private. Clear demo data clears that workspace only, preserves live tasks and immutable audit, and does not silently reseed on the next GET. Load demo data restores it explicitly. Seed updates preserve edited/cleared rows.

Limits: 100 tasks/workflows per page; up to 2,000 steps per workflow page (100 per workflow); latest 100 audit events; up to 500 central organization options. Write rate is 60 immutable events/minute/actor, so clearing retries cannot reset it. Unknown/malformed query and command fields are rejected.

## Validation and limitations

`node scripts/test-tenant-dashboard.mjs` validates actual counts, unavailable metrics, workflow grants, independent SQL/API reload, create/start/submit/complete, stale versions, retry, own-work limits, tenant isolation, independent review, preferences, demo cleanup and immutable audit. Native PostgreSQL acceptance runs in release CI alongside existing PSW/coordinator suites. Browser QA uses isolated disposable fixtures and the actual project UI/API. It does not impersonate a real employee production login.

The HTML and API are integrated into the TypeScript portals. This release does not rebuild Flutter native mobile/desktop UIs. English resources are registered, but independent translation and formal accessibility review remain unverified. Source-mapped workflow metadata stays `implemented-unverified`; no broad claim that all historical business processes have passed is made.
