import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate, Outlet } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';

// Components
import { Sidebar } from './Sidebar';
import { TopBar } from './TopBar';
import SideFloatingButton from './SideFloatingButton';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

import { adminMenu, clientMenu, staffMenu, pswMenu, rnMenu, managerMenu, coordinatorMenu, financeMenu, platformMenu } from './menu-configs';

interface AppLayoutProps {
    children?: React.ReactNode;
    roleGated?: string[];
}

export default function AppLayout({ children, roleGated }: AppLayoutProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);
    const [isCollapsed, setIsCollapsed] = useState(false);
    const isMobile = useMediaQuery('(max-width: 1024px)');

    useEffect(() => {
        setIsSidebarOpen(false);
    }, [location.pathname]);

    useEffect(() => {
        const width = isMobile ? '0px' : (isCollapsed ? '80px' : '280px');
        document.documentElement.style.setProperty('--sidebar-width', width);
    }, [isCollapsed, isMobile]);

    const userStr = localStorage.getItem('user');
    const user = userStr && userStr !== 'undefined' ? JSON.parse(userStr) : { roles: ['client'], activeRole: 'client' };
    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';
    const API_URL = import.meta.env.VITE_API_URL;

    useEffect(() => {
        const currentUser = localStorage.getItem('user');
        if (!currentUser || currentUser === 'undefined') {
            navigate(RouteRegistry.LOGIN);
            return;
        }

        if (roleGated && !roleGated.includes(role)) {
            navigate(RouteRegistry.DASHBOARD);
        }
    }, [navigate, role, roleGated]);

    const getMenuItems = (role: string) => {
        const lowerRole = role.toLowerCase();

        if (lowerRole === 'admin') return adminMenu;
        if (lowerRole.includes('manager') || ['coordinator', 'crm', 'training'].includes(lowerRole)) {
            if (lowerRole === 'coordinator') return coordinatorMenu;
            return managerMenu;
        }
        if (['staff', 'finance', 'hr', 'compliance'].includes(lowerRole)) {
            if (lowerRole === 'finance') return financeMenu;
            return staffMenu;
        }
        if (lowerRole === 'rn') return rnMenu;
        if (['psw', 'rmt', 'rpt', 'rch'].includes(lowerRole)) return pswMenu;
        if (lowerRole === 'super_admin') return platformMenu;

        return clientMenu;
    };

    const menuItems = getMenuItems(role);

    const handleLogout = async () => {
        try {
            const { ApiRegistry } = AdminRegistry;
            await fetch(`${API_URL}${ApiRegistry.AUTH.LOGOUT}`, {
                method: 'POST',
                credentials: 'include'
            });
        } catch (e) {
            console.error('Logout API call failed', e);
        }
        localStorage.removeItem('user');
        localStorage.removeItem('token');
        navigate(RouteRegistry.LOGIN);
    };

    return (
        <div className="pc-app-container" style={{
            display: 'flex',
            minHeight: '100vh',
            backgroundColor: '#FFFFFF',
            '--sidebar-width': isMobile ? '0px' : (isCollapsed ? '80px' : '280px')
        } as any}>
            {/* Sidebar Overlay (Mobile Only) */}
            {isMobile && isSidebarOpen && (
                <div
                    onClick={() => setIsSidebarOpen(false)}
                    style={{
                        position: 'fixed',
                        inset: 0,
                        backgroundColor: 'rgba(0,0,0,0.5)',
                        zIndex: 999
                    }}
                />
            )}

            <Sidebar
                menuItems={menuItems}
                isCollapsed={isCollapsed}
                isMobile={isMobile}
                isOpen={isSidebarOpen}
                setIsOpen={setIsSidebarOpen}
                handleLogout={handleLogout}
            />

            {/* Main Content */}
            <main style={{
                flex: 1,
                marginLeft: isMobile ? 0 : 'var(--sidebar-width)',
                display: 'flex',
                flexDirection: 'column',
                minHeight: '100vh',
                backgroundColor: '#FFFFFF',
                width: isMobile ? '100%' : 'calc(100% - var(--sidebar-width))',
                overflowX: 'hidden'
            }}>
                <TopBar
                    isMobile={isMobile}
                    isCollapsed={isCollapsed}
                    setIsCollapsed={setIsCollapsed}
                    setIsSidebarOpen={setIsSidebarOpen}
                    role={role}
                    user={user}
                />

                <div style={{ flex: 1, padding: isMobile ? '16px' : '32px' }}>
                    <Outlet />
                    {children}
                </div>
            </main>

            <SideFloatingButton />
        </div>
    );
}
