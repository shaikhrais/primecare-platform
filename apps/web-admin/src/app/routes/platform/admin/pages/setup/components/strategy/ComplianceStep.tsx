import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface ComplianceStepProps {
    config: any;
    setConfig: (config: any) => void;
}

export const ComplianceStep: React.FC<ComplianceStepProps> = ({ config, setConfig }) => {
    return (
        <div style={{ animation: 'fadeIn 0.3s' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.STEPS.COMPLIANCE}</h2>
            <div style={{ display: 'grid', gap: '1.5rem' }}>
                <div>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.COMPLIANCE.BN_LABEL}</label>
                    <input
                        placeholder={ContentRegistry.STRATEGY_WIZARD.COMPLIANCE.BN_PLACEHOLDER}
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
                        <div style={{ fontWeight: '600' }}>{ContentRegistry.STRATEGY_WIZARD.COMPLIANCE.TAX_LABEL}</div>
                        <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>{ContentRegistry.STRATEGY_WIZARD.COMPLIANCE.TAX_DESC}</div>
                    </div>
                </label>
            </div>
        </div>
    );
};
