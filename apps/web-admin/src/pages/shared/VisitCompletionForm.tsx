import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useNotification } from '../../App';

const API_URL = import.meta.env.VITE_API_URL;

export default function VisitCompletionForm() {
    const { id } = useParams();
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        tasksPerformed: [] as string[],
        signature: '',
        clinicalNotes: '',
        clientSatisfied: true,
        incidentReported: false
    });

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

    const handleTaskToggle = (task: string) => {
        setIsDirty(true);
        setFormData(prev => ({
            ...prev,
            tasksPerformed: prev.tasksPerformed.includes(task)
                ? prev.tasksPerformed.filter(t => t !== task)
                : [...prev.tasksPerformed, task]
        }));
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/visits/${id}/complete`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Visit completion recorded!', 'success');
                setIsDirty(false);
                navigate('/shifts');
            } else {
                showToast('Failed to save completion', 'error');
            }
        } catch (error) {
            showToast('Error during submission', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="page.container">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Discard Completion?</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>Visit details are not saved. If you leave, you will lose progress.</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2.5rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">Finalize Visit Report</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Record tasks performed and capture electronic signature for Visit #{id}.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ marginBottom: '2rem' }}>
                    <label style={{ display: 'block', marginBottom: '1rem', fontWeight: 600 }}>Care Tasks Performed</label>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }} data-cy="form.visitComplete.tasks">
                        {['Personal Hygiene', 'Meal Preparation', 'Medication Assist', 'Mobility Support'].map(task => (
                            <label key={task} style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', borderRadius: '0.5rem', background: '#f9fafb', cursor: 'pointer' }}>
                                <input
                                    type="checkbox"
                                    checked={formData.tasksPerformed.includes(task)}
                                    onChange={() => handleTaskToggle(task)}
                                    style={{ width: '1.2rem', height: '1.2rem' }}
                                />
                                {task}
                            </label>
                        ))}
                    </div>
                </div>

                <div style={{ marginBottom: '2rem' }}>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 600 }}>Electronic Signature (Full Name)</label>
                    <input
                        data-cy="form.visitComplete.signature"
                        required
                        value={formData.signature}
                        onChange={(e) => { setFormData({ ...formData, signature: e.target.value }); setIsDirty(true); }}
                        placeholder="Type legal name to sign..."
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    />
                </div>

                <div style={{ marginBottom: '2rem' }}>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 600 }}>Clinical Progress Notes</label>
                    <textarea
                        data-cy="form.visitComplete.notes"
                        value={formData.clinicalNotes}
                        onChange={(e) => { setFormData({ ...formData, clinicalNotes: e.target.value }); setIsDirty(true); }}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '120px' }}
                    />
                </div>

                <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.visitComplete.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Saving...' : 'Complete Visit'}
                    </button>
                </div>
            </form>
        </div>
    );
}
