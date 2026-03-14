/**
 * Frontend RBAC — Re-exports from shared PermissionRegistry
 *
 * All role and permission definitions now live in the shared package.
 * This file provides backward compatibility for existing imports.
 */
export type { PlatformRole as Role, Permission } from 'prime-care-shared';
export { PLATFORM_ROLES as ROLES } from 'prime-care-shared';
