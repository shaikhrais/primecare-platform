import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface BrandingStepProps {
    config: any;
    setConfig: (config: any) => void;
    fileInputRef: React.RefObject<HTMLInputElement>;
    handleFileUpload: (event: React.ChangeEvent<HTMLInputElement>) => void;
    uploading: boolean;
}

export const BrandingStep: React.FC<BrandingStepProps> = ({
    config,
    setConfig,
    fileInputRef,
    handleFileUpload,
    uploading
}) => {
    return (
        <div style={{ animation: 'fadeIn 0.3s' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.STEPS.BRANDING}</h2>
            <div style={{ display: 'grid', gap: '1.5rem' }}>
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.BRANDING.EMAIL_LABEL}</label>
                    <input
                        type="email"
                        placeholder={ContentRegistry.STRATEGY_WIZARD.BRANDING.EMAIL_PLACEHOLDER}
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
                                {ContentRegistry.STRATEGY_WIZARD.BRANDING.LOGO_CHANGE}
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
                                {uploading ? ContentRegistry.STRATEGY_WIZARD.BRANDING.LOGO_UPLOADING : ContentRegistry.STRATEGY_WIZARD.BRANDING.LOGO_UPLOAD}
                            </button>
                            <p style={{ fontSize: '0.75rem', color: '#6b7280', marginTop: '0.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.BRANDING.LOGO_HINT}</p>
                        </>
                    )}
                </div>
            </div>
        </div>
    );
};
