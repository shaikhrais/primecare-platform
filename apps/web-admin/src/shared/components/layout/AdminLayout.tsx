import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import QuickActions from '@/shared/components/dashboard/QuickActions';
import RoleSwitcher from '@/shared/components/layout/RoleSwitcher';
import NotificationHub from '@/shared/components/layout/NotificationHub';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

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
    const [isProfileOpen, setIsProfileOpen] = useState(false);
    const [isFullscreen, setIsFullscreen] = useState(false);

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

    const toggleFullscreen = () => {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(err => {
                console.error(`Error attempting to enable full-screen mode: ${err.message}`);
            });
            setIsFullscreen(true);
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
                setIsFullscreen(false);
            }
        }
    };

    // Auth & Role Guard
    React.useEffect(() => {
        const currentUser = localStorage.getItem('user');
        if (!currentUser || currentUser === 'undefined') {
            navigate(RouteRegistry.LOGIN);
            return;
        }

        if (roleGated && !roleGated.includes(role)) {
            // Redirect to home dashboard if unauthorized
            navigate(RouteRegistry.DASHBOARD);
        }
    }, [navigate, role, roleGated]);

    const adminMenu = [
        { label: 'Dashboard', path: RouteRegistry.DASHBOARD, icon: '📊' },
        { label: 'Users & PSWs', path: RouteRegistry.USERS, icon: '👥' },
        { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
        { label: 'Incidents', path: RouteRegistry.INCIDENTS, icon: '🚨' },
        { label: 'Timesheets', path: RouteRegistry.TIMESHEETS, icon: '⏰' },
        { label: 'Lead Inquiries', path: RouteRegistry.LEADS, icon: '📥' },
        { label: 'Services', path: RouteRegistry.SERVICES, icon: '💰' },
        { label: 'Call Audits', path: RouteRegistry.AUDITS, icon: '🎙️' },
        { label: 'Content', path: RouteRegistry.CONTENT, icon: '📝' },
        { label: 'Settings', path: RouteRegistry.SETTINGS, icon: '⚙️' },
        { label: 'Support', path: RouteRegistry.SUPPORT, icon: '💬' },
    ];

    const clientMenu = [
        { label: 'My Care Hub', path: RouteRegistry.DASHBOARD, icon: '🏠' },
        { label: 'My Bookings', path: '/bookings', icon: '📅' },
        { label: 'Billing', path: '/billing', icon: '💳' },
        { label: 'Account Profile', path: '/profile', icon: '👤' },
        { label: 'Support', path: '/support', icon: '💬' },
    ];

    const staffMenu: MenuItem[] = [
        { label: 'Staff Hub', path: RouteRegistry.DASHBOARD, icon: '🏢' },
        { label: 'Leads', path: RouteRegistry.LEADS, icon: '📥' },
        { label: 'Users', path: RouteRegistry.USERS, icon: '👥' },
        { label: 'Customer Mgmt', path: '/customers', icon: '👤' },
        { label: 'Tickets', path: '/support', icon: '🎫' },
        { label: 'My Profile', path: '/profile', icon: '👤' },
    ];

    const pswMenu: MenuItem[] = [
        { label: 'Work Schedule', path: RouteRegistry.DASHBOARD, icon: '🗓️' },
        { label: 'My Shifts', path: '/shifts', icon: '⌚' },
        { label: 'My Earnings', path: '/earnings', icon: '💰' },
        { label: 'My Credentials', path: '/profile', icon: '📜' },
        { label: 'Help Desk', path: '/support', icon: '❓' },
    ];

    const rnMenu: MenuItem[] = [
        { label: 'Clinical Dashboard', path: '/rn/dashboard', icon: '🩺' },
        { label: 'Clients admission', path: '/admin/clients/admission', icon: '📝' },
        { label: 'Incident List', path: '/incidents', icon: '🚨' },
        { label: 'Profile', path: '/profile', icon: '👤' },
    ];

    const menuItems = role === 'admin' ? adminMenu : role === 'rn' ? rnMenu : role === 'psw' ? pswMenu : role === 'staff' ? staffMenu : clientMenu;

    const portalTitle = role === 'admin' ? 'Admin' : role === 'rn' ? 'Nurse' : role === 'psw' ? 'Caregiver' : role === 'staff' ? 'Staff' : 'Family';

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

    return (
        <div className="app">
            {/* Sidebar */}
            <aside className="pc-sidebar" data-cy="sidebar" style={{ position: 'fixed', height: '100vh', width: 'var(--sidebar-width)', zIndex: 'var(--z-index-sidebar)', display: 'flex', flexDirection: 'column' }}>
                <div style={{ padding: '16px 12px' }}>
                    <h1 style={{ fontSize: '20px', fontWeight: 800, margin: 0, display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <span style={{ color: 'var(--brand-500)' }}>PrimeCare</span>
                        <span style={{ color: 'var(--text-100)', fontWeight: 500, fontSize: '0.85em' }}>{portalTitle}</span>
                    </h1>
                </div>

                <nav className="nav" style={{ flex: 1, padding: '10px 0', overflowY: 'auto' }} data-cy="nav.main">
                    {menuItems.map((item: MenuItem) => {
                        const isActive = location.pathname.startsWith(item.path) || (item.path === '/app' && location.pathname === '/app');
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                className={`pc-nav-link ${isActive ? 'active' : ''}`}
                                data-cy={`nav-item-${item.label.toLowerCase().replace(/\s+/g, '-')}`}
                            >
                                <span style={{ fontSize: '1.2rem' }}>{item.icon}</span>
                                <span style={{ fontWeight: isActive ? 700 : 500 }}>{item.label}</span>
                            </Link>
                        );
                    })}
                </nav>

                <RoleSwitcher />

                <div className="sidebar-footer">
                    <div className="pill">
                        <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: 'var(--brand-500)' }}></div>
                        <span>{role} ONLINE</span>
                    </div>

                    <button
                        onClick={handleLogout}
                        className="btn btn-danger"
                        data-cy="btn-logout"
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: '10px',
                            width: '100%',
                            justifyContent: 'center',
                            marginTop: '8px'
                        }}
                    >
                        🚪 Logout
                    </button>
                </div>
            </aside>

            {/* Main Content */}
            <main style={{ flex: 1, marginLeft: 'var(--sidebar-width)', display: 'flex', flexDirection: 'column' }}>
                <div style={{ padding: '24px' }}>
                    {/* Topbar */}
                    <header className="pc-topbar" data-cy="page.header">
                        <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                            <span className="title" style={{ fontSize: '0.7rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '1px', opacity: 0.6 }}>
                                System Operations
                            </span>
                        </div>

                        <div className="right">
                            {/* Full Screen Toggle */}
                            <button
                                onClick={toggleFullscreen}
                                className="btn"
                                style={{
                                    width: '44px',
                                    height: '44px',
                                    padding: 0,
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center'
                                }}
                            >
                                {isFullscreen ? (
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3" />
                                    </svg>
                                ) : (
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3" />
                                    </svg>
                                )}
                            </button>

                            <div className="chip">
                                📅 {new Date().toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })}
                            </div>

                            <QuickActions role={role} />

                            <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                                <NotificationHub />
                                <button className="btn" style={{ width: '44px', height: '44px', padding: 0 }}>🔍</button>
                            </div>
                        </div>
                    </header>

                    {/* Page Content */}
                    <div style={{ marginTop: '2rem' }}>
                        {children}
                    </div>
                </div>
            </main >
        </div >
    );
}
