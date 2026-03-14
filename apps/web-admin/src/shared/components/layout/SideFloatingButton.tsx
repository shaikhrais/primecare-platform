import React, { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { useApiMutation } from '@/shared/hooks/useApiMutation';

export default function SideFloatingButton() {
    const [isOpen, setIsOpen] = useState(false);
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const location = useLocation();

    const hiddenPaths = [
        '/admin/users', '/platform/admin/users',
        '/admin/schedule', '/platform/admin/schedule',
        '/admin/leads', '/platform/admin/leads',
        '/admin/services', '/platform/admin/services'
    ];

    const currentPath = window.location.hash || location.pathname;

    if (hiddenPaths.some(p => currentPath.includes(p))) {
        return null;
    }

    const baseStyle = {
        position: 'fixed' as 'fixed',
        right: '24px',
        bottom: '24px',
        width: '60px',
        height: '60px',
        borderRadius: '50%',
        backgroundColor: 'var(--primary)',
        color: 'white',
        border: 'none',
        boxShadow: '0 4px 12px rgba(0,0,0,0.3)',
        fontSize: '2rem',
        cursor: 'pointer',
        zIndex: 9999,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transition: 'transform 0.2s'
    };

    const menuStyle = {
        position: 'fixed' as 'fixed',
        right: '24px',
        bottom: '96px',
        display: 'flex',
        flexDirection: 'column' as 'column',
        gap: '12px',
        zIndex: 9998,
        alignItems: 'flex-end',
    };

    const menuItemStyle = {
        backgroundColor: 'var(--bg-elev)',
        color: 'var(--text)',
        padding: '10px 16px',
        borderRadius: '8px',
        border: '1px solid var(--line)',
        boxShadow: '0 2px 8px rgba(0,0,0,0.15)',
        cursor: 'pointer',
        fontWeight: 600,
        display: 'flex',
        alignItems: 'center',
        gap: '8px',
        textDecoration: 'none'
    };

    const emergencyMutation = useApiMutation('/v1/system/emergency/trigger', {
        onSuccess: () => { showToast('Emergency Protocol Activated! Authorities notified.', 'error'); },
        onError: () => { showToast('Emergency Protocol Failed!', 'error'); },
    });

    return (
        <>
            {isOpen && (
                <div style={menuStyle} data-cy="floating-menu">
                    <button data-cy="mbtn-new-daily-entry" style={menuItemStyle} onClick={() => navigate('/manager/daily-entry')}>
                        📝 New Daily Entry
                    </button>
                    <button data-cy="mbtn-new-incident" style={menuItemStyle} onClick={() => navigate('/incidents')}>
                        ⚠️ New Incident
                    </button>
                    <button data-cy="mbtn-new-client" style={menuItemStyle} onClick={() => { navigate('/platform/admin/admission'); setIsOpen(false); }}>
                        🏥 New Client
                    </button>
                    <button data-cy="mbtn-emergency" style={{ ...menuItemStyle, backgroundColor: '#e53935', color: 'white', border: 'none' }} onClick={() => emergencyMutation.mutate({})}>
                        🚨 EMERGENCY
                    </button>
                </div>
            )}

            <button
                data-cy="btn-floating-toggle"
                style={{ ...baseStyle, transform: isOpen ? 'rotate(45deg)' : 'none' }}
                onClick={() => setIsOpen(!isOpen)}
            >
                +
            </button>
        </>
    );
}
