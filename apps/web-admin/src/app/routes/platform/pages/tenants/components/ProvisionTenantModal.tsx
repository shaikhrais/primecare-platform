import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

interface ProvisionTenantModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSuccess: (newTenant: any) => void;
}

export const ProvisionTenantModal: React.FC<ProvisionTenantModalProps> = ({ isOpen, onClose, onSuccess }) => {
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);
    
    const [formData, setFormData] = useState({
        name: '',
        slug: '',
        adminName: '',
        adminEmail: ''
    });

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);

        try {
            // Note: Since this is a Master Franchise cross-tenant route, we use the root API.
            // Normally apiClient sets X-Tenant-ID based on local storage, but the backend `/v1/superuser/tenants`
            // route doesn't require a tenant check because it creates tenants.
            const response = await fetch('https://primecare-api.itpro-mohammed.workers.dev/v1/superuser/tenants', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });

            const data = await response.json();

            if (response.ok) {
                showToast('Tenant organization provisioned successfully!', 'success');
                onSuccess(data.tenant);
                onClose();
                setFormData({ name: '', slug: '', adminName: '', adminEmail: '' });
            } else {
                showToast(data.error || 'Failed to provision tenant.', 'error');
            }
        } catch (error) {
            showToast('Network error while provisioning tenant.', 'error');
        } finally {
            setLoading(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} role="dialog" aria-modal="true">
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%', position: 'relative' }}>
                <button 
                    onClick={onClose} 
                    style={{ position: 'absolute', top: '1rem', right: '1rem', background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#6b7280' }}
                >
                    &times;
                </button>
                <h3 style={{ marginTop: 0, fontSize: '1.25rem', fontWeight: 'bold', color: '#111827' }}>Provision New Tenant</h3>
                <p style={{ fontSize: '0.875rem', color: '#6B7280', marginBottom: '1.5rem' }}>
                    Spin up a new dedicated fractal workspace. This allocates a siloed ledger and generates the initial root Administrator account.
                </p>

                <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    
                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <label style={{ fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.25rem' }}>Organization Name</label>
                        <input 
                            type="text" required placeholder="e.g. North Star Health" 
                            value={formData.name} onChange={e => {
                                const newName = e.target.value;
                                // Auto-fill slug organically
                                const autoSlug = newName.toLowerCase().replace(/[^a-z0-9]/g, '');
                                setFormData(p => ({ ...p, name: newName, slug: autoSlug }));
                            }} 
                            disabled={loading}
                            style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }} 
                        />
                    </div>

                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <label style={{ fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.25rem' }}>Endpoint Domain (Slug)</label>
                        <div style={{ display: 'flex', alignItems: 'center' }}>
                            <span style={{ padding: '0.5rem', backgroundColor: '#f3f4f6', border: '1px solid #d1d5db', borderRight: 'none', borderRadius: '0.375rem 0 0 0.375rem', color: '#6B7280' }}>https://</span>
                            <input 
                                type="text" required placeholder="northstar" 
                                value={formData.slug} onChange={e => setFormData(p => ({ ...p, slug: e.target.value.toLowerCase().replace(/[^a-z0-9]/g, '') }))} 
                                disabled={loading}
                                style={{ flex: 1, padding: '0.5rem', borderRadius: '0 0.375rem 0.375rem 0', border: '1px solid #d1d5db' }} 
                            />
                            <span style={{ padding: '0.5rem', backgroundColor: '#f3f4f6', border: '1px solid #d1d5db', borderLeft: 'none', borderRadius: '0 0.375rem 0.375rem 0', color: '#6B7280' }}>.primecare.ca</span>
                        </div>
                    </div>

                    <hr style={{ borderTop: '1px solid #e5e7eb', margin: '0.5rem 0' }} />
                    <h4 style={{ margin: 0, fontSize: '1rem', color: '#374151' }}>Root Administrator Options</h4>

                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <label style={{ fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.25rem' }}>Full Name</label>
                        <input 
                            type="text" required placeholder="Admin Name" 
                            value={formData.adminName} onChange={e => setFormData(p => ({ ...p, adminName: e.target.value }))} 
                            disabled={loading}
                            style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }} 
                        />
                    </div>

                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <label style={{ fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.25rem' }}>Email Address</label>
                        <input 
                            type="email" required placeholder="admin@domain.com" 
                            value={formData.adminEmail} onChange={e => setFormData(p => ({ ...p, adminEmail: e.target.value }))} 
                            disabled={loading}
                            style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }} 
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                        <button type="button" onClick={onClose} disabled={loading} style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Cancel</button>
                        <button type="submit" disabled={loading} style={{ flex: 2, padding: '0.75rem', borderRadius: '0.5rem', border: 'none', background: '#4F46E5', color: 'white', fontWeight: 'bold', cursor: 'pointer', opacity: loading ? 0.7 : 1 }}>
                            {loading ? 'Provisioning Ledger...' : 'Provision Tenant'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};
