import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../App';

export default function LeadEntryForm() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        fullName: '',
        email: '',
        phone: '',
        source: 'Website',
        notes: ''
    });

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        setTimeout(() => {
            showToast('Lead created successfully', 'success');
            setIsDirty(false);
            navigate('/leads');
            setSubmitting(false);
        }, 800);
    };

    return (
        <div style={{ maxWidth: '600px', margin: '0 auto', padding: '2rem' }} data-cy="form.lead.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>Discard Lead?</h2>
                        <div style={{ display: 'flex', gap: '16px', marginTop: '24px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold' }}>New Lead Entry</h2>
                <p style={{ color: '#6b7280' }}>Record an offline inquiry.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.4rem', fontWeight: 500 }}>Inquiry Source</label>
                        <select
                            data-cy="form.lead.source"
                            value={formData.source}
                            onChange={(e) => { setFormData({ ...formData, source: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option>Website</option>
                            <option>Phone Call</option>
                            <option>Referral</option>
                            <option>Walk-in</option>
                        </select>
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.4rem', fontWeight: 500 }}>Lead Name</label>
                        <input
                            data-cy="form.lead.fullName"
                            required
                            value={formData.fullName}
                            onChange={(e) => { setFormData({ ...formData, fullName: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2rem' }}>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.lead.save"
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Saving...' : 'Create Lead'}
                    </button>
                </div>
            </form>
        </div>
    );
}
