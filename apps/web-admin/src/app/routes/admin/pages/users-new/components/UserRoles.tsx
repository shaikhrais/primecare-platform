import React from 'react';
import { useAuth } from '@/shared/context/AuthContext';

interface UserRolesProps {
    selectedRoles: string[];
    onChange: (roles: string[]) => void;
}

const ALL_ROLES = ['admin', 'staff', 'manager', 'psw', 'client', 'coordinator', 'finance', 'hr', 'compliance', 'crm', 'training'];

export const UserRoles: React.FC<UserRolesProps> = ({ selectedRoles, onChange }) => {
    const { user } = useAuth();
    const currentUserRole = user?.activeRole || user?.roles?.[0] || 'staff';
    const isAdmin = currentUserRole === 'admin';

    const ROLE_GROUPS = [
        {
            title: 'Administration',
            roles: ['admin', 'staff', 'finance', 'hr', 'compliance'],
        },
        {
            title: 'Management',
            roles: ['manager', 'marketing_manager', 'operations_manager', 'coordinator', 'crm', 'training'],
        },
        {
            title: 'Service Providers',
            roles: ['psw', 'rn', 'rmt', 'rpt', 'rch'],
        }
    ];

    return (
        <div style={{ gridColumn: 'span 2' }}>
            <label style={{ display: 'block', marginBottom: '1rem', fontWeight: 600 }}>System Roles & Categories</label>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                {ROLE_GROUPS.map(group => {
                    const groupRoles = isAdmin ? group.roles : group.roles.filter(r => r !== 'admin');
                    if (groupRoles.length === 0) return null;

                    return (
                        <div key={group.title} style={{ padding: '1rem', backgroundColor: '#f9fafb', borderRadius: '0.8rem', border: '1px solid #e5e7eb' }}>
                            <div style={{ fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', color: '#6b7280', marginBottom: '0.8rem', letterSpacing: '0.5px' }}>
                                {group.title}
                            </div>
                            <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap' }}>
                                {groupRoles.map(role => (
                                    <label key={role} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.9rem', cursor: 'pointer', color: '#374151' }}>
                                        <input
                                            type="checkbox"
                                            checked={selectedRoles.includes(role)}
                                            onChange={(e) => {
                                                const newRoles = e.target.checked
                                                    ? [...selectedRoles, role]
                                                    : selectedRoles.filter(r => r !== role);
                                                onChange(newRoles);
                                            }}
                                            disabled={!isAdmin && role === 'admin'}
                                            style={{ width: '18px', height: '18px', accentColor: '#004d40' }}
                                        />
                                        {role.charAt(0).toUpperCase() + role.slice(1).replace('_', ' ')}
                                    </label>
                                ))}
                            </div>
                        </div>
                    );
                })}
            </div>
            {!isAdmin && (
                <p style={{ fontSize: '0.8rem', color: '#6b7280', marginTop: '0.5rem' }}>
                    * You can manage operational roles. Contact an Administrator to assign system-level access.
                </p>
            )}
        </div>
    );
};
