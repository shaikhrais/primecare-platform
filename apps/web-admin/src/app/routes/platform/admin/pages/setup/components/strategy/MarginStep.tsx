import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface MarginStepProps {
    config: any;
    setConfig: (config: any) => void;
}

export const MarginStep: React.FC<MarginStepProps> = ({ config, setConfig }) => {
    return (
        <div style={{ animation: 'fadeIn 0.3s' }}>
            <h2 data-cy="h2-admin.margin-step-0" style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '1.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.STEPS.MARGIN}</h2>
            <div style={{ display: 'grid', gap: '1.5rem' }}>
                <p style={{ color: '#6b7280', fontSize: '0.875rem' }}>
                    {ContentRegistry.STRATEGY_WIZARD.MARGIN.DESC}
                </p>
                <div style={{ padding: '2rem', background: '#f5f3ff', borderRadius: '1rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.875rem', color: '#4f46e5', fontWeight: '700', marginBottom: '0.5rem' }}>{ContentRegistry.STRATEGY_WIZARD.MARGIN.LABEL}</div>
                    <div style={{ fontSize: '3rem', fontWeight: '900', color: '#4338ca' }}>{config.globalMarkup}%</div>
                    <input data-cy="input-admin.margin-step-0"
                        type="range"
                        min="10"
                        max="60"
                        value={config.globalMarkup}
                        onChange={e => setConfig({ ...config, globalMarkup: parseInt(e.target.value) })}
                        style={{ width: '100%', marginTop: '1rem', accentColor: '#4f46e5' }}
                    />
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem', fontWeight: '500' }}>
                    <span style={{ color: '#6b7280' }}>{ContentRegistry.STRATEGY_WIZARD.MARGIN.LOW}</span>
                    <span style={{ color: '#4f46e5' }}>{ContentRegistry.STRATEGY_WIZARD.MARGIN.MID}</span>
                    <span style={{ color: '#6b7280' }}>{ContentRegistry.STRATEGY_WIZARD.MARGIN.HIGH}</span>
                </div>
            </div>
        </div>
    );
};
