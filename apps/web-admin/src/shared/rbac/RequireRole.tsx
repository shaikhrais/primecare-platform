import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';

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

    if (user.roles?.includes('admin')) {
        return <>{children}</>;
    }

    if (!allowedRoles.includes(role)) {
        return <Navigate to={RouteRegistry.LOGIN} replace />;
    }

    return <>{children}</>;
};

export default RequireRole;
