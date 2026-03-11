import React, { useState } from 'react';
import { Lock, Server, Save, CheckCircle2 } from 'lucide-react';

export const BYOKVault: React.FC = () => {
    const [kmsArn, setKmsArn] = useState('arn:aws:kms:us-east-1:123456789012:key/mock-default-key-id');
    const [saving, setSaving] = useState(false);
    const [saved, setSaved] = useState(false);

    const handleSave = () => {
        setSaving(true);
        setSaved(false);
        // Simulate validating the KMS key and re-encrypting the tenant DB payload
        setTimeout(() => {
            setSaving(false);
            setSaved(true);
            setTimeout(() => setSaved(false), 3000);
        }, 1500);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', maxWidth: '600px', marginBottom: '24px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '16px' }}>
                <div style={{ backgroundColor: '#F1F5F9', padding: '12px', borderRadius: '8px' }}>
                    <Server size={24} color="#0F172A" />
                </div>
                <div>
                    <h3 style={{ margin: 0, color: '#0F172A', fontSize: '1.1rem', fontWeight: 800 }}>Bring-Your-Own-Key (BYOK)</h3>
                    <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.85rem' }}>Enterprise Tenant Database Encryption</p>
                </div>
            </div>

            <p style={{ color: '#475569', fontSize: '0.9rem', lineHeight: '1.5', marginBottom: '24px' }}>
                By default, your tenant data is encrypted at rest using PrimeCare's master keys. 
                Enter your AWS Key Management Service (KMS) ARN to assume full cryptographic control over your data partition.
            </p>

            <div style={{ marginBottom: '16px' }}>
                <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#334155', marginBottom: '8px' }}>
                    AWS KMS ARN String
                </label>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', backgroundColor: '#F8FAFC', padding: '8px', borderRadius: '8px', border: '1px solid #CBD5E1' }}>
                    <Lock size={16} color="#64748B" style={{ marginLeft: '8px' }} />
                    <input 
                        type="text" 
                        value={kmsArn}
                        onChange={(e) => setKmsArn(e.target.value)}
                        placeholder="arn:aws:kms:us-east-1:..."
                        style={{ flex: 1, backgroundColor: 'transparent', border: 'none', outline: 'none', color: '#0F172A', fontSize: '0.9rem', fontFamily: 'monospace' }}
                    />
                </div>
            </div>

            <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: '12px' }}>
                {saved && <span style={{ color: '#10B981', fontSize: '0.85rem', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '4px' }}><CheckCircle2 size={16} /> Key Verified & Activated</span>}
                <button 
                    onClick={handleSave}
                    disabled={saving || !kmsArn.includes('arn:')}
                    style={{ 
                        display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 20px', 
                        backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', 
                        fontWeight: 700, cursor: saving ? 'not-allowed' : 'pointer', opacity: saving ? 0.7 : 1 
                    }}
                >
                    {saving ? <div className="spinner" /> : <Save size={16} />}
                    {saving ? 'Validating KMS Interop...' : 'Save & Encrypt Partition'}
                </button>
                <style>{`.spinner { width: 14px; height: 14px; border: 2px solid rgba(255,255,255,0.3); border-radius: 50%; border-top-color: white; animation: spin 1s ease-in-out infinite; }`}</style>
            </div>
        </div>
    );
};
