// ================================================================
// PAGE IDENTITY: W3 · Care Plan Wizard
// Type: Wizard | Owner: admin
// ================================================================
import React, { useState } from 'react';

const STEPS = ['Client Selection','Goals','Interventions','Schedule','Review'];

export default function CarePlanWizard() {
    const [step, setStep] = useState(0);
    return (
        <div role="main" aria-label="Care Plan" data-cy="W3-page" style={{ padding: '24px', maxWidth: '800px', margin: '0 auto' }}>
            <div style={{ marginBottom: '28px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>📋 Care Plan Wizard</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Step {step + 1} of {STEPS.length}: {STEPS[step]}</p>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '4px', marginBottom: '32px', flexWrap: 'wrap' }}>
                {STEPS.map((s, i) => (
                    <React.Fragment key={i}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }} onClick={() => setStep(i)}>
                            <div style={{ width: '32px', height: '32px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.8rem', fontWeight: 700, background: step >= i ? '#5B21B6' : '#E2E8F0', color: step >= i ? 'white' : '#94A3B8' }}>{i + 1}</div>
                            <span style={{ fontSize: '0.8rem', fontWeight: step === i ? 700 : 400, color: step >= i ? '#0F172A' : '#94A3B8' }}>{s}</span>
                        </div>
                        {i < STEPS.length - 1 && <div style={{ width: '40px', height: '2px', background: step > i ? '#5B21B6' : '#E2E8F0' }} />}
                    </React.Fragment>
                ))}
            </div>
            <div style={{ background: 'white', borderRadius: '12px', padding: '32px', border: '1px solid #E2E8F0', minHeight: '300px', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: '24px' }}>
                <div style={{ textAlign: 'center', color: '#94A3B8' }}>
                    <div style={{ fontSize: '3rem', marginBottom: '12px' }}>📋</div>
                    <div style={{ fontSize: '1.1rem', fontWeight: 600, color: '#0F172A' }}>{STEPS[step]}</div>
                    <div style={{ fontSize: '0.85rem', marginTop: '4px' }}>Wizard step content renders here</div>
                </div>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                <button data-cy="btn-admin.care-plan-wizard-0" onClick={() => setStep(Math.max(0, step - 1))} disabled={step === 0} style={{ padding: '10px 24px', borderRadius: '8px', border: '1px solid #CBD5E1', background: 'white', color: step === 0 ? '#CBD5E1' : '#334155', fontWeight: 600, cursor: step === 0 ? 'default' : 'pointer' }}>← Back</button>
                <button data-cy="btn-admin.care-plan-wizard-1" onClick={() => setStep(Math.min(STEPS.length - 1, step + 1))} style={{ padding: '10px 24px', borderRadius: '8px', border: 'none', background: step === STEPS.length - 1 ? '#059669' : '#5B21B6', color: 'white', fontWeight: 700, cursor: 'pointer' }}>{step === STEPS.length - 1 ? '✓ Complete' : 'Next →'}</button>
            </div>
        </div>
    );
}
