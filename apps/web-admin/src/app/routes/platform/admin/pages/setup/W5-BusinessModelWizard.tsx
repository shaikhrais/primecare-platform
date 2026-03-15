// ================================================================
// PAGE IDENTITY: W5 � Business Model Wizard
// Registry ID:   page.admin.biz-model
// Type:          Wizard
// Owner:         admin
// ================================================================
import React, { useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { useMutation } from '@tanstack/react-query';

// Components
import { BrandingStep } from './components/strategy/BrandingStep';
import { ComplianceStep } from './components/strategy/ComplianceStep';
import { MarginStep } from './components/strategy/MarginStep';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function BusinessModelWizard() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const fileInputRef = useRef<HTMLInputElement>(null);
    const [step, setStep] = useState(1);

    // Form Data
    const [config, setConfig] = useState({
        businessName: 'PrimeCare Branch',
        supportEmail: '',
        businessNumber: '',
        taxEnabled: true,
        globalMarkup: 30, // Default 30% margin
        logoUrl: '',
    });

    const logoMutation = useMutation({
        mutationFn: async (formData: FormData) => {
            const res = await apiClient.post('/v1/admin/settings/logo', formData);
            if (!res.ok) throw new Error('Upload failed');
            return res.json();
        },
        onSuccess: (data: any) => {
            setConfig({ ...config, logoUrl: data.logoUrl });
            showToast(ContentRegistry.STRATEGY_WIZARD.MESSAGES.SUCCESS_LOGO, 'success');
        },
        onError: () => { showToast(ContentRegistry.STRATEGY_WIZARD.MESSAGES.ERROR_LOGO, 'error'); },
    });

    const uploading = logoMutation.isPending;

    const handleFileUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
        const file = event.target.files?.[0];
        if (!file) return;
        if (file.size > 2 * 1024 * 1024) {
            showToast(ContentRegistry.STRATEGY_WIZARD.BRANDING.LOGO_ERROR_SIZE, 'error');
            return;
        }
        const formData = new FormData();
        formData.append('file', file);
        logoMutation.mutate(formData);
    };

    const saveMutation = useMutation({
        mutationFn: async (data: any) => {
            const res = await apiClient.patch('/v1/admin/settings/business-model', data);
            if (!res.ok) throw new Error('Save failed');
            return res.json();
        },
        onSuccess: () => {
            showToast(ContentRegistry.STRATEGY_WIZARD.MESSAGES.SUCCESS_SAVE, 'success');
            if (step < 3) setStep(step + 1);
            else navigate(RouteRegistry.ADMIN.WIZARD_HUB);
        },
        onError: () => { showToast(ContentRegistry.STRATEGY_WIZARD.MESSAGES.ERROR_SAVE, 'error'); },
    });

    const loading = saveMutation.isPending;

    const handleSave = () => saveMutation.mutate(config);

    return (
        <div data-cy="page.container" style={{ maxWidth: '800px', margin: '2rem auto', padding: '2rem', background: 'white', borderRadius: '1.5rem', border: '1px solid #e5e7eb' }}>
            <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
                <h1 data-cy="page.title" style={{ fontSize: '2rem', fontWeight: '800', color: '#111827', marginBottom: '0.5rem' }}>🚀 {ContentRegistry.STRATEGY_WIZARD.TITLE}</h1>
                <p style={{ color: '#6b7280' }}>{ContentRegistry.STRATEGY_WIZARD.SUBTITLE}</p>
            </div>

            <div style={{ marginBottom: '2.5rem', display: 'flex', gap: '0.75rem' }}>
                {[1, 2, 3].map(s => (
                    <div key={s} style={{ flex: 1, height: '6px', background: s <= step ? '#4f46e5' : '#e5e7eb', borderRadius: '3px' }} />
                ))}
            </div>

            {step === 1 && (
                <BrandingStep
                    config={config}
                    setConfig={setConfig}
                    fileInputRef={fileInputRef}
                    handleFileUpload={handleFileUpload}
                    uploading={uploading}
                />
            )}

            {step === 2 && (
                <ComplianceStep config={config} setConfig={setConfig} />
            )}

            {step === 3 && (
                <MarginStep config={config} setConfig={setConfig} />
            )}

            <div style={{ marginTop: '3rem', display: 'flex', gap: '1rem' }}>
                <button data-cy="btn-admin.business-model-wizard-0"
                    onClick={() => step > 1 ? setStep(step - 1) : navigate(RouteRegistry.ADMIN.WIZARD_HUB)}
                    style={{ flex: 1, padding: '1rem', background: 'white', border: '1px solid #d1d5db', borderRadius: '1rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    {step === 1 ? ContentRegistry.STRATEGY_WIZARD.BUTTONS.CANCEL : ContentRegistry.STRATEGY_WIZARD.BUTTONS.BACK}
                </button>
                <button data-cy="btn-admin.business-model-wizard-1"
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
                    {loading ? ContentRegistry.STRATEGY_WIZARD.BUTTONS.PROCESSING : (step === 3 ? ContentRegistry.STRATEGY_WIZARD.BUTTONS.COMPLETE : ContentRegistry.STRATEGY_WIZARD.BUTTONS.SAVE_CONTINUE)}
                </button>
            </div>
        </div>
    );
}
