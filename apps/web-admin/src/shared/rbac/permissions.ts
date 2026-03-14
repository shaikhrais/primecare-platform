/**
 * Frontend Permissions — Re-exports from shared PermissionRegistry
 *
 * All permissions and the role-permission matrix now live in the shared package.
 * This file provides backward compatibility for existing imports.
 */
export type { Permission } from 'prime-care-shared';
export { ROLE_PERMISSIONS as RolePermissions } from 'prime-care-shared';
