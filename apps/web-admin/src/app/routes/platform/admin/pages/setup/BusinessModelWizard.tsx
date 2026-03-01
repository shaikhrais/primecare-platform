import React, { useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function BusinessModelWizard() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const fileInputRef = useRef<HTMLInputElement>(null);
    const [step, setStep] = useState(1);
    const [loading, setLoading] = useState(false);
    const [uploading, setUploading] = useState(false);

    // Form Data
    const [config, setConfig] = useState({
        businessName: 'PrimeCare Branch',
        supportEmail: '',
        businessNumber: '',
        taxEnabled: true,
        globalMarkup: 30, // Default 30% margin
        logoUrl: '',
    });

    const handleFileUpload = async (event: React.ChangeEvent<HTMLInputElement>) => {
        const file = event.target.files?.[0];
        if (!file) return;

        if (file.size > 2 * 1024 * 1024) {
            showToast('Logo must be smaller than 2MB', 'error');
            return;
        }

        setUploading(true);
        const formData = new FormData();
        formData.append('file', file);

        try {
            const response = await apiClient.post('/v1/admin/settings/logo', formData);
            if (response.ok) {
                const data = await response.json();
                setConfig({ ...config, logoUrl: data.logoUrl });
                showToast('Logo uploaded successfully!', 'success');
            } else {
                showToast('Failed to upload logo', 'error');
            }
        } catch (error) {
            showToast('Error uploading logo', 'error');
        } finally {
            setUploading(false);
        }
    };

    const handleSave = async () => {
        setLoading(true);
        try {
            const response = await apiClient.patch('/v1/admin/settings/business-model', config);
            if (response.ok) {
                showToast('Business Strategy saved!', 'success');
                if (step < 3) setStep(step + 1);
                else navigate(RouteRegistry.WIZARD_HUB);
            } else {
                showToast('Failed to save settings', 'error');
            }
        } catch (error) {
            showToast('Error connecting to server', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '2rem auto', padding: '2rem', background: 'white', borderRadius: '1.5rem', border: '1px solid #e5e7eb' }}>
            <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
                <h1 style={{ fontSize: '2rem', fontWeight: '800', color: '#111827', marginBottom: '0.5rem' }}>🚀 Business Strategy Wizard</h1>
                <p style={{ color: '#6b7280' }}>Define your core business parameters and margins.</p>
            </div>

            <div style={{ marginBottom: '2.5rem', display: 'flex', gap: '0.75rem' }}>
                {[1, 2, 3].map(s => (
                    <div key={s} style={{ flex: 1, height: '6px', background: s <= step ? '#4f46e5' : '#e5e7eb', borderRadius: '3px' }} />
                ))}
            </div>

            {step === 1 && (
                <div style={{ animation: 'fadeIn 0.3s' }}>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 1: Branding & Identity</h2>
                    <div style={{ display: 'grid', gap: '1.5rem' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Public Support Email</label>
                            <input
                                type="email"
                                placeholder="support@yourcare.com"
                                value={config.supportEmail}
                                onChange={e => setConfig({ ...config, supportEmail: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                            />
                        </div>
                        <div style={{ border: '2px dashed #e5e7eb', padding: '2rem', textAlign: 'center', borderRadius: '1rem', position: 'relative' }}>
                            <input
                                type="file"
                                ref={fileInputRef}
                                style={{ display: 'none' }}
                                accept="image/png, image/svg+xml"
                                onChange={handleFileUpload}
                            />
                            {config.logoUrl ? (
                                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '1rem' }}>
                                    <div style={{ width: '64px', height: '64px', background: '#f3f4f6', borderRadius: '0.5rem', display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden' }}>
                                        <img src={config.logoUrl} alt="Logo Preview" style={{ maxWidth: '100%', maxHeight: '100%' }} />
                                    </div>
                                    <button
                                        onClick={() => fileInputRef.current?.click()}
                                        style={{ color: '#4f46e5', fontWeight: 'bold', background: 'none', border: 'none', cursor: 'pointer' }}
                                    >
                                        Change Logo
                                    </button>
                                </div>
                            ) : (
                                <>
                                    <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>{uploading ? '⌛' : '🖼️'}</div>
                                    <button
                                        onClick={() => fileInputRef.current?.click()}
                                        disabled={uploading}
                                        style={{ color: '#4f46e5', fontWeight: 'bold', background: 'none', border: 'none', cursor: 'pointer' }}
                                    >
                                        {uploading ? 'Uploading...' : 'Upload Business Logo'}
                                    </button>
                                    <p style={{ fontSize: '0.75rem', color: '#6b7280', marginTop: '0.5rem' }}>PNG or SVG, Max 2MB</p>
                                </>
                            )}
                        </div>
                    </div>
                </div>
            )}

            {step === 2 && (
                <div style={{ animation: 'fadeIn 0.3s' }}>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 2: Tax & Legal Compliance</h2>
                    <div style={{ display: 'grid', gap: '1.5rem' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Business Registration Number (BN)</label>
                            <input
                                placeholder="e.g. 12345 6789 RT0001"
                                value={config.businessNumber}
                                onChange={e => setConfig({ ...config, businessNumber: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem' }}
                            />
                        </div>
                        <label style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', background: '#f9fafb', borderRadius: '0.75rem', cursor: 'pointer' }}>
                            <input
                                type="checkbox"
                                checked={config.taxEnabled}
                                onChange={e => setConfig({ ...config, taxEnabled: e.target.checked })}
                                style={{ width: '1.25rem', height: '1.25rem' }}
                            />
                            <div>
                                <div style={{ fontWeight: '600' }}>Automatically apply HST/GST to invoices</div>
                                <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Based on your primary business location settings.</div>
                            </div>
                        </label>
                    </div>
                </div>
            )}

            {step === 3 && (
                <div style={{ animation: 'fadeIn 0.3s' }}>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>Step 3: Profit Margin Strategy</h2>
                    <div style={{ display: 'grid', gap: '1.5rem' }}>
                        <p style={{ color: '#6b7280', fontSize: '0.875rem' }}>
                            Set your target gross margin. This helps calculate what you pay providers versus what you charge clients.
                        </p>
                        <div style={{ padding: '2rem', background: '#f5f3ff', borderRadius: '1rem', textAlign: 'center' }}>
                            <div style={{ fontSize: '0.875rem', color: '#4f46e5', fontWeight: '700', marginBottom: '0.5rem' }}>TARGET MARGIN</div>
                            <div style={{ fontSize: '3rem', fontWeight: '900', color: '#4338ca' }}>{config.globalMarkup}%</div>
                            <input
                                type="range"
                                min="10"
                                max="60"
                                value={config.globalMarkup}
                                onChange={e => setConfig({ ...config, globalMarkup: parseInt(e.target.value) })}
                                style={{ width: '100%', marginTop: '1rem', accentColor: '#4f46e5' }}
                            />
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem', fontWeight: '500' }}>
                            <span style={{ color: '#6b7280' }}>Lean (10%)</span>
                            <span style={{ color: '#4f46e5' }}>Industry Standard (30%)</span>
                            <span style={{ color: '#6b7280' }}>Premium (60%)</span>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginTop: '3rem', display: 'flex', gap: '1rem' }}>
                <button
                    onClick={() => step > 1 ? setStep(step - 1) : navigate(RouteRegistry.WIZARD_HUB)}
                    style={{ flex: 1, padding: '1rem', background: 'white', border: '1px solid #d1d5db', borderRadius: '1rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    {step === 1 ? 'Cancel' : 'Back'}
                </button>
                <button
                    onClick={handleSave}
                    disabled={loading || uploading}
                    style={{
                        flex: 2,
                        padding: '1rem',
                        background: '#4f46e5',
                        color: 'white',
                        border: 'none',
                        borderRadius: '1rem',
                        fontWeight: 'bold',
                        cursor: 'pointer',
                        boxShadow: '0 4px 6px -1px rgba(79, 70, 229, 0.2)',
                        opacity: (loading || uploading) ? 0.7 : 1
                    }}
                >
                    {loading ? 'Processing...' : (step === 3 ? 'Complete Setup' : 'Save & Continue')}
                </button>
            </div>
        </div>
    );
}
