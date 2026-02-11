import React, { useState } from 'react';

export default function CallAuditPage() {
    const [calls] = useState([
        { id: 1, type: 'Inquiry', duration: '1:24', status: 'Summarized', date: '2026-02-04 14:20', aiSummary: 'Client inquiring about availability for diabetic foot care in West end.' },
        { id: 2, type: 'Support', duration: '0:45', status: 'Pending Review', date: '2026-02-04 15:10', aiSummary: 'PSW reported issues with the mobile app check-in feature.' },
        { id: 3, type: 'Inquiry', duration: '2:10', status: 'Summarized', date: '2026-02-04 16:05', aiSummary: 'New lead interested in 24/7 care for elderly parent.' },
    ]);

    return (
        <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '1rem' }} data-cy="call-audit-page">
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>Voice Call Audits</h2>
                <p style={{ color: '#6b7280' }}>Review AI summaries and audio logs from marketing chat inquiries.</p>
            </div>

            <div style={{ display: 'grid', gap: '1.5rem' }}>
                {calls.map(call => (
                    <div key={call.id} data-cy={`call-audit-card-${call.id}`} style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', border: '1px solid #e5e7eb' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
                            <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                                <span style={{ backgroundColor: '#f3f4f6', padding: '0.25rem 0.75rem', borderRadius: '0.5rem', fontSize: '0.75rem', fontWeight: 'bold' }}>{call.type}</span>
                                <span style={{ color: '#6b7280', fontSize: '0.875rem' }} data-cy="call-date">{call.date}</span>
                            </div>
                            <span style={{ fontSize: '0.875rem', fontWeight: '600', color: '#004d40' }} data-cy="call-duration">{call.duration}</span>
                        </div>

                        <div style={{ display: 'flex', gap: '1.5rem' }}>
                            <div style={{ flex: 1 }}>
                                <h4 style={{ margin: '0 0 0.5rem 0', fontSize: '1rem' }}>AI Summary</h4>
                                <p style={{ color: '#4b5563', margin: 0, lineHeight: '1.5' }} data-cy="call-summary">{call.aiSummary}</p>
                            </div>
                            <div style={{ width: '200px', display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                                <button data-cy="btn-play-recording" style={{ width: '100%', padding: '0.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem' }}>
                                    ▶️ Play Recording
                                </button>
                                <button data-cy="btn-full-transcript" style={{ width: '100%', padding: '0.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer' }}>
                                    Full Transcript
                                </button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>

            <div style={{ marginTop: '3rem', padding: '2rem', backgroundColor: '#ecfdf5', borderRadius: '1rem', textAlign: 'center' }}>
                <h3 style={{ margin: '0 0 0.5rem 0', color: '#065f46' }}>Voice AI Engine Active</h3>
                <p style={{ color: '#065f46', opacity: 0.8, maxWidth: '600px', margin: '0 auto' }}>All calls are automatically transcribed and summarized using our Whisper + GPT-4o pipeline connected via worker-api.</p>
            </div>
        </div>
    );
}
