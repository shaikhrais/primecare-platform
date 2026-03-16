import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { CreateVisitModal } from '@/shared/components/modals/CreateVisitModal';
import { AdminRegistry, ApiRegistry } from 'prime-care-shared';
import { useApiMutation } from '@/shared/hooks/useApiMutation';

const { RouteRegistry } = AdminRegistry;

interface QuickActionsProps {
    role: string;
}

export default function QuickActions({ role }: QuickActionsProps) {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isCrisisMode, setIsCrisisMode] = useState(false);
    const [isPostShiftModalOpen, setIsPostShiftModalOpen] = useState(false);

    const CONTENT = AdminRegistry.ContentRegistry.QUICK_ACTIONS;

    const crisisMutation = useApiMutation(ApiRegistry.ADMIN.CRISIS_MODE, {
        onSuccess: () => {
            setIsCrisisMode(!isCrisisMode);
            showToast(
                isCrisisMode ? CONTENT.MESSAGES.CRISIS_DEACTIVATED : CONTENT.MESSAGES.CRISIS_ACTIVATED,
                isCrisisMode ? 'info' : 'error'
            );
        },
        onError: () => {
            showToast(CONTENT.MESSAGES.TEMP_ERROR, 'error');
        },
    });

    const isLoading = crisisMutation.isPending;

    const toggleCrisisMode = async () => {
        if (role !== 'admin') {
            showToast(CONTENT.MESSAGES.ADMIN_ONLY, 'error');
            return;
        }

        const confirmMsg = isCrisisMode
            ? CONTENT.MESSAGES.CRISIS_DEACTIVATE
            : CONTENT.MESSAGES.CRISIS_CONFIRM;

        if (!window.confirm(confirmMsg)) return;

        crisisMutation.mutate({ active: !isCrisisMode });
    };

    if (!['admin', 'staff', 'manager'].includes(role)) return null;

    const handleAddUser = () => {
        navigate(RouteRegistry.ADMIN.USERS);
    };

    return (
        <div data-cy="page.container" style={{ display: 'flex', gap: '0.5rem' }}>
            <button
                data-cy="btn-quick-post-shift"
                onClick={() => setIsPostShiftModalOpen(true)}
                style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    padding: '0.5rem 1rem',
                    borderRadius: '8px',
                    border: '1px solid #00875A',
                    backgroundColor: '#00875A',
                    color: 'white',
                    cursor: 'pointer',
                    fontWeight: 700,
                    fontSize: '0.85rem',
                    boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
                }}
            >
                <span style={{ fontSize: '1.1rem' }}>📅</span>
                {CONTENT.POST_SHIFT}
            </button>

            <button
                data-cy="btn-quick-add-user"
                onClick={handleAddUser}
                style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    padding: '0.5rem 1rem',
                    borderRadius: '8px',
                    border: '1px solid var(--line)',
                    backgroundColor: 'var(--bg-elev)',
                    color: 'var(--text)',
                    cursor: 'pointer',
                    fontWeight: 700,
                    fontSize: '0.85rem'
                }}
            >
                <span style={{ fontSize: '1.1rem' }}>👤</span>
                {CONTENT.ADD_USER}
            </button>

            {role === 'admin' && (
                <button
                    data-cy="btn-crisis-mode"
                    onClick={toggleCrisisMode}
                    disabled={isLoading}
                    style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem',
                        padding: '0.5rem 1rem',
                        borderRadius: '8px',
                        border: isCrisisMode ? '1px solid #ef4444' : '1px solid var(--line)',
                        backgroundColor: isCrisisMode ? '#fef2f2' : 'var(--bg-elev)',
                        color: isCrisisMode ? '#ef4444' : 'var(--text)',
                        cursor: 'pointer',
                        fontWeight: 700,
                        fontSize: '0.85rem'
                    }}
                >
                    <span style={{ fontSize: '1.1rem' }}>{isCrisisMode ? '🚨' : '🛡️'}</span>
                    {isLoading ? CONTENT.WAITING : isCrisisMode ? CONTENT.CRISIS_ACTIVE : CONTENT.CRISIS_ALERTS}
                </button>
            )}

            <CreateVisitModal
                isOpen={isPostShiftModalOpen}
                onClose={() => setIsPostShiftModalOpen(false)}
                onSuccess={() => {
                    setIsPostShiftModalOpen(false);
                    showToast(CONTENT.MESSAGES.SYNC_SUCCESS, 'success');
                }}
            />
        </div>
    );
}
