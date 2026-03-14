/**
 * API-side RBAC — Re-exports from shared PermissionRegistry
 *
 * This file bridges the old API-local permission types to the new shared system.
 * All permission checking now goes through the centralized PermissionRegistry.
 *
 * OLD: import { Permission } from '../rbac/permissions'
 * NEW: Same import path works, but resolves to shared PermissionRegistry
 */
import {
    Permission as SharedPermission,
    can as sharedCan,
    canAny as sharedCanAny,
    ROLE_PERMISSIONS as SHARED_ROLE_PERMISSIONS,
} from 'prime-care-shared';

// Re-export the shared Permission type as both the old and new names
export type Permission = SharedPermission;

// Legacy operation-level permissions mapped to new system
// These are kept for backward compatibility with existing route handlers
export type OperationPermission =
    | 'CLIENT_CREATE' | 'CLIENT_UPDATE' | 'CLIENT_VIEW_ALL' | 'CLIENT_VIEW_ASSIGNED'
    | 'CARE_PLAN_CREATE' | 'CARE_PLAN_UPDATE' | 'CARE_PLAN_VIEW'
    | 'RISK_LEVEL_UPDATE' | 'PSW_SUPERVISE'
    | 'SHIFT_CREATE' | 'SHIFT_ASSIGN' | 'SHIFT_REASSIGN' | 'SHIFT_START_END'
    | 'DAILY_ENTRY_CREATE' | 'DAILY_ENTRY_REVIEW'
    | 'INCIDENT_CREATE' | 'INCIDENT_CLOSE'
    | 'PAYROLL_APPROVE'
    | 'USER_CREATE' | 'USER_RESET_PASSWORD'
    | 'BACKUP_CREATE' | 'BACKUP_RESTORE'
    | 'AUDIT_VIEW' | 'SETTINGS_UPDATE' | 'COORDINATOR_DISPATCH';

// Map old operation permissions → new page-level permissions
export const LEGACY_PERMISSION_MAP: Record<OperationPermission, SharedPermission> = {
    CLIENT_CREATE: 'manage_users',
    CLIENT_UPDATE: 'manage_users',
    CLIENT_VIEW_ALL: 'view_users',
    CLIENT_VIEW_ASSIGNED: 'view_dashboard',
    CARE_PLAN_CREATE: 'manage_care_plans',
    CARE_PLAN_UPDATE: 'manage_care_plans',
    CARE_PLAN_VIEW: 'clinical_oversight',
    RISK_LEVEL_UPDATE: 'clinical_oversight',
    PSW_SUPERVISE: 'clinical_oversight',
    SHIFT_CREATE: 'create_visits',
    SHIFT_ASSIGN: 'manage_schedule',
    SHIFT_REASSIGN: 'manage_schedule',
    SHIFT_START_END: 'clock_in_out',
    DAILY_ENTRY_CREATE: 'submit_handover',
    DAILY_ENTRY_REVIEW: 'clinical_oversight',
    INCIDENT_CREATE: 'manage_incidents',
    INCIDENT_CLOSE: 'manage_incidents',
    PAYROLL_APPROVE: 'manage_payroll',
    USER_CREATE: 'create_users',
    USER_RESET_PASSWORD: 'manage_users',
    BACKUP_CREATE: 'manage_security',
    BACKUP_RESTORE: 'manage_security',
    AUDIT_VIEW: 'view_audit_logs',
    SETTINGS_UPDATE: 'manage_settings',
    COORDINATOR_DISPATCH: 'manage_dispatch',
};

/**
 * Check a legacy operation permission by mapping it to the new system.
 */
export function canLegacy(role: string, permission: OperationPermission): boolean {
    const mapped = LEGACY_PERMISSION_MAP[permission];
    return sharedCan(role, mapped);
}

// Re-export shared helpers under familiar names
export { sharedCan as can, sharedCanAny as canAny, SHARED_ROLE_PERMISSIONS as ROLE_PERMISSIONS };
