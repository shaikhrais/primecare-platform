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

            // Navigate to the correct dashboard
            const dashboardMap: Record<string, string> = {
                admin: '/admin/dashboard',
                manager: '/manager/dashboard',
                staff: '/staff/dashboard',
                rn: '/rn/dashboard',
                psw: '/psw/dashboard',
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

                // Save original admin if not already impersonating
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
            {/* Sidebar Trigger Button */}
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

            {/* Modal Popup Overlay (Portalled to Document Body for full-screen centering) */}
            {isOpen && createPortal(
                <div style={{
                    position: 'fixed',
                    top: 0, left: 0, right: 0, bottom: 0,
                    zIndex: 9999,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    padding: '20px'
                }}>
                    {/* Backdrop */}
                    <div
                        onClick={() => setIsOpen(false)}
                        style={{
                            position: 'absolute',
                            top: 0, left: 0, right: 0, bottom: 0,
                            background: 'rgba(0,0,0,0.5)',
                            backdropFilter: 'blur(4px)',
                            zIndex: -1
                        }}
                    />

                    {/* Modal Content */}
                    <div style={{
                        width: '100%',
                        maxWidth: '450px',
                        background: 'white',
                        borderRadius: '20px',
                        overflow: 'hidden',
                        boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
                        animation: 'pc-modal-slide-up 0.3s ease-out'
                    }}>
                        {/* Header */}
                        <div style={{
                            padding: '24px',
                            background: isImpersonating ? 'linear-gradient(135deg, #FFF7ED 0%, #FFEDD5 100%)' : 'linear-gradient(135deg, #F9FAFB 0%, #F3F4F6 100%)',
                            borderBottom: '1px solid var(--line)',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center'
                        }}>
                            <div>
                                <h3 style={{ margin: 0, fontSize: '18px', fontWeight: 800, color: 'var(--text-400)' }}>
                                    {isImpersonating ? 'User Impersonation Tool' : 'Perspective Switcher'}
                                </h3>
                                <p style={{ margin: '4px 0 0 0', fontSize: '12px', color: 'var(--text-300)' }}>
                                    {isImpersonating ? 'You are currently viewing as another user' : 'Toggle your role or impersonate a system user'}
                                </p>
                            </div>
                            <button
                                onClick={() => setIsOpen(false)}
                                style={{ background: 'none', border: 'none', fontSize: '24px', cursor: 'pointer', color: 'var(--text-300)' }}
                            >
                                ×
                            </button>
                        </div>

                        <div style={{ padding: '24px' }}>
                            {/* Role Switching */}
                            <div style={{ marginBottom: '24px' }}>
                                <div style={{ fontSize: '11px', fontWeight: 800, color: 'var(--text-200)', marginBottom: '12px', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                                    YOUR ASSIGNED ROLES
                                </div>
                                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(130px, 1fr))', gap: '10px' }}>
                                    {currentUser.roles?.map(role => (
                                        <button
                                            key={role}
                                            onClick={() => handleSwitchRole(role)}
                                            disabled={loading || role === currentUser.activeRole}
                                            style={{
                                                padding: '12px',
                                                fontSize: '13px',
                                                fontWeight: 700,
                                                borderRadius: '10px',
                                                border: '1px solid',
                                                borderColor: role === currentUser.activeRole ? 'var(--brand-500)' : 'var(--line)',
                                                background: role === currentUser.activeRole ? 'var(--brand-500)' : '#F9FAFB',
                                                color: role === currentUser.activeRole ? 'white' : 'var(--text-400)',
                                                cursor: 'pointer',
                                                transition: 'all 0.2s',
                                                display: 'flex',
                                                alignItems: 'center',
                                                justifyContent: 'center',
                                                gap: '8px'
                                            }}
                                        >
                                            {role === currentUser.activeRole && <span>✓</span>}
                                            {role.toUpperCase()}
                                        </button>
                                    ))}
                                </div>
                            </div>

                            {/* Impersonation */}
                            {isAdmin && (
                                <div style={{ borderTop: '1px solid var(--line)', paddingTop: '24px' }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                        <div style={{ fontSize: '11px', fontWeight: 800, color: 'var(--text-200)', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                                            IMPERSONATE SYSTEM USER
                                        </div>
                                        {isImpersonating && (
                                            <button onClick={exitImpersonation} style={{
                                                padding: '6px 12px', fontSize: '11px', background: '#EF4444', color: 'white', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 800
                                            }}>
                                                RESTORE ADMIN SESSION
                                            </button>
                                        )}
                                    </div>

                                    <div style={{ position: 'relative' }}>
                                        <input
                                            type="text"
                                            placeholder="Find user by email or ID..."
                                            value={searchQuery}
                                            onChange={(e) => {
                                                setSearchQuery(e.target.value);
                                                setShowImpersonate(true);
                                            }}
                                            style={{
                                                width: '100%', padding: '14px 14px 14px 40px', fontSize: '14px', border: '1px solid var(--line)', borderRadius: '12px', boxSizing: 'border-box', background: '#F9FAFB', transition: 'all 0.2s'
                                            }}
                                        />
                                        <span style={{ position: 'absolute', left: '14px', top: '50%', transform: 'translateY(-50%)', fontSize: '16px' }}>🔍</span>
                                    </div>

                                    {showImpersonate && searchQuery && (
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginTop: '12px' }}>
                                            {filteredUsers.map(user => (
                                                <button
                                                    key={user.id}
                                                    onClick={() => handleImpersonate(user)}
                                                    style={{
                                                        padding: '12px', fontSize: '13px', textAlign: 'left', background: 'white', border: '1px solid #F3F4F6', borderRadius: '10px', cursor: 'pointer', display: 'flex', justifyContent: 'space-between', alignItems: 'center', transition: 'all 0.2s'
                                                    }}
                                                    onMouseEnter={(e) => {
                                                        e.currentTarget.style.borderColor = 'var(--brand-300)';
                                                        e.currentTarget.style.background = 'var(--brand-50)';
                                                    }}
                                                    onMouseLeave={(e) => {
                                                        e.currentTarget.style.borderColor = '#F3F4F6';
                                                        e.currentTarget.style.background = 'white';
                                                    }}
                                                >
                                                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                                                        <span style={{ fontWeight: 600, color: 'var(--text-400)' }}>{user.email}</span>
                                                        <span style={{ fontSize: '10px', color: 'var(--text-300)' }}>ID: {user.id.slice(0, 8)}...</span>
                                                    </div>
                                                    <span style={{ color: 'var(--brand-600)', fontWeight: 800, fontSize: '11px' }}>VIEW PERSPECTIVE →</span>
                                                </button>
                                            ))}
                                            {filteredUsers.length === 0 && (
                                                <div style={{ fontSize: '13px', color: 'var(--text-200)', textAlign: 'center', padding: '20px' }}>
                                                    No system users found for "{searchQuery}"
                                                </div>
                                            )}
                                        </div>
                                    )}
                                </div>
                            )}
                        </div>

                        {/* Footer */}
                        <div style={{ padding: '16px 24px', background: '#F9FAFB', borderTop: '1px solid var(--line)', display: 'flex', justifyContent: 'flex-end' }}>
                            <button
                                onClick={() => setIsOpen(false)}
                                style={{ padding: '10px 20px', fontSize: '13px', fontWeight: 700, color: 'var(--text-300)', background: 'none', border: 'none', cursor: 'pointer' }}
                            >
                                Close
                            </button>
                        </div>
                    </div>

                    <style>{`
                        @keyframes pc-modal-slide-up {
                            from { transform: translateY(20px); opacity: 0; }
                            to { transform: translateY(0); opacity: 1; }
                        }
                    `}</style>
                </div>,
                document.body
            )}
        </div>
    );
}
