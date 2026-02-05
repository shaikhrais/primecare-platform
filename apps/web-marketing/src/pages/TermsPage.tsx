import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function TermsPage() {
    return (
        <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '800px', margin: '0 auto', padding: '4rem 2rem' }}>
            <Helmet>
                <title>{ContentRegistry.LEGAL.TERMS_TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#004d40', fontSize: '2.5rem', marginBottom: '2rem' }}>{ContentRegistry.LEGAL.TERMS_TITLE}</h1>
            <p style={{ color: '#666', marginBottom: '2rem' }}>Last updated: February 2026</p>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>1. Acceptance of Terms</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    By accessing and using PrimeCare Health Services ("Service"), you accept and agree to be bound by the terms and provisions of this agreement. If you do not agree to abide by these terms, please do not use this service.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>2. Services Provided</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    PrimeCare provides personal support worker services, foot care nursing, senior home care, and healthcare education. Services are subject to availability and geographic coverage areas.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>3. User Responsibilities</h2>
                <ul style={{ lineHeight: '1.8', color: '#444', paddingLeft: '1.5rem' }}>
                    <li>Provide accurate and complete information during registration</li>
                    <li>Maintain the confidentiality of your account credentials</li>
                    <li>Notify us immediately of any unauthorized use of your account</li>
                    <li>Comply with all applicable laws and regulations</li>
                </ul>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>4. Payment Terms</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    Payment for services is due upon completion unless otherwise agreed. We accept major credit cards and direct bank transfers. Cancellation of scheduled appointments requires 24-hour notice to avoid cancellation fees.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>5. Limitation of Liability</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    PrimeCare shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of or inability to use the service.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>6. Changes to Terms</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    We reserve the right to modify these terms at any time. Changes will be effective immediately upon posting to the website. Your continued use of the service constitutes acceptance of the modified terms.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>7. Contact Us</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    If you have questions about these Terms, please contact us at <a href="mailto:legal@primecare.ca" style={{ color: '#004d40' }}>legal@primecare.ca</a>.
                </p>
            </section>

            <div style={{ marginTop: '3rem', paddingTop: '2rem', borderTop: '1px solid #eee' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#004d40', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
