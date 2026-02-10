import React from 'react';
import { useLocation, Link, useNavigate } from 'react-router-dom';
import GlobalQuickActionBar from './GlobalQuickActionBar';
import SideFloatingButton from './SideFloatingButton';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface ManagerLayoutProps {
    children: React.ReactNode;
}

export default function ManagerLayout({ children }: ManagerLayoutProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const userStr = localStorage.getItem('user');
    const user = userStr ? JSON.parse(userStr) : { role: 'client' };
    const role = user.role || 'client';

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
        <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh', backgroundColor: 'var(--bg)' }}>

            {/* 1. Global Quick Action Bar (Fixed Top) */}
            <div style={{ position: 'sticky', top: 0, zIndex: 1002 }}>
                <GlobalQuickActionBar role={role} />
            </div>

            <div style={{ display: 'flex', flex: 1 }}>

                {/* 2. Sidebar (Below Action Bar) */}
                <aside style={{
                    width: '240px',
                    backgroundColor: 'var(--bg-elev)',
                    borderRight: '1px solid var(--line)',
                    position: 'sticky',
                    top: '50px', // Below text bar
                    height: 'calc(100vh - 50px)',
                    overflowY: 'auto'
                }}>
                    <div style={{ padding: '20px' }}>
                        <h2 style={{ margin: 0, fontSize: '1.2rem', color: 'var(--primary)' }}>PSW Manager</h2>
                        <p style={{ margin: '5px 0 0', fontSize: '0.8rem', color: 'var(--text-muted)' }}>{user.email}</p>
                    </div>

                    <nav style={{ padding: '0 10px' }}>
                        {menuItems.map((item) => {
                            const isActive = location.pathname.startsWith(item.path);
                            return (
                                <Link
                                    key={item.path}
                                    to={item.path}
                                    style={{
                                        display: 'flex',
                                        alignItems: 'center',
                                        gap: '10px',
                                        padding: '12px 16px',
                                        color: isActive ? 'var(--primary)' : 'var(--text)',
                                        background: isActive ? 'var(--bg-active)' : 'transparent',
                                        borderRadius: '8px',
                                        textDecoration: 'none',
                                        marginBottom: '4px',
                                        fontWeight: isActive ? 600 : 400
                                    }}
                                >
                                    <span>{item.icon}</span>
                                    {item.label}
                                </Link>
                            );
                        })}

                        <div style={{ height: '1px', background: 'var(--line)', margin: '10px 0' }}></div>

                        <button
                            onClick={handleLogout}
                            style={{
                                display: 'flex',
                                alignItems: 'center',
                                gap: '10px',
                                padding: '12px 16px',
                                color: '#e53935',
                                background: 'transparent',
                                border: 'none',
                                width: '100%',
                                cursor: 'pointer',
                                fontSize: '1rem'
                            }}
                        >
                            <span>🚪</span> Logout
                        </button>
                    </nav>
                </aside>

                {/* 3. Main Content Area */}
                <main style={{ flex: 1, padding: '24px' }}>
                    {children}
                </main>

            </div>

            {/* 4. Floating Action Button */}
            <SideFloatingButton />

        </div>
    );
}
