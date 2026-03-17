import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

// Inlined from deleted ./components/ProvisionTenantModal
const ProvisionTenantModal: React.FC<{ isOpen: boolean; onClose: () => void; onSuccess: () => void }> = ({ isOpen, onClose, onSuccess }) => {
    const [name, setName] = useState('');
    const [domain, setDomain] = useState('');
    if (!isOpen) return null;
    return (
        <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 9999 }}>
            <div style={{ background: 'white', borderRadius: '1rem', padding: '2rem', width: 480, maxWidth: '90vw' }}>
                <h3 style={{ margin: '0 0 1rem' }}>Provision New Tenant</h3>
                <input value={name} onChange={e => setName(e.target.value)} placeholder="Organization name" style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', marginBottom: '1rem' }} />
                <input value={domain} onChange={e => setDomain(e.target.value)} placeholder="Domain (e.g. acme.primecare.io)" style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', marginBottom: '1rem' }} />
                <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'flex-end' }}>
                    <button onClick={onClose} className="btn secondary">Cancel</button>
                    <button onClick={() => { onClose(); onSuccess(); }} className="btn primary">Provision</button>
                </div>
            </div>
        </div>
    );
};

const { ContentRegistry } = AdminRegistry;

interface Tenant {
    id: string;
    name: string;
    domain: string;
    status: 'active' | 'suspended' | 'pending';
    createdAt: string;
}

export default function TenantList() {
    const [tenants, setTenants] = useState<Tenant[]>([]);
    const [loading, setLoading] = useState(true);
    const [isProvisionModalOpen, setIsProvisionModalOpen] = useState(false);

    const fetchTenants = async () => {
        setLoading(true);
        try {
            const res = await fetch('https://primecare-api.itpro-mohammed.workers.dev/v1/superuser/tenants');
            if (res.ok) {
                const data = await res.json();
                setTenants(data);
            }
        } catch (error) {
            console.error('Failed to load active tenants', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchTenants();
    }, []);

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Tenant Management</h1>
                    <p style={{ color: '#6B7280' }}>Provision and manage active fractal SaaS organizations.</p>
                </div>
                <button data-cy="btn-index-0" className="btn primary" onClick={() => setIsProvisionModalOpen(true)}>
                    + Provision New Tenant
                </button>
            </div>

            <div className="pc-card" style={{ overflow: 'hidden' }}>
                <ProvisionTenantModal 
                    isOpen={isProvisionModalOpen} 
                    onClose={() => setIsProvisionModalOpen(false)} 
                    onSuccess={() => fetchTenants()} 
                />
                <table data-cy="table-index" style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                        <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                            <th style={{ padding: '16px' }}>Organization</th>
                            <th style={{ padding: '16px' }}>Endpoint Domain</th>
                            <th style={{ padding: '16px' }}>SLA Tier</th>
                            <th style={{ padding: '16px' }}>Status</th>
                            <th style={{ padding: '16px' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '40px', textAlign: 'center' }}>Orchestrating tenant roster...</td></tr>
                        ) : tenants.map(tenant => (
                            <tr key={tenant.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                <td style={{ padding: '16px' }}><strong>{tenant.name}</strong></td>
                                <td style={{ padding: '16px', fontFamily: 'monospace', color: '#6B7280' }}>{tenant.domain}</td>
                                <td style={{ padding: '16px' }}>
                                    <span className="badge secondary">PLATINUM</span>
                                </td>
                                <td style={{ padding: '16px' }}>
                                    <span style={{
                                        color: tenant.status === 'active' ? '#10B981' : '#F59E0B',
                                        fontWeight: 'bold',
                                        fontSize: '12px'
                                    }}>
                                        ● {tenant.status.toUpperCase()}
                                    </span>
                                </td>
                                <td style={{ padding: '16px' }}>
                                    <button data-cy="btn-index-1" className="btn secondary" style={{ padding: '6px 12px', fontSize: '12px' }}>Manage</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
