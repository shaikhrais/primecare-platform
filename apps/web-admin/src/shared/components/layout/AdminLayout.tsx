import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';

// Components
import { Sidebar } from './Sidebar';
import { TopBar } from './TopBar';

const { RouteRegistry } = AdminRegistry;

interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

interface AdminLayoutProps {
    children: React.ReactNode;
    roleGated?: string[];
}

export default function AdminLayout({ children, roleGated }: AdminLayoutProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);
    const [isCollapsed, setIsCollapsed] = useState(false);
    const isMobile = useMediaQuery('(max-width: 1024px)');

    useEffect(() => {
        setIsSidebarOpen(false);
    }, [location.pathname]);

    // Update CSS variable for sidebar width
    useEffect(() => {
        const width = isMobile ? '0px' : (isCollapsed ? '80px' : '280px');
        document.documentElement.style.setProperty('--sidebar-width', width);
    }, [isCollapsed, isMobile]);

    // Get user info from storage with safety
    const getUser = () => {
        try {
            const userStr = localStorage.getItem('user');
            if (!userStr || userStr === 'undefined') return { roles: ['client'], activeRole: 'client' };
            const u = JSON.parse(userStr);
            return u;
        } catch (e) {
            return { roles: ['client'], activeRole: 'client' };
        }
    };

    const user = getUser();
    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';
    const API_URL = import.meta.env.VITE_API_URL;

    // Auth & Role Guard
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

    const adminMenu: MenuItem[] = [
        { label: 'Dashboard', path: RouteRegistry.DASHBOARD, icon: '📊' },
        { label: 'Users & PSWs', path: RouteRegistry.USERS, icon: '👥' },
        { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
        { label: 'Incidents', path: RouteRegistry.INCIDENTS, icon: '🚨' },
        { label: 'Timesheets', path: RouteRegistry.TIMESHEETS, icon: '⏰' },
        { label: 'Lead Inquiries', path: RouteRegistry.LEADS, icon: '📥' },
        { label: 'Services', path: RouteRegistry.SERVICES, icon: '💰' },
        { label: 'Call Audits', path: RouteRegistry.AUDITS, icon: '🎙️' },
        { label: 'Content', path: RouteRegistry.CONTENT, icon: '📝' },
        { label: 'Reports', path: '/admin/reports', icon: '📈' },
        { label: 'Settings', path: RouteRegistry.SETTINGS, icon: '⚙️' },
        { label: 'Support', path: RouteRegistry.SUPPORT, icon: '💬' },
    ];

    const clientMenu: MenuItem[] = [
        { label: 'My Care Hub', path: '/client/dashboard', icon: '🏠' },
        { label: 'My Bookings', path: '/client/bookings', icon: '📅' },
        { label: 'Billing', path: '/client/billing', icon: '💳' },
        { label: 'Account Profile', path: '/profile', icon: '👤' },
        { label: 'Support', path: '/support', icon: '💬' },
    ];

    const staffMenu: MenuItem[] = [
        { label: 'Staff Hub', path: '/staff/dashboard', icon: '🏢' },
        { label: 'Leads', path: RouteRegistry.LEADS, icon: '📥' },
        { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
        { label: 'Users', path: RouteRegistry.USERS, icon: '👥' },
        { label: 'Customer Mgmt', path: '/staff/customers', icon: '👤' },
        { label: 'Tickets', path: '/support', icon: '🎫' },
        { label: 'My Profile', path: '/profile', icon: '👤' },
    ];

    const pswMenu: MenuItem[] = [
        { label: 'Work Schedule', path: '/psw/dashboard', icon: '🗓️' },
        { label: 'Open Shifts', path: '/psw/open-shifts', icon: '✨' },
        { label: 'My Shifts', path: '/psw/schedule', icon: '⌚' },
        { label: 'My Earnings', path: '/psw/earnings', icon: '💰' },
        { label: 'My Credentials', path: '/psw/profile', icon: '📜' },
        { label: 'Help Desk', path: '/support', icon: '❓' },
    ];

    const rnMenu: MenuItem[] = [
        { label: 'Clinical Dashboard', path: '/rn/dashboard', icon: '🩺' },
        { label: 'Clients admission', path: '/admin/clients/admission', icon: '📝' },
        { label: 'Incident List', path: RouteRegistry.INCIDENTS, icon: '🚨' },
        { label: 'Profile', path: '/profile', icon: '👤' },
    ];

    const managerMenu: MenuItem[] = [
        { label: 'Dashboard', path: '/manager/dashboard', icon: '📊' },
        { label: 'Daily Entry', path: '/manager/daily-entry', icon: '📝' },
        { label: 'Evaluations', path: '/manager/evaluations', icon: '📋' },
        { label: 'Service Review', path: '/manager/service-review', icon: '⭐' },
        { label: 'Profile', path: '/profile', icon: '👤' },
    ];

    const menuItems = role === 'admin' ? adminMenu : role === 'manager' ? managerMenu : role === 'rn' ? rnMenu : role === 'psw' ? pswMenu : role === 'staff' ? staffMenu : clientMenu;

    const handleLogout = async () => {
        try {
            await fetch(`${API_URL}/v1/auth/logout`, {
                method: 'POST',
                credentials: 'include'
            });
        } catch (e) {
            console.error('Logout API call failed', e);
        }
        localStorage.removeItem('user');
        navigate(RouteRegistry.LOGIN);
    };

    const containerStyle = {
        display: 'flex',
        minHeight: '100vh',
        backgroundColor: '#FFFFFF',
        '--sidebar-width': isMobile ? '0px' : (isCollapsed ? '80px' : '280px')
    } as any;

    const overlayStyle = {
        position: 'fixed' as const,
        inset: 0,
        backgroundColor: 'rgba(0,0,0,0.5)',
        zIndex: 999
    };

    return (
        <div className="app" style={containerStyle}>
            {/* Sidebar Overlay (Mobile Only) */}
            {isMobile && isSidebarOpen && (
                <div
                    onClick={() => setIsSidebarOpen(false)}
                    style={overlayStyle}
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
                width: isMobile ? '100%' : 'calc(100% - var(--sidebar-width))'
            }}>
                <TopBar
                    isMobile={isMobile}
                    isCollapsed={isCollapsed}
                    setIsCollapsed={setIsCollapsed}
                    setIsSidebarOpen={setIsSidebarOpen}
                    role={role}
                    user={user}
                />

                <div style={{ flex: 1, padding: isMobile ? '16px' : '24px' }}>
                    {children}
                </div>
            </main>
        </div>
    );
}
