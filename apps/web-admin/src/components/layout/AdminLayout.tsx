import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

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

    // Get user info from storage with safety
    const getUser = () => {
        try {
            const userStr = localStorage.getItem('user');
            if (!userStr || userStr === 'undefined') return { role: 'client' };
            const u = JSON.parse(userStr);
            return u;
        } catch (e) {
            return { role: 'client' };
        }
    };

    const user = getUser();
    const token = localStorage.getItem('token');
    const role = user.role || 'client';

    // Auth & Role Guard
    React.useEffect(() => {
        if (!token) {
            navigate(RouteRegistry.LOGIN);
            return;
        }

        if (roleGated && !roleGated.includes(role)) {
            // Redirect to home dashboard if unauthorized
            navigate(RouteRegistry.DASHBOARD);
        }
    }, [token, navigate, role, roleGated]);

    const adminMenu = [
        { label: 'Dashboard', path: RouteRegistry.DASHBOARD, icon: '📊' },
        { label: 'Users & PSWs', path: RouteRegistry.USERS, icon: '👥' },
        { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
        { label: 'Lead Inquiries', path: '/leads', icon: '📥' },
        { label: 'Services', path: '/services', icon: '💰' },
        { label: 'Call Audits', path: '/audits', icon: '🎙️' },
        { label: 'Content', path: '/content', icon: '📝' },
        { label: 'Settings', path: '/settings', icon: '⚙️' },
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

    const menuItems = role === 'admin' ? adminMenu : role === 'psw' ? pswMenu : role === 'staff' ? staffMenu : clientMenu;

    const portalTitle = role === 'admin' ? 'Admin' : role === 'psw' ? 'Caregiver' : role === 'staff' ? 'Staff' : 'Family';

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        navigate(RouteRegistry.LOGIN);
    };

    return (
        <div style={{ display: 'flex', minHeight: '100vh', backgroundColor: '#f9fafb', fontFamily: 'Inter, system-ui, sans-serif' }}>
            {/* Sidebar */}
            <aside style={{
                width: '260px',
                backgroundColor: 'var(--pc-primary-dark)',
                color: 'white',
                display: 'flex',
                flexDirection: 'column',
                position: 'fixed',
                height: '100vh',
                zIndex: 100,
            }}>
                <div style={{ padding: '1.5rem', borderBottom: '1px solid rgba(255,255,255,0.1)' }}>
                    <h1 style={{ fontSize: '1.25rem', fontWeight: 'bold', margin: 0, color: '#4db6ac' }}>
                        PrimeCare <span style={{ color: 'white', fontWeight: 'normal' }}>{portalTitle}</span>
                    </h1>
                </div>

                <nav style={{ flex: 1, padding: '1rem 0' }}>
                    {menuItems.map((item: MenuItem) => {
                        const isActive = location.pathname === item.path;
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '0.75rem',
                                    padding: '0.75rem 1.5rem',
                                    textDecoration: 'none',
                                    color: isActive ? 'white' : 'rgba(255,255,255,0.7)',
                                    backgroundColor: isActive ? 'rgba(255,255,255,0.1)' : 'transparent',
                                    borderLeft: isActive ? '4px solid #4db6ac' : '4px solid transparent',
                                    transition: 'all 0.2s',
                                }}
                            >
                                <span style={{ fontSize: '1.2rem' }}>{item.icon}</span>
                                <span style={{ fontWeight: isActive ? '600' : '400' }}>{item.label}</span>
                            </Link>
                        );
                    })}
                </nav>

                <div style={{ padding: '1rem', borderTop: '1px solid rgba(255,255,255,0.1)' }}>
                    <p style={{ fontSize: '0.75rem', opacity: 0.5, margin: 0 }}>Logged in as {role.toUpperCase()}</p>
                </div>
            </aside>

            {/* Main Content */}
            <main style={{ flex: 1, marginLeft: '260px', display: 'flex', flexDirection: 'column' }}>
                {/* Header */}
                <header style={{
                    height: '64px',
                    backgroundColor: 'white',
                    borderBottom: '1px solid #e5e7eb',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'flex-end',
                    padding: '0 2rem',
                    position: 'sticky',
                    top: 0,
                    zIndex: 90,
                }}>
                    <div style={{ position: 'relative' }}>
                        <button
                            onClick={() => setIsProfileOpen(!isProfileOpen)}
                            style={{
                                background: 'none',
                                border: 'none',
                                cursor: 'pointer',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '0.5rem',
                                color: '#374151',
                                fontWeight: '500',
                            }}
                        >
                            <div style={{ width: '32px', height: '32px', borderRadius: '50%', backgroundColor: 'var(--pc-primary-dark)', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.875rem' }}>
                                {user.email?.[0].toUpperCase() || 'U'}
                            </div>
                            <span style={{ textTransform: 'capitalize' }}>{user.email?.split('@')[0] || portalTitle}</span>
                            <span>▼</span>
                        </button>

                        {isProfileOpen && (
                            <div style={{
                                position: 'absolute',
                                top: '100%',
                                right: 0,
                                width: '160px',
                                backgroundColor: 'white',
                                boxShadow: '0 10px 15px -3px rgba(0,0,0,0.1)',
                                borderRadius: '0.5rem',
                                border: '1px solid #e5e7eb',
                                padding: '0.5rem 0',
                                marginTop: '0.5rem',
                            }}>
                                <button onClick={() => { navigate('/profile'); setIsProfileOpen(false); }} style={{ width: '100%', textAlign: 'left', padding: '0.5rem 1rem', background: 'none', border: 'none', cursor: 'pointer', color: '#374151' }}>Profile</button>
                                <button onClick={() => { navigate('/settings'); setIsProfileOpen(false); }} style={{ width: '100%', textAlign: 'left', padding: '0.5rem 1rem', background: 'none', border: 'none', cursor: 'pointer', color: '#374151' }}>Settings</button>
                                <div style={{ borderTop: '1px solid #e5e7eb', margin: '0.5rem 0' }} />
                                <button
                                    onClick={handleLogout}
                                    style={{ width: '100%', textAlign: 'left', padding: '0.5rem 1rem', background: 'none', border: 'none', cursor: 'pointer', color: '#dc2626', fontWeight: '500' }}
                                >
                                    Log out
                                </button>
                            </div>
                        )}
                    </div>
                </header>

                {/* Page Content */}
                <div style={{ padding: '2rem', flex: 1 }}>
                    {children}
                </div>
            </main>
        </div>
    );
}
