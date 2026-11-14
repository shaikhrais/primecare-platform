# Help guides: concrete first implementation package

**Draft for decision. No handler, production migration, content publication or access change has been applied.** This package makes the proposed existing-FAQ option reviewable. It does not create a new API, route, permission or sidebar item.

## Recommended decision

Use the existing FAQ content source, add explicit tenant ownership, EN/FR/ES language, draft/published/withdrawn state and a revision, then expose only published current-tenant guides to the existing PSW audience. Retain API794 POST `/v1/psw/help-support`, existing screen685 `psw_help_support` and reusable Help control779. No support ticket, live chat, notification, provider or payment operation is included.

This choice needs agreement because existing FAQ rows have no tenant, language or publication owner, and API794 has no canonical request/response/permission/screen binding. The repository requires registered definitions before implementing a new host/handler. The existing64 legacy grants are not a policy to expose this content to every role.

## Exact proposed data changes

Existing FAQ columns remain id, question, answer, category and creation/update times. No old title, body, category, ID or timestamp is rewritten by the proposal.

| Additive field | Proposed initial value and rule |
| --- | --- |
| tenant_id | NULL for every legacy row; foreign-key type matches actual tenants.id (text/UUID/varchar). An assigned article cannot change tenants. |
| locale | NULL for legacy rows; explicit en/fr/es when adopted. A localized article cannot be moved to another language. Separate reviewed FAQ rows hold translations. |
| publication_state | draft by default. Published/withdrawn are explicit future workflow states. No legacy row becomes readable automatically. |
| revision |1 by default, safe positive integer up to9007199254740991. Database increments it on content/publication changes; direct edits rejected. |
| summary | Empty by default, up to1000UTF-16 code units when published. List projection never sends the full article body. |
| published_at | NULL by default; published requires a non-future server timestamp, assigned tenant/language and valid content. Unpublished rows have no publication timestamp. |

Published content must fit the exact proposed wire limits: identifier1–200 safe ASCII characters, question/title1–500UTF-16 units, category1–100, answer/body1–5000 and summary0–1000. ASCII control characters are rejected except tab/newline/carriage return; PostgreSQL text itself rejects NUL. This validation is supplementary to strict request/response schemas and UTF-8 body/response caps at the future handler boundary.

An edit to title, body, category, summary, tenant or locale invalidates publication and increments revision. Publication must then be a separate reviewed action. A stale update using `WHERE id=$id AND revision=$expected` changes no row. Withdraw must clear published_at. These are proposed data-integrity rules; they do not authorize a publisher or provide an editorial workflow.

The draft SQL is outside the operational migration directory and explicitly refuses execution without an isolated-fixture opt-in. It is not a command to run against production. The rollback refuses to discard assigned/localized/published/revised content. A future production migration needs review against the actual existing table/column/index schema and generated Prisma model, with a separate migration writer and rollback decision. This package does not alter Prisma or any production connection.

## Proposed read predicates

After an independently validated current bearer session, active tenant, existing PSW role and exact approved API/screen/control grant, the future server must use its own captured actor/tenant context. Client-supplied userId/tenantId/role/permission selectors remain invalid.

List and detail queries require all of:

- `tenant_id=$authenticatedTenant`
- `locale=$validatedRequestedLocale`
- `publication_state='published'`
- `published_at<=CURRENT_TIMESTAMP`

List search uses a bound literal substring over question and summary, not interpolated SQL or unescaped LIKE wildcards. Results are ordered stably by ID. Rows and total use the same read-only repeatable-read snapshot; an empty page still returns the actual total. Detail additionally requires the bound article ID. Missing, other-tenant, unpublished or wrong-language detail returns404 without disclosing which predicate failed. No silent language or global-content fallback.

The fixture exercises these predicates. It is not an authenticated service and does not prove actual role/grant/revocation enforcement. That requires exact production metadata, a real server handler and denied/cross-tenant API tests.

## Access and publication changes still required

| Existing identity/evidence | Required change or decision before implementation |
| --- | --- |
| API794 POST /v1/psw/help-support | Review proposed list/read semantics and strict schemas. Reconcile its actual permission key, rate/audit policy and screen link. No alternate GET route or generic /help/articles alias. |
| Role51 psw | Proposed first reader audience only. Re-read actual grant identities and reconcile this exact role/API policy; do not enable or inherit all64 legacy grants. Other roles remain separate decisions. |
| Screen685 psw_help_support | Reconcile actual role visibility, exact route/app host, sections/elements and API link before mounting a Help factory. Screen existence alone does not establish a working host. |
| Reusable Help control779 | Reuse the registered shared component, resource keys, theme tokens and captured-session lifecycle; do not introduce direct UI controls or infer a business API binding. |
| Existing FAQ records | Retain as unpublished/unowned. A designated tenant content publisher and review/audit process must explicitly adopt and publish each language version. No seed article is presented as approved content. |
| New data fields and published-reader service | Review the additive model/migration and identity types first; register accepted definitions before implementation. No writer/grant/publisher is created by these proposal files. |

The proposed reading session remains no-store and scope-bound. Token/tenant/user change, logout, navigation or revocation retires pending results and clears private views. Quota and required audit failures return503; no synthetic support phone/email/chat flag or path-only cached success is allowed. Actual publisher role, rate/audit identifiers and retention remain explicit policy decisions.

## Verified isolated behavior

`node docs/appearance/pc10-section2-test-help-data-proposal.mjs --check` uses in-memory PGlite only and never reads a database URL or credential. Both text and UUID tenant primary keys were tested. The retained JSON receipt records exact SQL hashes and38passed cases covering fixture guard, legacy preservation, tenant/language isolation, unpublished detail denial, exact projections, stable empty paging/count, literal search, publication constraints, Unicode bounds, revision/republish, stale updates and safe rollback. This is PostgreSQL-engine fixture evidence, not a live PostgreSQL server, production migration, authenticated Help flow or human approval.

The existing Help wire proposal retains32synthetic schema cases. Full feature acceptance still needs the approved database/metadata changes, real API/PostgreSQL authorization, registered shared web/native host, reload/logout/revocation, keyboard/accessibility/localization and required device/human evidence. The current production-facing behavior is unchanged by this draft package.

## Implementation order once the decision is made

1. Agree existing-FAQ tenant-published guides and PSW-only first reader scope; designate the content publication owner.
2. Recover exact live permission/grant/host identities and validate the real FAQ schema. Prepare the specific production model/registration migrations for review; retain zero automatic legacy publication.
3. Reconcile the accepted database/metadata definitions before implementing API794's captured-session read service.
4. Mount the existing Help factory only in its exact authorized registered host and verify API/SQL/client isolation, errors and lifecycle end to end.

The two existing false-success repairs remain verified, and all five domain drafts remain available. This Help package prepares one concrete policy/data decision; it does not remove the other domains' authority/provider dependencies or mark Section2B complete.
