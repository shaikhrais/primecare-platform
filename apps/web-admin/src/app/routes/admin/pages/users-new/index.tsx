import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

// Components
import { UnsavedChangesGuard } from './components/UnsavedChangesGuard';
import { UserBasicInfo } from './components/UserBasicInfo';
import { UserRoles } from './components/UserRoles';
import { UserRoleDetails } from './components/UserRoleDetails';
import { UserPermissions } from './components/UserPermissions';
import { RoleHelp } from './components/RoleHelp';

const { ApiRegistry } = AdminRegistry;

export default function UserEntryForm() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [loading, setLoading] = useState(id ? true : false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        email: '',
        roles: ['staff'] as string[],
        permissions: [] as string[],
        fullName: '',
        phone: '',
        status: 'active',
        // Role-specific fields
        sin: '', // PSW only
        billingAccount: '', // Client only
        address: ''
    });

    useEffect(() => {
        if (id) {
            const fetchUser = async () => {
                try {
                    const response = await apiClient.get(`${ApiRegistry.ADMIN.USERS}/${id}`);
                    if (response.ok) {
                        const data = await response.json();
                        setFormData({
                            email: data.email || '',
                            roles: data.roles || (data.role ? [data.role] : ['staff']),
                            permissions: data.permissions || [],
                            fullName: data.profile?.fullName || '',
                            phone: data.phone || '',
                            status: data.status || 'active',
                            sin: data.pswProfile?.sin || '',
                            billingAccount: data.clientProfile?.billingAccount || '',
                            address: data.profile?.address || ''
                        });
                    }
                } catch (error) {
                    showToast('Failed to load user data', 'error');
                } finally {
                    setLoading(false);
                }
            };
            fetchUser();
        }
    }, [id]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const method = id ? 'PATCH' : 'POST';

            const response = await apiClient.request(`${id ? ApiRegistry.ADMIN.USERS + '/' + id : ApiRegistry.ADMIN.USERS}`, {
                method,
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast(`User ${id ? 'updated' : 'created'} successfully`, 'success');
                setIsDirty(false);
                navigate('/admin/users');
            } else {
                showToast('Action failed', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    const handleFieldChange = (field: string, value: string) => {
        setFormData(prev => ({ ...prev, [field]: value }));
        setIsDirty(true);
    };

    const handleRolesChange = (roles: string[]) => {
        setFormData(prev => ({ ...prev, roles }));
        setIsDirty(true);
    };

    const handlePermissionsChange = (permissions: string[]) => {
        setFormData(prev => ({ ...prev, permissions }));
        setIsDirty(true);
    };

    if (loading) return <div style={{ padding: '2rem' }}>Loading user data...</div>;

    return (
        <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '2rem' }} data-cy="form.user.page">
            <UnsavedChangesGuard
                isOpen={showGuard}
                onStay={() => setShowGuard(false)}
                onLeave={() => navigate(-1)}
            />

            <div style={{ marginBottom: '2rem' }} data-cy="page.header">
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">{id ? 'Edit User' : 'Create New User'}</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Manage system access and profile details.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 320px', gap: '2rem', alignItems: 'start' }}>
                <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                        <UserBasicInfo
                            fullName={formData.fullName}
                            email={formData.email}
                            status={formData.status}
                            onChange={handleFieldChange}
                        />

                        <UserRoles
                            selectedRoles={formData.roles}
                            onChange={handleRolesChange}
                        />

                        <UserPermissions
                            assignedPermissions={formData.permissions}
                            onChange={handlePermissionsChange}
                        />

                        <UserRoleDetails
                            roles={formData.roles}
                            sin={formData.sin}
                            billingAccount={formData.billingAccount}
                            address={formData.address}
                            onChange={handleFieldChange}
                        />
                    </div>

                    <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem', borderTop: '1px solid #f3f4f6', paddingTop: '1.5rem' }}>
                        <button
                            type="button"
                            onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                            style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer', fontWeight: 500 }}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            disabled={submitting}
                            data-cy="form.user.save"
                            style={{ padding: '0.75rem 2.5rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)' }}
                        >
                            {submitting ? 'Processing...' : id ? 'Update User' : 'Create User'}
                        </button>
                    </div>
                </form>

                <RoleHelp />
            </div>
        </div>
    );
}

