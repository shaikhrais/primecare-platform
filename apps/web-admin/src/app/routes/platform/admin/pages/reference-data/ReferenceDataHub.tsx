import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';

export default function ReferenceDataHub() {
    const { showToast } = useNotification();
    const [tab, setTab] = useState<'insurance' | 'billing'>('insurance');
    const [insuranceProviders] = useState([
        { id: '1', name: 'BlueCross Ontario', code: 'BCBS-ON', contactEmail: 'claims@bluecross.on.ca', status: 'active' },
        { id: '2', name: 'Sun Life Financial', code: 'SLF', contactEmail: 'homecare@sunlife.ca', status: 'active' },
        { id: '3', name: 'Manulife Health', code: 'MAN-HC', contactEmail: 'provider@manulife.ca', status: 'inactive' },
    ]);
    const [billingCodes] = useState([
        { id: '1', code: 'PSW-PC-60', description: 'Personal Care — 60 min visit', unitRate: 42.50, category: 'Personal Care' },
        { id: '2', code: 'PSW-HM-60', description: 'Homemaking — 60 min visit', unitRate: 38.00, category: 'Homemaking' },
        { id: '3', code: 'RN-ASSESS', description: 'RN Clinical Assessment', unitRate: 85.00, category: 'Nursing' },
        { id: '4', code: 'PSW-RESP-8H', description: 'Respite Care — 8 hour shift', unitRate: 280.00, category: 'Respite' },
    ]);

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>🏢</div>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">Reference Data Management</h1>
                    <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>Manage insurance providers and billing code directories. These are used across claims, invoicing, and service rate calculations.</p>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '8px', marginBottom: '24px' }}>
                <button className={`btn ${tab === 'insurance' ? 'primary' : 'secondary'}`} onClick={() => setTab('insurance')}>🏥 Insurance Providers</button>
                <button className={`btn ${tab === 'billing' ? 'primary' : 'secondary'}`} onClick={() => setTab('billing')}>💲 Billing Codes</button>
            </div>

            {tab === 'insurance' && (
                <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                    <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span>Insurance Provider Directory</span>
                        <button className="btn primary" data-cy="btn-add-provider" style={{ fontSize: '12px', padding: '6px 12px' }} onClick={() => showToast('Insurance provider form opened', 'info')}>+ Add Provider</button>
                    </div>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                            <tr>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Provider Name</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Code</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Contact</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {insuranceProviders.map(p => (
                                <tr key={p.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{p.name}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)', fontFamily: 'monospace' }}>{p.code}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)' }}>{p.contactEmail}</td>
                                    <td style={{ padding: '16px 24px' }}><span style={{ color: p.status === 'active' ? '#10B981' : '#EF4444', fontWeight: '600', fontSize: '13px' }}>{p.status === 'active' ? '● Active' : '○ Inactive'}</span></td>
                                    <td style={{ padding: '16px 24px' }}><button className="btn secondary" data-cy={`btn-edit-provider-${p.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(`Editing ${p.name}`, 'info')}>Edit</button></td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {tab === 'billing' && (
                <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                    <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span>Billing Code Directory</span>
                        <button className="btn primary" data-cy="btn-add-billing-code" style={{ fontSize: '12px', padding: '6px 12px' }} onClick={() => showToast('Billing code form opened', 'info')}>+ Add Billing Code</button>
                    </div>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                            <tr>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Code</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Description</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Category</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Unit Rate</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {billingCodes.map(bc => (
                                <tr key={bc.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--brand-500)', fontFamily: 'monospace' }}>{bc.code}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-100)' }}>{bc.description}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)' }}>{bc.category}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '800', color: '#10B981' }}>${bc.unitRate.toFixed(2)}</td>
                                    <td style={{ padding: '16px 24px' }}><button className="btn secondary" data-cy={`btn-edit-code-${bc.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(`Editing billing code ${bc.code}`, 'info')}>Edit</button></td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}
        </div>
    );
}
