import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTheme } from '@/shared/context/ThemeContext';

// Components
import { TopBarIdentity } from './topbar/TopBarIdentity';
import { TopBarActions } from './topbar/TopBarActions';

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
                            color: '#6B7280',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            transition: 'all 0.2s'
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

                {(isMobile || isCollapsed) && <div style={{ height: '24px', width: '1px', backgroundColor: '#E5E7EB' }}></div>}

                <TopBarIdentity role={role} user={user} isMobile={isMobile} />
            </div>

            <TopBarActions
                isMobile={isMobile}
                currentTime={currentTime}
                isFullscreen={isFullscreen}
                toggleFullscreen={toggleFullscreen}
                role={role}
            />
        </header>
    );
};
