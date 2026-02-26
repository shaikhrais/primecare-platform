import React, { useState, useEffect } from 'react';
import QuickActions from '@/shared/components/dashboard/QuickActions';
import NotificationHub from '@/shared/components/layout/NotificationHub';

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
                            role === 'psw' ? 'Service Provider Portal' :
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
    );
};
