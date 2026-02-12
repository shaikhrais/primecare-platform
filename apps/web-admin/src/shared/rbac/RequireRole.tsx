import React, { useEffect } from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface RequireRoleProps {
    children: React.ReactNode;
    allowedRoles: string[];
}

/**
 * RequireRole Guard
 * Enforces role-based access control at the route level.
 * Centralizes user/role fetching from localStorage/cookies.
 */
export const RequireRole: React.FC<RequireRoleProps> = ({ children, allowedRoles }) => {
    const location = useLocation();

    // Get user info from storage with safety
    const getUser = () => {
        try {
            const userStr = localStorage.getItem('user');
            if (!userStr || userStr === 'undefined') return null;
            return JSON.parse(userStr);
        } catch (e) {
            return null;
        }
    };

    const user = getUser();

    if (!user) {
        // Redirect to login if not authenticated
        return <Navigate to={RouteRegistry.LOGIN} state={{ from: location }} replace />;
    }

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';

    if (!allowedRoles.includes(role)) {
        // Redirect to login or a safe page to avoid loops
        return <Navigate to={RouteRegistry.LOGIN} replace />;
    }

    return <>{children}</>;
};

export default RequireRole;
