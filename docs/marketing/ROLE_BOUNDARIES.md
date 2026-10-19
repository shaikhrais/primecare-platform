# Franchise and growth role boundaries

Implemented locally on 2026-10-17 for the user request to close role gaps. This review covers platform administration, tenant operations and growth; it is not acceptance of every clinical or workforce role.

## Operating responsibilities

| Role | Responsibilities and permitted actions | Boundary |
|---|---|---|
| Central administrator | Global tenant/account administration; protected administrator changes; launch and document review | Central administrator accounts still require protected bootstrap |
| Platform administrator | Tenant provisioning, eligible accounts, territory allocation, launch/document review and support | Cannot change protected administrator accounts; API now matches disabled UI controls |
| Franchise owner (`owner`) | Own-tenant growth targets, campaign budgets/spend, campaign decisions, staff coordination, all four manual finance kinds; own administration console | Cannot provision tenants, promote owners/CEOs, inspect other tenants, allocate territories or approve its own launch/documents |
| CEO (`ceo`) | Retains legacy owner authority for growth planning, campaign money, review and finance | No new global administration grant or tenant-console grant |
| Tenant administrator | Own-tenant eligible accounts/reference records, operations, lead/task coordination, campaign preparation and submission; manual invoices/payments | Cannot promote/change owner or CEO accounts, change owner plans or campaign money, approve campaign briefs, or record refunds/expenses |
| Caller/coordinator | Assigned lead work, contact outcomes, callbacks and own appointments/tasks according to registered staff policy | Reassignment removes access; no campaign money, ownership administration or approval authority |
| Marketing specialists | Source-scoped campaign preparation and own task work according to registered staff policy | No individual client contact access, owner decisions or budget/spend changes |

Marketing manager roles retain their registered operational scope. Campaign creation by a nonowner requires zero budget and zero spend. The owner can subsequently fund it through the editable campaign budget field. Campaign PATCH operations are owner-only because that endpoint changes money.

## Workflow

1. A central/platform administrator provisions the tenant and assigns its ownership through authorized account administration.
2. The owner sets targets and money limits; the tenant administrator coordinates eligible accounts, callers and specialists.
3. Staff work within assigned leads or campaign sources and record outcomes, deadlines and evidence through APIs.
4. The tenant administrator or marketing operator prepares and submits a campaign brief. Only the owner/CEO can approve, request changes or reject it.
5. The owner monitors funnel gaps and finances; the tenant administrator records operational invoices/payments and escalates refund/expense decisions.
6. Central/platform administrators independently review tenant launch and documents. Local owner approval never substitutes for these gates.

The authorized one-person model permits owner/CEO campaign self-review, recorded explicitly in immutable review history. It does not imply independent human review. Historical campaign decisions remain attributed to the role and actor recorded at the time; these changes do not rewrite prior approvals.

## Implementation and contracts

Governance seeds and registrars own role grants, policies, EN/FR/ES labels and controls. Generated exports include the workspace landing, hierarchy, growth, tenant operations, territory and platform bundle policies. Owner landing is `/growth`; a governed link opens its own administration console. No production user was assigned a role by this work.

`GrowthPolicy.privilegedOperation` checks present authority before idempotency replay. A downgraded owner cannot retrieve an earlier privileged success as authorization to repeat that action. Command handlers retain checks as defense in depth. Finance kinds are returned by the API for the current actor and enforced again on writes. UI controls render server capabilities; SQL and business authorization remain behind APIs.

Existing endpoint paths and schemas remain unchanged. Applicable APIs are growth plan/team/campaign/review/finance commands and platform account administration, with existing authenticated, tenant-scoped, versioned, idempotent and audited handling. See `growth.openapi.json`, `admin-hierarchy.openapi.json` and the platform bundle/operations/territory OpenAPI exports. Forbidden privileged operations return 403; concealed foreign-tenant resources remain inaccessible.

Owner budget/spend drafts survive language changes only for the same actor, tenant, campaign and version. A refreshed version prevents restoring an obsolete row draft.

## Verification and limits

Tests exercise direct API denials, foreign-tenant isolation, owner-console scope, protected administrator accounts, restricted finance kinds, campaign submission/decisions, and cached-request replay after role downgrade. Browser coverage includes owner, CEO, tenant administrator, caller and specialist growth views plus central/platform/tenant/owner administration in EN/FR/ES at 320 and 1440 CSS pixels. The English desktop owner case changes budget/spend, preserves drafts across language changes and verifies persisted cents.

Unit and PostgreSQL-compatible local regressions cover the policy, text/UUID CRM and business paths, and platform hierarchy/onboarding. Local PGlite checks are not proof of independent-connection PostgreSQL races; the original concurrent tests remain in CI. Automated accessibility checks do not close unresolved contrast/manual acceptance items documented in the platform bundle review.

Deployment, real account/provider integrations, physical-device acceptance, independent human review and broader workforce/clinical role acceptance remain pending. Nurse or retired-nurse franchise ownership grants no clinical credential or clinical scheduling authority.

Final local results: 62 combined API/browser cases passed with zero failures; 18 policy/unit cases passed. The compatible SQL regressions passed for both text/UUID CRM paths, both text/UUID business paths and both hierarchy/provisioning paths; eight onboarding browser cases also passed. TypeScript checking, the main browser bundle, all five affected governance export checks and staged whitespace checking passed. No real tenant or staff record was changed.
