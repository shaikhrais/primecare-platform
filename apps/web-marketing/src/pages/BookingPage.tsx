import React, { useState } from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function BookingPage() {
    const [formData, setFormData] = useState({
        full_name: '',
        email: '',
        phone: '',
        service_type: '',
        urgency: 'immediate'
    });
    const [status, setStatus] = useState<'idle' | 'sending' | 'success' | 'error'>('idle');

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setStatus('sending');

        try {
            // Mock API call or real endpoint
            const res = await fetch(`${API_URL}/v1/public/bookings`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData),
            });

            if (res.ok) {
                setStatus('success');
                setFormData({ full_name: '', email: '', phone: '', service_type: '', urgency: 'immediate' });
            } else {
                setStatus('error');
            }
        } catch (e) {
            setStatus('error');
        }
    };

    return (
        <div style={{ padding: '2rem', maxWidth: '800px', margin: '0 auto' }} data-cy="page.container">
            <Helmet>
                <title>{ContentRegistry.BOOKING.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#00897b' }} data-cy="page.title">{ContentRegistry.BOOKING.TITLE}</h1>
            <p className="lead" data-cy="page.header">{ContentRegistry.BOOKING.SUBTITLE}</p>

            {status === 'success' && (
                <div style={{ padding: '1rem', backgroundColor: '#e8f5e9', borderRadius: '8px', marginTop: '1rem', color: '#2e7d32' }}>
                    Booking request received! We will contact you shortly.
                </div>
            )}

            {status === 'error' && (
                <div style={{ padding: '1rem', backgroundColor: '#ffebee', borderRadius: '8px', marginTop: '1rem', color: '#c62828' }}>
                    Something went wrong. Please try again.
                </div>
            )}

            <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem', marginTop: '2rem' }}>
                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }} data-cy="lbl-name">Full Name</label>
                    <input
                        data-cy="inp-name"
                        type="text"
                        required
                        value={formData.full_name}
                        onChange={e => setFormData({ ...formData, full_name: e.target.value })}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                    />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Email Address</label>
                    <input
                        data-cy="inp-email"
                        type="email"
                        required
                        value={formData.email}
                        onChange={e => setFormData({ ...formData, email: e.target.value })}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                    />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Phone Number</label>
                    <input
                        data-cy="inp-phone"
                        type="tel"
                        required
                        value={formData.phone}
                        onChange={e => setFormData({ ...formData, phone: e.target.value })}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                    />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.BOOKING.FORM.SERVICE_TYPE}</label>
                    <select
                        data-cy="sel-service"
                        value={formData.service_type}
                        onChange={e => setFormData({ ...formData, service_type: e.target.value })}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                        required
                    >
                        <option value="">Select a Service...</option>
                        <option value="foot-care">Foot Care</option>
                        <option value="senior-care">Senior Home Care</option>
                        <option value="education">Nurse Education</option>
                        <option value="it-support">IT Support</option>
                    </select>
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.BOOKING.FORM.URGENCY}</label>
                    <select
                        data-cy="sel-urgency"
                        value={formData.urgency}
                        onChange={e => setFormData({ ...formData, urgency: e.target.value })}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                    >
                        <option value="immediate">Immediately</option>
                        <option value="week">Within a week</option>
                        <option value="month">Within a month</option>
                        <option value="info">Just researching</option>
                    </select>
                </div>

                <button
                    data-cy="btn-submit-booking"
                    type="submit"
                    disabled={status === 'sending'}
                    className="btn-primary"
                    style={{
                        padding: '1rem',
                        backgroundColor: status === 'sending' ? '#999' : '#00897b',
                        color: 'white',
                        border: 'none',
                        borderRadius: '4px',
                        fontSize: '1.1rem',
                        cursor: status === 'sending' ? 'not-allowed' : 'pointer'
                    }}
                >
                    {status === 'sending' ? 'Sending Request...' : ContentRegistry.BOOKING.FORM.SUBMIT_BTN}
                </button>
            </form>
        </div>
    );
}
