import { Role } from '../../generated/client/edge';
import { Permission } from './permissions';

export const ROLE_PERMISSIONS: Record<Role, Permission[]> = {
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
        'CARE_PLAN_UPDATE', 'DAILY_ENTRY_REVIEW',
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
    ]
};
