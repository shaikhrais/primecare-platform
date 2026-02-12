import { Role } from './roles';

export type Permission =
    | 'view_dashboard'
    | 'manage_users'
    | 'manage_leads'
    | 'view_schedule'
    | 'manage_incidents'
    | 'view_reports'
    | 'clinical_oversight';

export const RolePermissions: Record<Role, Permission[]> = {
    admin: ['view_dashboard', 'manage_users', 'manage_leads', 'view_schedule', 'manage_incidents', 'view_reports', 'clinical_oversight'],
    manager: ['view_dashboard', 'manage_users', 'view_schedule', 'manage_incidents', 'view_reports'],
    staff: ['view_dashboard', 'manage_leads', 'manage_users'],
    rn: ['view_dashboard', 'clinical_oversight', 'view_schedule'],
    psw: ['view_dashboard', 'view_schedule'],
    client: ['view_dashboard'],
};
