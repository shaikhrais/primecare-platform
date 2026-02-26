import React from 'react';

interface RoleSwitcherModalProps {
    isOpen: boolean;
    onClose: () => void;
    activeRole: string;
    availableRoles: string[];
    systemRoles: string[];
    isAdmin: boolean;
    handleSwitch: (role: string) => void;
}

export function RoleSwitcherModal({
    isOpen,
    onClose,
    activeRole,
    availableRoles,
    systemRoles,
    isAdmin,
    handleSwitch
}: RoleSwitcherModalProps) {
    if (!isOpen) return null;

    return (
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
                        onClick={onClose}
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
    );
}
