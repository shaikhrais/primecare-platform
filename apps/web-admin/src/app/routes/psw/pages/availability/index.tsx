import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function AvailabilityForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        effectiveDate: new Date().toISOString().split('T')[0],
        weeklyHours: 40,
        excludeWeekends: false,
        shifts: {
            morning: true,
            afternoon: true,
            evening: false,
            night: false
        },
        notes: ''
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

    const handleShiftToggle = (shift: string) => {
        setIsDirty(true);
        setFormData({
            ...formData,
            shifts: {
                ...formData.shifts,
                [shift]: !(formData.shifts as any)[shift]
            }
        });
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/psw/availability`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Availability updated successfully!', 'success');
                setIsDirty(false);
                navigate('/psw/dashboard');
            } else {
                showToast('Failed to update availability', 'error');
            }
        } catch (error) {
            showToast('Error during update', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '700px', margin: '0 auto', padding: '2rem' }} data-cy="form.availability.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Discard Changes?</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved availability changes. Discard them?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Schedule Availability</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Manage your working hours and preferred shift times.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Effective Date</label>
                        <input
                            data-cy="form.availability.date"
                            type="date"
                            required
                            value={formData.effectiveDate}
                            onChange={(e) => { setFormData({ ...formData, effectiveDate: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Max Weekly Hours</label>
                        <input
                            data-cy="form.availability.hours"
                            type="number"
                            required
                            value={formData.weeklyHours}
                            onChange={(e) => { setFormData({ ...formData, weeklyHours: parseInt(e.target.value) }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '1rem', fontWeight: 500 }}>Preferred Shift Blocks</label>
                        <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }} data-cy="form.availability.shifts">
                            {['morning', 'afternoon', 'evening', 'night'].map((s) => (
                                <button
                                    key={s}
                                    type="button"
                                    data-cy={`form.availability.shift.${s}`}
                                    onClick={() => handleShiftToggle(s)}
                                    style={{
                                        padding: '0.75rem 1.5rem',
                                        borderRadius: '50px',
                                        border: (formData.shifts as any)[s] ? '2px solid #004d40' : '1px solid #d1d5db',
                                        background: (formData.shifts as any)[s] ? '#e0f2f1' : 'transparent',
                                        color: (formData.shifts as any)[s] ? '#004d40' : '#6b7280',
                                        fontWeight: 600,
                                        cursor: 'pointer',
                                        textTransform: 'capitalize'
                                    }}
                                >
                                    {s}
                                </button>
                            ))}
                        </div>
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Special Requests / Constraints</label>
                        <textarea
                            data-cy="form.availability.notes"
                            value={formData.notes}
                            onChange={(e) => { setFormData({ ...formData, notes: e.target.value }); setIsDirty(true); }}
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
                        data-cy="form.availability.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Updating...' : 'Update Availability'}
                    </button>
                </div>
            </form>
        </div>
    );
}
