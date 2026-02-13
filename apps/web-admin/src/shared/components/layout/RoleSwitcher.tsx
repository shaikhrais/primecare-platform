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

    const handleSwitch = async (targetRole: string) => {
        if (targetRole === activeRole) return;

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

                // Redirect based on new role using standard routes
                if (targetRole === 'manager') {
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
                    window.location.reload();
                }
            }
        } catch (err) {
            console.error('Error switching role:', err);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="pc-role-switcher" style={{
            padding: '12px',
            background: '#F9FAFB',
            borderRadius: '6px',
            margin: '12px',
            border: '1px solid var(--line)'
        }}>
            <label style={{
                display: 'block',
                fontSize: '10px',
                fontWeight: 700,
                textTransform: 'uppercase',
                letterSpacing: '1px',
                marginBottom: '8px',
                color: 'var(--text-300)'
            }}>
                {isAdmin ? 'Admin Perspective' : 'Switch Persona'} {loading && '...'}
            </label>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                {availableRoles.map(role => (
                    <button
                        key={role}
                        data-cy={`btn-switch-role-${role}`}
                        onClick={() => handleSwitch(role)}
                        disabled={loading || role === activeRole}
                        style={{
                            padding: '8px 12px',
                            fontSize: '13px',
                            fontWeight: 600,
                            borderRadius: '4px',
                            border: '1px solid transparent',
                            textAlign: 'left',
                            background: role === activeRole ? 'var(--brand-500)' : 'transparent',
                            color: role === activeRole ? 'white' : 'var(--text-300)',
                            cursor: loading || role === activeRole ? 'default' : 'pointer',
                            display: 'flex',
                            alignItems: 'center',
                            gap: '10px'
                        }}
                    >
                        <span style={{ fontSize: '1.2rem' }}>
                            {role === 'admin' ? '🔒' : role === 'manager' ? '📊' : role === 'rn' ? '🩺' : role === 'psw' ? '👨‍⚕️' : role === 'staff' ? '🏢' : '🏠'}
                        </span>
                        <span>{role.charAt(0).toUpperCase() + role.slice(1)}</span>
                    </button>
                ))}
            </div>
        </div>
    );
}
