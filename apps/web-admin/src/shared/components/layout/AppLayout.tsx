import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate, Outlet } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';
import { useRouteTracker } from '@/shared/hooks/useRouteTracker';

// Components
import { Sidebar } from './Sidebar';
import { TopBar } from './TopBar';
import SideFloatingButton from './SideFloatingButton';
import OfflineIndicator from './OfflineIndicator';
import PswBottomNav from './PswBottomNav';
import SosButton from './SosButton';
import { CommandPalette } from './CommandPalette';
import { SoftphoneWidget } from '../communications/SoftphoneWidget';
import { ImpersonationBanner } from './ImpersonationBanner';
import { SystemHealthFooter } from './SystemHealthFooter';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

import { adminMenu, clientMenu, staffMenu, pswMenu, rnMenu, managerMenu, coordinatorMenu, financeMenu, financeDirectorMenu, platformMenu, scrumMasterMenu } from './menu-configs';

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
    useRouteTracker(); // auto-track every navigation

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
            navigate(RouteRegistry.ADMIN.DASHBOARD);
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
        if (lowerRole === 'finance_director') return financeDirectorMenu;
        if (lowerRole === 'rn') return rnMenu;
        if (['psw', 'rmt', 'rpt', 'rch'].includes(lowerRole)) return pswMenu;
        if (lowerRole === 'super_admin') return platformMenu;
        if (lowerRole === 'scrum_master') return scrumMasterMenu;

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
                setIsCollapsed={setIsCollapsed}
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
            <OfflineIndicator />
            {['psw', 'rn', 'rmt', 'rpt', 'rch'].includes(role.toLowerCase()) && (
                <>
                    <PswBottomNav />
                    <SosButton />
                </>
            )}

            {/* Coordinator/Dispatcher Global Accelerators */}
            <CommandPalette />
            <SoftphoneWidget />
            
            {/* Platform Administrator Telemetry & Barriers */}
            {role.toLowerCase() === 'super_admin' && (
                <>
                    <ImpersonationBanner />
                    <SystemHealthFooter />
                </>
            )}
        </div>
    );
}
