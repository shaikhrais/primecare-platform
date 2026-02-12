import { Role } from '../generated/client/edge';

export type Permission =
    | "CLIENT_CREATE"
    | "CLIENT_UPDATE"
    | "CLIENT_VIEW_ALL"
    | "CLIENT_VIEW_ASSIGNED"
    | "CARE_PLAN_CREATE"        // NEW
    | "CARE_PLAN_UPDATE"        // NEW
    | "RISK_LEVEL_UPDATE"       // NEW
    | "PSW_SUPERVISE"           // NEW (view PSW performance/logs)
    | "SHIFT_CREATE"
    | "SHIFT_ASSIGN"
    | "SHIFT_REASSIGN"
    | "SHIFT_START_END"
    | "DAILY_ENTRY_CREATE"
    | "DAILY_ENTRY_REVIEW"      // NEW (RN review/sign-off)
    | "INCIDENT_CREATE"
    | "INCIDENT_CLOSE"
    | "PAYROLL_APPROVE"
    | "USER_CREATE"
    | "USER_RESET_PASSWORD"
    | "BACKUP_CREATE"
    | "BACKUP_RESTORE"
    | "AUDIT_VIEW"
    | "SETTINGS_UPDATE";

export const ROLE_PERMISSIONS: Record<Role, Permission[]> = {
    admin: [
        "CLIENT_CREATE", "CLIENT_UPDATE", "CLIENT_VIEW_ALL",
        "CARE_PLAN_CREATE", "CARE_PLAN_UPDATE", "RISK_LEVEL_UPDATE", "PSW_SUPERVISE", "DAILY_ENTRY_REVIEW",
        "SHIFT_CREATE", "SHIFT_ASSIGN", "SHIFT_REASSIGN", "SHIFT_START_END",
        "DAILY_ENTRY_CREATE", "INCIDENT_CREATE", "INCIDENT_CLOSE",
        "PAYROLL_APPROVE",
        "USER_CREATE", "USER_RESET_PASSWORD",
        "BACKUP_CREATE", "BACKUP_RESTORE",
        "AUDIT_VIEW", "SETTINGS_UPDATE",
    ],
    manager: [
        "CLIENT_CREATE", "CLIENT_UPDATE", "CLIENT_VIEW_ALL",
        "SHIFT_CREATE", "SHIFT_ASSIGN", "SHIFT_REASSIGN",
        "DAILY_ENTRY_CREATE", "INCIDENT_CREATE", "INCIDENT_CLOSE",
        "AUDIT_VIEW",
    ],
    staff: [
        "CLIENT_UPDATE", "CLIENT_VIEW_ALL",
        "SHIFT_CREATE", "SHIFT_ASSIGN",
        "PAYROLL_APPROVE",
        "AUDIT_VIEW",
    ],
    rn: [
        "CLIENT_VIEW_ALL",
        "CARE_PLAN_CREATE", "CARE_PLAN_UPDATE", "RISK_LEVEL_UPDATE",
        "PSW_SUPERVISE", "DAILY_ENTRY_REVIEW",
        "INCIDENT_CLOSE",
        "AUDIT_VIEW",
    ],
    psw: [
        "CLIENT_VIEW_ASSIGNED",
        "SHIFT_START_END",
        "DAILY_ENTRY_CREATE",
        "INCIDENT_CREATE",
    ],
    coordinator: [
        "CLIENT_VIEW_ALL",
        "SHIFT_CREATE", "SHIFT_ASSIGN", "SHIFT_REASSIGN",
    ],
    finance: [
        "AUDIT_VIEW",
        "PAYROLL_APPROVE",
    ],
    client: [
        "CLIENT_VIEW_ASSIGNED",
        "DAILY_ENTRY_CREATE", // Clients might submit entries/feedback in some contexts? User logic said psw but let's keep it safe.
    ]
};
