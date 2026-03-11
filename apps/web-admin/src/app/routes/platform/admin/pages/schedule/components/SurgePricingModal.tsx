import React, { useState } from 'react';

interface SurgePricingModalProps {
    visitId: string;
    clientName: string;
    currentMultiplier: number;
    isActive: boolean;
    basePayout: number; // base payout for demonstration
    onClose: () => void;
    onSave: (visitId: string, surgeMultiplier: number, isSurgeActive: boolean) => Promise<void>;
}

export const SurgePricingModal: React.FC<SurgePricingModalProps> = ({
    visitId,
    clientName,
    currentMultiplier,
    isActive,
    basePayout,
    onClose,
    onSave
}) => {
    const [multiplier, setMultiplier] = useState(currentMultiplier || 1.0);
    const [active, setActive] = useState(isActive || false);
    const [loading, setLoading] = useState(false);

    const handleSave = async () => {
        setLoading(true);
        try {
            await onSave(visitId, multiplier, active);
            onClose();
        } catch (error) {
            console.error('Failed to save surge pricing', error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{
            position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)',
            display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 50
        }}>
            <div style={{
                backgroundColor: 'white', padding: '24px', borderRadius: '12px',
                width: '100%', maxWidth: '400px', boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1)'
            }}>
                <h2 style={{ margin: '0 0 16px', fontSize: '1.25rem', fontWeight: 600, color: '#111827' }}>
                    Surge Pricing Configuration
                </h2>

                <p style={{ margin: '0 0 20px', fontSize: '0.875rem', color: '#4B5563' }}>
                    Adjust the payout multiplier for the unfilled shift with <strong>{clientName}</strong> to incentivize providers.
                </p>

                <div style={{ marginBottom: '20px' }}>
                    <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer', marginBottom: '16px' }}>
                        <input
                            type="checkbox"
                            checked={active}
                            onChange={(e) => setActive(e.target.checked)}
                            style={{ width: '16px', height: '16px', accentColor: '#EF4444' }}
                        />
                        <span style={{ fontSize: '0.875rem', fontWeight: 500, color: '#374151' }}>
                            Enable Surge Pricing
                        </span>
                    </label>

                    <div style={{ opacity: active ? 1 : 0.5, transition: 'opacity 0.2s' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
                            <label style={{ fontSize: '0.875rem', fontWeight: 500, color: '#374151' }}>Multiplier</label>
                            <span style={{ fontSize: '0.875rem', fontWeight: 600, color: '#EF4444' }}>{multiplier.toFixed(1)}x</span>
                        </div>
                        <input
                            type="range"
                            min="1.0"
                            max="3.0"
                            step="0.1"
                            value={multiplier}
                            onChange={(e) => setMultiplier(parseFloat(e.target.value))}
                            disabled={!active}
                            style={{ width: '100%', cursor: active ? 'pointer' : 'not-allowed', accentColor: '#EF4444' }}
                        />
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '4px', fontSize: '0.75rem', color: '#6B7280' }}>
                            <span>1.0x (Base)</span>
                            <span>3.0x (Max)</span>
                        </div>
                    </div>
                </div>

                <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px', marginBottom: '24px', border: '1px solid #FECACA' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span style={{ fontSize: '0.875rem', color: '#991B1B', fontWeight: 500 }}>Estimated Provider Payout:</span>
                        <span style={{ fontSize: '1.125rem', color: '#991B1B', fontWeight: 700 }}>
                            ${active ? (basePayout * multiplier).toFixed(2) : basePayout.toFixed(2)}
                        </span>
                    </div>
                </div>

                <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '12px' }}>
                    <button
                        onClick={onClose}
                        disabled={loading}
                        style={{ padding: '8px 16px', borderRadius: '6px', border: '1px solid #D1D5DB', backgroundColor: 'white', color: '#374151', cursor: 'pointer', fontWeight: 500 }}
                    >
                        Cancel
                    </button>
                    <button
                        onClick={handleSave}
                        disabled={loading}
                        style={{ padding: '8px 16px', borderRadius: '6px', border: 'none', backgroundColor: '#EF4444', color: 'white', cursor: loading ? 'not-allowed' : 'pointer', fontWeight: 500, display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        {loading ? 'Saving...' : 'Apply Surge'}
                    </button>
                </div>
            </div>
        </div>
    );
};
