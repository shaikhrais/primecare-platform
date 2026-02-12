# PrimeCare Role-Page-Component Matrix

## 🔐 ADMIN
| Page | Route | Buttons | Components | Core API |
| :--- | :--- | :--- | :--- | :--- |
| Dashboard | `/admin/dashboard` | Create User, Backup, Audit | KPI Cards, Activity Feed | `GET /v1/admin/stats` |
| Users | `/admin/users` | Add User, Edit, Reset Pwd | DataTable, Confirm Modal | `POST /v1/admin/users` |
| Settings | `/admin/settings` | Save Settings | Toggles, Validation | `PATCH /v1/admin/settings` |
| Audit Logs | `/admin/audit` | Export CSV, Filter | DataTable, Date Picker | `GET /v1/admin/audit` |

## 🧑💼 MANAGER (Operations)
| Page | Route | Buttons | Components | Core API |
| :--- | :--- | :--- | :--- | :--- |
| Dashboard | `/manager/dashboard` | Add Client, Create Shift | Timeline, Alerts | `GET /v1/manager/stats` |
| Clients | `/manager/clients` | Add Client, Assign RN/PSW | Tabs, Uploader | `POST /v1/admin/clients` |
| Shifts | `/manager/shifts` | Create, Assign, Cancel | Calendar, Conflict Checker | `POST /v1/admin/visits` |

## 🩺 RN (Clinical Supervisor)
| Page | Route | Buttons | Components | Core API |
| :--- | :--- | :--- | :--- | :--- |
| Dashboard | `/rn/dashboard` | Update Risk, Review Logs | Clinical Queue, Alerts | `GET /v1/rn/stats` |
| Care Plans | `/rn/care-plans` | Create, Update, Sign | Version History | `POST /v1/client/:id/care-plan` |
| Review | `/rn/daily-review` | Approve, Return to PSW | Detail Panel, Signature | `POST /daily-entry/review` |

## 👩⚕️ PSW (Caregiver)
| Page | Route | Buttons | Components | Core API |
| :--- | :--- | :--- | :--- | :--- |
| Dashboard | `/psw/dashboard` | Start/End Shift, Entry | Visit List, Quick Action | `GET /v1/psw/visits` |
| My Entry | `/psw/daily-entry` | Submit, Save Draft | Checklist, Vitals Form | `POST /v1/daily-entry` |
| Incident | `/psw/incidents` | Create Incident | File Upload, Severity Tag | `POST /v1/incidents` |
