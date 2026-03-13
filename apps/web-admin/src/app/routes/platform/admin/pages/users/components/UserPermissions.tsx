import React from 'react';

interface UserPermissionsProps {
    assignedPermissions: string[];
    onChange: (perms: string[]) => void;
}

const PERMISSIONS = [
    { key: 'users.view', label: 'View Users', description: 'Access user list and profiles' },
    { key: 'users.edit', label: 'Edit Users', description: 'Create and modify user records' },
    { key: 'billing.view', label: 'View Billing', description: 'Access financial records and invoices' },
    { key: 'reports.view', label: 'View Reports', description: 'Generate and export system reports' },
    { key: 'support.handle', label: 'Handle Support', description: 'Respond to and manage support tickets' },
];

export const UserPermissions: React.FC<UserPermissionsProps> = ({ assignedPermissions, onChange }) => {
    return (
        <div style={{ gridColumn: 'span 2', marginTop: '1.5rem' }}>
            <label style={{ display: 'block', marginBottom: '0.8rem', fontWeight: 600 }}>Granular Permissions</label>
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))',
                gap: '1rem',
                padding: '1.5rem',
                backgroundColor: '#ffffff',
                borderRadius: '0.5rem',
                border: '1px solid #e5e7eb'
            }}>
                {PERMISSIONS.map(p => (
                    <div
                        key={p.key}
                        style={{
                            padding: '1rem',
                            borderRadius: '0.5rem',
                            border: '1px solid #f3f4f6',
                            cursor: 'pointer',
                            backgroundColor: assignedPermissions.includes(p.key) ? '#f0f9ff' : 'transparent',
                            transition: 'all 0.2s',
                            display: 'flex',
                            alignItems: 'flex-start',
                            gap: '0.75rem'
                        }}
                        onClick={() => {
                            const newPerms = assignedPermissions.includes(p.key)
                                ? assignedPermissions.filter(k => k !== p.key)
                                : [...assignedPermissions, p.key];
                            onChange(newPerms);
                        }}
                    >
                        <input data-cy="input-admin.user-permissions-0"
                            type="checkbox"
                            checked={assignedPermissions.includes(p.key)}
                            readOnly
                            style={{ marginTop: '0.25rem', accentColor: '#004d40' }}
                        />
                        <div>
                            <div style={{ fontWeight: 600, fontSize: '0.9rem', color: '#111827' }}>{p.label}</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280', marginTop: '0.125rem' }}>{p.description}</div>
                        </div>
                    </div>
                ))}
            </div>
            <p style={{ fontSize: '0.8rem', color: '#6b7280', marginTop: '0.5rem' }}>
                * Standard permissions are inherited from roles automatically. Use these to override or refine access.
            </p>
        </div>
    );
};
