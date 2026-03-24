import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router';
import { createPortal } from 'react-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry, RouteRegistry } = AdminRegistry;

interface User {
    id: string;
    email: string;
    roles: string[];
    activeRole: string;
    tenantId: string;
}

import { PerspectiveModal } from './switcher/PerspectiveModal';

export default function DevPerspectiveSwitcher() {
    const navigate = useNavigate();
    const [isOpen, setIsOpen] = useState(false);
    const [loading, setLoading] = useState(false);
    const [searchQuery, setSearchQuery] = useState('');
    const [users, setUsers] = useState<User[]>([]);
    const [showImpersonate, setShowImpersonate] = useState(false);

    const userStr = localStorage.getItem('user');
    const currentUser: User | null = (userStr && userStr !== 'undefined') ? JSON.parse(userStr) : null;

    const isAdmin = currentUser?.roles?.includes('admin') ?? false;
    const isImpersonating = sessionStorage.getItem('originalAdmin') !== null;

    useEffect(() => {
        if (showImpersonate && isAdmin) {
            fetchUsers();
        }
    }, [showImpersonate]);

    if (!currentUser) return null;

    const fetchUsers = async () => {
        try {
            const response = await apiClient.get(ApiRegistry.ADMIN.USERS);
            if (response.ok) {
                const data = await response.json();
                setUsers(data);
            }
        } catch (err) {
            // R13: Silent error — don't expose internal details
        }
    };

    const handleSwitchRole = async (targetRole: string) => {
        if (targetRole === currentUser.activeRole) return;
        setLoading(true);
        try {
            const updatedUser = { ...currentUser, activeRole: targetRole };
            localStorage.setItem('user', JSON.stringify(updatedUser));

            const target = RouteRegistry.ROLE_HOMES[targetRole.toLowerCase()] || RouteRegistry.ADMIN.HOME;
            navigate(target);
            setIsOpen(false);
        } finally {
            setLoading(false);
        }
    };

    const handleImpersonate = async (targetUser: User) => {
        setLoading(true);
        try {
            const response = await apiClient.post(ApiRegistry.AUTH.IMPERSONATE, { targetUserId: targetUser.id });
            if (response.ok) {
                const data = await response.json();
                if (!isImpersonating) {
                    // R13: Only store non-sensitive user data for UI restore — NOT tokens
                    sessionStorage.setItem('originalAdmin', userStr!);
                }
                // R13: Token is set via HttpOnly cookie by backend — don't store in localStorage
                localStorage.setItem('user', JSON.stringify({ ...data.user, activeRole: data.user.roles[0] }));
                window.location.href = RouteRegistry.ADMIN.HOME;
            }
        } catch (err) {
            // R13: Silent error
        } finally {
            setLoading(false);
        }
    };

    const exitImpersonation = async () => {
        const originalAdmin = sessionStorage.getItem('originalAdmin');
        if (originalAdmin) {
            // R13: Call backend to restore original admin session via cookie
            try {
                await apiClient.post('/v1/auth/exit-impersonation');
            } catch { /* will redirect anyway */ }
            localStorage.setItem('user', originalAdmin);
            sessionStorage.removeItem('originalAdmin');
            window.location.href = RouteRegistry.ADMIN.HOME;
        }
    };

    const filteredUsers = users.filter(u =>
        u.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
        u.id.includes(searchQuery)
    ).slice(0, 5);

    return (
        <div data-cy="page.container" className="pc-umbrella-role-switcher" style={{ margin: '12px' }}>
            <button data-cy="btn-shared.dev-perspective-switcher-0"
                onClick={() => setIsOpen(true)}
                style={{
                    width: '100%',
                    padding: '12px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    background: isImpersonating ? '#FFF7ED' : 'white',
                    border: `1px solid ${isImpersonating ? '#FB923C' : 'var(--line)'}`,
                    borderRadius: '8px',
                    cursor: 'pointer',
                    fontWeight: 700,
                    fontSize: '13px',
                    color: isImpersonating ? '#C2410C' : 'var(--text-400)',
                    transition: 'all 0.2s',
                    boxShadow: 'var(--shadow-sm)'
                }}
            >
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <span>{isImpersonating ? '👤' : '🎭'}</span>
                    <span>{isImpersonating ? 'Impersonating' : 'Switch Perspective'}</span>
                </div>
                <span>✨</span>
            </button>

            {isOpen && createPortal(
                <PerspectiveModal
                    isOpen={isOpen}
                    onClose={() => setIsOpen(false)}
                    isImpersonating={isImpersonating}
                    activeRole={currentUser.activeRole}
                    roles={currentUser.roles}
                    handleSwitchRole={handleSwitchRole}
                    loading={loading}
                    isAdmin={isAdmin}
                    exitImpersonation={exitImpersonation}
                    searchQuery={searchQuery}
                    setSearchQuery={setSearchQuery}
                    setShowImpersonate={setShowImpersonate}
                    showImpersonate={showImpersonate}
                    filteredUsers={filteredUsers}
                    handleImpersonate={handleImpersonate}
                />,
                document.body
            )}
        </div>
    );
}
