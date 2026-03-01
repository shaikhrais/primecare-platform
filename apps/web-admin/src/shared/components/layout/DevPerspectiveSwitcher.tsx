import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
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
    if (!userStr || userStr === 'undefined') return null;
    const currentUser: User = JSON.parse(userStr);

    const isAdmin = currentUser.roles?.includes('admin');
    const isImpersonating = sessionStorage.getItem('originalAdmin') !== null;

    useEffect(() => {
        if (showImpersonate && isAdmin) {
            fetchUsers();
        }
    }, [showImpersonate]);

    const fetchUsers = async () => {
        try {
            const response = await apiClient.get(ApiRegistry.ADMIN.USERS);
            if (response.ok) {
                const data = await response.json();
                setUsers(data);
            }
        } catch (err) {
            console.error('Failed to fetch users', err);
        }
    };

    const handleSwitchRole = async (targetRole: string) => {
        if (targetRole === currentUser.activeRole) return;
        setLoading(true);
        try {
            const updatedUser = { ...currentUser, activeRole: targetRole };
            localStorage.setItem('user', JSON.stringify(updatedUser));

            const target = RouteRegistry.ROLE_DASHBOARDS[targetRole.toLowerCase()] || RouteRegistry.ADMIN.DASHBOARD;
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
                    sessionStorage.setItem('originalAdmin', userStr);
                    sessionStorage.setItem('originalToken', localStorage.getItem('token') || '');
                }
                localStorage.setItem('token', data.token);
                localStorage.setItem('user', JSON.stringify({ ...data.user, activeRole: data.user.roles[0] }));
                window.location.href = RouteRegistry.ADMIN.DASHBOARD;
            }
        } catch (err) {
            console.error('Impersonation failed', err);
        } finally {
            setLoading(false);
        }
    };

    const exitImpersonation = () => {
        const originalAdmin = sessionStorage.getItem('originalAdmin');
        const originalToken = sessionStorage.getItem('originalToken');
        if (originalAdmin && originalToken) {
            localStorage.setItem('user', originalAdmin);
            localStorage.setItem('token', originalToken);
            sessionStorage.removeItem('originalAdmin');
            sessionStorage.removeItem('originalToken');
            window.location.href = RouteRegistry.ADMIN.DASHBOARD;
        }
    };

    const filteredUsers = users.filter(u =>
        u.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
        u.id.includes(searchQuery)
    ).slice(0, 5);

    return (
        <div className="pc-umbrella-role-switcher" style={{ margin: '12px' }}>
            <button
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
