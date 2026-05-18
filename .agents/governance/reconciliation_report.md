# PrimeCare Feature Reconciliation Report

## Global Statistics
- **Total Registered Intents:** 69
- **Total Registered Pages:** 74
- **Total Tracked Fields:** 7

## 🚨 Anomalies & Orphaned Components
- **[WARNING]** Form Page `create_shift_form` exists but has no mapped data entry fields.

## Planned VS Actual Implementation
| Field ID | Page | API Endpoint | DB Table | Status |
|----------|------|--------------|----------|--------|
| `create_user_first_name_input` | `create_user_form` | `POST /api/v1/users` | `User` | `verified` |
| `create_user_last_name_input` | `create_user_form` | `POST /api/v1/users` | `User` | `verified` |
| `create_user_email_input` | `create_user_form` | `POST /api/v1/users` | `User` | `verified` |
| `create_user_role_select` | `create_user_form` | `POST /api/v1/users` | `User` | `verified` |
| `create_user_office_input` | `create_user_form` | `POST /api/v1/users` | `Tenant` | `verified` |
| `password_reset_input` | `password_reset_form` | `POST /api/v1/users/reset-password` | `User` | `verified` |
| `login_email_input` | `auth_layout` | `POST /api/v1/auth/login` | `User` | `verified` |