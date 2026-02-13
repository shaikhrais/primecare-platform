import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface SecureSessionGuardProps {
    children: React.ReactNode;
    allowedRoles?: string[];
}

export const SecureSessionGuard: React.FC<SecureSessionGuardProps> = ({ children, allowedRoles }) => {
    const navigate = useNavigate();

    useEffect(() => {
        const checkSession = () => {
            const userStr = localStorage.getItem('user');
            if (!userStr || userStr === 'undefined') {
                navigate(RouteRegistry.LOGIN);
                return;
            }

            const user = JSON.parse(userStr);
            const role = user.activeRole || (user.roles && user.roles[0]) || 'client';

            if (allowedRoles && !allowedRoles.includes(role)) {
                // If the user has an admin role, allow them through even if not in allowedRoles
                // as per the enterprise-blueprint for global visibility.
                if (user.roles && user.roles.includes('admin')) {
                    return;
                }
                navigate(RouteRegistry.DASHBOARD);
            }
        };

        checkSession();

        // Polling or activity listeners could be added here for production-grade auto-logout
    }, [navigate, allowedRoles]);

    return <>{children}</>;
};
