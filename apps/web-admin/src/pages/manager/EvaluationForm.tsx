import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../App';

const API_URL = import.meta.env.VITE_API_URL;

export default function EvaluationForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        staffId: '',
        performanceScore: 5,
        attendanceScore: 5,
        technicalSkills: 5,
        actionPlan: '',
        comments: ''
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

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/manager/evaluations`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Staff evaluation submitted successfully!', 'success');
                setIsDirty(false);
                navigate('/manager/dashboard');
            } else {
                showToast('Failed to submit evaluation', 'error');
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
                        <h2 style={{ marginTop: 0 }}>Unsaved Evaluation</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved changes in this staff evaluation. Discard them?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }} data-cy="page.header">
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Staff Performance Evaluation</h2>
                <p style={{ color: '#6b7280' }}>Conduct a formal performance and compliance review for care staff.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Staff Member</label>
                        <select
                            data-cy="form.evaluation.staff"
                            required
                            value={formData.staffId}
                            onChange={(e) => { setFormData({ ...formData, staffId: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">Select Staff...</option>
                            <option value="psw-1">John Walker (PSW)</option>
                            <option value="psw-2">Sarah Jenkins (PSW)</option>
                        </select>
                    </div>

                    {['performance', 'attendance', 'technical'].map((metric) => (
                        <div key={metric}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500, textTransform: 'capitalize' }}>{metric} Score (1-10)</label>
                            <input
                                data-cy={`form.evaluation.${metric}`}
                                type="range"
                                min="1"
                                max="10"
                                value={(formData as any)[metric + 'Score'] || formData.technicalSkills}
                                onChange={(e) => {
                                    const key = metric === 'technical' ? 'technicalSkills' : metric + 'Score';
                                    setFormData({ ...formData, [key]: parseInt(e.target.value) });
                                    setIsDirty(true);
                                }}
                                style={{ width: '100%', cursor: 'pointer' }}
                            />
                            <div style={{ textAlign: 'center', fontWeight: 'bold', marginTop: '0.5rem' }}>
                                {(formData as any)[metric === 'technical' ? 'technicalSkills' : metric + 'Score']} / 10
                            </div>
                        </div>
                    ))}

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Action Plan for Improvement</label>
                        <textarea
                            data-cy="form.evaluation.plan"
                            value={formData.actionPlan}
                            onChange={(e) => { setFormData({ ...formData, actionPlan: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px' }}
                            placeholder="Describe development goals..."
                        />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>General Comments</label>
                        <textarea
                            data-cy="form.evaluation.comments"
                            value={formData.comments}
                            onChange={(e) => { setFormData({ ...formData, comments: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
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
                        data-cy="form.evaluation.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Submitting...' : 'Submit Evaluation'}
                    </button>
                </div>
            </form>
        </div>
    );
}
