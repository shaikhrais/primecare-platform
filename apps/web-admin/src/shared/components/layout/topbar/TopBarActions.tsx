import React from 'react';
import NotificationHub from '@/shared/components/layout/NotificationHub';
import QuickActions from '@/shared/components/dashboard/QuickActions';
import { AdminRegistry } from 'prime-care-shared';
import FlagLanguageSwitcher from './FlagLanguageSwitcher';

const { ContentRegistry } = AdminRegistry;

interface TopBarActionsProps {
    isMobile: boolean;
    currentTime: Date;
    isFullscreen: boolean;
    toggleFullscreen: () => void;
    role: string;
}

export const TopBarActions: React.FC<TopBarActionsProps> = ({
    isMobile,
    currentTime,
    isFullscreen,
    toggleFullscreen,
    role
}) => {


    return (
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
                    <button data-cy="btn-shared.top-bar-actions-0" className="btn-icon" style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '8px', color: '#6B7280' }} title={ContentRegistry.LAYOUT.SEARCH_LABEL}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                    </button>
                    <NotificationHub />
                    <button data-cy="btn-shared.top-bar-actions-1"
                        onClick={toggleFullscreen}
                        className="btn-icon"
                        style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '8px', color: '#6B7280' }}
                        title={isFullscreen ? ContentRegistry.LAYOUT.FULLSCREEN_EXIT : ContentRegistry.LAYOUT.FULLSCREEN_ENTER}
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

            <FlagLanguageSwitcher />

            <QuickActions role={role} />
        </div>
    );
};
