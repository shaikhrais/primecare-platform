# Role completion order and E2E gate — 2026-10-10

## Scope and baseline

Authentication is verified separately. This queue covers the 64 role codes in `docs/audits/role-dashboards/inventory.json`; that historical inventory describes old screens and is a planning baseline, not evidence that their business workflows are implemented in the new skeleton. No role in this queue is marked business-E2E-complete by this document.

The order is an implementation dependency order, not a privilege ranking or inheritance tree. Normalize role aliases against `PlatformRole` and deployed authorization before implementing a role. In particular, `owner`, `patient`, `portal`, and `guest` require explicit policy reconciliation; do not silently treat them as interchangeable. Additional enum entries are not automatically enabled roles. Record any confirmed additions separately instead of silently changing the 64-role denominator.

## First role: Admin

Finish Admin before moving to the next role. Its initial bounded scope is organization/tenant setup, tenant-scoped user administration, permitted role assignment, activation/deactivation, and an operational dashboard derived from those records. Cross-tenant or global administration must have an explicit backend policy; the role name alone never grants it. Inspect existing API handlers and contracts first and record authorized operations, rather than inventing privileged endpoints.

Admin E2E acceptance:

1. Sign in as the isolated Admin fixture and resolve server-issued tenant, roles, and permissions; load the inherited dashboard.
2. Perform permitted user creation, profile update, and role assignment; reload and verify database-backed results through the API and UI.
3. Reject unauthorized role escalation and wrong-role requests. Reject cross-tenant list, detail, and mutation attempts. Verify the intended validation and unauthenticated responses.
4. Deactivate the fixture user and verify new access is denied and session policy is enforced. Reactivate it and verify sign-in succeeds, then deactivate again and verify the new session is revoked. Verify sign-out revocation.
5. Exercise empty, loading, validation, permission-denied, and API-error states; no placeholder actions or simulated success.
6. Verify durable state after reload, review relevant audit events, and remove every owned fixture record.
7. Pass focused model/core/API tests and browser E2E for the primary portal. Verify the shared native UI when workflow or platform behavior changes. Publish the implementation and rerun production smoke/E2E before marking complete.

Any undefined privilege or external dependency is a named blocker. A blocked role remains incomplete; fixtures can unblock testing but do not substitute for the actual upstream workflow.

## Shared structure and completion accounting

Use shared entities and contracts, central business workflows and authorization, then thin API handlers and inherited UI. Dart and TypeScript share serialized contracts and policy semantics; they do not inherit one runtime class across languages. Role membership is a permission policy, not a subclass granting inherited access.

For each role record: workflow, UI entry, API method/path, permission, tenant scope, database dependency, implementation status, test evidence, deployment evidence, and blocker. Count unique workflows/operations separately from file edits and repeated test executions. A role is complete only when every agreed workflow passes its acceptance gate; login alone is not completion.

The workspace `.agents/governance/governance.db` could not be read because SQLite reported a malformed database. It was left untouched. Recover or obtain a valid governance snapshot before using it to expand the scope beyond the explicit role inventory and verified contracts.

The implemented Admin task register is [admin-task-register-20261010.md](admin-task-register-20261010.md). Its nine workflow descriptions use four unique Admin API operations and local language selection; metadata does not grant permission.

## Ordered queue

| Order | Stage | Role code | Primary app | Business E2E status |
| --- | --- | --- | --- | --- |
| 1 | Access and organization setup | `admin` | support | Accounts, search/status filters, audit, task overview and activation lifecycle verified in Support production EN/ES/FR run 38099908370; broader policy/native acceptance pending |
| 2 | Access and organization setup | `owner` | franchise | Pending fresh verification |
| 3 | Access and organization setup | `gm` | support | Pending fresh verification |
| 4 | Access and organization setup | `ops_manager` | support | Pending fresh verification |
| 5 | Intake, scheduling, and client experience | `intake` | clinic | Pending fresh verification |
| 6 | Intake, scheduling, and client experience | `scheduler` | support | Pending fresh verification |
| 7 | Intake, scheduling, and client experience | `guest` | client | Pending fresh verification |
| 8 | Intake, scheduling, and client experience | `patient` | client | Pending fresh verification |
| 9 | Intake, scheduling, and client experience | `family` | client | Pending fresh verification |
| 10 | Intake, scheduling, and client experience | `portal` | client | Pending fresh verification |
| 11 | Clinical service delivery | `clinical_director` | clinic | Pending fresh verification |
| 12 | Clinical service delivery | `rmt` | clinic | Pending fresh verification |
| 13 | Clinical service delivery | `physio` | clinic | Pending fresh verification |
| 14 | Clinical service delivery | `chiropractor` | clinic | Pending fresh verification |
| 15 | Clinical service delivery | `therapist` | clinic | Pending fresh verification |
| 16 | Clinical service delivery | `social_worker` | clinic | Pending fresh verification |
| 17 | Clinical service delivery | `physician` | clinic | Pending fresh verification |
| 18 | Clinical service delivery | `np` | clinic | Pending fresh verification |
| 19 | Clinical service delivery | `rn` | clinic | Pending fresh verification |
| 20 | Clinical service delivery | `rpn` | clinic | Pending fresh verification |
| 21 | Clinical service delivery | `lpn` | clinic | Pending fresh verification |
| 22 | Clinical service delivery | `cns` | clinic | Pending fresh verification |
| 23 | Clinical service delivery | `pediatric` | clinic | Pending fresh verification |
| 24 | Clinical service delivery | `rn_field_supervisor` | clinic | Pending fresh verification |
| 25 | Clinical service delivery | `psw` | clinic | Pending fresh verification |
| 26 | Clinical service delivery | `hsw` | clinic | Pending fresh verification |
| 27 | Clinical service delivery | `caregiver` | clinic | Pending fresh verification |
| 28 | Workforce and service support | `hr_hiring` | support | Pending fresh verification |
| 29 | Workforce and service support | `employee` | support | Pending fresh verification |
| 30 | Workforce and service support | `volunteer_coordinator` | support | Pending fresh verification |
| 31 | Workforce and service support | `volunteer` | support | Pending fresh verification |
| 32 | Workforce and service support | `customer_support` | support | Pending fresh verification |
| 33 | Workforce and service support | `premium_concierge` | support | Pending fresh verification |
| 34 | Workforce and service support | `vip_manager` | support | Pending fresh verification |
| 35 | Workforce and service support | `training_coordinator` | governance | Pending fresh verification |
| 36 | Workforce and service support | `training` | governance | Pending fresh verification |
| 37 | Workforce and service support | `training_director` | corporate | Pending fresh verification |
| 38 | Workforce and service support | `qa_specialist` | support | Pending fresh verification |
| 39 | Finance and operational oversight | `finance_director` | corporate | Pending fresh verification |
| 40 | Finance and operational oversight | `cfo` | corporate | Pending fresh verification |
| 41 | Finance and operational oversight | `coo` | corporate | Pending fresh verification |
| 42 | Finance and operational oversight | `cx_director` | corporate | Pending fresh verification |
| 43 | Finance and operational oversight | `hr_director` | corporate | Pending fresh verification |
| 44 | Governance and technical oversight | `compliance` | governance | Pending fresh verification |
| 45 | Governance and technical oversight | `governance` | governance | Pending fresh verification |
| 46 | Governance and technical oversight | `legal` | corporate | Pending fresh verification |
| 47 | Governance and technical oversight | `ciso` | corporate | Pending fresh verification |
| 48 | Governance and technical oversight | `infrastructure` | governance | Pending fresh verification |
| 49 | Governance and technical oversight | `system_verification` | governance | Pending fresh verification |
| 50 | Governance and technical oversight | `cto` | corporate | Pending fresh verification |
| 51 | Governance and technical oversight | `scrum_master` | support | Pending fresh verification |
| 52 | Governance and technical oversight | `dynamic` | support | Pending fresh verification |
| 53 | Growth and executive reporting | `partnership` | business_development | Pending fresh verification |
| 54 | Growth and executive reporting | `bus_dev` | business_development | Pending fresh verification |
| 55 | Growth and executive reporting | `regional_bdm` | business_development | Pending fresh verification |
| 56 | Growth and executive reporting | `regional_manager_usa` | support | Pending fresh verification |
| 57 | Growth and executive reporting | `territory_expansion` | business_development | Pending fresh verification |
| 58 | Growth and executive reporting | `territory_sales` | business_development | Pending fresh verification |
| 59 | Growth and executive reporting | `franchise_sales` | franchise | Pending fresh verification |
| 60 | Growth and executive reporting | `local_marketing` | marketing | Pending fresh verification |
| 61 | Growth and executive reporting | `community_outreach` | marketing | Pending fresh verification |
| 62 | Growth and executive reporting | `marketing` | marketing | Pending fresh verification |
| 63 | Growth and executive reporting | `ceo` | corporate | Pending fresh verification |
| 64 | Growth and executive reporting | `shareholder` | corporate | Pending fresh verification |
