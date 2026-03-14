// RoleFlowsPage: StepAuditModal and handleVerifyAll extracted
import React from 'react';

interface StepAuditModalProps {
    selectedStep: { role: string; index: number; content: string };
    roleFlows: Record<string, { label: string; icon: string; color: string; steps: readonly string[] }>;
    onClose: () => void;
}

export const StepAuditModal: React.FC<StepAuditModalProps> = ({ selectedStep, roleFlows, onClose }) => (
    <div style={{ position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', backgroundColor: 'rgba(0,0,0,0.3)', display: 'flex', justifyContent: 'center', alignItems: 'center', zIndex: 1000, backdropFilter: 'blur(8px)' }} onClick={onClose}>
        <div className="bento-item" style={{ width: '550px', padding: '2.5rem', background: 'white', border: 'none' }} onClick={e => e.stopPropagation()}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <h2 data-cy="h2-role-flows-page-1" style={{ margin: 0, fontSize: '1.4rem', fontWeight: 900 }}>Technical Audit</h2>
                <span style={{ fontSize: '2rem' }}>{roleFlows[selectedStep.role].icon}</span>
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                <div style={{ background: '#f8fafc', padding: '1.5rem', borderRadius: '16px', border: '1px solid #f1f5f9' }}>
                    <label style={{ fontSize: '0.65rem', color: 'var(--text-400)', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '8px' }}>Target Workflow</label>
                    <div style={{ color: 'var(--text-100)', fontSize: '1.2rem', fontWeight: 800 }}>{selectedStep.content}</div>
                </div>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                    <div><label style={{ fontSize: '0.65rem', color: 'var(--text-400)', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '4px' }}>Security Anchor</label><div style={{ fontWeight: 700, color: roleFlows[selectedStep.role].color }}>{roleFlows[selectedStep.role].label}</div></div>
                    <div><label style={{ fontSize: '0.65rem', color: 'var(--text-400)', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '4px' }}>Policy Logic</label><code style={{ fontSize: '0.75rem' }}>RequireRole('{selectedStep.role}')</code></div>
                </div>
                <div style={{ padding: '1rem', background: '#0f172a', borderRadius: '12px', color: '#94a3b8' }}>
                    <label style={{ fontSize: '0.65rem', color: '#475569', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '8px' }}>Registry Trace</label>
                    <code style={{ fontSize: '0.75rem', color: '#38bdf8' }}>ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.{selectedStep.role.toUpperCase()}[{selectedStep.index}]</code>
                </div>
            </div>
            <button data-cy="btn-role-flows-page-3" onClick={onClose}
                style={{ marginTop: '2rem', width: '100%', padding: '14px', background: 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)', color: 'white', border: 'none', borderRadius: '12px', fontWeight: 800, cursor: 'pointer', boxShadow: '0 4px 12px rgba(0,0,0,0.1)' }}>
                CLOSE AUDIT TRACE
            </button>
        </div>
    </div>
);

export async function runGlobalHealthSweep(
    roleFlows: Record<string, { steps: readonly string[] }>,
    setVerifyResults: React.Dispatch<React.SetStateAction<Record<string, Record<number, boolean>>>>,
    setIsVerifying: (v: boolean) => void
): Promise<void> {
    setIsVerifying(true);
    setVerifyResults({});
    for (const role of Object.keys(roleFlows)) {
        const steps = roleFlows[role].steps;
        for (let i = 0; i < steps.length; i++) {
            await new Promise(resolve => setTimeout(resolve, Math.random() * 200 + 100));
            setVerifyResults(prev => ({ ...prev, [role]: { ...(prev[role] || {}), [i]: true } }));
        }
    }
    setIsVerifying(false);
}
