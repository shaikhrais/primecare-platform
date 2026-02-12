import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

export default function TimesheetAdjForm() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        staffId: '',
        date: '',
        originalHours: '',
        adjustedHours: '',
        reason: ''
    });

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        // Simulate API
        setTimeout(() => {
            showToast('Timesheet adjustment saved', 'success');
            setIsDirty(false);
            navigate('/timesheets');
            setSubmitting(false);
        }, 1000);
    };

    return (
        <div style={{ maxWidth: '600px', margin: '0 auto', padding: '2rem' }} data-cy="page.container">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>Discard Adjustment?</h2>
                        <div style={{ display: 'flex', gap: '16px', marginTop: '24px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }} data-cy="page.header">
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold' }} data-cy="page.title">Timesheet Adjustment</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Correct reported hours for payroll.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Adjusted Hours</label>
                        <input
                            data-cy="form.timesheet.hours"
                            type="number"
                            step="0.5"
                            required
                            value={formData.adjustedHours}
                            onChange={(e) => { setFormData({ ...formData, adjustedHours: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Reason for Change</label>
                        <textarea
                            data-cy="form.timesheet.reason"
                            required
                            value={formData.reason}
                            onChange={(e) => { setFormData({ ...formData, reason: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2rem', display: 'flex', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        data-cy="btn-cancel"
                        style={{ padding: '0.75rem 1.5rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.timesheet.save"
                        style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Saving...' : 'Save Adjustment'}
                    </button>
                </div>
            </form>
        </div>
    );
}
