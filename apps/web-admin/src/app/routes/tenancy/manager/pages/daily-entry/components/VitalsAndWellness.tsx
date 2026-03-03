import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface VitalsAndWellnessProps {
    vitals: any;
    setVitals: (vitals: any) => void;
    mood: number;
    setMood: (mood: number) => void;
    setIsDirty: (dirty: boolean) => void;
}

export const VitalsAndWellness: React.FC<VitalsAndWellnessProps> = ({
    vitals,
    setVitals,
    mood,
    setMood,
    setIsDirty
}) => {
    return (
        <div>
            <h3 style={{ borderBottom: '2px solid var(--line)', paddingBottom: '8px', marginBottom: '16px' }}>{ContentRegistry.DAILY_ENTRY.VITALS_TITLE}</h3>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '12px', marginBottom: '24px' }}>
                <div>
                    <label style={{ fontSize: '0.85rem', fontWeight: 600, display: 'block', marginBottom: '4px' }}>{ContentRegistry.DAILY_ENTRY.VITALS.BP}</label>
                    <input data-cy="form.daily.vitals.bp" placeholder="120/80" value={vitals.bp} onChange={(e) => { setVitals({ ...vitals, bp: e.target.value }); setIsDirty(true); }} style={{ width: '100%', padding: '10px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)' }} />
                </div>
                <div>
                    <label style={{ fontSize: '0.85rem', fontWeight: 600, display: 'block', marginBottom: '4px' }}>{ContentRegistry.DAILY_ENTRY.VITALS.PULSE}</label>
                    <input data-cy="form.daily.vitals.pulse" placeholder="72" value={vitals.pulse} onChange={(e) => { setVitals({ ...vitals, pulse: e.target.value }); setIsDirty(true); }} style={{ width: '100%', padding: '10px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)' }} />
                </div>
                <div>
                    <label style={{ fontSize: '0.85rem', fontWeight: 600, display: 'block', marginBottom: '4px' }}>{ContentRegistry.DAILY_ENTRY.VITALS.TEMP}</label>
                    <input data-cy="form.daily.vitals.temp" placeholder="36.5" value={vitals.temp} onChange={(e) => { setVitals({ ...vitals, temp: e.target.value }); setIsDirty(true); }} style={{ width: '100%', padding: '10px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)' }} />
                </div>
            </div>

            <label style={{ display: 'block', marginBottom: '8px', fontWeight: 600 }}>{ContentRegistry.DAILY_ENTRY.VITALS.MOOD_LABEL}</label>
            <div style={{ display: 'flex', gap: '8px' }}>
                {[1, 2, 3, 4, 5].map(m => (
                    <button
                        key={m}
                        data-cy={`form.daily.mood.${m}`}
                        onClick={() => {
                            setMood(m);
                            setIsDirty(true);
                        }}
                        style={{
                            flex: 1,
                            padding: '12px',
                            borderRadius: '8px',
                            border: mood === m ? '2px solid var(--primary)' : '1px solid var(--line)',
                            background: mood === m ? 'var(--primary-light)' : 'var(--bg)',
                            color: mood === m ? 'var(--primary-dark)' : 'var(--text)',
                            fontWeight: 800,
                            cursor: 'pointer'
                        }}
                    >
                        {m}
                    </button>
                ))}
            </div>
        </div>
    );
};
