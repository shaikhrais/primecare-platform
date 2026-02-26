import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface User {
    id: string;
    email: string;
    roles: string[];
    activeRole: string;
    tenantId: string;
    role?: string;
}

export default function RoleSwitcher() {
    const navigate = useNavigate();
    const [loading, setLoading] = useState(false);

    const userStr = localStorage.getItem('user');
    const token = localStorage.getItem('token');

    if (!userStr || userStr === 'undefined' || !token) return null;

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
            // Admin role switching is purely client-side perspective change for dashboard visibility
            // Regular role switching still hits the API for token refresh/validation if needed
            let success = true;
            if (!isAdmin) {
                const response = await fetch(`${API_URL}/v1/auth/switch-role`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${token}`
                    },
                    body: JSON.stringify({ targetRole })
                });
                success = response.ok;
                if (success) {
                    const data = await response.json();
                    localStorage.setItem('token', data.token);
                }
            }

            if (success) {
                const updatedUser = { ...user, activeRole: targetRole };
                localStorage.setItem('user', JSON.stringify(updatedUser));
                setIsOpen(false); // Close modal

                // Redirect based on new role using standard routes
                if (['manager', 'coordinator', 'finance', 'hr', 'compliance', 'crm', 'training'].includes(targetRole)) {
                    navigate('/manager/dashboard');
                } else if (targetRole === 'rn') {
                    navigate('/rn/dashboard');
                } else if (targetRole === 'psw') {
                    navigate('/psw/dashboard');
                } else if (targetRole === 'admin') {
                    navigate('/admin/dashboard');
                } else if (targetRole === 'client') {
                    navigate('/client/dashboard');
                } else if (targetRole === 'staff') {
                    navigate('/staff/dashboard');
                } else {
                    // Default fallback
                    window.location.reload();
                }
            }
        } catch (err) {
            console.error('Error switching role:', err);
        } finally {
            setLoading(false);
        }
    };

    const [isOpen, setIsOpen] = useState(false);

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
            {/* Sidebar Trigger */}
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

            {/* Modal Overlay */}
            {isOpen && (
                <div style={{
                    position: 'fixed',
                    inset: 0,
                    backgroundColor: 'rgba(0,0,0,0.6)',
                    backdropFilter: 'blur(4px)',
                    zIndex: 9999,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    animation: 'fadeIn 0.2s ease-out'
                }}>
                    <div
                        style={{
                            backgroundColor: 'white',
                            borderRadius: '16px',
                            width: '400px',
                            maxWidth: '90vw',
                            boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
                            overflow: 'hidden',
                            display: 'flex',
                            flexDirection: 'column',
                            animation: 'scaleIn 0.2s ease-out'
                        }}
                    >
                        {/* Header */}
                        <div style={{ padding: '20px', borderBottom: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                            <div>
                                <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 800, color: '#111827' }}>Perspective Switcher</h3>
                                <p style={{ margin: '4px 0 0', fontSize: '0.85rem', color: '#6B7280' }}>Toggle your role or impersonate a system user</p>
                            </div>
                            <button
                                onClick={() => setIsOpen(false)}
                                style={{ background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#9CA3AF', lineHeight: 1 }}
                            >
                                ×
                            </button>
                        </div>

                        {/* Body */}
                        <div style={{ padding: '20px', overflowY: 'auto', maxHeight: '60vh' }}>
                            {/* Assigned Roles */}
                            <div style={{ marginBottom: '24px' }}>
                                <h4 style={{ margin: '0 0 12px', fontSize: '0.75rem', fontWeight: 800, color: '#9CA3AF', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                                    Your Assigned Roles
                                </h4>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                                    {availableRoles.filter(r => !isAdmin || !systemRoles.includes(r) || r === 'admin' || r === 'manager').map(role => (
                                        <button
                                            key={role}
                                            onClick={() => handleSwitch(role)}
                                            style={{
                                                display: 'flex',
                                                alignItems: 'center',
                                                justifyContent: 'space-between',
                                                width: '100%',
                                                padding: '12px',
                                                borderRadius: '8px',
                                                border: role === activeRole ? '1px solid #00875A' : '1px solid #E5E7EB',
                                                background: role === activeRole ? '#ECFDF5' : '#FFFFFF',
                                                cursor: 'pointer',
                                                transition: 'all 0.2s'
                                            }}
                                        >
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                                <span style={{ fontSize: '1.25rem' }}>
                                                    {role === 'admin' ? '🔒' : role === 'manager' ? '📊' : '👤'}
                                                </span>
                                                <span style={{ fontWeight: 600, color: '#374151', textTransform: 'uppercase', fontSize: '0.9rem' }}>
                                                    {role}
                                                </span>
                                            </div>
                                            {role === activeRole && <span style={{ color: '#00875A', fontWeight: 900 }}>✓</span>}
                                        </button>
                                    ))}
                                </div>
                            </div>

                            {/* System Roles (Impersonation) */}
                            {isAdmin && (
                                <div>
                                    <h4 style={{ margin: '0 0 12px', fontSize: '0.75rem', fontWeight: 800, color: '#9CA3AF', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                                        Impersonate System User
                                    </h4>
                                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '8px' }}>
                                        {systemRoles.map(role => (
                                            <button
                                                key={role}
                                                onClick={() => handleSwitch(role)}
                                                style={{
                                                    padding: '10px',
                                                    border: '1px solid #e5e7eb',
                                                    borderRadius: '6px',
                                                    background: 'white',
                                                    cursor: 'pointer',
                                                    textAlign: 'left',
                                                    display: 'flex',
                                                    alignItems: 'center',
                                                    gap: '8px',
                                                    fontSize: '0.9rem',
                                                    fontWeight: 500,
                                                    color: '#374151',
                                                    transition: 'all 0.2s'
                                                }}
                                                onMouseEnter={(e) => e.currentTarget.style.borderColor = '#004d40'}
                                                onMouseLeave={(e) => e.currentTarget.style.borderColor = '#e5e7eb'}
                                            >
                                                <span>
                                                    {role === 'staff' ? '👨‍💼' :
                                                        role === 'rn' ? '👩‍⚕️' :
                                                            role === 'psw' ? '🦺' :
                                                                role === 'client' ? '🏠' :
                                                                    role === 'coordinator' ? '📅' :
                                                                        role === 'finance' ? '💰' :
                                                                            role === 'hr' ? '📋' :
                                                                                role === 'compliance' ? '✅' :
                                                                                    role === 'crm' ? '🤝' :
                                                                                        role === 'training' ? '🎓' : '❓'}
                                                </span>
                                                {role.charAt(0).toUpperCase() + role.slice(1)}
                                            </button>
                                        ))}
                                    </div>
                                </div>
                            )}
                        </div>

                        {/* Footer / Impersonate Action */}
                        {isAdmin && (
                            <div style={{ padding: '20px', background: '#F9FAFB', borderTop: '1px solid #E5E7EB' }}>
                                <button
                                    onClick={() => alert("User Lookup Feature Coming Soon")}
                                    style={{
                                        width: '100%',
                                        padding: '12px',
                                        background: '#111827',
                                        color: 'white',
                                        border: 'none',
                                        borderRadius: '8px',
                                        fontWeight: 700,
                                        fontSize: '0.9rem',
                                        cursor: 'pointer',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        gap: '8px'
                                    }}
                                >
                                    <span>🕵️</span>
                                    IMPERSONATE SYSTEM USER
                                </button>
                            </div>
                        )}
                    </div>
                    <style dangerouslySetInnerHTML={{
                        __html: `
                        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
                        @keyframes scaleIn { from { transform: scale(0.95); opacity: 0; } to { transform: scale(1); opacity: 1; } }
                    `}} />
                </div>
            )}
        </>
    );
}
