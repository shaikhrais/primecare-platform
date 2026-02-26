import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import DevPerspectiveSwitcher from '@/shared/components/layout/DevPerspectiveSwitcher';

interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

interface SidebarProps {
    menuItems: MenuItem[];
    isCollapsed: boolean;
    isMobile: boolean;
    isOpen: boolean;
    setIsOpen: (isOpen: boolean) => void;
    handleLogout: () => void;
}

export const Sidebar: React.FC<SidebarProps> = ({
    menuItems,
    isCollapsed,
    isMobile,
    isOpen,
    setIsOpen,
    handleLogout
}) => {
    const location = useLocation();

    return (
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
                transform: isMobile && !isOpen ? 'translateX(-100%)' : 'translateX(0)',
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
    );
};
