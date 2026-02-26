import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { createPortal } from 'react-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry } = AdminRegistry;

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
            const response = await apiClient.get('/v1/admin/users');
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

            const dashboardMap: Record<string, string> = {
                admin: '/admin/dashboard',
                manager: '/manager/dashboard',
                marketing_manager: '/manager/dashboard',
                operations_manager: '/manager/dashboard',
                staff: '/staff/dashboard',
                finance: '/staff/dashboard',
                hr: '/staff/dashboard',
                compliance: '/staff/dashboard',
                rn: '/rn/dashboard',
                psw: '/psw/dashboard',
                rmt: '/psw/dashboard',
                rpt: '/psw/dashboard',
                rch: '/psw/dashboard',
                client: '/client/dashboard'
            };
            navigate(dashboardMap[targetRole] || '/app');
            setIsOpen(false);
        } finally {
            setLoading(false);
        }
    };

    const handleImpersonate = async (targetUser: User) => {
        setLoading(true);
        try {
            const response = await apiClient.post('/v1/auth/impersonate', { targetUserId: targetUser.id });
            if (response.ok) {
                const data = await response.json();
                if (!isImpersonating) {
                    sessionStorage.setItem('originalAdmin', userStr);
                    sessionStorage.setItem('originalToken', localStorage.getItem('token') || '');
                }
                localStorage.setItem('user', JSON.stringify({ ...data.user, activeRole: data.user.roles[0] }));
                localStorage.setItem('token', data.token);
                window.location.href = '/app';
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
            window.location.href = '/admin/dashboard';
        }
    };

    const filteredUsers = users.filter(u =>
        u.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
        u.id.includes(searchQuery)
    ).slice(0, 5);

    return (
        <div className="pc-perspective-switcher" style={{ margin: '12px' }}>
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
                    <span>{isImpersonating ? 'Impersonating' : 'Switch Umbrella Role'}</span>
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
