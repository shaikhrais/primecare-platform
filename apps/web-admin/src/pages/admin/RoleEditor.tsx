import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../App';

export default function RoleEditor() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

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
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="page.container">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>Discard Permissions?</h2>
                        <div style={{ display: 'flex', gap: '16px', marginTop: '24px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }} data-cy="page.title">Role Permission Editor</h2>
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
                <div style={{ marginTop: '2rem', display: 'flex', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ padding: '0.75rem 1.5rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        data-cy="form.role.save"
                        disabled={!isDirty}
                        onClick={handleSave}
                        style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', fontWeight: 'bold', border: 'none', cursor: isDirty ? 'pointer' : 'default', opacity: isDirty ? 1 : 0.6 }}
                    >
                        Save Permissions
                    </button>
                </div>
            </div>
        </div>
    );
}
