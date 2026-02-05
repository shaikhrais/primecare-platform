import React from 'react';

export default function SupportHub() {
    return (
        <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>Support Hub</h2>
                <p style={{ color: '#6b7280' }}>How can we help you today?</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem' }}>
                <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>📞</div>
                    <h3 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '0.5rem' }}>Call Us</h3>
                    <p style={{ color: '#4b5563', marginBottom: '1.5rem' }}>Speak directly with a care coordinator for immediate assistance.</p>
                    <a href="tel:18005550199" style={{ color: '#004d40', fontWeight: '600', textDecoration: 'none', fontSize: '1.125rem' }}>1-800-555-0199</a>
                </div>

                <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>✉️</div>
                    <h3 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '0.5rem' }}>Email Support</h3>
                    <p style={{ color: '#4b5563', marginBottom: '1.5rem' }}>Send us a message and we'll get back to you within 24 hours.</p>
                    <a href="mailto:support@primecare.ca" style={{ color: '#004d40', fontWeight: '600', textDecoration: 'none', fontSize: '1.125rem' }}>support@primecare.ca</a>
                </div>

                <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>❓</div>
                    <h3 style={{ fontSize: '1.25rem', fontWeight: '700', marginBottom: '0.5rem' }}>Knowledge Base</h3>
                    <p style={{ color: '#4b5563', marginBottom: '1.5rem' }}>Browse our frequently asked questions and care guides.</p>
                    <button style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}>View FAQs</button>
                </div>
            </div>

            <div style={{ marginTop: '3rem', backgroundColor: 'var(--pc-primary-dark)', color: 'white', padding: '3rem', borderRadius: '1rem', textAlign: 'center' }}>
                <h3 style={{ fontSize: '1.5rem', marginBottom: '1rem' }}>Need Direct Help?</h3>
                <p style={{ opacity: 0.8, maxWidth: '600px', margin: '0 auto', marginBottom: '2rem' }}>Connect with our care coordination team instantly through our secure messaging portal.</p>
                <button
                    onClick={() => window.location.href = '/support'}
                    style={{ padding: '0.75rem 2rem', backgroundColor: 'white', color: 'var(--pc-primary-dark)', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    Open Messaging Portal
                </button>
            </div>
        </div>
    );
}
