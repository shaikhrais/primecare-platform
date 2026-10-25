# Messaging storage and native link registration — 25 October 2026

This milestone registers the exact storage design and native account-link
contracts before creating empty owner-private tables. It does not mount routes,
grant roles, enroll contacts, write message content, change phone routing or
activate live messaging.

The generated bundle includes 13 tables and 78 columns: the three existing shared
conversation/workflow tables, four SMS outbox/callback tables, one inbound inbox,
three AI turn tables and the two link/consent tables. Existing shared table
registrations are reused unchanged. The bundle is reproducible from five reviewed
source migrations; each source hash, bundle hash and metadata definition is pinned.

The new metadata writer inherits the existing storage registration implementation.
It preserves edited/duplicate metadata instead of overwriting it. Production uses
the pinned PostgreSQL catalogue only. Independent read-only verification checks
all table/column metadata and the full committed SQL baseline before native DDL.

The native schema gate compares all existing target tables with an isolated
PostgreSQL reference before creating missing tables. It checks constraints,
indexes, identity/generated columns, row-security flags, column metadata and
owner-only table/sequence ACLs. Existing drift causes rollback; no ALTER, DROP,
GRANT, REVOKE, data migration or repair is attempted in production. The verified
contact schema is an existing prerequisite and is not created in production.

Registered native owner-only contracts are proposed for:

- `POST /v1/messaging/sms/link/status`
- `POST /v1/messaging/sms/link/bind`
- `POST /v1/messaging/sms/link/revoke`

The bind request accepts only a link ID, conversation ID and explicit consent.
Actor, tenant, verified phone/provider and native session context cannot come from
the body or AI. Successful responses omit account IDs, phone numbers and session
handles. No screen or role grants are added by registration.

The protected workflow first runs old storage regression checks, exact new
metadata/API registration checks, native schema/rollback/drift/private-access
checks and the existing messaging/link integration suites. It then registers
metadata, independently reads it back, rolls back a schema dry run, applies exact
missing tables and verifies through a fresh pooled read-only transaction.

## Verified production result

Source `c1baa6c8`, protected run `40189337571`, completed all three jobs. The
metadata job `121156789488` passed eight existing storage regression tests, six
new inherited metadata tests, four native link schema tests and 28 API/store
tests. Reference job `121156789356` passed six native schema tests, six existing
messaging integration groups and ten link/consent groups. The typed 32-operation
OpenAPI also passes eight local checks.

Production job `121157044884` independently registered the storage design
(table IDs 1352–1364, 78 columns) and these native APIs:

| API | Operation |
| --- | --- |
| 16539 | `/v1/messaging/sms/link/status` |
| 16540 | `/v1/messaging/sms/link/bind` |
| 16541 | `/v1/messaging/sms/link/revoke` |

After a rolled-back dry run, ten missing messaging tables were created. All three
existing shared tables were preserved. A fresh pooled read-only transaction then
verified all 13 table fingerprints, 78 columns and owner-only access, with no
missing tables. No grants, user/contact/message records, provider configuration
or phone routing were changed. Failed earlier reference attempts were blocked
before production: PostgreSQL integer type normalization and a reference/report
filename collision were corrected without weakening the gate.

Evidence: `evidence/messaging-storage-activation-20261025.json`. Worker composition,
native owner runtime/access and signed receiver/dispatcher activation remain
separate steps. These registrations do not expose endpoints or enable live SMS.

Post-deployment source `20d96a22` passed all 12 communication CI jobs in run
`40189799148` and all eight typed OpenAPI checks in run `40189799149`. Production
API documentation refresh `40189799208` also passed and saved the current full
catalogue to main. These remain scoped passes; live messaging is not activated.
