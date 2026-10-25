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

The completed workflow's actual IDs, table counts and verification evidence must
be recorded before claiming this milestone deployed. Worker composition, native
owner access and signed receiver/dispatcher activation remain separate steps.
