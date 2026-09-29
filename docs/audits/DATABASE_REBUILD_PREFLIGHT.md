# Full database rebuild preflight

Requested: rebuild the entire PrimeCare PostgreSQL database.

Status: preparation only. No production tables or records have been deleted.

## Verified
- Prisma 5.22.0 validates packages/database/prisma/schema.
- The schema contains 223 models.
- Prisma migrate diff from an empty database generates a 4,838-line SQL baseline.
- The legacy infra/migrations/001_initial_schema.sql is not a compatible baseline for current authentication: it uses users.role rather than users.roles and lacks the current tenant relationship.
- The universal seed creates fake business records and a shared password hash. It must not be used for the clean production initialization.
- The inspected governance.db db_schema_tables registry contains 102 records, with no users, tenants, or auth_sessions registration.
- Existing authentication migrations assume users already exists; they cannot rebuild the entire database alone.

## Required execution sequence
1. Reconcile the current Prisma schema and authentication migrations with the governed database registry.
2. Test the generated baseline plus authentication migrations against disposable PostgreSQL.
3. Take and verify a restorable production backup; choose an explicitly authorized storage destination before exporting production records.
4. Apply the validated rebuild during a maintenance window.
5. Initialize the real organization and first CEO using the existing bootstrap password secret and itpro.mohammed@gmail.com. Do not run fake-data seeds.
6. Verify schema, login, session restoration, role authorization, and logout before restoring service.

The requested destructive rebuild is authorized, but production execution is blocked by the schema-governance mismatch and the absence of a verified backup/restore path. The repository AGENTS.md requires database definitions and validation before implementation.
