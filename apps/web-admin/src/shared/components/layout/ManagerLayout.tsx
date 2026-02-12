import React from 'react';
import { useLocation, Link, useNavigate } from 'react-router-dom';
import GlobalQuickActionBar from './GlobalQuickActionBar';
import SideFloatingButton from './SideFloatingButton';
import RoleSwitcher from './RoleSwitcher';
import NotificationHub from './NotificationHub';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface ManagerLayoutProps {
    children: React.ReactNode;
}

export default function ManagerLayout({ children }: ManagerLayoutProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const userStr = localStorage.getItem('user');
    const user = userStr && userStr !== 'undefined' ? JSON.parse(userStr) : { roles: ['client'], activeRole: 'client' };
    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';
    const API_URL = import.meta.env.VITE_API_URL;

    React.useEffect(() => {
        const currentUser = localStorage.getItem('user');
        if (!currentUser || currentUser === 'undefined') {
            navigate(RouteRegistry.LOGIN);
        }
    }, [navigate]);

    const menuItems = [
        { label: 'Dashboard', path: '/manager/dashboard', icon: '📊' },
        { label: 'Daily Entry', path: '/manager/daily-entry', icon: '📝' },
        { label: 'Clients', path: '/customers', icon: '👥' },
        { label: 'Staff', path: '/users', icon: '👨‍⚕️' },
        { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
        { label: 'Incidents', path: '/incidents', icon: '⚠️' },
        { label: 'Reports', path: '/reports', icon: '📈' },
    ];

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        navigate(RouteRegistry.LOGIN);
    };

    return (
        <div className="app">
            {/* Sidebar */}
            <aside className="pc-sidebar" data-cy="sidebar" style={{ position: 'fixed', height: '100vh', width: 'var(--sidebar-width)', zIndex: 'var(--z-index-sidebar)', display: 'flex', flexDirection: 'column' }}>
                <div style={{ padding: '14px 10px 18px' }}>
                    <h1 style={{ fontSize: '20px', fontWeight: 900, margin: 0, letterSpacing: '.2px', display: 'flex', alignItems: 'center', gap: '10px' }}>
                        <span style={{ color: 'var(--brand-500)' }}>Manager</span>
                        <span style={{ color: 'var(--text-100)', fontWeight: 500, fontSize: '0.8em' }}>Portal</span>
                    </h1>
                </div>

                <nav className="nav" style={{ flex: 1, padding: '10px 0', overflowY: 'auto' }} data-cy="nav.main">
                    {menuItems.map((item) => {
                        const isActive = location.pathname.startsWith(item.path);
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                className={`pc-nav-link ${isActive ? 'active' : ''}`}
                                data-cy={`menu-${item.label.toLowerCase().replace(/\s+/g, '-')}`}
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
                        <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: 'var(--brand-500)', boxShadow: '0 0 10px var(--brand-500)' }}></div>
                        <span style={{ textTransform: 'uppercase', letterSpacing: '0.05em' }}>MGR ONLINE</span>
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
                {/* Global Action Bar Integrated as Topbar */}
                <header className="pc-topbar" style={{ margin: '28px 32px 0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <GlobalQuickActionBar role={role} />
                    <NotificationHub />
                </header>

                <div style={{ padding: '28px 32px 36px', flex: 1 }}>
                    {children}
                </div>
            </main>

            <SideFloatingButton />
        </div>
    );
}
