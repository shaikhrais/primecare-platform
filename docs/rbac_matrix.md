# Role × Feature Matrix (PrimeCare Platform)

| Feature / Action | Admin | Manager | Staff (Office) | RN (Clinical) | PSW (Caregiver) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Client Management** | | | | | |
| Create Client | ✅ | ✅ | ❌ | ❌ | ❌ |
| Edit Client Demographics | ✅ | ✅ | ✅ (limited) | ✅ | ❌ |
| Create / Update Care Plan | ✅ | ❌ | ❌ | ✅ | ❌ |
| Update Risk Level | ✅ | ❌ | ❌ | ✅ | ❌ |
| **Shift Management** | | | | | |
| Create Shift | ✅ | ✅ | ✅ | ❌ | ❌ |
| Assign / Reassign PSW | ✅ | ✅ | ✅ (scheduler) | ❌ | ❌ |
| Start / End Shift | ✅ | ❌ | ❌ | ❌ | ✅ |
| **Clinical Monitoring** | | | | | |
| Create Daily Care Entry | ✅ | ✅ | ✅ | ✅ | ✅ |
| RN Review / Approve Daily Entry | ✅ | ❌ | ❌ | ✅ | ❌ |
| Supervise PSWs (Performance) | ✅ | ✅ (ops) | ❌ | ✅ | ❌ |
| **Admin & Finance** | | | | | |
| Payroll Approve | ✅ | ✅ | ✅ | ❌ | ❌ |
| Create User / Reset Password | ✅ | ❌ | ✅ (reset) | ❌ | ❌ |
| Backup / Restore | ✅ | ❌ | ❌ | ❌ | ❌ |
| View Audit Logs | ✅ | ✅ | ✅ | ✅ | ❌ |
| Update System Settings | ✅ | ❌ | ❌ | ❌ | ❌ |

## Clinical Roles (RN)
The **Registered Nurse (RN)** role acts as a clinical supervisor. They are responsible for the clinical integrity of care plans and overseeing the quality of daily entries submitted by PSWs.

### Key RN Permissions:
- `CARE_PLAN_CREATE` / `CARE_PLAN_UPDATE`
- `DAILY_ENTRY_REVIEW`
- `PSW_SUPERVISE`
- `RISK_LEVEL_UPDATE`
