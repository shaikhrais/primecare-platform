import React, { useState } from 'react';

export default function ClinicalAssistant() {
    const [notes, setNotes] = useState('');
    const [generating, setGenerating] = useState(false);
    const [plan, setPlan] = useState<string | null>(null);

    const handleGenerate = () => {
        setGenerating(true);
        // Simulate AI generation
        setTimeout(() => {
            setPlan(`Based on your notes ("${notes}"), I recommend the following care plan:
\n1. **Mobility Support**: Assist with transfers 3x daily using gait belt.
2. **Medication Management**: Monitor blood pressure before administering Atenolol.
3. **Hydration**: Encourage 500ml oral fluids every 4 hours.
4. **Safety**: Keep walker within reach at all times.`);
            setGenerating(false);
        }, 1500);
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1000px', margin: '0 auto' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>AI Clinical Assistant</h1>
                <p style={{ color: '#6B7280' }}>Transform assessment notes into detailed care plans in seconds.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '32px' }}>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontWeight: '700', marginBottom: '16px' }}>Input Assessment Notes</div>
                    <textarea
                        value={notes}
                        onChange={(e) => setNotes(e.target.value)}
                        placeholder="e.g. Client shows signs of fatigue during transfers. BP slightly high (145/90). Needs encouragement for fluid intake..."
                        style={{ width: '100%', minHeight: '300px', padding: '16px', borderRadius: '8px', border: '1px solid var(--line)', fontFamily: 'inherit', fontSize: '14px', resize: 'vertical' }}
                    />
                    <button
                        onClick={handleGenerate}
                        disabled={!notes || generating}
                        className="btn btn-primary"
                        style={{ width: '100%', marginTop: '20px', padding: '12px' }}
                    >
                        {generating ? 'Generating Plan...' : '🪄 Generate Care Plan'}
                    </button>
                </div>

                <div className="pc-card" style={{ padding: '24px', backgroundColor: '#F9FAFB', border: '1px dashed var(--line)' }}>
                    <div style={{ fontWeight: '700', marginBottom: '16px' }}>Generated Plan Draft</div>
                    {!plan && !generating && (
                        <div style={{ textAlign: 'center', marginTop: '100px', color: '#6B7280' }}>
                            <span style={{ fontSize: '3rem' }}>📝</span>
                            <p style={{ marginTop: '16px' }}>Your AI-generated plan will appear here.</p>
                        </div>
                    )}
                    {generating && (
                        <div style={{ textAlign: 'center', marginTop: '100px' }}>
                            <div className="animate-spin" style={{ fontSize: '2rem' }}>⚙️</div>
                            <p style={{ marginTop: '16px', color: '#6B7280' }}>Analysing clinical data...</p>
                        </div>
                    )}
                    {plan && (
                        <div style={{ whiteSpace: 'pre-wrap', fontSize: '14px', lineHeight: '1.6', color: '#374151' }}>
                            {plan}
                            <div style={{ marginTop: '32px', display: 'flex', gap: '12px' }}>
                                <button className="btn btn-primary" style={{ flex: 1 }}>Approve & Save</button>
                                <button className="btn" style={{ flex: 1 }} onClick={() => setPlan(null)}>Edit Draft</button>
                            </div>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
}
