# Audit Matrix

*This checklist determines if a feature is ACTUALLY complete.*

**Statuses:** Pass | Fail | Partial | Drift | Missing | Duplicate

## 1. User Management

| Feature | UI Exists? | Validation Works? | DB Write Verified? | DB Read Verified? | Perms Verified? | Audit Trail Exists? | Overall Status | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Create User** | Partial | Fail | Fail | Fail | Fail | Fail | **Fail** | Uses modal TextField, pure local state mock. |
| **Edit User** | Partial | Fail | Fail | Fail | Fail | Fail | **Fail** | Same as Create User. |
| **Deactivate User**| Partial | Fail | Fail | Fail | Fail | Fail | **Fail** | Status toggle in mock provider only. |
| **Reset Password** | Fail | Fail | Fail | Fail | Fail | Fail | **Fail** | Entirely missing from UI routing. |
| **Role Perms** | Fail | Fail | Fail | Fail | Fail | Fail | **Fail** | Strings only, no real RBAC or platform roles synced. |

## 2. Scheduling
*(Pending Audit)*

## 3. Daily Entry
*(Pending Audit)*

## 4. Billing
*(Pending Audit)*

## 5. Documents / Clinical
*(Pending Audit)*
