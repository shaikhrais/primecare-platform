# Page Inventory

*This document maps what actually exists in the UI footprint.*

## 1. User Management

| Route | Screen Name | Actions Present | Expected Roles | Linked Forms/Tables |
| :--- | :--- | :--- | :--- | :--- |
| `/admin/users` | User Directory | List users, Filter, Click to Edit, Click to Add | `Org Admin`, `Facility Admin` | `UserListTable` |
| `/admin/users/new` | Create User | Fill profile, Select Role, Save | `Org Admin`, `Facility Admin` | `CreateUserForm` |
| `/admin/users/:id` | Edit User | Update Profile, Reset Password, Deactivate | `Org Admin`, `Facility Admin` | `EditUserForm` |
| `/auth/reset-password` | Password Reset | Request link, Set new password | *Any Unauthenticated* | `PasswordResetForm` |

## 2. Scheduling
*(Pending Audit)*

## 3. Daily Entry
*(Pending Audit)*

## 4. Billing
*(Pending Audit)*

## 5. Documents / Clinical
*(Pending Audit)*
