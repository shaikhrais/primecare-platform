import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../context/NotificationContext';

interface GlobalQuickActionBarProps {
    role: string;
}

export default function GlobalQuickActionBar({ role }: GlobalQuickActionBarProps) {
    const navigate = useNavigate();
    const { showToast } = useNotification();

    const handleEmergency = () => {
        if (confirm('🚨 ACTIVATE EMERGENCY PROTOCOL?\n\nThis will alert all available staff and supervisors.')) {
            showToast('Emergency Alert Broadcasted!', 'error');
            // In real app, API call to /v1/incidents/emergency
        }
    };

    const actionButtonStyle = {
        background: 'rgba(255,255,255,0.1)',
        border: '1px solid rgba(255,255,255,0.2)',
        color: 'white',
        padding: '6px 12px',
        borderRadius: '6px',
        cursor: 'pointer',
        fontWeight: 600,
        fontSize: '0.8rem',
        display: 'flex',
        alignItems: 'center',
        gap: '6px',
        transition: 'all 0.2s'
    };

    const emergencyStyle = {
        ...actionButtonStyle,
        background: '#e53935',
        border: 'none',
        boxShadow: '0 2px 8px rgba(229, 57, 53, 0.4)'
    };

    return (
        <div style={{
            height: '50px',
            background: 'var(--primary-dark)',
            display: 'flex',
            alignItems: 'center',
            padding: '0 20px',
            gap: '12px',
            overflowX: 'auto',
            whiteSpace: 'nowrap',
            borderBottom: '1px solid rgba(255,255,255,0.1)'
        }} className="no-scrollbar" data-cy="qa-bar">

            <span style={{ color: 'rgba(255,255,255,0.7)', fontSize: '0.75rem', fontWeight: 700, textTransform: 'uppercase', marginRight: '8px' }}>
                Quick Actions
            </span>

            {/* Common Actions */}
            <button style={actionButtonStyle} onClick={() => navigate('/manager/daily-entry')} data-cy="qa-daily-entry">
                📝 Daily Entry
            </button>

            <button style={actionButtonStyle} onClick={() => showToast('Opening Shift Modal...', 'info')} data-cy="qa-create-shift">
                ⏱️ Create Shift
            </button>

            <button style={actionButtonStyle} onClick={() => navigate('/incidents')} data-cy="qa-incident">
                ⚠️ Log Incident
            </button>

            {/* Manager/Admin Extras */}
            {(role === 'manager' || role === 'admin') && (
                <>
                    <button style={actionButtonStyle} onClick={() => showToast('Assigning Staff...', 'info')} data-cy="qa-assign-staff">
                        👥 Assign Staff
                    </button>
                    <button style={actionButtonStyle} onClick={() => navigate('/schedule')} data-cy="qa-schedule">
                        📅 Today Schedule
                    </button>
                </>
            )}

            {/* Admin Extras */}
            {role === 'admin' && (
                <>
                    <button style={actionButtonStyle} onClick={() => navigate('/users')} data-cy="qa-add-user">
                        👤 Add User
                    </button>
                    <button style={actionButtonStyle} onClick={() => showToast('System Backup Started', 'success')} data-cy="qa-backup">
                        💾 Backup
                    </button>
                </>
            )}

            <div style={{ flex: 1 }}></div>

            {/* Emergency - Always Visible */}
            <button style={emergencyStyle} onClick={handleEmergency} data-cy="qa-emergency">
                🚨 EMERGENCY ALERT
            </button>

        </div>
    );
}
