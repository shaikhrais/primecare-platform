import React, { useState } from 'react';
import { useNotification } from '../../App';

export default function RoleEditor() {
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);

    const permissions = [
        { key: 'users.view', label: 'View Users' },
        { key: 'users.edit', label: 'Edit Users' },
        { key: 'billing.view', label: 'View Billing' },
        { key: 'reports.view', label: 'View Reports' }
    ];

    const [rolePerms, setRolePerms] = useState<Record<string, boolean>>({});

    const togglePerm = (key: string) => {
        setRolePerms(prev => ({ ...prev, [key]: !prev[key] }));
        setIsDirty(true);
    };

    const handleSave = () => {
        showToast('Role permissions updated', 'success');
        setIsDirty(false);
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.role.page">
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Role Permission Editor</h2>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }} data-cy="form.role.grid">
                {permissions.map(p => (
                    <div key={p.key} style={{ display: 'flex', justifyContent: 'space-between', padding: '1rem 0', borderBottom: '1px solid #f3f4f6' }}>
                        <span>{p.label}</span>
                        <input
                            type="checkbox"
                            checked={!!rolePerms[p.key]}
                            onChange={() => togglePerm(p.key)}
                            style={{ width: '1.25rem', height: '1.25rem' }}
                        />
                    </div>
                ))}
                <button
                    data-cy="form.role.save"
                    disabled={!isDirty}
                    onClick={handleSave}
                    style={{ marginTop: '2rem', width: '100%', padding: '0.75rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', fontWeight: 'bold', border: 'none', cursor: isDirty ? 'pointer' : 'default', opacity: isDirty ? 1 : 0.6 }}
                >
                    Save Permissions
                </button>
            </div>
        </div>
    );
}
