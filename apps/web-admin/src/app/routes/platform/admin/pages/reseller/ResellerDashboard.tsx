import React, { useState, useEffect } from 'react';

const ResellerDashboard: React.FC = () => {
    const [children, setChildren] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const [isProvisioning, setIsProvisioning] = useState(false);

    // Mock new tenant form state
    const [newTenant, setNewTenant] = useState({ name: '', slug: '', adminEmail: '', adminPassword: '' });

    const fetchChildren = async () => {
        setIsLoading(true);
        try {
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8787';

            const response = await fetch(`${apiUrl}/admin/reseller`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setChildren(data.children || []);
            }
        } catch (e) {
            console.error(e);
        } finally {
            setIsLoading(false);
        }
    };

    useEffect(() => {
        fetchChildren();
    }, []);

    const handleProvision = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsProvisioning(true);
        try {
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8787';

            const response = await fetch(`${apiUrl}/admin/reseller/provision`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify(newTenant)
            });

            if (!response.ok) {
                const err = await response.json();
                throw new Error(err.error || 'Failed to provision');
            }

            alert('Successfully provisioned new child agency!');
            setNewTenant({ name: '', slug: '', adminEmail: '', adminPassword: '' });
            fetchChildren();
        } catch (e: any) {
            alert(e.message);
        } finally {
            setIsProvisioning(false);
        }
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: '#EEF2FF', padding: '16px', borderRadius: '12px', fontSize: '32px' }}>
                    🏢
                </div>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: '#111827' }}>White-Label Reseller Hub</h1>
                    <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>Spawn and manage your child agencies in the Fractal SaaS network.</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 2fr) minmax(0, 1fr)', gap: '24px' }}>
                {/* Child Tenants List */}
                <div style={{ backgroundColor: 'white', borderRadius: '12px', border: '1px solid #E5E7EB', boxShadow: '0 1px 3px rgba(0,0,0,0.05)', overflow: 'hidden' }}>
                    <div style={{ padding: '20px 24px', borderBottom: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <h2 style={{ fontSize: '16px', fontWeight: '600', margin: '0', color: '#111827' }}>Your Portfolio Agencies</h2>
                        <span style={{ backgroundColor: '#DBEAFE', color: '#1D4ED8', padding: '2px 8px', borderRadius: '12px', fontSize: '12px', fontWeight: 'bold' }}>
                            {children.length} Active
                        </span>
                    </div>

                    <div style={{ padding: '0' }}>
                        {isLoading ? (
                            <div style={{ padding: '24px', textAlign: 'center', color: '#6B7280' }}>Loading...</div>
                        ) : children.length === 0 ? (
                            <div style={{ padding: '48px 24px', textAlign: 'center', color: '#6B7280' }}>
                                <p style={{ margin: '0 0 8px 0', fontSize: '16px', color: '#374151', fontWeight: '500' }}>No child agencies yet</p>
                                <p style={{ margin: '0', fontSize: '14px' }}>Use the provisioning tool to spawn your first sub-tenant.</p>
                            </div>
                        ) : (
                            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                                <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                                    <tr>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '500', color: '#6B7280', textTransform: 'uppercase' }}>Agency Name</th>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '500', color: '#6B7280', textTransform: 'uppercase' }}>Slug</th>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '500', color: '#6B7280', textTransform: 'uppercase' }}>Users</th>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '500', color: '#6B7280', textTransform: 'uppercase' }}>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {children.map(child => (
                                        <tr key={child.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                            <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '500', color: '#111827' }}>{child.name}</td>
                                            <td style={{ padding: '16px 24px', fontSize: '14px', color: '#4B5563', fontFamily: 'monospace' }}>{child.slug}</td>
                                            <td style={{ padding: '16px 24px', fontSize: '14px', color: '#4B5563' }}>{child.usersCount || 0}</td>
                                            <td style={{ padding: '16px 24px' }}>
                                                <span style={{ backgroundColor: child.status === 'active' ? '#D1FAE5' : '#FEF3C7', color: child.status === 'active' ? '#065F46' : '#92400E', padding: '2px 8px', borderRadius: '12px', fontSize: '12px', fontWeight: '500' }}>
                                                    {child.status}
                                                </span>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        )}
                    </div>
                </div>

                {/* Provisioning Form */}
                <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E5E7EB', boxShadow: '0 1px 3px rgba(0,0,0,0.05)', height: 'fit-content' }}>
                    <h2 style={{ fontSize: '16px', fontWeight: '600', marginBottom: '16px', color: '#111827' }}>Provision New Agency</h2>
                    <form onSubmit={handleProvision} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '14px', fontWeight: '500', color: '#374151', marginBottom: '4px' }}>Agency Name</label>
                            <input
                                required
                                value={newTenant.name}
                                onChange={e => setNewTenant({ ...newTenant, name: e.target.value })}
                                style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #D1D5DB', fontSize: '14px' }}
                                placeholder="e.g. Apex HomeCare"
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', fontSize: '14px', fontWeight: '500', color: '#374151', marginBottom: '4px' }}>Routing Slug</label>
                            <input
                                required
                                value={newTenant.slug}
                                onChange={e => setNewTenant({ ...newTenant, slug: e.target.value })}
                                style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #D1D5DB', fontSize: '14px' }}
                                placeholder="apex-care"
                            />
                        </div>
                        <div style={{ height: '1px', backgroundColor: '#E5E7EB', margin: '8px 0' }}></div>
                        <div>
                            <label style={{ display: 'block', fontSize: '14px', fontWeight: '500', color: '#374151', marginBottom: '4px' }}>Admin Login Email</label>
                            <input
                                required
                                type="email"
                                value={newTenant.adminEmail}
                                onChange={e => setNewTenant({ ...newTenant, adminEmail: e.target.value })}
                                style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #D1D5DB', fontSize: '14px' }}
                                placeholder="admin@apexcare.com"
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', fontSize: '14px', fontWeight: '500', color: '#374151', marginBottom: '4px' }}>Temporary Password</label>
                            <input
                                required
                                type="password"
                                minLength={8}
                                value={newTenant.adminPassword}
                                onChange={e => setNewTenant({ ...newTenant, adminPassword: e.target.value })}
                                style={{ width: '100%', padding: '8px 12px', borderRadius: '6px', border: '1px solid #D1D5DB', fontSize: '14px' }}
                                placeholder="••••••••"
                            />
                        </div>

                        <button
                            type="submit"
                            disabled={isProvisioning}
                            style={{
                                marginTop: '8px',
                                backgroundColor: isProvisioning ? '#9CA3AF' : '#4F46E5',
                                color: 'white',
                                padding: '10px',
                                borderRadius: '6px',
                                border: 'none',
                                fontWeight: '500',
                                cursor: isProvisioning ? 'not-allowed' : 'pointer'
                            }}
                        >
                            {isProvisioning ? 'Spawning Instance...' : 'Spawn Sub-Tenant'}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
};

export default ResellerDashboard;
