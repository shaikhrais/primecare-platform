import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

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

    useEffect(() => {
        const fetchTenants = async () => {
            try {
                // Mocking tenant data for now as specific API might be pending
                const mockTenants: Tenant[] = [
                    { id: '1', name: 'PrimeCare Main', domain: 'main.primecare.ca', status: 'active', createdAt: '2025-01-01' },
                    { id: '2', name: 'West Side Health', domain: 'westside.primecare.ca', status: 'active', createdAt: '2025-02-15' },
                    { id: '3', name: 'North Star Seniors', domain: 'northstar.primecare.ca', status: 'pending', createdAt: '2026-01-10' },
                ];
                setTenants(mockTenants);
            } finally {
                setLoading(false);
            }
        };
        fetchTenants();
    }, []);

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>Tenant Management</h2>
                <button style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                    + Provision New Tenant
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.875rem', color: '#6b7280' }}>Tenant Name</th>
                            <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.875rem', color: '#6b7280' }}>Domain</th>
                            <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.875rem', color: '#6b7280' }}>Status</th>
                            <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.875rem', color: '#6b7280' }}>Provisioned</th>
                            <th style={{ padding: '1rem', textAlign: 'left', fontSize: '0.875rem', color: '#6b7280' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center' }}>Loading tenants...</td></tr>
                        ) : tenants.map(tenant => (
                            <tr key={tenant.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', fontWeight: '600' }}>{tenant.name}</td>
                                <td style={{ padding: '1rem', color: '#6b7280' }}>{tenant.domain}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{
                                        padding: '0.25rem 0.75rem',
                                        borderRadius: '9999px',
                                        fontSize: '0.75rem',
                                        backgroundColor: tenant.status === 'active' ? '#dcfce7' : '#fef3c7',
                                        color: tenant.status === 'active' ? '#166534' : '#92400e'
                                    }}>
                                        {tenant.status.toUpperCase()}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem', color: '#6b7280' }}>{tenant.createdAt}</td>
                                <td style={{ padding: '1rem' }}>
                                    <button style={{ color: '#004d40', border: 'none', background: 'none', cursor: 'pointer', fontWeight: '500' }}>Manage</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
