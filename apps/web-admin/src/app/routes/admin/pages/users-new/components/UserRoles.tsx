import React from 'react';

interface UserRolesProps {
    selectedRoles: string[];
    onChange: (roles: string[]) => void;
}

const AVAILABLE_ROLES = ['admin', 'staff', 'manager', 'psw', 'client', 'coordinator', 'finance'];

export const UserRoles: React.FC<UserRolesProps> = ({ selectedRoles, onChange }) => {
    return (
        <div style={{ gridColumn: 'span 2' }}>
            <label style={{ display: 'block', marginBottom: '0.8rem', fontWeight: 600 }}>System Roles</label>
            <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap', padding: '1rem', backgroundColor: '#f9fafb', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}>
                {AVAILABLE_ROLES.map(role => (
                    <label key={role} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.9rem', cursor: 'pointer' }}>
                        <input
                            type="checkbox"
                            checked={selectedRoles.includes(role)}
                            onChange={(e) => {
                                const newRoles = e.target.checked
                                    ? [...selectedRoles, role]
                                    : selectedRoles.filter(r => r !== role);
                                onChange(newRoles);
                            }}
                            style={{ width: '18px', height: '18px', accentColor: '#004d40' }}
                        />
                        {role.charAt(0).toUpperCase() + role.slice(1)}
                    </label>
                ))}
            </div>
        </div>
    );
};
