import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import QuickActions from '../dashboard/QuickActions';

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
        { label: 'Incidents', path: '/incidents', icon: '🚨' },
        { label: 'Timesheets', path: '/timesheets', icon: '⏰' },
        { label: 'Invoices', path: '/billing', icon: '💳' }, // Reuse billing as invoices list for now
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
        <div style={{ display: 'flex', minHeight: '100vh', backgroundColor: 'var(--bg)', fontFamily: 'var(--pc-font-main)', color: 'var(--text)' }}>
            {/* Sidebar */}
            <aside className="glass-effect" style={{
                width: 'var(--sidebar-width)',
                backgroundColor: 'var(--bg-elev)',
                color: 'var(--text)',
                display: 'flex',
                flexDirection: 'column',
                position: 'fixed',
                height: '100vh',
                zIndex: 'var(--z-index-sidebar)',
                borderRight: '1px solid var(--line)'
            }}>
                <div style={{ padding: '1.5rem', borderBottom: '1px solid var(--line)' }}>
                    <h1 style={{ fontSize: '1.25rem', fontWeight: 900, margin: 0, color: 'var(--primary)', fontFamily: 'var(--pc-font-display)', letterSpacing: '-0.03em' }}>
                        PrimeCare <span style={{ color: 'var(--text)', fontWeight: 500 }}>{portalTitle}</span>
                    </h1>
                </div>

                <nav style={{ flex: 1, padding: '1rem 0', overflowY: 'auto' }}>
                    {menuItems.map((item: MenuItem) => {
                        const isActive = location.pathname.startsWith(item.path) || (item.path === '/app' && location.pathname === '/app');
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '0.75rem',
                                    padding: '0.85rem 1.5rem',
                                    textDecoration: 'none',
                                    color: isActive ? 'var(--text)' : 'var(--text-muted)',
                                    backgroundColor: isActive ? 'var(--line)' : 'transparent',
                                    borderLeft: isActive ? '4px solid var(--primary)' : '4px solid transparent',
                                    transition: 'var(--pc-transition)',
                                    marginBottom: '4px'
                                }}
                            >
                                <span style={{ fontSize: '1.4rem', opacity: isActive ? 1 : 0.6 }}>{item.icon}</span>
                                <span style={{ fontWeight: isActive ? 800 : 500, fontSize: '0.95rem' }}>{item.label}</span>
                            </Link>
                        );
                    })}
                </nav>

                <div style={{ padding: '1.25rem', borderTop: '1px solid var(--line)', background: 'var(--bg)' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                        <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: '#4db6ac', boxShadow: '0 0 10px #4db6ac' }}></div>
                        <p style={{ fontSize: '0.7rem', fontWeight: 800, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.05em', margin: 0 }}>{role} SESSION ACTIVE</p>
                    </div>
                </div>
            </aside>

            {/* Main Content */}
            <main style={{ flex: 1, marginLeft: 'var(--sidebar-width)', display: 'flex', flexDirection: 'column' }}>
                {/* Header */}
                <header className="glass-effect" style={{
                    height: 'var(--header-height)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    padding: '0 2rem',
                    position: 'sticky',
                    top: 0,
                    zIndex: 'var(--z-index-header)',
                    borderBottom: '1px solid var(--line)'
                }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                        <h2 style={{ fontSize: '1rem', fontWeight: 800, margin: 0, textTransform: 'uppercase', letterSpacing: '0.1em', opacity: 0.8 }}>SYSTEM OPERATIONS</h2>
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '1.5rem' }}>
                        {/* Full Screen Toggle */}
                        <button
                            onClick={toggleFullscreen}
                            title={isFullscreen ? "Exit Fullscreen" : "Enter Fullscreen"}
                            style={{
                                width: '40px',
                                height: '40px',
                                borderRadius: '12px',
                                border: '1px solid var(--line)',
                                background: 'var(--bg-elev)',
                                color: 'var(--text)',
                                cursor: 'pointer',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontSize: '1.2rem',
                                transition: 'var(--pc-transition)',
                                boxShadow: 'var(--shadow-sm)'
                            }}
                            onMouseOver={(e) => e.currentTarget.style.transform = 'translateY(-2px)'}
                            onMouseOut={(e) => e.currentTarget.style.transform = 'translateY(0)'}
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

                        {/* Theme Switcher */}
                        <div style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: '0.75rem',
                            background: 'var(--bg-input)',
                            padding: '6px 16px',
                            borderRadius: 'var(--radius-md)',
                            border: '1px solid var(--line)',
                            boxShadow: 'inset 0 2px 4px rgba(0,0,0,0.1)'
                        }}>
                            <span style={{ fontSize: '0.75rem', fontWeight: 900, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.08em' }}>Mode</span>
                            <select
                                id="themePick"
                                defaultValue={localStorage.getItem('psw_theme') || 'midnight'}
                                onChange={(e) => {
                                    const v = e.target.value;
                                    document.documentElement.setAttribute('data-theme', v);
                                    localStorage.setItem('psw_theme', v);
                                }}
                                style={{
                                    height: '28px',
                                    borderRadius: '8px',
                                    border: 'none',
                                    background: 'transparent',
                                    color: 'var(--text)',
                                    fontSize: '0.9rem',
                                    fontWeight: 800,
                                    cursor: 'pointer',
                                    outline: 'none',
                                    appearance: 'none',
                                    paddingRight: '10px'
                                }}
                            >
                                <option value="midnight">🌌 Midnight</option>
                                <option value="light">☀️ Light</option>
                                <option value="ocean">🌊 Ocean</option>
                                <option value="grape">🍇 Grape</option>
                                <option value="contrast">🏁 Contrast</option>
                            </select>
                        </div>

                        <QuickActions role={role} />
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            <button style={{ width: '40px', height: '40px', borderRadius: '12px', border: '1px solid var(--line)', background: 'var(--bg-elev)', color: 'var(--text)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.2rem', transition: 'var(--pc-transition)' }}>🔔</button>
                            <button style={{ width: '40px', height: '40px', borderRadius: '12px', border: '1px solid var(--line)', background: 'var(--bg-elev)', color: 'var(--text)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.2rem', transition: 'var(--pc-transition)' }}>🔍</button>
                        </div>
                        <div style={{ height: '24px', width: '1px', background: 'var(--line)' }}></div>
                        <p style={{ margin: 0, fontSize: '0.8rem', fontWeight: 900, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.1em' }}>
                            {new Date().toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })}
                        </p>
                    </div>
                </header>

                {/* Page Content */}
                <div style={{ padding: '2rem', flex: 1 }}>
                    {children}
                </div>
            </main >
        </div >
    );
}
