import React, { useState } from 'react';
import { ShieldAlert, KeyRound, Clock, AlertTriangle } from 'lucide-react';

interface JITProps {
    onElevate: (reason: string) => void;
    onCancel: () => void;
}

export const JITElevationModal: React.FC<JITProps> = ({ onElevate, onCancel }) => {
    const [justification, setJustification] = useState('');
    const [requesting, setRequesting] = useState(false);

    const handleSubmit = () => {
        if (justification.length < 15) return;
        setRequesting(true);
        onElevate(justification);
        setRequesting(false);
    };

    return (
        <div data-cy="modal-jit-elevation" style={{ position: 'fixed', top: 0, left: 0, right: 0, bottom: 0, backgroundColor: 'rgba(15, 23, 42, 0.85)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 10000, backdropFilter: 'blur(4px)' }}>
            <div style={{ backgroundColor: 'white', borderRadius: '16px', width: '100%', maxWidth: '450px', padding: '24px', boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)' }}>
                <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '16px', borderRadius: '50%' }}>
                        <ShieldAlert size={36} color="#DC2626" />
                    </div>
                </div>

                <h2 data-cy="h2-admin.j-i-t-elevation-modal-0" style={{ textAlign: 'center', margin: '0 0 8px 0', color: '#0F172A', fontSize: '1.25rem', fontWeight: 800 }}>High-Privilege Area</h2>
                <p style={{ textAlign: 'center', color: '#64748B', fontSize: '0.9rem', marginBottom: '24px', lineHeight: '1.5' }}>
                    You are requesting Just-In-Time (JIT) elevation into God-Mode. This action will be immutably logged to the Compliance Forensic Audit Trail.
                </p>

                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', marginBottom: '16px', border: '1px solid #E2E8F0' }}>
                    <Clock size={16} color="#475569" />
                    <span style={{ fontSize: '0.85rem', color: '#334155', fontWeight: 600 }}>Elevation Duration: <strong style={{ color: '#0F172A' }}>60 Minutes</strong></span>
                </div>

                <div style={{ marginBottom: '24px' }}>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#334155', marginBottom: '8px' }}>
                        Required Justification (min 15 chars)
                    </label>
                    <textarea 
                        data-cy="jit.inp-justification"
                        value={justification}
                        onChange={(e) => setJustification(e.target.value)}
                        placeholder="e.g., Investigating critical payroll discrepancy for worker psw_882..."
                        style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.9rem', minHeight: '80px', resize: 'none', fontFamily: 'inherit' }}
                    />
                    {justification.length > 0 && justification.length < 15 && (
                        <div style={{ fontSize: '0.75rem', color: '#DC2626', marginTop: '6px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                            <AlertTriangle size={12} /> Justification too short.
                        </div>
                    )}
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="jit.btn-cancel" onClick={onCancel} style={{ flex: 1, padding: '12px', backgroundColor: 'transparent', border: '1px solid #CBD5E1', borderRadius: '8px', color: '#475569', fontWeight: 600, cursor: 'pointer' }}>
                        Cancel Let Me Out
                    </button>
                    <button 
                        data-cy="jit.btn-elevate"
                        onClick={handleSubmit} 
                        disabled={justification.length < 15 || requesting}
                        style={{ 
                            flex: 1, padding: '12px', backgroundColor: '#DC2626', border: 'none', borderRadius: '8px', 
                            color: 'white', fontWeight: 700, cursor: (justification.length < 15 || requesting) ? 'not-allowed' : 'pointer', 
                            display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px',
                            opacity: (justification.length < 15 || requesting) ? 0.7 : 1
                        }}
                    >
                        {requesting ? <div className="spinner" /> : <KeyRound size={18} />}
                        {requesting ? 'Provisioning...' : 'Request Elevation'}
                    </button>
                    <style>{`.spinner { width: 16px; height: 16px; border: 2px solid rgba(255,255,255,0.3); border-radius: 50%; border-top-color: white; animation: spin 1s ease-in-out infinite; } @keyframes spin { to { transform: rotate(360deg); } }`}</style>
                </div>
            </div>
        </div>
    );
};
