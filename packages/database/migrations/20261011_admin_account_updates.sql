-- Extend platform history without rewriting the original migration.
ALTER TABLE admin_control_audit DROP CONSTRAINT IF EXISTS admin_control_audit_action_check;
ALTER TABLE admin_control_audit ADD CONSTRAINT admin_control_audit_action_check CHECK(action IN ('tenant_created','account_created','account_updated','master_created','master_updated'));
