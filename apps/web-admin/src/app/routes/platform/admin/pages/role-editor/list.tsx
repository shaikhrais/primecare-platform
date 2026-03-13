import { AdminRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { useDialog } from '@/shared/hooks/useDialog';

export default function RolesList() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const { confirm, DialogRenderer } = useDialog();
    const [roles, setRoles] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
 // data fetch
        setTimeout(() => {
            setRoles([
                { id: 'admin', name: 'Administrator', usersCount: 3, permissionsCount: 45, type: 'System' },
                { id: 'manager', name: 'Care Manager', usersCount: 5, permissionsCount: 28, type: 'System' },
                { id: 'rn', name: 'Registered Nurse', usersCount: 8, permissionsCount: 15, type: 'System' },
                { id: 'custom-1', name: 'Billing Clerk', usersCount: 1, permissionsCount: 5, type: 'Custom' }
            ]);
            setLoading(false);
        }, 500);
    }, []);

    return (
        <div style={{ padding: '2rem' }} data-cy="roles-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }} data-cy="page.title">Roles & Permissions</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">Manage system access levels and user capabilities.</p>
                </div>
                <button
                    data-cy="btn-new-role"
                    onClick={() => navigate(AdminRegistry.RouteRegistry.ADMIN.USERS_NEW)}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    + New Role
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Role Name</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Type</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Assigned Users</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Permissions</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                        ) : roles.map((role) => (
                            <tr key={role.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', color: '#111827', fontWeight: 500 }}>{role.name}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{
                                        padding: '0.25rem 0.625rem',
                                        borderRadius: '9999px',
                                        backgroundColor: role.type === 'System' ? '#e0e7ff' : '#f3f4f6',
                                        color: role.type === 'System' ? '#3730a3' : '#374151',
                                        fontWeight: '600',
                                        fontSize: '0.75rem'
                                    }}>
                                        {role.type}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem', color: '#4b5563' }}>{role.usersCount} users</td>
                                <td style={{ padding: '1rem', color: '#4b5563' }}>{role.permissionsCount} capabilities</td>
                                <td style={{ padding: '1rem' }}>
                                    <button
                                        onClick={() => navigate(`/roles/${role.id}`)}
                                        style={{ color: '#004d40', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer', marginRight: '1rem' }}
                                    >
                                        Edit
                                    </button>
                                    {role.type !== 'System' && (
                                        <button
                                            onClick={async () => {
                                                if (!(await confirm('Delete Role', `Delete role "${role.name}"? Users with this role will lose their permissions.`))) return;
                                                try {
                                                    const { apiClient } = await import('@/shared/utils/apiClient');
                                                    await apiClient.delete(`/v1/admin/roles/${role.id}`);
                                                    setRoles(prev => prev.filter(r => r.id !== role.id));
                                                    showToast(`Role "${role.name}" deleted`, 'success');
                                                } catch { showToast('Failed to delete role', 'error'); }
                                            }}
                                            style={{ color: '#991b1b', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer' }}
                                        >
                                            Delete
                                        </button>
                                    )}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
            <DialogRenderer />
            </div>
    );
}
