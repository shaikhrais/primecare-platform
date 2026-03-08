import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import Unauthorized from '../../app/routes/shared/pages/error/Unauthorized';

const { RouteRegistry } = AdminRegistry;

interface RequireRoleProps {
    children: React.ReactNode;
    allowedRoles: string[];
}

export const RequireRole: React.FC<RequireRoleProps> = ({ children, allowedRoles }) => {
    const location = useLocation();
    const { user, loading } = useAuth();

    if (loading) {
        return null; // Silent while checking session
    }

    if (!user) {
        return <Navigate to={RouteRegistry.LOGIN} state={{ from: location }} replace />;
    }

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';

    // #10: Only super_admin and scrum_master get full bypass — admin still checks allowed list
    if (user.roles?.includes('super_admin') || user.roles?.includes('scrum_master')) {
        return <>{children}</>;
    }

    // Check if user's active role or any of their roles match the allowed list
    if (!allowedRoles.includes(role)) {
        // Also check if any user role matches (umbrella access)
        const hasAnyMatch = user.roles?.some((r: string) => allowedRoles.includes(r));
        if (!hasAnyMatch) return <Unauthorized />;
    }

    return <>{children}</>;
};

export default RequireRole;
