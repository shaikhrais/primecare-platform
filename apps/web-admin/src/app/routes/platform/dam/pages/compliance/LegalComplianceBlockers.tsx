import React, { useState } from 'react';
import { ShieldCheck, Plus, Settings, AlertTriangle, FileSignature, AlertOctagon, RefreshCcw } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useNotification } from '@/shared/context/NotificationContext';

interface ComplianceRule {
    id: string;
    targetFormOrRoute: string;
    requiredComponent: string;
    region: 'GLOBAL' | 'US_NY' | 'CA_ON' | 'UK_ENG';
    isActive: boolean;
}

export const LegalComplianceBlockers: React.FC = () => {
    const [rules, setRules] = useState<ComplianceRule[]>([
        { id: '1', targetFormOrRoute: '/forms/patient-onboarding', requiredComponent: '<BiometricSignaturePad />', region: 'GLOBAL', isActive: true },
        { id: '2', targetFormOrRoute: '/forms/telehealth-consent', requiredComponent: '<HipaaDisclaimerCheckbox />', region: 'US_NY', isActive: true },
        { id: '3', targetFormOrRoute: '/forms/caregiver-contract', requiredComponent: '<UnionAddendumModal />', region: 'CA_ON', isActive: false }
    ]);
    const { showToast } = useNotification();

    const toggleRuleActive = (id: string) => {
        setRules(prev => prev.map(r => r.id === id ? { ...r, isActive: !r.isActive } : r));
    };

    const saveMutation = useApiMutation('/platform/admin/dam/compliance/blockers', {
        onSuccess: () => { showToast('Compliance blockers successfully enforced on the UI routing layer.', 'success'); },
        onError: () => { showToast('Failed to lock down legal paths', 'error'); },
    });

    const isSaving = saveMutation.isPending;

    const handleSave = () => saveMutation.mutate({ rules });

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '10px', borderRadius: '8px' }}>
                        <ShieldCheck size={24} color="#DC2626" />
                    </div>
                    <div>
                        <h3 data-cy="h3-legal-compliance-blockers-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Legal Compliance Blockers</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Force specific components to be mandatory before users can submit regional documents.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-add-blocker-rule" style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <Plus size={16} color="#DC2626" /> Add Blocker Rule
                    </button>
                    <button 
                        data-cy="btn-enforce-compliance"
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#DC2626', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <AlertTriangle size={16} /> {isSaving ? 'Enforcing...' : 'Enforce Requirements'}
                    </button>
                </div>
            </div>

            <table data-cy="table-legal-compliance-blockers" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem', marginBottom: '24px' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, width: '40px' }}>State</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Target View / Route</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Mandatory React Component</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Jurisdiction</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {rules.map(rule => (
                        <tr key={rule.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: rule.isActive ? 'white' : '#F8FAFC', opacity: rule.isActive ? 1 : 0.6 }}>
                            <td style={{ padding: '12px', textAlign: 'center' }}>
                                <input 
                                    data-cy={`compliance-rule-${rule.id}`}
                                    type="checkbox" 
                                    checked={rule.isActive}
                                    onChange={() => toggleRuleActive(rule.id)}
                                    style={{ cursor: 'pointer', transform: 'scale(1.2)' }}
                                />
                            </td>
                            <td style={{ padding: '12px', fontFamily: 'monospace', color: '#0F172A', fontWeight: 600 }}>
                                {rule.targetFormOrRoute}
                            </td>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#DC2626', fontWeight: 700, fontFamily: 'monospace' }}>
                                    <FileSignature size={16} /> {rule.requiredComponent}
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                {rule.region === 'GLOBAL' && <span style={{ backgroundColor: '#1E293B', color: 'white', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700 }}>GLOBAL</span>}
                                {rule.region !== 'GLOBAL' && <span style={{ backgroundColor: '#EFF6FF', color: '#3B82F6', border: '1px solid #BFDBFE', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700 }}>REGION: {rule.region}</span>}
                            </td>
                            <td style={{ padding: '12px', textAlign: 'right' }}>
                                <button data-cy={`btn-settings-rule-${rule.id}`} style={{ background: 'transparent', border: 'none', color: '#94A3B8', cursor: 'pointer' }}><Settings size={18} /></button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div style={{ backgroundColor: '#FFFBEB', border: '1px solid #FDE68A', borderRadius: '8px', padding: '16px', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                <AlertOctagon size={24} color="#D97706" style={{ flexShrink: 0 }} />
                <div style={{ fontSize: '0.85rem', color: '#92400E', lineHeight: 1.5 }}>
                    <strong>Warning: Enforcing Hard Blockers</strong><br/>
                    When a rule is active, the React rendering engine will artificially disable the primary "Submit" or "Save" button on the target route until the user interacts with the Mandatory Component (e.g., providing a physical signature or checking a HIPAA consent box). Removing a component from the codebase while it is marked as a mandatory blocker will cause a catastrophic build failure.
                </div>
            </div>
        </div>
    );
};
