import React, { useState } from 'react';
import { AlertTriangle } from 'lucide-react';

interface DangerZoneModalProps {
    isOpen: boolean;
    onClose: () => void;
    onConfirm: () => void;
    title: string;
    description: string;
    targetEntityName: string; // The exact string they must type
}

export const DangerZoneModal: React.FC<DangerZoneModalProps> = ({ isOpen, onClose, onConfirm, title, description, targetEntityName }) => {
    const [inputValue, setInputValue] = useState('');
    
    if (!isOpen) return null;

    const isMatch = inputValue === targetEntityName;

    return (
        <div style={{
            position: 'fixed', inset: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.8)',
            backdropFilter: 'blur(4px)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            zIndex: 99999
        }}>
            <div style={{ backgroundColor: 'white', borderTop: '8px solid #EF4444', borderRadius: '12px', padding: '32px', maxWidth: '500px', width: '100%', boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)', animation: 'pop-in 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275)' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '24px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '16px', borderRadius: '50%' }}>
                        <AlertTriangle size={32} color="#DC2626" />
                    </div>
                    <div>
                        <h2 data-cy="h2-shared.danger-zone-modal-0" style={{ fontSize: '1.5rem', fontWeight: 900, color: '#0F172A', margin: 0 }}>{title}</h2>
                        <div style={{ color: '#EF4444', fontWeight: 700, fontSize: '0.85rem', textTransform: 'uppercase', letterSpacing: '1px' }}>Irreversible Action</div>
                    </div>
                </div>

                <div style={{ color: '#475569', fontSize: '0.95rem', lineHeight: '1.6', marginBottom: '24px' }}>
                    {description}
                </div>

                <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '32px' }}>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#334155', marginBottom: '8px' }}>
                        To confirm this catastrophic action, please type <span style={{ backgroundColor: '#FEE2E2', color: '#B91C1C', padding: '2px 4px', borderRadius: '4px', border: '1px solid #FECACA', fontFamily: 'monospace' }}>{targetEntityName}</span> below:
                    </label>
                    <input data-cy="input-shared.danger-zone-modal-0" 
                        type="text"
                        value={inputValue}
                        onChange={e => setInputValue(e.target.value)}
                        placeholder={targetEntityName}
                        style={{ width: '100%', padding: '12px', borderRadius: '6px', border: `2px solid ${isMatch ? '#10B981' : '#CBD5E1'}`, fontSize: '1rem', boxSizing: 'border-box', outline: 'none' }}
                        autoComplete="off"
                        spellCheck="false"
                    />
                </div>

                <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '16px' }}>
                    <button data-cy="btn-shared.danger-zone-modal-0" 
                        onClick={onClose}
                        style={{ padding: '12px 24px', backgroundColor: 'transparent', color: '#475569', border: 'none', fontWeight: 800, cursor: 'pointer' }}
                    >
                        CANCEL ABORT
                    </button>
                    <button data-cy="btn-shared.danger-zone-modal-1" 
                        onClick={() => { if(isMatch) onConfirm(); }}
                        disabled={!isMatch}
                        style={{ padding: '12px 24px', backgroundColor: isMatch ? '#DC2626' : '#E2E8F0', color: isMatch ? 'white' : '#94A3B8', border: 'none', borderRadius: '6px', fontWeight: 800, cursor: isMatch ? 'pointer' : 'not-allowed', transition: 'all 0.2s ease' }}
                    >
                        PERMANENTLY EXECUTE
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes pop-in {
                    0% { transform: scale(0.9); opacity: 0; }
                    100% { transform: scale(1); opacity: 1; }
                }
            `}</style>
        </div>
    );
};
