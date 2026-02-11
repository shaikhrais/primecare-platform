import React, { useState } from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function ContactPage() {
    const [formData, setFormData] = useState({
        full_name: '',
        email: '',
        phone: '',
        message: '',
    });
    const [status, setStatus] = useState<'idle' | 'sending' | 'success' | 'error'>('idle');

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setStatus('sending');

        try {
            const res = await fetch(`${API_URL}/v1/public/leads`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    ...formData,
                    source: 'contact_form',
                }),
            });

            if (res.ok) {
                setStatus('success');
                setFormData({ full_name: '', email: '', phone: '', message: '' });
            } else {
                setStatus('error');
            }
        } catch (e) {
            setStatus('error');
        }
    };

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '1200px', margin: '0 auto', padding: '4rem 2rem' }} data-cy="contact-page-container">
            <Helmet>
                <title>{ContentRegistry.CONTACT.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#00897b', fontSize: '2.5rem', textAlign: 'center', marginBottom: '1rem' }} data-cy="contact-header">{ContentRegistry.CONTACT.TITLE}</h1>
            <p style={{ textAlign: 'center', fontSize: '1.2rem', color: '#666', marginBottom: '3rem' }} data-cy="contact-subtitle">
                We'd love to hear from you. Reach out with any questions or to schedule a consultation.
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '3rem' }}>
                {/* Contact Form */}
                <div>
                    <h2 style={{ color: '#333', marginBottom: '1.5rem' }}>Send us a Message</h2>

                    {status === 'success' && (
                        <div data-cy="contact-success" style={{ padding: '1rem', backgroundColor: '#e8f5e9', borderRadius: '8px', marginBottom: '1rem', color: '#2e7d32' }}>
                            Thank you! We'll be in touch shortly.
                        </div>
                    )}

                    {status === 'error' && (
                        <div data-cy="contact-error" style={{ padding: '1rem', backgroundColor: '#ffebee', borderRadius: '8px', marginBottom: '1rem', color: '#c62828' }}>
                            Something went wrong. Please try again.
                        </div>
                    )}

                    <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.CONTACT.FORM.NAME}</label>
                            <input
                                data-cy="inp-name"
                                type="text"
                                required
                                value={formData.full_name}
                                onChange={e => setFormData(prev => ({ ...prev, full_name: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.CONTACT.FORM.EMAIL}</label>
                            <input
                                data-cy="inp-email"
                                type="email"
                                required
                                value={formData.email}
                                onChange={e => setFormData(prev => ({ ...prev, email: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Phone (Optional)</label>
                            <input
                                data-cy="inp-phone"
                                type="tel"
                                value={formData.phone}
                                onChange={e => setFormData(prev => ({ ...prev, phone: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.CONTACT.FORM.MESSAGE}</label>
                            <textarea
                                data-cy="inp-message"
                                rows={5}
                                required
                                value={formData.message}
                                onChange={e => setFormData(prev => ({ ...prev, message: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}
                            />
                        </div>
                        <button
                            data-cy="btn-submit-contact"
                            type="submit"
                            disabled={status === 'sending'}
                            style={{
                                padding: '1rem',
                                backgroundColor: status === 'sending' ? '#999' : '#00897b',
                                color: 'white',
                                border: 'none',
                                borderRadius: '4px',
                                fontSize: '1rem',
                                cursor: status === 'sending' ? 'not-allowed' : 'pointer'
                            }}
                        >
                            {status === 'sending' ? 'Sending...' : ContentRegistry.CONTACT.FORM.SUBMIT}
                        </button>
                    </form>
                </div>

                {/* Contact Info */}
                <div>
                    <h2 style={{ color: '#333', marginBottom: '1.5rem' }}>Contact Information</h2>

                    <div style={{ marginBottom: '2rem' }}>
                        <h3 style={{ fontSize: '1rem', color: '#666', marginBottom: '0.5rem' }}>Email</h3>
                        <a href="mailto:info@primecare.ca" style={{ color: '#00897b', fontSize: '1.1rem' }}>info@primecare.ca</a>
                    </div>

                    <div style={{ marginBottom: '2rem' }}>
                        <h3 style={{ fontSize: '1rem', color: '#666', marginBottom: '0.5rem' }}>Phone</h3>
                        <a href="tel:+14165551234" style={{ color: '#00897b', fontSize: '1.1rem' }}>+1 (416) 555-1234</a>
                    </div>

                    <div style={{ marginBottom: '2rem' }}>
                        <h3 style={{ fontSize: '1rem', color: '#666', marginBottom: '0.5rem' }}>Office Hours</h3>
                        <p style={{ color: '#444' }}>Monday - Friday: 8:00 AM - 6:00 PM</p>
                        <p style={{ color: '#444' }}>Saturday: 9:00 AM - 1:00 PM</p>
                        <p style={{ color: '#444' }}>Sunday: Closed</p>
                    </div>

                    <div style={{ marginBottom: '2rem' }}>
                        <h3 style={{ fontSize: '1rem', color: '#666', marginBottom: '0.5rem' }}>Address</h3>
                        <p style={{ color: '#444' }}>
                            123 Healthcare Drive<br />
                            Toronto, ON M5V 1K1<br />
                            Canada
                        </p>
                    </div>

                    <div style={{ backgroundColor: '#f5f5f5', padding: '1.5rem', borderRadius: '8px' }}>
                        <h3 style={{ color: '#00897b', marginBottom: '0.5rem' }}>Need Immediate Assistance?</h3>
                        <p style={{ color: '#666', marginBottom: '1rem' }}>Book a consultation to speak with our care coordinators.</p>
                        <Link to={RouteRegistry.BOOKING} style={{ display: 'inline-block', padding: '0.75rem 1.5rem', backgroundColor: '#00897b', color: 'white', textDecoration: 'none', borderRadius: '4px' }}>
                            Book Consultation
                        </Link>
                    </div>
                </div>
            </div>

            <div style={{ textAlign: 'center', marginTop: '4rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
