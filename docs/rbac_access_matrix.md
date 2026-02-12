# PrimeCare Access Control Matrix (Role × Action × API)

This technical matrix maps high-level business actions to their respective API endpoints and indicates the required role permissions.

## 🏥 Clinical & Care Management

| Action | API Endpoint | Method | Required Role | IDOR Protection |
| :--- | :--- | :--- | :--- | :--- |
| **Create Care Plan** | `/v1/client/:id/care-plan` | POST | RN, Admin | Tenant & Client Check |
| **Update Care Plan** | `/v1/client/:id/care-plan` | PATCH | RN, Admin | Tenant & Client Check |
| **Review Daily Entry** | `/v1/daily-entry/:id/review` | POST | RN, Admin | Tenant & DailyEntry Owner |
| **Update Risk Level** | `/v1/client/:id/risk` | PATCH | RN, Admin | Tenant & Client Check |
| **View Assigned Stats** | `/v1/rn/stats` | GET | RN, Admin | Tenant Isolation |
| **Supervise PSW** | `/v1/rn/psw/:id/overview` | GET | RN, Admin | Tenant Isolation |

## 📅 Scheduling & Operations

| Action | API Endpoint | Method | Required Role | IDOR Protection |
| :--- | :--- | :--- | :--- | :--- |
| **Create Shift** | `/v1/admin/visits` | POST | Manager, Staff, Admin | Tenant Mapping |
| **Assign PSW** | `/v1/admin/visits/assign` | POST | Manager, Staff, Admin | Tenant & Profile Check |
| **Check-in Visit** | `/v1/psw/visits/:id/check-in` | POST | PSW | Visit Assignment Check |
| **Check-out Visit** | `/v1/psw/visits/:id/check-out` | POST | PSW | Visit Assignment Check |
| **Submit Daily Entry** | `/v1/daily-entry` | POST | PSW | Active Visit Check |
| **Report Incident** | `/v1/incidents` | POST | All (except Client) | Tenant & Reporter Check |

## 👤 User & Profile Management

| Action | API Endpoint | Method | Required Role | IDOR Protection |
| :--- | :--- | :--- | :--- | :--- |
| **Client Admission** | `/v1/admin/clients` | POST | Manager, Admin | Multi-table Transaction |
| **PSW Onboarding** | `/v1/admin/psw/onboard` | POST | Manager, Admin | Multi-table Transaction |
| **Change User Role** | `/v1/admin/users/:id/role` | PATCH | Admin | Scope restricted |
| **Reset Password** | `/v1/auth/reset-password` | POST | Admin | Actor verify |
| **View Audit Logs** | `/v1/admin/audit` | GET | Admin | Strict Tenant Read |

## 🧪 RBAC Verification Rules (Cypress Logic)
- **PSW** must get `403` on `/v1/admin/clients`.
- **Staff** must get `403` on `/v1/client/:id/care-plan`.
- **Manager** must get `403` on `/v1/admin/audit` (if restricted).
- **RN** must get `403` on `/v1/admin/backups`.
