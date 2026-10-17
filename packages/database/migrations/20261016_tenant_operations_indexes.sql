-- Optional performance indexes for the scoped tenant operations read model.
BEGIN;
CREATE INDEX IF NOT EXISTS tenant_operations_users ON users(tenant_id,LOWER(status),roles);
CREATE INDEX IF NOT EXISTS tenant_operations_masters ON platform_master_records(tenant_id,LOWER(status),type);
COMMIT;
