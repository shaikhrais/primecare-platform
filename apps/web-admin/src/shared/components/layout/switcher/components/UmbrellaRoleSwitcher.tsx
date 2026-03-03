import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface UmbrellaRoleSwitcherProps {
    roles: string[];
    activeRole: string;
    loading: boolean;
    handleSwitchRole: (role: string) => void;
}

export const UmbrellaRoleSwitcher: React.FC<UmbrellaRoleSwitcherProps> = ({
    roles,
    activeRole,
    loading,
    handleSwitchRole
}) => {
    const groups = [
        { title: ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.GROUPS.ADMIN, roles: ['admin'] },
        { title: ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.GROUPS.STAFF, roles: ['staff', 'finance', 'hr', 'compliance'] },
        { title: ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.GROUPS.MANAGEMENT, roles: ['manager', 'marketing_manager', 'operations_manager', 'clinical_manager', 'regional_manager', 'recruiting_manager', 'coordinator', 'crm', 'training'] },
        { title: ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.GROUPS.HEALTHCARE, roles: ['psw', 'rn', 'rmt', 'rpt', 'rch'] }
    ];

    return (
        <div style={{ marginBottom: '24px' }}>
            <div style={{ fontSize: '11px', fontWeight: 800, color: 'var(--text-200)', marginBottom: '16px', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                {ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.SECTION_ROLE}
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {groups.map(group => {
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
    );
};
