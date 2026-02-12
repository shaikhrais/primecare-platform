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
}

export default function RoleSwitcher() {
    const navigate = useNavigate();
    const [loading, setLoading] = useState(false);

    const userStr = localStorage.getItem('user');
    const token = localStorage.getItem('token');

    if (!userStr || userStr === 'undefined' || !token) return null;

    const user: User = JSON.parse(userStr);
    const roles = user.roles || [];

    if (roles.length <= 1) return null;

    const handleSwitch = async (targetRole: string) => {
        if (targetRole === user.activeRole) return;

        setLoading(true);
        try {
            const response = await fetch(`${API_URL}/v1/auth/switch-role`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ targetRole })
            });

            if (response.ok) {
                const data = await response.json();

                // Update local storage
                localStorage.setItem('token', data.token);
                const updatedUser = { ...user, activeRole: targetRole };
                localStorage.setItem('user', JSON.stringify(updatedUser));

                // Redirect based on new role
                if (targetRole === 'manager') {
                    navigate('/manager/dashboard');
                } else if (targetRole === 'rn') {
                    navigate('/rn/dashboard');
                } else if (targetRole === 'psw') {
                    navigate('/shifts');
                } else if (targetRole === 'admin') {
                    navigate('/app');
                } else if (targetRole === 'client') {
                    navigate('/bookings');
                } else {
                    window.location.reload();
                }
            } else {
                console.error('Failed to switch role');
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
            background: 'rgba(255, 255, 255, 0.05)',
            backdropFilter: 'blur(10px)',
            WebkitBackdropFilter: 'blur(10px)',
            borderRadius: '12px',
            margin: '12px',
            border: '1px solid rgba(5, 150, 105, 0.2)',
            boxShadow: '0 8px 32px 0 rgba(0, 0, 0, 0.1)'
        }}>
            <label style={{
                display: 'block',
                fontSize: '10px',
                fontWeight: 900,
                textTransform: 'uppercase',
                letterSpacing: '1.5px',
                marginBottom: '10px',
                color: 'var(--brand-400)',
                opacity: 0.8
            }}>
                Switch Persona {loading && '...'}
            </label>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                {roles.map(role => (
                    <button
                        key={role}
                        onClick={() => handleSwitch(role)}
                        disabled={loading || role === user.activeRole}
                        style={{
                            padding: '8px 12px',
                            fontSize: '12px',
                            fontWeight: 600,
                            borderRadius: '8px',
                            border: '1px solid transparent',
                            textAlign: 'left',
                            background: role === user.activeRole ? 'linear-gradient(135deg, var(--brand-500), var(--brand-600))' : 'rgba(255, 255, 255, 0.03)',
                            color: role === user.activeRole ? 'white' : 'var(--text-200)',
                            cursor: loading || role === user.activeRole ? 'default' : 'pointer',
                            display: 'flex',
                            alignItems: 'center',
                            gap: '10px',
                            transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                            transform: role === user.activeRole ? 'scale(1.02)' : 'scale(1)',
                            boxShadow: role === user.activeRole ? '0 4px 12px rgba(5, 150, 105, 0.3)' : 'none'
                        }}
                        onMouseOver={(e) => {
                            if (role !== user.activeRole && !loading) {
                                e.currentTarget.style.background = 'rgba(255, 255, 255, 0.08)';
                                e.currentTarget.style.borderColor = 'rgba(5, 150, 105, 0.3)';
                                e.currentTarget.style.transform = 'translateX(4px)';
                            }
                        }}
                        onMouseOut={(e) => {
                            if (role !== user.activeRole && !loading) {
                                e.currentTarget.style.background = 'rgba(255, 255, 255, 0.03)';
                                e.currentTarget.style.borderColor = 'transparent';
                                e.currentTarget.style.transform = 'scale(1)';
                            }
                        }}
                    >
                        <span style={{
                            fontSize: '1.3rem',
                            filter: role === user.activeRole ? 'drop-shadow(0 0 5px rgba(255,255,255,0.5))' : 'none'
                        }}>
                            {role === 'admin' ? '🔒' : role === 'manager' ? '📊' : role === 'rn' ? '🩺' : role === 'psw' ? '👨‍⚕️' : '🏠'}
                        </span>
                        <span>{role.charAt(0).toUpperCase() + role.slice(1)}</span>
                    </button>
                ))}
            </div>
        </div>
    );
}
