import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useNotification } from '../../App';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '../../utils/apiClient';

const { ApiRegistry, ContentRegistry, DataRegistry } = AdminRegistry;

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
                navigate('/users');
            } else {
                showToast('Action failed', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    if (loading) return <div style={{ padding: '2rem' }}>Loading user data...</div>;

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.user.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>Discard Changes?</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>Any unsaved changes will be lost.</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }} data-cy="page.header">
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">{id ? 'Edit User' : 'Create New User'}</h2>
                <p style={{ color: '#6b7280' }}>Manage system access and profile details.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Full Name</label>
                        <input
                            data-cy="form.user.fullName"
                            type="text"
                            required
                            value={formData.fullName}
                            onChange={(e) => { setFormData({ ...formData, fullName: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Email Address</label>
                        <input
                            data-cy="form.user.email"
                            type="email"
                            required
                            value={formData.email}
                            onChange={(e) => { setFormData({ ...formData, email: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.8rem', fontWeight: 600 }}>System Roles</label>
                        <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap', padding: '1rem', backgroundColor: '#f9fafb', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}>
                            {['admin', 'staff', 'manager', 'psw', 'client', 'coordinator', 'finance'].map(role => (
                                <label key={role} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.9rem', cursor: 'pointer' }}>
                                    <input
                                        type="checkbox"
                                        checked={formData.roles.includes(role)}
                                        onChange={(e) => {
                                            const newRoles = e.target.checked
                                                ? [...formData.roles, role]
                                                : formData.roles.filter(r => r !== role);
                                            setFormData({ ...formData, roles: newRoles });
                                            setIsDirty(true);
                                        }}
                                        style={{ width: '18px', height: '18px', accentColor: '#004d40' }}
                                    />
                                    {role.charAt(0).toUpperCase() + role.slice(1)}
                                </label>
                            ))}
                        </div>
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Account Status</label>
                        <select
                            data-cy="form.user.status"
                            value={formData.status}
                            onChange={(e) => { setFormData({ ...formData, status: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                            <option value="suspended">Suspended</option>
                        </select>
                    </div>

                    {/* Role-Specific: PSW */}
                    {formData.roles.includes('psw') && (
                        <div style={{ gridColumn: 'span 2' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>SIN (Social Insurance Number)</label>
                            <input
                                data-cy="form.user.sin"
                                type="password"
                                value={formData.sin}
                                onChange={(e) => { setFormData({ ...formData, sin: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    )}

                    {/* Role-Specific: Client */}
                    {formData.roles.includes('client') && (
                        <div style={{ gridColumn: 'span 2' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Billing Account #</label>
                            <input
                                data-cy="form.user.billingAccount"
                                type="text"
                                value={formData.billingAccount}
                                onChange={(e) => { setFormData({ ...formData, billingAccount: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    )}

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Physical Address</label>
                        <textarea
                            data-cy="form.user.address"
                            value={formData.address}
                            onChange={(e) => { setFormData({ ...formData, address: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.user.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Processing...' : id ? 'Update User' : 'Create User'}
                    </button>
                </div>
            </form>
        </div>
    );
}
