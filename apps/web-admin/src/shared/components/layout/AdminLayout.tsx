import React, { useState, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import QuickActions from '@/shared/components/dashboard/QuickActions';
import DevPerspectiveSwitcher from '@/shared/components/layout/DevPerspectiveSwitcher';
import NotificationHub from '@/shared/components/layout/NotificationHub';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';

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
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);
    const [isCollapsed, setIsCollapsed] = useState(false);
    const [isFullscreen, setIsFullscreen] = useState(false);
    const [currentTime, setCurrentTime] = useState(new Date());
    const isMobile = useMediaQuery('(max-width: 1024px)');

    useEffect(() => {
        setIsSidebarOpen(false);
    }, [location.pathname]);

    // Header Clock
    useEffect(() => {
        const timer = setInterval(() => setCurrentTime(new Date()), 1000);
        return () => clearInterval(timer);
    }, []);

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

    const menuItems = role === 'admin' ? adminMenu : role === 'rn' ? rnMenu : role === 'psw' ? pswMenu : role === 'staff' ? staffMenu : clientMenu;

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

            {/* Sidebar */}
            <aside
                className={`pc-sidebar ${isCollapsed ? 'collapsed' : ''}`}
                data-cy="sidebar"
                style={{
                    position: 'fixed',
                    height: '100vh',
                    width: 'var(--sidebar-width)',
                    zIndex: 1000,
                    display: 'flex',
                    flexDirection: 'column',
                    backgroundColor: '#FFFFFF',
                    borderRight: '1px solid #E5E7EB',
                    transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                    transform: isMobile && !isSidebarOpen ? 'translateX(-100%)' : 'translateX(0)',
                    overflow: 'hidden'
                }}
            >
                <div style={{
                    padding: isCollapsed ? '24px 0' : '24px 20px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: isCollapsed ? 'center' : 'space-between',
                    gap: '12px',
                    borderBottom: '1px solid #F3F4F6',
                    height: '72px',
                    boxSizing: 'border-box'
                }}>
                    {!isCollapsed && <img src="/logo.png" alt="PrimeCare" style={{ height: '36px', width: 'auto' }} />}
                    {isCollapsed && <span style={{ fontSize: '1.5rem', fontWeight: 900, color: '#00875A' }}>P</span>}

                </div>

                <nav className="nav" style={{ flex: 1, padding: '20px 0', overflowY: 'auto', overflowX: 'hidden' }} data-cy="nav.main">
                    {menuItems.map((item: MenuItem) => {
                        const isActive = location.pathname.startsWith(item.path) || (item.path === '/app' && location.pathname === '/app');
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                className={`pc-nav-link ${isActive ? 'active' : ''}`}
                                data-cy={`nav-item-${item.label.toLowerCase().replace(/\s+/g, '-')}`}
                                title={isCollapsed ? item.label : ''}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: isCollapsed ? 'center' : 'flex-start',
                                    gap: isCollapsed ? '0' : '12px',
                                    padding: isCollapsed ? '12px 0' : '12px 24px',
                                    textDecoration: 'none',
                                    color: isActive ? '#000000' : '#4B5563',
                                    backgroundColor: isActive ? '#F9FAFB' : 'transparent',
                                    borderLeft: !isCollapsed && isActive ? '4px solid #00875A' : '4px solid transparent',
                                    fontWeight: isActive ? '700' : '500',
                                    transition: 'all 0.2s ease',
                                    whiteSpace: 'nowrap'
                                }}
                            >
                                <span style={{ fontSize: '1.25rem', minWidth: '24px', textAlign: 'center' }}>{item.icon}</span>
                                {!isCollapsed && <span>{item.label}</span>}
                            </Link>
                        );
                    })}
                </nav>

                <div style={{ display: isCollapsed ? 'none' : 'block' }}>
                    <DevPerspectiveSwitcher />
                </div>

                <div className="sidebar-footer" style={{ padding: isCollapsed ? '10px' : '20px', borderTop: '1px solid #F3F4F6' }}>
                    <button
                        onClick={handleLogout}
                        data-cy="btn-logout"
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            gap: isCollapsed ? '0' : '10px',
                            width: '100%',
                            padding: isCollapsed ? '12px 0' : '12px',
                            backgroundColor: '#FFFFFF',
                            border: '1px solid #EF4444',
                            borderRadius: '8px',
                            color: '#EF4444',
                            fontWeight: '700',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        title={isCollapsed ? "Logout" : ""}
                    >
                        <span>🚪</span>
                        {!isCollapsed && <span>Sign Out</span>}
                    </button>
                </div>
            </aside>

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
                <header className="pc-topbar" data-cy="page.header" style={{
                    height: '72px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    padding: '0 24px',
                    backgroundColor: '#FFFFFF',
                    borderBottom: '1px solid #E5E7EB',
                    position: 'sticky',
                    top: 0,
                    zIndex: 900
                }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                        {/* Mobile Toggle */}
                        {isMobile && (
                            <button
                                onClick={() => setIsSidebarOpen(true)}
                                data-cy="btn-drawer-toggle-mobile"
                                style={{
                                    background: '#F9FAFB',
                                    border: '1px solid #E5E7EB',
                                    padding: '10px',
                                    borderRadius: '8px',
                                    cursor: 'pointer',
                                    marginRight: '8px',
                                    color: '#111827',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    transition: 'all 0.2s',
                                    boxShadow: '0 1px 2px rgba(0,0,0,0.05)'
                                }}
                                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#F3F4F6'}
                                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = '#F9FAFB'}
                                title="Open Sidebar"
                            >
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
                                    <line x1="3" y1="12" x2="21" y2="12"></line>
                                    <line x1="3" y1="6" x2="21" y2="6"></line>
                                    <line x1="3" y1="18" x2="21" y2="18"></line>
                                </svg>
                            </button>
                        )}

                        {/* Desktop Toggle (when collapsed or to allow collapsing from top) */}
                        {!isMobile && (
                            <button
                                onClick={() => setIsCollapsed(!isCollapsed)}
                                data-cy="btn-drawer-toggle-desktop"
                                style={{
                                    background: 'none',
                                    border: 'none',
                                    padding: '8px',
                                    cursor: 'pointer',
                                    color: '#6B7280',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    transition: 'all 0.2s'
                                }}
                                title={isCollapsed ? "Expand Sidebar" : "Collapse Sidebar"}
                            >
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
                                    <line x1="3" y1="12" x2="21" y2="12"></line>
                                    <line x1="3" y1="6" x2="21" y2="6"></line>
                                    <line x1="3" y1="18" x2="21" y2="18"></line>
                                </svg>
                            </button>
                        )}

                        {/* Logo in topbar when sidebar can't show it */}
                        {(isMobile || isCollapsed) && <img src="/logo.png" alt="PrimeCare" style={{ height: '32px', width: 'auto' }} />}

                        {/* Only show vertical divider if logo is present */}
                        {(isMobile || isCollapsed) && <div style={{ height: '24px', width: '1px', backgroundColor: '#E5E7EB' }}></div>}

                        <div style={{ display: 'flex', flexDirection: 'column' }}>
                            <span style={{ fontSize: '0.875rem', fontWeight: 900, color: '#111827', textTransform: 'uppercase', letterSpacing: '0.5px', lineHeight: 1 }}>
                                {role === 'admin' ? 'Administration' :
                                    role === 'psw' ? 'Caregiver Portal' :
                                        role === 'client' ? 'Family Hub' :
                                            role === 'rn' ? 'Clinical Panel' : 'Staff Workspace'}
                            </span>
                            {!isMobile && (
                                <span style={{ fontSize: '0.75rem', fontWeight: 600, color: '#6B7280', marginTop: '2px' }}>
                                    Logged in as <span style={{ color: '#00875A' }}>{user.fullName || user.email}</span>
                                </span>
                            )}
                        </div>
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                        {!isMobile && (
                            <>
                                <div style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '8px',
                                    padding: '6px 16px',
                                    backgroundColor: '#000000',
                                    color: 'white',
                                    borderRadius: '12px',
                                    fontSize: '0.9rem',
                                    fontWeight: 900,
                                    marginRight: '8px',
                                    boxShadow: '0 4px 12px rgba(0,0,0,0.1)'
                                }}>
                                    <span style={{ opacity: 0.7 }}>🕒</span>
                                    {currentTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true })}
                                </div>
                                <button className="btn-icon" style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '8px', color: '#6B7280' }} title="Search">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                        <circle cx="11" cy="11" r="8"></circle>
                                        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                    </svg>
                                </button>
                                <NotificationHub />
                                <button
                                    onClick={toggleFullscreen}
                                    className="btn-icon"
                                    style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '8px', color: '#6B7280' }}
                                    title={isFullscreen ? 'Exit Fullscreen' : 'Enter Fullscreen'}
                                >
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                        <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3" />
                                    </svg>
                                </button>
                            </>
                        )}
                        <div className="chip" style={{
                            backgroundColor: '#F3F4F6',
                            padding: '6px 12px',
                            borderRadius: '20px',
                            fontSize: '0.8rem',
                            fontWeight: 700,
                            color: '#374151',
                            display: isMobile ? 'none' : 'flex',
                            alignItems: 'center',
                            gap: '6px'
                        }}>
                            📅 {new Date().toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                        </div>
                        <QuickActions role={role} />
                    </div>
                </header>

                <div style={{ flex: 1, padding: isMobile ? '16px' : '24px' }}>
                    {children}
                </div>
            </main>
        </div>
    );
}
