import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function SupportTicketForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        subject: '',
        category: 'Technical Support',
        priority: 'Medium',
        description: '',
        contactPhone: ''
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
            const response = await fetch(`${API_URL}/v1/support/tickets`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Support ticket created!', 'success');
                setIsDirty(false);
                navigate('/support/manual');
            } else {
                showToast('Failed to create ticket', 'error');
            }
        } catch (error) {
            showToast('Error during submission', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '700px', margin: '0 auto', padding: '2rem' }} data-cy="page.container">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Discard Ticket?</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>Your support request is not yet submitted. Discard it?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">Contact Helpdesk</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Open a support ticket for technical issues or clinical inquiries.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Subject Line</label>
                        <input
                            data-cy="form.supportTicket.subject"
                            required
                            placeholder="Brief summary of the issue..."
                            value={formData.subject}
                            onChange={(e) => { setFormData({ ...formData, subject: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Category</label>
                            <select
                                data-cy="form.supportTicket.category"
                                value={formData.category}
                                onChange={(e) => { setFormData({ ...formData, category: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option>Technical Support</option>
                                <option>Clinical Question</option>
                                <option>Billing Issue</option>
                                <option>Feature Request</option>
                            </select>
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Priority</label>
                            <select
                                data-cy="form.supportTicket.priority"
                                value={formData.priority}
                                onChange={(e) => { setFormData({ ...formData, priority: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option>Low</option>
                                <option>Medium</option>
                                <option>High</option>
                                <option>Urgent</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Issue Description</label>
                        <textarea
                            data-cy="form.supportTicket.description"
                            required
                            placeholder="Provide details to help us resolve this faster..."
                            value={formData.description}
                            onChange={(e) => { setFormData({ ...formData, description: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '150px' }}
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Callback Number (Optional)</label>
                        <input
                            data-cy="form.supportTicket.phone"
                            type="tel"
                            value={formData.contactPhone}
                            onChange={(e) => { setFormData({ ...formData, contactPhone: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
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
                        data-cy="form.supportTicket.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Sending...' : 'Create Ticket'}
                    </button>
                </div>
            </form>
        </div>
    );
}
