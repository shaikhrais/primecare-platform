import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface PerspectiveModalProps {
    isOpen: boolean;
    onClose: () => void;
    isImpersonating: boolean;
    activeRole: string;
    roles: string[];
    handleSwitchRole: (role: string) => void;
    loading: boolean;
    isAdmin: boolean;
    exitImpersonation: () => void;
    searchQuery: string;
    setSearchQuery: (query: string) => void;
    setShowImpersonate: (show: boolean) => void;
    showImpersonate: boolean;
    filteredUsers: any[];
    handleImpersonate: (user: any) => void;
}

export function PerspectiveModal({
    isOpen,
    onClose,
    isImpersonating,
    activeRole,
    roles,
    handleSwitchRole,
    loading,
    isAdmin,
    exitImpersonation,
    searchQuery,
    setSearchQuery,
    setShowImpersonate,
    showImpersonate,
    filteredUsers,
    handleImpersonate
}: PerspectiveModalProps) {
    if (!isOpen) return null;

    return (
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
                onClick={onClose}
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
                            {isImpersonating ? 'User Impersonation Tool' : 'Umbrella Perspective'}
                        </h3>
                        <p style={{ margin: '4px 0 0 0', fontSize: '12px', color: 'var(--text-300)' }}>
                            {isImpersonating ? 'Viewing system as another user' : 'Switch between platform umbrellas or impersonate users'}
                        </p>
                    </div>
                    <button
                        onClick={onClose}
                        style={{ background: 'none', border: 'none', fontSize: '24px', cursor: 'pointer', color: 'var(--text-300)' }}
                    >
                        ×
                    </button>
                </div>

                <div style={{ padding: '24px' }}>
                    {/* Role Switching */}
                    <div style={{ marginBottom: '24px' }}>
                        <div style={{ fontSize: '11px', fontWeight: 800, color: 'var(--text-200)', marginBottom: '16px', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                            SWITCH UMBRELLA
                        </div>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                            {[
                                { title: 'Administration', roles: ['admin'] },
                                { title: 'Staff Operations', roles: ['staff', 'finance', 'hr', 'compliance'] },
                                { title: 'Management', roles: ['manager', 'marketing_manager', 'operations_manager', 'clinical_manager', 'regional_manager', 'recruiting_manager', 'coordinator', 'crm', 'training'] },
                                { title: 'Healthcare Workers', roles: ['psw', 'rn', 'rmt', 'rpt', 'rch'] }
                            ].map(group => {
                                const userGroupRoles = roles.filter(r => group.roles.includes(r));
                                if (userGroupRoles.length === 0) return null;

                                return (
                                    <div key={group.title}>
                                        <div style={{ fontSize: '10px', fontWeight: 700, color: 'var(--text-300)', marginBottom: '8px', opacity: 0.8 }}>
                                            {group.title.toUpperCase()}
                                        </div>
                                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(130px, 1fr))', gap: '8px' }}>
                                            {userGroupRoles.map(role => (
                                                <button
                                                    key={role}
                                                    onClick={() => handleSwitchRole(role)}
                                                    disabled={loading || role === activeRole}
                                                    style={{
                                                        padding: '10px',
                                                        fontSize: '11px',
                                                        fontWeight: 700,
                                                        borderRadius: '8px',
                                                        border: '1px solid',
                                                        borderColor: role === activeRole ? 'var(--brand-500)' : 'var(--line)',
                                                        background: role === activeRole ? 'var(--brand-500)' : '#F9FAFB',
                                                        color: role === activeRole ? 'white' : 'var(--text-400)',
                                                        cursor: 'pointer',
                                                        transition: 'all 0.2s',
                                                        display: 'flex',
                                                        alignItems: 'center',
                                                        justifyContent: 'center',
                                                        gap: '4px'
                                                    }}
                                                >
                                                    {role === activeRole && <span>✓</span>}
                                                    {role.toUpperCase().replace('_', ' ')}
                                                </button>
                                            ))}
                                        </div>
                                    </div>
                                );
                            })}
                        </div>
                    </div>

                    {/* Impersonation */}
                    {isAdmin && (
                        <div style={{ borderTop: '1px solid var(--line)', paddingTop: '24px' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                <div style={{ fontSize: '11px', fontWeight: 800, color: 'var(--text-200)', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                                    SEARCH SYSTEM USERS
                                </div>
                                {isImpersonating && (
                                    <button onClick={exitImpersonation} style={{
                                        padding: '6px 12px', fontSize: '11px', background: '#EF4444', color: 'white', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 800
                                    }}>
                                        EXIT IMPERSONATION
                                    </button>
                                )}
                            </div>

                            <div style={{ position: 'relative' }}>
                                <input
                                    type="text"
                                    placeholder="Search by name, email or UID..."
                                    value={searchQuery}
                                    onChange={(e) => {
                                        setSearchQuery(e.target.value);
                                        setShowImpersonate(true);
                                    }}
                                    style={{
                                        width: '100%', padding: '14px 14px 14px 40px', fontSize: '14px', border: '1px solid var(--line)', borderRadius: '12px', boxSizing: 'border-box', background: '#F9FAFB'
                                    }}
                                />
                                <span style={{ position: 'absolute', left: '14px', top: '50%', transform: 'translateY(-50%)', opacity: 0.5 }}>🔍</span>
                            </div>

                            {showImpersonate && searchQuery && (
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginTop: '12px' }}>
                                    {filteredUsers.map(user => (
                                        <button
                                            key={user.id}
                                            onClick={() => handleImpersonate(user)}
                                            style={{
                                                padding: '12px', fontSize: '13px', textAlign: 'left', background: 'white', border: '1px solid #F3F4F6', borderRadius: '10px', cursor: 'pointer', display: 'flex', justifyContent: 'space-between', alignItems: 'center'
                                            }}
                                        >
                                            <div style={{ display: 'flex', flexDirection: 'column' }}>
                                                <span style={{ fontWeight: 600, color: 'var(--text-400)' }}>{user.email}</span>
                                                <span style={{ fontSize: '10px', color: 'var(--text-300)' }}>UID: {user.id}</span>
                                            </div>
                                            <span style={{ color: 'var(--brand-600)', fontWeight: 800, fontSize: '11px' }}>IMPERSONATE →</span>
                                        </button>
                                    ))}
                                </div>
                            )}
                        </div>
                    )}
                </div>

                {/* Footer */}
                <div style={{ padding: '16px 24px', background: '#F9FAFB', borderTop: '1px solid var(--line)', display: 'flex', justifyContent: 'flex-end' }}>
                    <button
                        onClick={onClose}
                        style={{ padding: '10px 20px', fontSize: '13px', fontWeight: 700, color: 'var(--text-300)', background: 'none', border: 'none', cursor: 'pointer' }}
                    >
                        {ContentRegistry.SCHEDULE.ACTIONS.CLOSE}
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes pc-modal-slide-up {
                    from { transform: translateY(10px); opacity: 0; }
                    to { transform: translateY(0); opacity: 1; }
                }
            `}</style>
        </div>
    );
}
