// ================================================================
// PAGE IDENTITY: W4 � Revenue Wizard
// Registry ID:   page.admin.revenue-wizard
// Type:          Wizard
// Owner:         admin
// ================================================================
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useTranslation } from 'react-i18next';

const { RouteRegistry, ApiRegistry, ContentRegistry } = AdminRegistry;

export default function RevenueWizard() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);
    const [formData, setFormData] = useState({
        hourlyRate: 35,
        billingCycle: 'weekly',
        taxEnabled: true
    });

    const handleSaveRevenue = async () => {
        setLoading(true);
        try {
            const response = await apiClient.patch(ApiRegistry.ADMIN.SETTINGS_BUSINESS_MODEL, {
                globalMarkup: formData.hourlyRate,
                taxEnabled: formData.taxEnabled
            });
            if (response.ok) {
                showToast(ContentRegistry.REVENUE_WIZARD.SUCCESS, 'success');
                navigate(RouteRegistry.ADMIN.BUSINESS_STATUS);
            } else {
                showToast('Failed to save settings', 'error');
            }
        } catch (error) {
            showToast('Network error', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div data-cy="page.container" role="main" aria-label="Revenue" style={{ maxWidth: '800px', margin: '2rem auto', padding: '2.5rem', background: '#fff', borderRadius: '2rem', border: '1px solid #e5e7eb', boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)' }}>
            <div style={{ textAlign: 'center', marginBottom: '3rem' }}>
                <h1 data-cy="page.title" style={{ fontSize: '2rem', fontWeight: '900', color: '#111827', marginBottom: '0.5rem' }}>💰 {t(ContentRegistry.REVENUE_WIZARD.TITLE)}</h1>
                <p style={{ color: '#6b7280' }}>{t(ContentRegistry.REVENUE_WIZARD.SUBTITLE)}</p>
            </div>

            <div style={{ display: 'grid', gap: '2rem' }}>
                <div style={{ background: '#f9fafb', padding: '2rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb' }}>
                    <h2 data-cy="h2-admin.revenue-wizard-0" style={{ fontSize: '1.125rem', fontWeight: '800', marginBottom: '1.5rem', color: '#374151' }}>{t(ContentRegistry.REVENUE_WIZARD.ECONOMICS_TITLE)}</h2>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '700', marginBottom: '0.5rem' }}>{t(ContentRegistry.REVENUE_WIZARD.RATE_LABEL)}</label>
                        <div style={{ position: 'relative' }}>
                            <span style={{ position: 'absolute', left: '1rem', top: '50%', transform: 'translateY(-50%)', fontWeight: 'bold' }}>$</span>
                            <input data-cy="input-admin.revenue-wizard-0"
                                type="number"
                                value={formData.hourlyRate}
                                onChange={e => setFormData({ ...formData, hourlyRate: Number(e.target.value) })}
                                style={{ width: '100%', padding: '0.75rem 1rem 0.75rem 2rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                            />
                        </div>
                    </div>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '700', marginBottom: '0.5rem' }}>{t(ContentRegistry.REVENUE_WIZARD.CYCLE_LABEL)}</label>
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            {['weekly', 'bi-weekly', 'monthly'].map(cycle => (
                                <button data-cy="btn-admin.revenue-wizard-0"
                                    key={cycle}
                                    onClick={() => setFormData({ ...formData, billingCycle: cycle })}
                                    style={{
                                        flex: 1,
                                        padding: '0.75rem',
                                        borderRadius: '0.5rem',
                                        border: '1px solid',
                                        borderColor: formData.billingCycle === cycle ? '#004d40' : '#d1d5db',
                                        background: formData.billingCycle === cycle ? '#004d40' : 'white',
                                        color: formData.billingCycle === cycle ? 'white' : '#374151',
                                        fontWeight: '700',
                                        textTransform: 'capitalize',
                                        cursor: 'pointer'
                                    }}
                                >
                                    {cycle}
                                </button>
                            ))}
                        </div>
                    </div>
                </div>

                <div style={{ background: '#f0fdf4', padding: '2rem', borderRadius: '1.5rem', border: '1px solid #dcfce7', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div>
                        <h3 data-cy="h3-admin.revenue-wizard-0" style={{ fontWeight: '800', color: '#166534' }}>{t(ContentRegistry.REVENUE_WIZARD.TAX_TITLE)}</h3>
                        <p style={{ fontSize: '0.875rem', color: '#166534' }}>{t(ContentRegistry.REVENUE_WIZARD.TAX_DESC)}</p>
                    </div>
                    <label style={{ position: 'relative', display: 'inline-block', width: '50px', height: '26px' }}>
                        <input data-cy="input-admin.revenue-wizard-1"
                            type="checkbox"
                            checked={formData.taxEnabled}
                            onChange={e => setFormData({ ...formData, taxEnabled: e.target.checked })}
                            style={{ opacity: 0, width: 0, height: 0 }}
                        />
                        <span style={{
                            position: 'absolute',
                            cursor: 'pointer',
                            top: 0, left: 0, right: 0, bottom: 0,
                            backgroundColor: formData.taxEnabled ? '#004d40' : '#ccc',
                            transition: '0.4s',
                            borderRadius: '34px'
                        }}>
                            <span style={{
                                position: 'absolute',
                                content: '""',
                                height: '20px', width: '20px',
                                left: formData.taxEnabled ? '26px' : '4px',
                                bottom: '3px',
                                backgroundColor: 'white',
                                transition: '0.4s',
                                borderRadius: '50%'
                            }} />
                        </span>
                    </label>
                </div>
            </div>

            <div style={{ marginTop: '3rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <button data-cy="btn-admin.revenue-wizard-1" onClick={() => navigate(RouteRegistry.ADMIN.BUSINESS_STATUS)} style={{ color: '#6b7280', fontWeight: 'bold', border: 'none', background: 'none', cursor: 'pointer' }}>Skip setup</button>
                <button data-cy="btn-admin.revenue-wizard-2"
                    onClick={handleSaveRevenue}
                    disabled={loading}
                    style={{ padding: '0.875rem 3rem', background: '#004d40', color: 'white', fontWeight: '900', borderRadius: '1.25rem', border: 'none', cursor: 'pointer', boxShadow: '0 4px 14px 0 rgba(0,77,64,0.39)' }}
                >
                    {loading ? t(ContentRegistry.REVENUE_WIZARD.SAVING) : t(ContentRegistry.REVENUE_WIZARD.SUBMIT_BTN)}
                </button>
            </div>
        </div>
    );
}
