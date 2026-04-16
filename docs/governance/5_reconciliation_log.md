# Reconciliation Log

*Ledger for when intent and code do not match.*

| Issue ID | Feature / Module | What is wrong (Drift/Missing/Duplicate) | Root Cause | Decision Made | Assigned / Who | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| REC-UM-001 | User Management | **Drift**: UI collects `name` (full name) but DB has `ClientProfile.fullName` and `User` missing name fields. | Legacy code used full strings, DB uses separated models for Profiles. | Migrate UI to BaseForm; connect to User + Profile API. | AI | Resolved |
| REC-UM-002 | User Management | **Drift**: Role selection in UI is a hardcoded list of strings. | Disconnected from `PlatformRole` ecosystem table. | Replace string dropdown with `asyncValue` from `PlatformRole` provider. | AI | Resolved |
| REC-UM-003 | User Management | **Missing**: Password Reset UI | Forgotten during UI normalization. | Generate `PasswordResetForm` and backend token route. | AI | Resolved |
| REC-UM-004 | User Management | **Drift**: Office/Department selection in UI | Office does not exist on `User` Prisma model (mapped to Facility?). | Reconcile with `Tenant` / `Facility` database IDs. | AI | Resolved |
| REC-UM-005 | User Management | **Missing**: End-To-End Backend Connection | `user_management_provider.dart` uses local memory arrays (`state = [...state, user]`). | Prototype never converted to API architecture. | Replace with `AsyncNotifier` fetching from `/users` API. | AI | Resolved |
