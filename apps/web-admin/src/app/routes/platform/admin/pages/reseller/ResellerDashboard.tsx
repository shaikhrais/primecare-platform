import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { fetchChildAgencies, provisionAgency } from './resellerHandlers';

const { ButtonRegistry } = AdminRegistry;

const ResellerDashboard: React.FC = () => {
    const [children, setChildren] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const [isProvisioning, setIsProvisioning] = useState(false);
    const { showToast } = useNotification();

    const [newTenant, setNewTenant] = useState({ name: '', slug: '', adminEmail: '', adminPassword: '' });

    const loadChildren = async () => { setIsLoading(true); setChildren(await fetchChildAgencies()); setIsLoading(false); };

    useEffect(() => { loadChildren(); }, []);

    const handleProvision = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsProvisioning(true);
        try {
            await provisionAgency(newTenant);
            showToast('Successfully provisioned new child agency!', 'success');
            setNewTenant({ name: '', slug: '', adminEmail: '', adminPassword: '' });
            loadChildren();
        } catch (e: any) {
            showToast(e.message || 'Provisioning failed', 'error');
        } finally { setIsProvisioning(false); }
    };

    const provisionBtn = getButtonById('btn-reseller-provision');

    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>
                    🏢
                </div>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }}>White-Label Reseller Hub</h1>
                    <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>Spawn and manage your child agencies in the Fractal SaaS network.</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: 'var(--text-300)' }}>Total Portfolio MRR</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: 'var(--brand-500)', marginTop: '8px' }}>$42,850</div>
                    <p style={{ fontSize: '12px', color: '#10B981', marginTop: '8px' }}>↑ 14% vs last month</p>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: 'var(--text-300)' }}>Franchise Success Rate</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: 'var(--text-100)', marginTop: '8px' }}>92.4%</div>
                    <p style={{ fontSize: '12px', color: 'var(--text-300)', marginTop: '8px' }}>Measured via Retention</p>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: 'var(--text-300)' }}>Provisioning Capacity</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: 'var(--text-100)', marginTop: '8px' }}>8 / 10</div>
                    <p style={{ fontSize: '12px', color: 'var(--text-300)', marginTop: '8px' }}>Available Slots</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 2fr) minmax(0, 1fr)', gap: '24px' }}>
                {/* Child Tenants List */}
                <div className="pc-card" style={{ overflow: 'hidden', padding: '0' }}>
                    <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span>Your Portfolio Agencies</span>
                        <span className="pc-badge primary">
                            {children.length} Active
                        </span>
                    </div>

                    <div style={{ padding: '0' }}>
                        {isLoading ? (
                            <div style={{ padding: '24px', textAlign: 'center', color: 'var(--text-300)' }}>Loading...</div>
                        ) : children.length === 0 ? (
                            <div style={{ padding: '48px 24px', textAlign: 'center', color: 'var(--text-300)' }}>
                                <p style={{ margin: '0 0 8px 0', fontSize: '16px', color: 'var(--text-100)', fontWeight: '500' }}>No child agencies yet</p>
                                <p style={{ margin: '0', fontSize: '14px' }}>Use the provisioning tool to spawn your first sub-tenant.</p>
                            </div>
                        ) : (
                            <table data-cy="table-admin.reseller-dashboard" style={{ width: '100%', borderCollapse: 'collapse' }}>
                                <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                                    <tr>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Agency Name</th>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Revenue Share</th>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Users</th>
                                        <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {children.map(child => (
                                        <tr key={child.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                            <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{child.name}</td>
                                            <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--brand-600)', fontWeight: '700' }}>{child.revenue}</td>
                                            <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-200)' }}>{child.usersCount || 0}</td>
                                            <td style={{ padding: '16px 24px' }}>
                                                <span className={`pc-badge ${child.status === 'active' ? 'primary' : 'secondary'}`}>
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
                <div className="pc-card" style={{ padding: '24px', height: 'fit-content' }}>
                    <h2 data-cy="h2-admin.reseller-dashboard-0" style={{ fontSize: '18px', fontWeight: '800', marginBottom: '24px', color: 'var(--text-100)' }}>Provision New Agency</h2>
                    <form data-cy="reseller.form-provision" onSubmit={handleProvision} style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                        <div className="pc-input-group">
                            <label className="pc-label">Agency Name</label>
                            <input
                                data-cy="reseller.inp-name"
                                required
                                className="pc-input"
                                value={newTenant.name}
                                onChange={e => setNewTenant({ ...newTenant, name: e.target.value })}
                                placeholder="e.g. Apex HomeCare"
                            />
                        </div>
                        <div className="pc-input-group">
                            <label className="pc-label">Routing Slug</label>
                            <input
                                data-cy="reseller.inp-slug"
                                required
                                className="pc-input"
                                value={newTenant.slug}
                                onChange={e => setNewTenant({ ...newTenant, slug: e.target.value })}
                                placeholder="apex-care"
                            />
                        </div>
                        <div style={{ height: '1px', backgroundColor: 'var(--border)', margin: '8px 0' }}></div>
                        <div className="pc-input-group">
                            <label className="pc-label">Admin Login Email</label>
                            <input
                                data-cy="reseller.inp-email"
                                required
                                type="email"
                                className="pc-input"
                                value={newTenant.adminEmail}
                                onChange={e => setNewTenant({ ...newTenant, adminEmail: e.target.value })}
                                placeholder="admin@apexcare.com"
                            />
                        </div>
                        <div className="pc-input-group">
                            <label className="pc-label">Temporary Password</label>
                            <input
                                data-cy="reseller.inp-password"
                                required
                                type="password"
                                minLength={8}
                                className="pc-input"
                                value={newTenant.adminPassword}
                                onChange={e => setNewTenant({ ...newTenant, adminPassword: e.target.value })}
                                placeholder="••••••••"
                            />
                        </div>

                        <button
                            type="submit"
                            disabled={isProvisioning}
                            className={`btn ${isProvisioning ? 'secondary' : 'primary'}`}
                            style={{ width: '100%' }}
                            data-cy="btn-reseller-provision"
                        >
                            {isProvisioning ? 'Spawning Instance...' : (provisionBtn?.label || 'Spawn Sub-Tenant')}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
};

export default ResellerDashboard;
