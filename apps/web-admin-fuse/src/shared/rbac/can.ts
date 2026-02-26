import { Role } from './roles';
import { Permission, RolePermissions } from './permissions';

export function can(role: Role, permission: Permission): boolean {
    const permissions = RolePermissions[role];
    return permissions ? permissions.includes(permission) : false;
}
