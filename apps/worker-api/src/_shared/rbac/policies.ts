
import { Permission } from './permissions';

export const ROLE_PERMISSIONS: Record<string, Permission[]> = {
    admin: [
        'USER_CREATE', 'USER_RESET_PASSWORD', 'CLIENT_VIEW_ALL', 'CLIENT_UPDATE',
        'SHIFT_ASSIGN', 'SHIFT_REASSIGN', 'SETTINGS_UPDATE',
        'CARE_PLAN_UPDATE', 'DAILY_ENTRY_REVIEW', 'BACKUP_CREATE', 'BACKUP_RESTORE'
    ],
    manager: [
        'CLIENT_VIEW_ALL', 'SHIFT_ASSIGN', 'SHIFT_REASSIGN',
        'AUDIT_VIEW', 'DAILY_ENTRY_CREATE'
    ],
    staff: [
        'CLIENT_VIEW_ALL', 'SHIFT_ASSIGN', 'SHIFT_REASSIGN'
    ],
    rn: [
        'CARE_PLAN_UPDATE', 'CARE_PLAN_VIEW', 'DAILY_ENTRY_REVIEW',
        'PSW_SUPERVISE', 'CLIENT_VIEW_ALL'
    ],
    psw: [
        'CLIENT_VIEW_ASSIGNED', 'SHIFT_START_END', 'DAILY_ENTRY_CREATE'
    ],
    client: [
        'CLIENT_VIEW_ASSIGNED', 'CARE_PLAN_UPDATE'
    ],
    coordinator: [
        'SHIFT_ASSIGN', 'SHIFT_REASSIGN'
    ],
    finance: [
        'PAYROLL_APPROVE'
    ],
    super_admin: [],
    marketing_manager: ['CLIENT_VIEW_ALL', 'AUDIT_VIEW'],
    operations_manager: ['CLIENT_VIEW_ALL', 'SHIFT_ASSIGN', 'SHIFT_REASSIGN', 'AUDIT_VIEW', 'DAILY_ENTRY_CREATE'],
    hr_manager: ['USER_CREATE', 'USER_RESET_PASSWORD', 'AUDIT_VIEW'],
    clinical_manager: ['CARE_PLAN_UPDATE', 'CARE_PLAN_VIEW', 'DAILY_ENTRY_REVIEW', 'CLIENT_VIEW_ALL', 'AUDIT_VIEW'],
    regional_manager: ['CLIENT_VIEW_ALL', 'SHIFT_ASSIGN', 'AUDIT_VIEW'],
    finance_manager: ['PAYROLL_APPROVE', 'AUDIT_VIEW'],
    recruiting_manager: ['USER_CREATE', 'AUDIT_VIEW'],
    rmt: ['CLIENT_VIEW_ASSIGNED', 'SHIFT_START_END', 'DAILY_ENTRY_CREATE'],
    rpt: ['CLIENT_VIEW_ASSIGNED', 'SHIFT_START_END', 'DAILY_ENTRY_CREATE'],
    rch: ['CLIENT_VIEW_ASSIGNED', 'SHIFT_START_END', 'DAILY_ENTRY_CREATE'],
    scrum_master: ['AUDIT_VIEW', 'USER_CREATE', 'SETTINGS_UPDATE', 'CARE_PLAN_VIEW', 'CARE_PLAN_UPDATE', 'DAILY_ENTRY_REVIEW']
};
