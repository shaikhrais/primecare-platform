// ================================================================
// PAGE IDENTITY: T31 � MAR Client
// Type: Tool | Owner: rn
// ================================================================
import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { AlertCircle, CheckCircle, WifiOff, FileSignature } from 'lucide-react';
import { SignaturePad } from '../assessments/components/SignaturePad';
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';

interface Medication {
    id: string;
    name: string;
    dose: string;
    route: string;
    frequency: string;
    status: 'pending' | 'administered' | 'withheld';
    interactionLevel?: 'critical' | 'moderate' | 'none';
    interactionMessage?: string;
}

export const MarClient: React.FC = () => {
    const { showToast } = useNotification();
    const [meds, setMeds] = useState<Medication[]>([]);
    const [isOffline, setIsOffline] = useState(!navigator.onLine);

    // Safety Acknowledgements
    const [acknowledgements, setAcknowledgements] = useState<Record<string, boolean>>({});

    // Signing Flow
    const [isSigning, setIsSigning] = useState(false);
    const [signature, setSignature] = useState<string | null>(null);

    useEffect(() => {
        const loadMeds = async () => {
            const cached = localStorage.getItem('primecare_emar_cache_123');
            if (cached && !navigator.onLine) {
                setMeds(JSON.parse(cached));
                return;
            }

            try {
                // Hitting the actual schedule mapping in worker-api
                const response = await apiClient.get(AdminRegistry.ApiRegistry.RN.MAR_SCHEDULE('demo-client-1'));
                if (response.ok) {
                    const data = await response.json();
                    setMeds(data as Medication[]);
                    localStorage.setItem('primecare_emar_cache_123', JSON.stringify(data));
                } else {
                    throw new Error('Failed to fetch from network');
                }
            } catch (error) {
                console.error('Failed to load meds:', error);
                
                // Fallback to cache if API strictly fails
                if (cached) setMeds(JSON.parse(cached));
            }
        };
        loadMeds();

        const handleOffline = () => setIsOffline(true);
        const handleOnline = () => setIsOffline(false);
        window.addEventListener('offline', handleOffline);
        window.addEventListener('online', handleOnline);
        return () => {
            window.removeEventListener('offline', handleOffline);
            window.removeEventListener('online', handleOnline);
        };
    }, []);

    const toggleAcknowledge = (id: string) => {
        setAcknowledgements(prev => ({ ...prev, [id]: !prev[id] }));
    };

    const handleAdminister = (id: string) => {
        const updatedMeds = meds.map(m => m.id === id ? { ...m, status: 'administered' as const } : m);
        setMeds(updatedMeds);
        localStorage.setItem('primecare_emar_cache_123', JSON.stringify(updatedMeds));
        showToast('Medication recorded as administered.', 'success');
    };

    const beginSignOff = () => {
        const pending = meds.filter(m => m.status === 'pending');
        if (pending.length > 0) {
            showToast('Please document all scheduled medications before signing off.', 'error');
            return;
        }
        setIsSigning(true);
    };

    const handleFinalSubmit = async () => {
        if (!signature) {
            showToast('Signature required.', 'error');
            return;
        }

        try {
            // Commit administered medications back to the server
            const administeredMeds = meds.filter(m => m.status === 'administered');
            for (const med of administeredMeds) {
                await apiClient.post(AdminRegistry.ApiRegistry.RN.MAR_ADMINISTER, {
                    clientId: 'demo-client-1',
                    medicationName: med.name,
                    dosage: med.dose,
                    route: med.route,
                    scheduledTime: new Date().toISOString(),
                    status: 'given'
                });
            }

            showToast('Daily MAR Successfully Committed to Ledger.', 'success');
            setIsSigning(false);
            setMeds([]); // Assume fetched fresh on component reload
            localStorage.removeItem('primecare_emar_cache_123');
        } catch (error) {
            console.error('Failed to commit ledger:', error);
            showToast('Failed to sync MAR ledger. Data cached locally.', 'error');
        }
    };

    return (
        <div data-cy="page.container" style={{ padding: '0 24px 24px 24px', maxWidth: '1000px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 900, color: '#0F172A' }}>Medication Admin Record (eMAR)</h1>
                    <div style={{ display: 'flex', gap: '16px', alignItems: 'center' }}>
                        <span style={{ fontWeight: 800, color: '#334155' }}>Patient: Beatrice Morrison</span>
                        {isOffline && (
                            <span style={{ display: 'flex', alignItems: 'center', gap: '6px', backgroundColor: '#FEF2F2', color: '#B91C1C', padding: '4px 12px', borderRadius: '16px', fontSize: '0.85rem', fontWeight: 700 }}>
                                <WifiOff size={14} /> Offline Mode - Local Cache Active
                            </span>
                        )}
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', marginBottom: '32px' }}>
                {meds.map(med => (
                    <div key={med.id} style={{
                        backgroundColor: 'white',
                        border: '1px solid #E2E8F0',
                        borderRadius: '12px',
                        overflow: 'hidden',
                        boxShadow: '0 1px 3px rgba(0,0,0,0.05)'
                    }}>
                        <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 1fr 200px', gap: '16px', padding: '20px', alignItems: 'center' }}>
                            <div>
                                <h3 data-cy="h3-rn.mar-client-0" style={{ margin: '0 0 4px 0', fontSize: '1.2rem', fontWeight: 800, color: '#0F172A' }}>{med.name}</h3>
                                <div style={{ color: '#64748B', fontSize: '0.9rem', fontWeight: 600 }}>{med.dose} • {med.route}</div>
                            </div>
                            <div style={{ color: '#334155', fontWeight: 600 }}>{med.frequency}</div>

                            <div>
                                {med.status === 'administered' ? (
                                    <span style={{ display: 'flex', alignItems: 'center', gap: '4px', color: '#10B981', fontWeight: 800 }}><CheckCircle size={18} /> Given</span>
                                ) : (
                                    <span style={{ color: '#F59E0B', fontWeight: 800 }}>Pending</span>
                                )}
                            </div>

                            <div style={{ display: 'flex', justifyContent: 'flex-end', gridColumn: '5 / 6' }}>
                                {med.status === 'pending' && (
                                    <button data-cy="btn-rn.mar-client-0"
                                        onClick={() => handleAdminister(med.id)}
                                        disabled={med.interactionLevel === 'critical' && !acknowledgements[med.id]}
                                        style={{
                                            padding: '8px 16px',
                                            backgroundColor: (med.interactionLevel === 'critical' && !acknowledgements[med.id]) ? '#E2E8F0' : '#0F172A',
                                            color: (med.interactionLevel === 'critical' && !acknowledgements[med.id]) ? '#94A3B8' : 'white',
                                            border: 'none',
                                            borderRadius: '6px',
                                            fontWeight: 700,
                                            cursor: (med.interactionLevel === 'critical' && !acknowledgements[med.id]) ? 'not-allowed' : 'pointer',
                                            transition: 'all 0.2s'
                                        }}
                                    >
                                        Record Given
                                    </button>
                                )}
                            </div>
                        </div>

                        {/* Suggestion 12: Severity-Colored Medication Alerts */}
                        {med.interactionLevel === 'critical' && med.status === 'pending' && (
                            <div style={{ backgroundColor: '#FEF2F2', borderTop: '1px solid #FECACA', padding: '16px 20px', display: 'flex', gap: '16px', alignItems: 'flex-start' }}>
                                <AlertCircle color="#DC2626" style={{ flexShrink: 0, marginTop: '2px' }} />
                                <div style={{ flex: 1 }}>
                                    <div style={{ color: '#991B1B', fontWeight: 800, marginBottom: '8px' }}>{med.interactionMessage}</div>
                                    <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer', userSelect: 'none' }}>
                                        <input data-cy="input-rn.mar-client-0"
                                            type="checkbox"
                                            checked={!!acknowledgements[med.id]}
                                            onChange={() => toggleAcknowledge(med.id)}
                                            style={{ width: '18px', height: '18px', accentColor: '#DC2626' }}
                                        />
                                        <span style={{ color: '#7F1D1D', fontWeight: 600, fontSize: '0.9rem' }}>I acknowledge this risk and verify the clinical necessity of this dosage.</span>
                                    </label>
                                </div>
                            </div>
                        )}
                    </div>
                ))}
            </div>

            <div style={{ display: 'flex', justifyContent: 'flex-end', padding: '24px 0', borderTop: '2px solid #E2E8F0' }}>
                {!isSigning ? (
                    <button data-cy="btn-rn.mar-client-1"
                        onClick={beginSignOff}
                        style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '12px 24px', backgroundColor: '#3B82F6', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1.1rem', fontWeight: 800, cursor: 'pointer' }}
                    >
                        <FileSignature /> Sign Off Daily MAR
                    </button>
                ) : (
                    <div style={{ backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '12px', border: '1px solid #CBD5E1', width: '100%', maxWidth: '500px' }}>
                        <h3 data-cy="h3-rn.mar-client-1" style={{ margin: '0 0 16px 0', color: '#0F172A', fontWeight: 800 }}>Nurse Electronic Signature</h3>
                        <SignaturePad
                            width={450}
                            height={150}
                            onSave={(sig: string) => setSignature(sig)}
                            onClear={() => setSignature(null)}
                        />
                        {signature && (
                            <div style={{ marginTop: '20px', display: 'flex', justifyContent: 'flex-end' }}>
                                <button data-cy="btn-rn.mar-client-2"
                                    onClick={handleFinalSubmit}
                                    style={{ padding: '12px 32px', backgroundColor: '#10B981', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1.1rem', fontWeight: 800, cursor: 'pointer' }}
                                >
                                    Commit Ledger
                                </button>
                            </div>
                        )}
                    </div>
                )}
            </div>
        </div>
    );
};

export default MarClient;
