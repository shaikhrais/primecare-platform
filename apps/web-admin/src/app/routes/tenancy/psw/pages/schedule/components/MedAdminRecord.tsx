import React, { useState } from 'react';

export interface Medication {
    id: string;
    name: string;
    dosage: string;
    route: string;
    time: string;
    instructions: string;
}

interface MedAdminRecordProps {
    medications: Medication[];
    onMedicationUpdate?: (medId: string, status: 'GIVEN' | 'REFUSED' | 'HELD') => void;
}

export const MedAdminRecord: React.FC<MedAdminRecordProps> = ({ medications, onMedicationUpdate }) => {
    const [statuses, setStatuses] = useState<Record<string, string>>({});

    const handleStatusChange = (medId: string, status: 'GIVEN' | 'REFUSED' | 'HELD') => {
        setStatuses(prev => ({ ...prev, [medId]: status }));
        if (onMedicationUpdate) {
            onMedicationUpdate(medId, status);
        }
    };

    if (!medications || medications.length === 0) return null;

    return (
        <div style={{ marginBottom: '24px' }}>
            <h3 data-cy="h3-psw.med-admin-record-0" style={{ margin: '0 0 12px 0', fontSize: '1.2rem', color: '#111827', fontWeight: 800 }}>
                💊 Medication Administration (MAR)
            </h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {medications.map(med => (
                    <div key={med.id} style={{
                        backgroundColor: '#FFFFFF',
                        border: `1px solid ${statuses[med.id] ? (statuses[med.id] === 'GIVEN' ? '#10B981' : '#F59E0B') : '#E5E7EB'}`,
                        borderRadius: '12px',
                        padding: '16px',
                        boxShadow: '0 1px 2px rgba(0,0,0,0.05)'
                    }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '12px' }}>
                            <div>
                                <h4 style={{ margin: '0 0 4px 0', fontSize: '1.1rem', color: '#111827', fontWeight: 700 }}>{med.name}</h4>
                                <div style={{ color: '#4B5563', fontSize: '0.9rem', display: 'flex', gap: '8px' }}>
                                    <span style={{ fontWeight: 600 }}>{med.dosage}</span>
                                    <span style={{ color: '#9CA3AF' }}>•</span>
                                    <span>{med.route}</span>
                                </div>
                                <div style={{ fontSize: '0.8rem', color: '#6B7280', marginTop: '4px' }}>
                                    ⚠️ {med.instructions}
                                </div>
                            </div>
                            <div style={{ backgroundColor: '#F3F4F6', padding: '4px 8px', borderRadius: '4px', fontSize: '0.8rem', fontWeight: 700, color: '#374151' }}>
                                {med.time}
                            </div>
                        </div>

                        {/* Segmented Controls for explicit logging */}
                        <div style={{ display: 'flex', gap: '8px', backgroundColor: '#F3F4F6', padding: '4px', borderRadius: '8px' }}>
                            <button data-cy="btn-psw.med-admin-record-0"
                                onClick={() => handleStatusChange(med.id, 'GIVEN')}
                                style={{
                                    flex: 1, padding: '8px', border: 'none', borderRadius: '6px', fontWeight: 700, fontSize: '0.9rem', cursor: 'pointer', transition: 'all 0.2s',
                                    backgroundColor: statuses[med.id] === 'GIVEN' ? '#10B981' : 'transparent',
                                    color: statuses[med.id] === 'GIVEN' ? 'white' : '#6B7280'
                                }}
                            >
                                ✅ Given
                            </button>
                            <button data-cy="btn-psw.med-admin-record-1"
                                onClick={() => handleStatusChange(med.id, 'REFUSED')}
                                style={{
                                    flex: 1, padding: '8px', border: 'none', borderRadius: '6px', fontWeight: 700, fontSize: '0.9rem', cursor: 'pointer', transition: 'all 0.2s',
                                    backgroundColor: statuses[med.id] === 'REFUSED' ? '#EF4444' : 'transparent',
                                    color: statuses[med.id] === 'REFUSED' ? 'white' : '#6B7280'
                                }}
                            >
                                ❌ Refused
                            </button>
                            <button data-cy="btn-psw.med-admin-record-2"
                                onClick={() => handleStatusChange(med.id, 'HELD')}
                                style={{
                                    flex: 1, padding: '8px', border: 'none', borderRadius: '6px', fontWeight: 700, fontSize: '0.9rem', cursor: 'pointer', transition: 'all 0.2s',
                                    backgroundColor: statuses[med.id] === 'HELD' ? '#F59E0B' : 'transparent',
                                    color: statuses[med.id] === 'HELD' ? 'white' : '#6B7280'
                                }}
                            >
                                ⏸️ Held
                            </button>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};
