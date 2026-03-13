import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { CreateShiftModal } from '@/shared/components/modals/CreateShiftModal';
import { useDialog } from '@/shared/hooks/useDialog';
import { PageActionBar } from '@/shared/components/ui/PageActionBar';

interface GlobalQuickActionBarProps {
    role: string;
}

// Map each role → its dashboard page ID in PageActionRegistry
const ROLE_PAGE: Record<string, string> = {
    admin: 'admin.dashboard',
    manager: 'manager.dashboard',
    coordinator: 'coordinator.hub',
    psw: 'psw.dashboard',
    rn: 'rn.dashboard',
    staff: 'staff.dashboard',
    client: 'client.dashboard',
};

export default function GlobalQuickActionBar({ role }: GlobalQuickActionBarProps) {
    const { showConfirmDialog, DialogRenderer } = useDialog();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [shiftOpen, setShiftOpen] = useState(false);
    const [shiftMode, setShiftMode] = useState<'shift' | 'assign'>('shift');
    const [backingUp, setBackingUp] = useState(false);

    const handleEmergency = async () => {
        const confirmed = await showConfirmDialog({
            title: '🚨 EMERGENCY PROTOCOL',
            message: 'This will alert all available staff and supervisors. Proceed?',
            confirmLabel: 'Activate',
            variant: 'danger',
        });
        if (!confirmed) return;
        try {
            await apiClient.post('/v1/admin/actions/emergency/trigger', {});
            showToast('Emergency Alert Broadcasted! All staff notified.', 'error');
        } catch {
            showToast('Emergency Protocol Failed — check connection.', 'error');
        }
    };

    const handleBackup = async () => {
        setBackingUp(true);
        try {
            const res = await apiClient.post('/v1/admin/actions/backup', {});
            if (res.ok) {
                showToast('System backup initiated successfully.', 'success');
            } else {
                showToast('Backup failed — check system logs.', 'error');
            }
        } catch {
            showToast('Network error during backup.', 'error');
        } finally { setBackingUp(false); }
    };

    const pageId = ROLE_PAGE[role] || 'admin.dashboard';

    const emergencyStyle = {
        background: '#e53935',
        border: 'none',
        color: 'white',
        padding: '6px 12px',
        borderRadius: '6px',
        cursor: 'pointer',
        fontWeight: 600 as const,
        fontSize: '0.8rem',
        display: 'flex' as const,
        alignItems: 'center' as const,
        gap: '6px',
        boxShadow: '0 2px 8px rgba(229, 57, 53, 0.4)',
    };

    return (
        <>
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

                {/* Registry-driven: auto-renders buttons for current role's dashboard page */}
                <PageActionBar pageId={pageId} size="xs" compact />

                {/* Admin extras */}
                {role === 'admin' && (
                    <button style={{
                        background: 'rgba(255,255,255,0.1)',
                        border: '1px solid rgba(255,255,255,0.2)',
                        color: 'white', padding: '6px 12px', borderRadius: '6px',
                        cursor: 'pointer', fontWeight: 600, fontSize: '0.8rem',
                    }} onClick={handleBackup} disabled={backingUp} data-cy="qa-backup">
                        {backingUp ? '⏳ Backing up...' : '💾 Backup'}
                    </button>
                )}

                <div style={{ flex: 1 }}></div>

                {/* Emergency - Always Visible */}
                <button style={emergencyStyle} onClick={handleEmergency} data-cy="qa-emergency">
                    🚨 EMERGENCY ALERT
                </button>

            <DialogRenderer />
            </div>

            <CreateShiftModal
                isOpen={shiftOpen}
                onClose={() => setShiftOpen(false)}
                mode={shiftMode}
            />
        </>
    );
}
