import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function ServiceReviewForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        clientId: '',
        serviceCategory: '',
        satisfactionScore: 5,
        clinicalCompliance: true,
        improvementNotes: ''
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
            const response = await fetch(`${API_URL}/v1/manager/service-reviews`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Service review completed successfully!', 'success');
                setIsDirty(false);
                navigate('/manager/dashboard');
            } else {
                showToast('Failed to submit review', 'error');
            }
        } catch (error) {
            showToast('Error during submission', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.serviceReview.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Unsaved Review</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved changes in this service review. Discard them?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Internal Service Review</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Audit service delivery and client satisfaction for quality assurance.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Client Name</label>
                        <select
                            data-cy="form.serviceReview.client"
                            required
                            value={formData.clientId}
                            onChange={(e) => { setFormData({ ...formData, clientId: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">Select Client...</option>
                            <option value="c-1">Alice Thompson</option>
                            <option value="c-2">Robert Miller</option>
                        </select>
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Service Category</label>
                        <select
                            data-cy="form.serviceReview.category"
                            required
                            value={formData.serviceCategory}
                            onChange={(e) => { setFormData({ ...formData, serviceCategory: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">Select Category...</option>
                            <option value="nursing">Nursing Care</option>
                            <option value="personal">Personal Care</option>
                            <option value="companionship">Companionship</option>
                        </select>
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Satisfaction Score (1-10)</label>
                        <input
                            data-cy="form.serviceReview.score"
                            type="number"
                            min="1"
                            max="10"
                            value={formData.satisfactionScore}
                            onChange={(e) => { setFormData({ ...formData, satisfactionScore: parseInt(e.target.value) }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', paddingTop: '1.5rem' }}>
                        <input
                            data-cy="form.serviceReview.compliance"
                            type="checkbox"
                            checked={formData.clinicalCompliance}
                            onChange={(e) => { setFormData({ ...formData, clinicalCompliance: e.target.checked }); setIsDirty(true); }}
                            style={{ width: '20px', height: '20px' }}
                        />
                        <label style={{ fontWeight: 500 }}>Clinical Compliance Verified?</label>
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Improvement Notes</label>
                        <textarea
                            data-cy="form.serviceReview.notes"
                            value={formData.improvementNotes}
                            onChange={(e) => { setFormData({ ...formData, improvementNotes: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '120px' }}
                            placeholder="Identify areas for clinical or service enhancement..."
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
                        data-cy="form.serviceReview.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Completing...' : 'Complete Review'}
                    </button>
                </div>
            </form>
        </div>
    );
}
