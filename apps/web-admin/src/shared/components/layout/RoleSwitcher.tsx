import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry } = AdminRegistry;

interface User {
    id: string;
    email: string;
    roles: string[];
    activeRole: string;
    tenantId: string;
    role?: string;
}

import { RoleSwitcherModal } from './switcher/RoleSwitcherModal';

export default function RoleSwitcher() {
    const navigate = useNavigate();
    const [loading, setLoading] = useState(false);
    const [isOpen, setIsOpen] = useState(false);

    const userStr = localStorage.getItem('user');
    // R13: Removed localStorage.getItem('token') — auth via HttpOnly cookies

    if (!userStr || userStr === 'undefined') return null;

    const user: User = JSON.parse(userStr);
    const activeRole = user.activeRole;

    // For Admins, allow switching to ANY role to "see other dashboards"
    // For others, only allow assigned roles
    const isAdmin = user.roles?.includes('admin') || user.role === 'admin';
    const availableRoles = isAdmin
        ? ['admin', 'staff', 'manager', 'psw', 'client', 'rn']
        : (user.roles || []);

    if (availableRoles.length <= 1) return null;

    // System roles for impersonation (Admin only)
    const systemRoles = ['staff', 'rn', 'psw', 'client', 'coordinator', 'finance', 'hr', 'compliance', 'crm', 'training'];

    const handleSwitch = async (targetRole: string) => {
        if (targetRole === activeRole) {
            setIsOpen(false);
            return;
        }

        setLoading(true);
        try {
            let success = true;
            if (!isAdmin) {
                // R13: Use apiClient instead of raw fetch + localStorage token
                const response = await apiClient.post(ApiRegistry.AUTH.SWITCH_ROLE, { targetRole });
                success = response.ok;
            }

            if (success) {
                const updatedUser = { ...user, activeRole: targetRole };
                localStorage.setItem('user', JSON.stringify(updatedUser));
                setIsOpen(false);

                const { RouteRegistry } = AdminRegistry;
                const targetPath = RouteRegistry.ROLE_DASHBOARDS[targetRole.toLowerCase()] || RouteRegistry.ADMIN.DASHBOARD;
                navigate(targetPath);
            }
        } catch (err) {
            // R13: Silent error
        } finally {
            setLoading(false);
        }
    };

    // Close on escape key
    React.useEffect(() => {
        const handleEsc = (e: KeyboardEvent) => {
            if (e.key === 'Escape') setIsOpen(false);
        };
        window.addEventListener('keydown', handleEsc);
        return () => window.removeEventListener('keydown', handleEsc);
    }, []);

    return (
        <>
            <div className="pc-role-switcher" style={{
                padding: '12px',
                margin: '12px',
                borderTop: '1px solid var(--line)'
            }}>
                <button
                    onClick={() => setIsOpen(true)}
                    style={{
                        width: '100%',
                        padding: '10px 12px',
                        background: '#F3F4F6',
                        border: '1px solid #E5E7EB',
                        borderRadius: '8px',
                        fontSize: '0.85rem',
                        fontWeight: 600,
                        color: '#374151',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        gap: '8px'
                    }}
                >
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <span style={{ fontSize: '1.2rem' }}>🔄</span>
                        <div style={{ textAlign: 'left' }}>
                            <div style={{ fontSize: '0.65rem', textTransform: 'uppercase', color: '#6B7280', fontWeight: 700 }}>Perspective</div>
                            <div>{activeRole.charAt(0).toUpperCase() + activeRole.slice(1)}</div>
                        </div>
                    </div>
                    <span style={{ fontSize: '0.8rem', color: '#9CA3AF' }}>▼</span>
                </button>
            </div>

            <RoleSwitcherModal
                isOpen={isOpen}
                onClose={() => setIsOpen(false)}
                activeRole={activeRole}
                availableRoles={availableRoles}
                systemRoles={systemRoles}
                isAdmin={isAdmin}
                handleSwitch={handleSwitch}
            />
        </>
    );
}
