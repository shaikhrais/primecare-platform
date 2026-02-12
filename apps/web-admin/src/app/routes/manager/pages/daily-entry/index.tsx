import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../context/NotificationContext';

export default function DailyEntryPage() {
    const navigate = useNavigate();
    const { showToast } = useNotification();

    // State
    const [clients, setClients] = useState<any[]>([]);
    const [selectedClient, setSelectedClient] = useState<string>('');
    const [visitId, setVisitId] = useState<string>('');

    const [adl, setAdl] = useState({
        bathing: false,
        dressing: false,
        feeding: false,
        toileting: false,
        mobility: false
    });
    const [meds, setMeds] = useState({ given: false, notes: '' });
    const [mood, setMood] = useState<number>(3);
    const [vitals, setVitals] = useState({ bp: '', pulse: '', temp: '' });
    const [notes, setNotes] = useState('');
    const [signature, setSignature] = useState('');
    const [submitting, setSubmitting] = useState(false);
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [pendingNav, setPendingNav] = useState<string | null>(null);

    // Unsaved changes guard (Native)
    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty]);

    const handleBack = () => {
        if (isDirty) {
            setShowGuard(true);
        } else {
            navigate('/manager/dashboard');
        }
    };

    // Load available clients/visits
    useEffect(() => {
        const fetchClients = async () => {
            const token = localStorage.getItem('token');
            const res = await fetch(`${import.meta.env.VITE_API_URL}/v1/staff/customers`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (res.ok) {
                const data = await res.json();
                setClients(data);
                if (data.length > 0) setSelectedClient(data[0].id);
            }
        };
        fetchClients();
    }, []);

    const handleSubmit = async (isDraft: boolean) => {
        if (!selectedClient) return showToast('Please select a client', 'error');
        if (!isDraft && !signature) return showToast('Signature required for submission', 'error');

        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = isDraft ? '/v1/daily-entry/draft' : '/v1/daily-entry';

            const res = await fetch(`${import.meta.env.VITE_API_URL}${endpoint}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    clientId: selectedClient,
                    visitId: visitId || undefined, // Optional if just general daily entry
                    adlData: adl,
                    medication: meds,
                    mood,
                    vitals,
                    notes,
                    signature,
                    status: isDraft ? 'DRAFT' : 'SUBMITTED'
                })
            });

            if (res.ok) {
                showToast(isDraft ? 'Draft saved!' : 'Daily entry submitted successfully!', 'success');
                if (!isDraft) navigate('/manager/dashboard');
            } else {
                showToast('Failed to save entry', 'error');
            }
        } catch (error) {
            console.error('Submit error', error);
            showToast('Error communicating with server', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ display: 'flex', height: 'calc(100vh - 100px)', gap: '24px' }} data-cy="page.container">
            {/* Unsaved Changes Guard Dialog */}
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'var(--bg-elev)', padding: '32px', borderRadius: '16px', border: '1px solid var(--line)', maxWidth: '400px', textAlign: 'center', color: 'var(--text)' }}>
                        <h2 style={{ marginTop: 0 }}>Unsaved Changes</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved changes. Navigating away will discard them. Would you like to stay and save?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate('/manager/dashboard')} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid var(--line)', background: 'transparent', cursor: 'pointer', color: 'var(--text)' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: 'var(--primary)', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            {/* Left Panel: Context Selection */}
            <div style={{ width: '300px', background: 'var(--bg-elev)', padding: '24px', borderRadius: '16px', border: '1px solid var(--line)' }}>
                <h2 style={{ fontSize: '1.2rem', marginBottom: '20px' }}>Select Context</h2>

                <div style={{ marginBottom: '20px' }}>
                    <label style={{ display: 'block', marginBottom: '8px', fontWeight: 600 }}>Client</label>
                    <select
                        data-cy="form.daily.client"
                        style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg-input)', color: 'var(--text)' }}
                        value={selectedClient}
                        onChange={(e) => {
                            setSelectedClient(e.target.value);
                            setIsDirty(true);
                        }}
                    >
                        <option value="">Select Client...</option>
                        {clients.map(c => <option key={c.id} value={c.id}>{c?.fullName || 'Unknown Client'}</option>)}
                    </select>
                </div>

                {/* Could add Shift Selection here if relevant */}

                <div style={{ marginTop: 'auto', padding: '16px', background: 'rgba(33, 150, 243, 0.1)', borderRadius: '8px', border: '1px solid rgba(33, 150, 243, 0.3)' }}>
                    <h4 style={{ margin: '0 0 8px 0', color: '#2196f3' }}>💡 Tip</h4>
                    <p style={{ margin: 0, fontSize: '0.9rem', opacity: 0.8 }}>
                        Auto-save is enabled for drafts. Submitting requires a signature.
                    </p>
                </div>
            </div>

            {/* Right Panel: The Form */}
            <div style={{ flex: 1, background: 'var(--bg-elev)', padding: '32px', borderRadius: '16px', border: '1px solid var(--line)', overflowY: 'auto' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }} data-cy="page.header">
                    <h1 className="display-text" style={{ fontSize: '2rem', margin: 0 }} data-cy="page.title">Daily Care Entry</h1>
                    <div style={{ fontSize: '0.9rem', opacity: 0.6 }} data-cy="page.subtitle">{new Date().toLocaleDateString()}</div>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '32px' }}>

                    {/* ADL Checklist */}
                    <div>
                        <h3 style={{ borderBottom: '2px solid var(--line)', paddingBottom: '8px', marginBottom: '16px' }}>ADL Checklist</h3>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            {Object.keys(adl).map(key => (
                                <label key={key} style={{ display: 'flex', alignItems: 'center', gap: '12px', cursor: 'pointer', padding: '12px', background: 'var(--bg)', borderRadius: '8px', border: '1px solid var(--line)' }}>
                                    <input
                                        data-cy={`form.daily.adl.${key}`}
                                        type="checkbox"
                                        checked={(adl as any)[key]}
                                        onChange={(e) => {
                                            setAdl({ ...adl, [key]: e.target.checked });
                                            setIsDirty(true);
                                        }}
                                        style={{ width: '20px', height: '20px' }}
                                    />
                                    <span style={{ textTransform: 'capitalize', fontWeight: 600 }}>{key}</span>
                                </label>
                            ))}
                        </div>
                    </div>

                    {/* Vitals & Mood */}
                    <div>
                        <h3 style={{ borderBottom: '2px solid var(--line)', paddingBottom: '8px', marginBottom: '16px' }}>Vitals & Wellness</h3>

                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '12px', marginBottom: '24px' }}>
                            <div>
                                <label style={{ fontSize: '0.85rem', fontWeight: 600, display: 'block', marginBottom: '4px' }}>BP</label>
                                <input data-cy="form.daily.vitals.bp" placeholder="120/80" value={vitals.bp} onChange={(e) => { setVitals({ ...vitals, bp: e.target.value }); setIsDirty(true); }} style={{ width: '100%', padding: '10px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)' }} />
                            </div>
                            <div>
                                <label style={{ fontSize: '0.85rem', fontWeight: 600, display: 'block', marginBottom: '4px' }}>Pulse</label>
                                <input data-cy="form.daily.vitals.pulse" placeholder="72" value={vitals.pulse} onChange={(e) => { setVitals({ ...vitals, pulse: e.target.value }); setIsDirty(true); }} style={{ width: '100%', padding: '10px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)' }} />
                            </div>
                            <div>
                                <label style={{ fontSize: '0.85rem', fontWeight: 600, display: 'block', marginBottom: '4px' }}>Temp</label>
                                <input data-cy="form.daily.vitals.temp" placeholder="36.5" value={vitals.temp} onChange={(e) => { setVitals({ ...vitals, temp: e.target.value }); setIsDirty(true); }} style={{ width: '100%', padding: '10px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)' }} />
                            </div>
                        </div>

                        <label style={{ display: 'block', marginBottom: '8px', fontWeight: 600 }}>Client Mood (1-5)</label>
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
                </div>

                <div style={{ marginTop: '32px' }}>
                    <h3 style={{ borderBottom: '2px solid var(--line)', paddingBottom: '8px', marginBottom: '16px' }}>Notes & Signature</h3>
                    <textarea
                        data-cy="form.daily.notes"
                        placeholder="Daily progress notes, observations, or incidents..."
                        value={notes}
                        onChange={(e) => {
                            setNotes(e.target.value);
                            setIsDirty(true);
                        }}
                        style={{ width: '100%', minHeight: '120px', padding: '16px', borderRadius: '12px', border: '1px solid var(--line)', background: 'var(--bg)', marginBottom: '24px', resize: 'vertical' }}
                    />

                    <div style={{ display: 'flex', gap: '24px', alignItems: 'flex-end', flexWrap: 'wrap' }}>
                        <div style={{ flex: 1, minWidth: '250px' }}>
                            <label style={{ display: 'block', marginBottom: '8px', fontWeight: 600 }}>Digital Signature</label>
                            <input
                                data-cy="form.daily.signature"
                                placeholder="Type full name to sign"
                                value={signature}
                                onChange={(e) => {
                                    setSignature(e.target.value);
                                    setIsDirty(true);
                                }}
                                style={{ width: '100%', padding: '14px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)', fontFamily: 'monospace' }}
                            />
                        </div>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button
                                onClick={() => {
                                    setIsDirty(false);
                                    handleSubmit(true);
                                }}
                                disabled={submitting}
                                data-cy="form.daily.save"
                                style={{ padding: '14px 24px', borderRadius: '50px', border: '1px solid var(--line)', background: 'transparent', cursor: 'pointer', fontWeight: 600 }}
                            >
                                Save Draft
                            </button>
                            <button
                                onClick={() => {
                                    setIsDirty(false);
                                    handleSubmit(false);
                                }}
                                disabled={submitting}
                                className="btn btn-primary"
                                data-cy="form.daily.submit"
                                style={{ padding: '14px 32px', borderRadius: '50px', fontWeight: 800 }}
                            >
                                {submitting ? 'Submitting...' : 'Submit Entry'}
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    );
}
