import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import DevPerspectiveSwitcher from '@/shared/components/layout/DevPerspectiveSwitcher';
import { AdminRegistry } from 'prime-care-shared';
import { useTheme } from '@/shared/context/ThemeContext';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

interface SidebarProps {
    menuItems: MenuItem[];
    isCollapsed: boolean;
    setIsCollapsed: (collapsed: boolean) => void;
    isMobile: boolean;
    isOpen: boolean;
    setIsOpen: (isOpen: boolean) => void;
    handleLogout: () => void;
}

export const Sidebar: React.FC<SidebarProps> = ({
    menuItems,
    isCollapsed,
    setIsCollapsed,
    isMobile,
    isOpen,
    setIsOpen,
    handleLogout
}) => {
    const location = useLocation();
    const { branding } = useTheme();
    const { t } = useTranslation();

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
                flexDirection: 'column',
                alignItems: isCollapsed ? 'center' : 'flex-start',
                justifyContent: 'center',
                gap: '8px',
                borderBottom: '1px solid #F3F4F6',
                minHeight: '100px',
                boxSizing: 'border-box',
                background: branding?.isPlatform ? 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)' : 'transparent',
                color: branding?.isPlatform ? '#FFFFFF' : 'inherit'
            }}>
                <Link to="/" style={{ display: 'flex', alignItems: 'center', textDecoration: 'none', gap: '12px', justifyContent: isCollapsed ? 'center' : 'flex-start', width: '100%' }}>
                    {!isCollapsed && <img src={branding?.logoUrl || "/logo.png"} alt={branding?.name || ContentRegistry.APP.NAME} style={{ height: '32px', width: 'auto', filter: branding?.isPlatform ? 'brightness(0) invert(1)' : 'none' }} />}
                    {isCollapsed && <span style={{ fontSize: '1.25rem', fontWeight: 900, color: branding?.isPlatform ? '#3B82F6' : 'var(--brand-500)' }}>{(branding?.name || ContentRegistry.APP.NAME).charAt(0)}</span>}
                </Link>
                {!isCollapsed && branding?.isPlatform && (
                    <div style={{
                        fontSize: '10px',
                        fontWeight: '800',
                        textTransform: 'uppercase',
                        letterSpacing: '1px',
                        backgroundColor: '#3B82F6',
                        color: 'white',
                        padding: '2px 8px',
                        borderRadius: '4px',
                        marginTop: '4px'
                    }}>
                        Global Command
                    </div>
                )}
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
                                borderLeft: !isCollapsed && isActive ? '4px solid var(--brand-500)' : '4px solid transparent',
                                fontWeight: isActive ? '700' : '500',
                                transition: 'all 0.2s ease',
                                whiteSpace: 'nowrap'
                            }}
                        >
                            <span style={{ fontSize: '1.25rem', minWidth: '24px', textAlign: 'center' }}>{item.icon}</span>
                            {!isCollapsed && <span>{t(`nav.${item.label.toLowerCase()}`, item.label)}</span>}
                        </Link>
                    );
                })}
            </nav>

            <div style={{ display: isCollapsed ? 'none' : 'block' }}>
                <DevPerspectiveSwitcher />
            </div>

            <div className="sidebar-footer" style={{ padding: isCollapsed ? '10px' : '20px', borderTop: '1px solid #F3F4F6', display: 'flex', flexDirection: 'column', gap: '10px' }}>
                {!isMobile && (
                    <button data-cy="btn-shared.sidebar-0"
                        onClick={() => setIsCollapsed(!isCollapsed)}
                        data-cy="btn-sidebar-collapse"
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: isCollapsed ? 'center' : 'flex-start',
                            gap: isCollapsed ? '0' : '10px',
                            width: '100%',
                            padding: '12px',
                            backgroundColor: '#F9FAFB',
                            border: '1px solid #E5E7EB',
                            borderRadius: '8px',
                            color: '#4B5563',
                            fontWeight: '700',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                    >
                        <span style={{ transition: 'transform 0.3s', transform: isCollapsed ? 'rotate(180deg)' : 'rotate(0deg)' }}>◀</span>
                        {!isCollapsed && <span>{t('common.collapse', 'Collapse Menu')}</span>}
                    </button>
                )}

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
                    title={isCollapsed ? t('common.logout') : ""}
                >
                    <span>🚪</span>
                    {!isCollapsed && <span>{t('common.logout', ContentRegistry.LAYOUT.LOGOUT)}</span>}
                </button>
            </div>
        </aside>
    );
};
