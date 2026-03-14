import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { AdminRegistry, can, Permission } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import Unauthorized from '@/app/routes/shared/pages/error/Unauthorized';

const { RouteRegistry } = AdminRegistry;

interface RequireRoleProps {
    children: React.ReactNode;
    /** Role-based access: user must have one of these roles */
    allowedRoles?: string[];
    /** Permission-based access: user must have this permission (preferred over allowedRoles) */
    requiredPermission?: Permission;
}

/**
 * Route guard that supports both role-based and permission-based access control.
 *
 * Prefer `requiredPermission` for granular control:
 *   <RequireRole requiredPermission="manage_care_plans"><AppLayout /></RequireRole>
 *
 * Legacy `allowedRoles` still works:
 *   <RequireRole allowedRoles={['admin', 'manager']}><AppLayout /></RequireRole>
 */
export const RequireRole: React.FC<RequireRoleProps> = ({ children, allowedRoles, requiredPermission }) => {
    const location = useLocation();
    const { user, loading } = useAuth();

    if (loading) {
        return null;
    }

    if (!user) {
        return <Navigate to={RouteRegistry.LOGIN} state={{ from: location }} replace />;
    }

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';

    // super_admin and scrum_master always bypass
    if (user.roles?.includes('super_admin') || user.roles?.includes('scrum_master')) {
        return <>{children}</>;
    }

    // Permission-based check (preferred)
    if (requiredPermission) {
        const hasPermission = user.roles?.some((r: string) => can(r, requiredPermission)) || false;
        if (!hasPermission) return <Unauthorized />;
        return <>{children}</>;
    }

    // Role-based check (legacy)
    if (allowedRoles) {
        if (!allowedRoles.includes(role)) {
            const hasAnyMatch = user.roles?.some((r: string) => allowedRoles.includes(r));
            if (!hasAnyMatch) return <Unauthorized />;
        }
    }

    return <>{children}</>;
};

export default RequireRole;
