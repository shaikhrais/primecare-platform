import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function FeedbackForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        visitId: '',
        rating: 5,
        careQuality: 5,
        professionalism: 5,
        comments: '',
        recommend: true
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
            const response = await fetch(`${API_URL}/v1/client/feedback`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Thank you for your feedback!', 'success');
                setIsDirty(false);
                navigate('/bookings');
            } else {
                showToast('Failed to submit feedback', 'error');
            }
        } catch (error) {
            showToast('Error during submission', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '600px', margin: '0 auto', padding: '2rem' }} data-cy="feedback-form-page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Discard Feedback?</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>Your feedback hasn't been submitted yet. Discard it?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem', textAlign: 'center' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Care Experience Feedback</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Your feedback helps us provide better care for you and your loved ones.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '2rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Select Recent Visit</label>
                        <select
                            data-cy="form.feedback.visit"
                            required
                            value={formData.visitId}
                            onChange={(e) => { setFormData({ ...formData, visitId: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">Select Visit...</option>
                            <option value="v-1">Feb 10 - Personal Care (John W.)</option>
                            <option value="v-2">Feb 08 - Nursing Visit (Sarah J.)</option>
                        </select>
                    </div>

                    {['careQuality', 'professionalism'].map((metric) => (
                        <div key={metric}>
                            <label style={{ display: 'block', marginBottom: '1rem', fontWeight: 500, textTransform: 'capitalize' }}>
                                {metric === 'careQuality' ? 'Quality of Care' : 'Caregiver Professionalism'}
                            </label>
                            <div style={{ display: 'flex', justifyContent: 'space-between', gap: '0.5rem' }}>
                                {[1, 2, 3, 4, 5].map((star) => (
                                    <button
                                        key={star}
                                        type="button"
                                        data-cy={`form.feedback.${metric}.${star}`}
                                        onClick={() => { setFormData({ ...formData, [metric]: star }); setIsDirty(true); }}
                                        style={{
                                            flex: 1,
                                            padding: '1rem 0',
                                            borderRadius: '8px',
                                            border: (formData as any)[metric] >= star ? 'none' : '1px solid #d1d5db',
                                            background: (formData as any)[metric] >= star ? '#ffc107' : 'transparent',
                                            color: (formData as any)[metric] >= star ? 'white' : '#6b7280',
                                            fontSize: '1.2rem',
                                            cursor: 'pointer'
                                        }}
                                    >
                                        ★
                                    </button>
                                ))}
                            </div>
                        </div>
                    ))}

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Tell us more about your experience</label>
                        <textarea
                            data-cy="form.feedback.comments"
                            value={formData.comments}
                            onChange={(e) => { setFormData({ ...formData, comments: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '100px' }}
                            placeholder="Optional comments..."
                        />
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                        <input
                            data-cy="form.feedback.recommend"
                            type="checkbox"
                            checked={formData.recommend}
                            onChange={(e) => { setFormData({ ...formData, recommend: e.target.checked }); setIsDirty(true); }}
                            style={{ width: '20px', height: '20px' }}
                        />
                        <label style={{ fontWeight: 500 }}>I would recommend this caregiver to others.</label>
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.feedback.save"
                        style={{ width: '100%', padding: '1rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', fontSize: '1.1rem', cursor: 'pointer' }}
                    >
                        {submitting ? 'Sending...' : 'Submit Feedback'}
                    </button>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ width: '100%', padding: '1rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', color: '#6b7280', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    );
}
