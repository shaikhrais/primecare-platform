# PrimeCare Governance: Audit Matrix

This document implements the **Audit Matrix** component of the feature governance system. It maintains a tabular score for each feature, tracking whether it physically exists, saves data, reads data, enforces roles, and emits audit trails.

## User Management Module

| Intent ID | UI Exists | Data Write | Data Read | RBAC | Audit Trail | **Status Decision** |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| `user_management.view_users` | ✅ | N/A | ✅ | ✅ | N/A | **PASS** |
| `user_management.create_user` | ✅ | ⚠️ | ⚠️ | ✅ | ❌ | **DRIFT** (See Reconciliation Log) |
| `user_management.deactivate_user` | ✅ | ✅ | ✅ | ✅ | ❔ | **PARTIAL** (Audit trail unverified) |
| `user_management.reset_password` | ✅ | ✅ | N/A | ✅ | ❌ | **PARTIAL** (Audit trail missing) |

### Legend
- ✅ **Pass:** The component is fully verified against the source of truth mapping.
- ❌ **Fail:** The component is missing or critically broken.
- ⚠️ **Drift:** The intent is implemented, but the physical code has diverged from the data or structural mapping (e.g., UI capturing fields that do not exist in the database model).
- ❔ **Unverified:** Pending deep implementation checks.

## Verification Engine Sync
*This matrix provides a human-readable snapshot of the underlying `reconciliation_engine.dart` output. Always check `reconciliation_report.md` for specific AST-to-Prisma mismatch errors.*
