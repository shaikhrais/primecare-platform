import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function BookingRequestForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        serviceId: '',
        preferredDate: '',
        preferredTime: 'morning',
        urgency: 'routine',
        description: ''
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
            const response = await fetch(`${API_URL}/v1/client/bookings`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Booking request sent!', 'success');
                setIsDirty(false);
                navigate('/bookings');
            } else {
                showToast('Failed to send request', 'error');
            }
        } catch (error) {
            showToast('Error during submission', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '600px', margin: '0 auto', padding: '2rem' }} data-cy="form.booking.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Discard Request?</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>Your booking request details are not saved. Discard them?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">Request New Service</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Submit a request for our care coordinators to schedule a new visit.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Select Service</label>
                        <select
                            data-cy="form.booking.service"
                            required
                            value={formData.serviceId}
                            onChange={(e) => { setFormData({ ...formData, serviceId: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">Choose a service...</option>
                            <option value="psw-1">Personal Care (PSW)</option>
                            <option value="rn-1">Nursing Assessment (RN)</option>
                            <option value="ft-1">Foot Care Specialist</option>
                        </select>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Preferred Date</label>
                            <input
                                data-cy="form.booking.date"
                                type="date"
                                required
                                value={formData.preferredDate}
                                onChange={(e) => { setFormData({ ...formData, preferredDate: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Shift Block</label>
                            <select
                                data-cy="form.booking.time"
                                value={formData.preferredTime}
                                onChange={(e) => { setFormData({ ...formData, preferredTime: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option value="morning">Morning (8am - 12pm)</option>
                                <option value="afternoon">Afternoon (1pm - 5pm)</option>
                                <option value="evening">Evening (6pm - 10pm)</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Details / Requests</label>
                        <textarea
                            data-cy="form.booking.description"
                            value={formData.description}
                            onChange={(e) => { setFormData({ ...formData, description: e.target.value }); setIsDirty(true); }}
                            placeholder="Tell us about specific needs for this visit..."
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '100px' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.booking.save"
                        style={{ width: '100%', padding: '1rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', fontSize: '1.1rem', cursor: submitting ? 'not-allowed' : 'pointer' }}
                    >
                        {submitting ? 'Sending Request...' : 'Submit Request'}
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
