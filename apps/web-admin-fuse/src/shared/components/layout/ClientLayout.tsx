import React from 'react';
import { useLocation, Link, useNavigate, Outlet } from 'react-router-dom';
import GlobalQuickActionBar from './GlobalQuickActionBar';
import SideFloatingButton from './SideFloatingButton';
import RoleSwitcher from './RoleSwitcher';
import NotificationHub from './NotificationHub';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface ClientLayoutProps {
    children?: React.ReactNode;
}

export default function ClientLayout({ children }: ClientLayoutProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const userStr = localStorage.getItem('user');
    const user = userStr && userStr !== 'undefined' ? JSON.parse(userStr) : { roles: ['client'], activeRole: 'client' };
    const role = 'client';

    const menuItems = [
        { label: 'Dashboard', path: '/client/dashboard', icon: '🏠' },
        { label: 'My Bookings', path: '/client/bookings', icon: '📅' },
        { label: 'Request Care', path: '/client/request-booking', icon: '➕' },
        { label: 'Billing', path: '/client/billing', icon: '💳' },
        { label: 'Feedback', path: '/client/feedback', icon: '💬' },
    ];

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        navigate(RouteRegistry.LOGIN);
    };

    return (
        <div className="app" style={{ display: 'block' }}>
            {/* Sidebar */}
            <aside className="pc-sidebar" style={{ position: 'fixed', height: '100vh', width: 'var(--sidebar-width)', zIndex: 'var(--z-index-sidebar)', display: 'flex', flexDirection: 'column' }}>
                <div style={{ padding: '14px 10px 18px' }}>
                    <h1 style={{ fontSize: '20px', fontWeight: 900, margin: 0, letterSpacing: '.2px', display: 'flex', alignItems: 'center', gap: '10px' }}>
                        <span style={{ color: 'var(--brand-500)' }}>Client</span>
                        <span style={{ color: 'var(--text-100)', fontWeight: 500, fontSize: '0.8em' }}>Portal</span>
                    </h1>
                </div>

                <nav className="nav" style={{ flex: 1, padding: '10px 0', overflowY: 'auto' }}>
                    {menuItems.map((item) => {
                        const isActive = location.pathname.startsWith(item.path);
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                className={`pc-nav-link ${isActive ? 'active' : ''}`}
                            >
                                <span style={{ fontSize: '1.2rem' }}>{item.icon}</span>
                                <span style={{ fontWeight: isActive ? 700 : 500 }}>{item.label}</span>
                            </Link>
                        );
                    })}
                </nav>

                <RoleSwitcher />

                <div className="sidebar-footer">
                    <button
                        onClick={handleLogout}
                        className="btn btn-danger"
                        style={{ display: 'flex', alignItems: 'center', gap: '10px', width: '100%', justifyContent: 'center', marginTop: '8px' }}
                    >
                        🚪 Logout
                    </button>
                </div>
            </aside>

            {/* Main Content */}
            <main style={{ flex: 1, marginLeft: 'var(--sidebar-width)', display: 'flex', flexDirection: 'column' }}>
                <header className="pc-topbar" style={{ margin: '28px 32px 0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <GlobalQuickActionBar role={role} />
                    <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                        <NotificationHub />
                    </div>
                </header>

                <div style={{ padding: '28px 32px 36px', flex: 1 }}>
                    <Outlet />
                    {children}
                </div>
            </main>

            <SideFloatingButton />
        </div>
    );
}
