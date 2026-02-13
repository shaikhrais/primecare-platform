import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

interface QuickActionsProps {
    role: string;
}

export default function QuickActions({ role }: QuickActionsProps) {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isCrisisMode, setIsCrisisMode] = useState(false);
    const [isLoading, setIsLoading] = useState(false);

    const toggleCrisisMode = async () => {
        if (role !== 'admin') {
            showToast('Only administrators can activate Crisis Mode', 'error');
            return;
        }

        const confirmMsg = isCrisisMode
            ? "Deactivate Crisis Mode? This will resume normal notifications."
            : "ACTIVATE CRISIS MODE? This will send emergency alerts to all active staff.";

        if (!window.confirm(confirmMsg)) return;

        setIsLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${import.meta.env.VITE_API_URL}/incidents/crisis-mode`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ active: !isCrisisMode })
            });

            if (!response.ok) throw new Error('Failed to toggle crisis mode');

            setIsCrisisMode(!isCrisisMode);
            showToast(
                isCrisisMode ? 'Crisis Mode Deactivated' : 'CRISIS MODE ACTIVATED',
                isCrisisMode ? 'info' : 'error'
            );
        } catch (error) {
            console.error('Crisis mode error:', error);
            showToast('Failed to update Crisis Mode status', 'error');
        } finally {
            setIsLoading(false);
        }
    };

    if (!['admin', 'staff', 'manager'].includes(role)) return null;

    const handleAddUser = () => {
        navigate('/admin/users');
    };

    return (
        <div style={{ display: 'flex', gap: '0.5rem' }}>
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
                Add User
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
                        backgroundColor: isCrisisMode ? 'rgba(239, 68, 68, 0.1)' : 'var(--bg-elev)',
                        color: isCrisisMode ? '#ef4444' : 'var(--text)',
                        cursor: 'pointer',
                        fontWeight: 700,
                        fontSize: '0.85rem',
                        transition: 'all 0.2s',
                        animation: isCrisisMode ? 'pulse 2s infinite' : 'none'
                    }}
                >
                    <span style={{ fontSize: '1.1rem' }}>{isCrisisMode ? '🚨' : '🛡️'}</span>
                    {isLoading ? 'Wait...' : isCrisisMode ? 'CRISIS ACTIVE' : 'Crisis Mode'}
                </button>
            )}
            <style>{`
                @keyframes pulse {
                    0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4); }
                    70% { box-shadow: 0 0 0 10px rgba(239, 68, 68, 0); }
                    100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
                }
            `}</style>
        </div>
    );
}
