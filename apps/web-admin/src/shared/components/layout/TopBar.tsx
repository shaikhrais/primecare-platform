import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTheme } from '@/shared/context/ThemeContext';
import { useUIStore, useIsDarkMode } from '@/shared/stores';

// Components
import { TopBarIdentity } from './topbar/TopBarIdentity';
import { TopBarActions } from './topbar/TopBarActions';
import { AccessibilityToggle } from '@/app/routes/tenancy/client/pages/dashboard/components/AccessibilityToggle';

const { ContentRegistry } = AdminRegistry;

interface TopBarProps {
    isMobile: boolean;
    isCollapsed: boolean;
    setIsCollapsed: (collapsed: boolean) => void;
    setIsSidebarOpen: (isOpen: boolean) => void;
    role: string;
    user: any;
}

export const TopBar: React.FC<TopBarProps> = ({
    isMobile,
    isCollapsed,
    setIsCollapsed,
    setIsSidebarOpen,
    role,
    user
}) => {
    const { branding } = useTheme();
    const [currentTime, setCurrentTime] = useState(new Date());
    const [isFullscreen, setIsFullscreen] = useState(false);
    const toggleDarkMode = useUIStore((s) => s.toggleDarkMode);
    const isDark = useIsDarkMode();

    useEffect(() => {
        const timer = setInterval(() => setCurrentTime(new Date()), 1000);
        return () => clearInterval(timer);
    }, []);

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

    return (
        <header className="pc-topbar" data-cy="page.header" style={{
            height: '72px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '0 24px',
            backgroundColor: 'var(--pc-surface-topbar, #FFFFFF)',
            borderBottom: '1px solid var(--pc-border-primary, #E5E7EB)',
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
                            background: 'var(--pc-bg-secondary)',
                            border: '1px solid var(--pc-border-primary)',
                            padding: '10px',
                            borderRadius: 'var(--pc-radius-md)',
                            cursor: 'pointer',
                            marginRight: '8px',
                            color: 'var(--pc-text-primary)',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            transition: 'var(--pc-transition)',
                            boxShadow: 'var(--pc-shadow-sm)'
                        }}
                        onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--pc-bg-tertiary)'}
                        onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'var(--pc-bg-secondary)'}
                        title={ContentRegistry.LAYOUT.MOBILE_MENU}
                    >
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
                            <line x1="3" y1="12" x2="21" y2="12"></line>
                            <line x1="3" y1="6" x2="21" y2="6"></line>
                            <line x1="3" y1="18" x2="21" y2="18"></line>
                        </svg>
                    </button>
                )}

                {/* Desktop Toggle */}
                {!isMobile && (
                    <button
                        onClick={() => setIsCollapsed(!isCollapsed)}
                        data-cy="btn-drawer-toggle-desktop"
                        style={{
                            background: 'none',
                            border: 'none',
                            padding: '8px',
                            cursor: 'pointer',
                            color: 'var(--pc-text-secondary)',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            transition: 'var(--pc-transition)'
                        }}
                        title={isCollapsed ? "Expand" : "Collapse"}
                    >
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
                            <line x1="3" y1="12" x2="21" y2="12"></line>
                            <line x1="3" y1="6" x2="21" y2="6"></line>
                            <line x1="3" y1="18" x2="21" y2="18"></line>
                        </svg>
                    </button>
                )}

                {/* Logo when sidebar is hidden/collapsed */}
                {(isMobile || isCollapsed) && <img src={branding?.logoUrl || "/logo.png"} alt={branding?.name || ContentRegistry.APP.NAME} style={{ height: '32px', width: 'auto' }} />}

                {(isMobile || isCollapsed) && <div style={{ height: '24px', width: '1px', backgroundColor: 'var(--pc-border-primary)' }}></div>}

                <TopBarIdentity role={role} user={user} isMobile={isMobile} />
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                {/* Dark Mode Toggle */}
                <button
                    onClick={toggleDarkMode}
                    data-cy="btn-dark-mode-toggle"
                    title={isDark ? 'Switch to light mode' : 'Switch to dark mode'}
                    style={{
                        background: 'none',
                        border: '1px solid var(--pc-border-primary, #E5E7EB)',
                        padding: '8px',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        color: 'var(--pc-text-secondary, #6B7280)',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        transition: 'all 0.2s',
                    }}
                >
                    {isDark ? (
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <circle cx="12" cy="12" r="5" />
                            <line x1="12" y1="1" x2="12" y2="3" />
                            <line x1="12" y1="21" x2="12" y2="23" />
                            <line x1="4.22" y1="4.22" x2="5.64" y2="5.64" />
                            <line x1="18.36" y1="18.36" x2="19.78" y2="19.78" />
                            <line x1="1" y1="12" x2="3" y2="12" />
                            <line x1="21" y1="12" x2="23" y2="12" />
                            <line x1="4.22" y1="19.78" x2="5.64" y2="18.36" />
                            <line x1="18.36" y1="5.64" x2="19.78" y2="4.22" />
                        </svg>
                    ) : (
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z" />
                        </svg>
                    )}
                </button>

                {role.toLowerCase() === 'client' && <AccessibilityToggle />}
                <TopBarActions
                    isMobile={isMobile}
                    currentTime={currentTime}
                    isFullscreen={isFullscreen}
                    toggleFullscreen={toggleFullscreen}
                    role={role}
                />
            </div>
        </header>
    );
};
