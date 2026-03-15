/**
 * PermissionGuard — Role-based route & component protection
 *
 * Wraps routes or UI sections that require specific roles/permissions.
 *
 * Usage:
 *   <PermissionGuard roles={['admin', 'manager']}>
 *       <SensitiveContent />
 *   </PermissionGuard>
 *
 *   <PermissionGuard roles={['admin']} fallback={<AccessDenied />}>
 *       <AdminPanel />
 *   </PermissionGuard>
 */
import React, { type ReactNode } from 'react';
import { useAuthStore } from '@/shared/stores';

interface PermissionGuardProps {
    /** Required roles (user must have at least one) */
    roles: string[];
    /** Content to show when authorized */
    children: ReactNode;
    /** Content to show when unauthorized (default: AccessDenied UI) */
    fallback?: ReactNode;
    /** If true, require ALL roles instead of ANY */
    requireAll?: boolean;
    /** If true, hide content silently instead of showing fallback */
    silent?: boolean;
}

export const PermissionGuard: React.FC<PermissionGuardProps> = ({
    roles, children, fallback, requireAll = false, silent = false,
}) => {
    const user = useAuthStore((s) => s.user);
    const activeRole = user?.activeRole;
    const userRoles = user?.roles || [];

    const isAuthorized = (() => {
        if (!activeRole) return false;
        if (roles.length === 0) return true;

        if (requireAll) {
            return roles.every(r => userRoles.includes(r));
        }
        return roles.includes(activeRole) || roles.some(r => userRoles.includes(r));
    })();

    if (isAuthorized) return <>{children}</>;
    if (silent) return null;
    if (fallback) return <>{fallback}</>;

    return <DefaultAccessDenied requiredRoles={roles} currentRole={activeRole} />;
};

// ── Default Access Denied UI ──────────────────────────────────────────────

const DefaultAccessDenied: React.FC<{ requiredRoles: string[]; currentRole?: string }> = ({ requiredRoles, currentRole }) => (
    <div
        data-cy="access-denied"
        style={{
            display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
            minHeight: '300px', padding: '2rem', textAlign: 'center',
            fontFamily: "'Inter', system-ui, sans-serif",
        }}
    >
        <div style={{
            width: '64px', height: '64px', borderRadius: '50%', backgroundColor: '#FEF3C7',
            display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem', marginBottom: '1rem',
        }}>🔒</div>
        <h2 style={{ fontSize: '1.25rem', fontWeight: 700, color: '#0f172a', margin: '0 0 0.5rem' }}>
            Access Restricted
        </h2>
        <p style={{ fontSize: '0.875rem', color: '#64748b', maxWidth: '400px', margin: '0 0 1rem' }}>
            This section requires {requiredRoles.map(r => r.charAt(0).toUpperCase() + r.slice(1)).join(' or ')} access.
            {currentRole && ` Your current role is ${currentRole.charAt(0).toUpperCase() + currentRole.slice(1)}.`}
        </p>
        <button
            onClick={() => window.history.back()}
            data-cy="access-denied-back"
            style={{
                padding: '0.5rem 1.25rem', borderRadius: '0.5rem',
                backgroundColor: '#3B82F6', color: '#fff', border: 'none',
                fontSize: '0.875rem', fontWeight: 600, cursor: 'pointer',
            }}
        >Go Back</button>
    </div>
);

// ── Hook ──────────────────────────────────────────────────────────────────

/** Check if current user has one of the specified roles */
export function useHasRole(...roles: string[]): boolean {
    const user = useAuthStore((s) => s.user);
    if (!user) return false;
    return roles.includes(user.activeRole) || roles.some(r => user.roles.includes(r));
}

/** Check if current user has ALL specified roles */
export function useHasAllRoles(...roles: string[]): boolean {
    const userRoles = useAuthStore((s) => s.user?.roles || []);
    return roles.every(r => userRoles.includes(r));
}

export default PermissionGuard;
