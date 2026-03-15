// ================================================================
// PAGE IDENTITY: H9 — Reference Data Hub
// Registry ID:   page.admin.reference-data
// Type:          Hub
// Owner:         admin
// ================================================================
import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';
import { useDialog } from '@/shared/hooks/useDialog';

export default function ReferenceDataHub() {
    const { showToast } = useNotification();
    const { t } = useTranslation();
    const { prompt, DialogRenderer } = useDialog();
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

    const handleAddProvider = async () => {
        const name = await prompt('Add Insurance Provider', 'Enter the name of the new insurance provider.', { placeholder: 'e.g. Ontario Health Insurance' });
        if (!name) return;
        try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.post('/v1/admin/actions/reference-data/providers', { name }); } catch {}
        showToast(t('admin.insurance_form_opened', { defaultValue: 'Insurance provider form opened' }), 'info');
    };

    const handleEditProvider = async (p: typeof insuranceProviders[0]) => {
        const name = await prompt('Edit Insurance Provider', `Update the name for provider "${p.name}".`, { placeholder: 'Provider name', defaultValue: p.name });
        if (!name) return;
        try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.patch(`/v1/admin/actions/reference-data/providers/${p.id}`, { name }); } catch {}
        showToast(t('admin.editing_provider', { defaultValue: `Editing ${p.name}`, name: p.name }), 'info');
    };

    const handleAddBillingCode = async () => {
        const code = await prompt('Add Billing Code', 'Enter the new billing code identifier.', { placeholder: 'e.g. PSW-PC-90' });
        if (!code) return;
        try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.post('/v1/admin/actions/reference-data/billing-codes', { code }); } catch {}
        showToast(t('admin.billing_form_opened', { defaultValue: 'Billing code form opened' }), 'info');
    };

    const handleEditBillingCode = async (bc: typeof billingCodes[0]) => {
        const code = await prompt('Edit Billing Code', `Update the code for "${bc.code}".`, { placeholder: 'Billing code', defaultValue: bc.code });
        if (!code) return;
        try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.patch(`/v1/admin/actions/reference-data/billing-codes/${bc.id}`, { code }); } catch {}
        showToast(t('admin.editing_billing_code', { defaultValue: `Editing billing code ${bc.code}`, code: bc.code }), 'info');
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container" role="main" aria-label="Reference Data">
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>🏢</div>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">
                        {t('admin.reference_data_title', { defaultValue: 'Reference Data Management' })}
                    </h1>
                    <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>
                        {t('admin.reference_data_subtitle', { defaultValue: 'Manage insurance providers and billing code directories. These are used across claims, invoicing, and service rate calculations.' })}
                    </p>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '8px', marginBottom: '24px' }}>
                <button data-cy="btn-admin.reference-data-hub-0" className={`btn ${tab === 'insurance' ? 'primary' : 'secondary'}`} onClick={() => setTab('insurance')}>🏥 {t('admin.insurance_providers', { defaultValue: 'Insurance Providers' })}</button>
                <button data-cy="btn-admin.reference-data-hub-1" className={`btn ${tab === 'billing' ? 'primary' : 'secondary'}`} onClick={() => setTab('billing')}>💲 {t('admin.billing_codes', { defaultValue: 'Billing Codes' })}</button>
            </div>

            {tab === 'insurance' && (
                <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                    <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span>{t('admin.insurance_provider_directory', { defaultValue: 'Insurance Provider Directory' })}</span>
                        <button className="btn primary" data-cy="btn-add-provider" style={{ fontSize: '12px', padding: '6px 12px' }} onClick={handleAddProvider}>+ {t('admin.add_provider', { defaultValue: 'Add Provider' })}</button>
                    </div>
                    <table data-cy="table-admin.reference-data-hub" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                            <tr>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.provider_name', { defaultValue: 'Provider Name' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.code', { defaultValue: 'Code' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.contact', { defaultValue: 'Contact' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.status', { defaultValue: 'Status' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.actions', { defaultValue: 'Actions' })}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {insuranceProviders.map(p => (
                                <tr key={p.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{p.name}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)', fontFamily: 'monospace' }}>{p.code}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)' }}>{p.contactEmail}</td>
                                    <td style={{ padding: '16px 24px' }}><span style={{ color: p.status === 'active' ? '#10B981' : '#EF4444', fontWeight: '600', fontSize: '13px' }}>{p.status === 'active' ? `● ${t('admin.active', { defaultValue: 'Active' })}` : `○ ${t('admin.inactive', { defaultValue: 'Inactive' })}`}</span></td>
                                    <td style={{ padding: '16px 24px' }}><button className="btn secondary" data-cy={`btn-edit-provider-${p.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => handleEditProvider(p)}>{t('admin.edit', { defaultValue: 'Edit' })}</button></td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {tab === 'billing' && (
                <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                    <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span>{t('admin.billing_code_directory', { defaultValue: 'Billing Code Directory' })}</span>
                        <button className="btn primary" data-cy="btn-add-billing-code" style={{ fontSize: '12px', padding: '6px 12px' }} onClick={handleAddBillingCode}>+ {t('admin.add_billing_code', { defaultValue: 'Add Billing Code' })}</button>
                    </div>
                    <table data-cy="table-admin.reference-data-hub" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                            <tr>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.code', { defaultValue: 'Code' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.description', { defaultValue: 'Description' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.category', { defaultValue: 'Category' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.unit_rate', { defaultValue: 'Unit Rate' })}</th>
                                <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.actions', { defaultValue: 'Actions' })}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {billingCodes.map(bc => (
                                <tr key={bc.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--brand-500)', fontFamily: 'monospace' }}>{bc.code}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-100)' }}>{bc.description}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)' }}>{bc.category}</td>
                                    <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '800', color: '#10B981' }}>${bc.unitRate.toFixed(2)}</td>
                                    <td style={{ padding: '16px 24px' }}><button className="btn secondary" data-cy={`btn-edit-code-${bc.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => handleEditBillingCode(bc)}>{t('admin.edit', { defaultValue: 'Edit' })}</button></td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            <DialogRenderer />
        </div>
    );
}
