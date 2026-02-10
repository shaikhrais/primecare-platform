import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function PrivacyPage() {
    return (
        <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '800px', margin: '0 auto', padding: '4rem 2rem' }}>
            <Helmet>
                <title>{ContentRegistry.LEGAL.PRIVACY_TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#00897b', fontSize: '2.5rem', marginBottom: '2rem' }}>{ContentRegistry.LEGAL.PRIVACY_TITLE}</h1>
            <p style={{ color: '#666', marginBottom: '2rem' }}>Effective Date: February 2026</p>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>Introduction</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    PrimeCare Health Services ("we", "our", "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our services. We comply with the Personal Information Protection and Electronic Documents Act (PIPEDA) and Ontario's Personal Health Information Protection Act (PHIPA).
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>Information We Collect</h2>
                <ul style={{ lineHeight: '1.8', color: '#444', paddingLeft: '1.5rem' }}>
                    <li><strong>Personal Information:</strong> Name, email, phone number, address</li>
                    <li><strong>Health Information:</strong> Medical history, care requirements, health conditions</li>
                    <li><strong>Usage Data:</strong> Pages visited, features used, device information</li>
                    <li><strong>Payment Information:</strong> Billing address, payment method details (processed by Stripe)</li>
                </ul>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>How We Use Your Information</h2>
                <ul style={{ lineHeight: '1.8', color: '#444', paddingLeft: '1.5rem' }}>
                    <li>To provide and maintain our healthcare services</li>
                    <li>To match you with appropriate care providers</li>
                    <li>To process payments and send billing information</li>
                    <li>To communicate about appointments and service updates</li>
                    <li>To improve our services and user experience</li>
                </ul>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>Data Security</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    We implement industry-standard security measures including encryption, secure servers, and access controls to protect your personal and health information. All data is stored on secure cloud infrastructure with regular security audits.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>Your Rights</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    You have the right to access, correct, or delete your personal information. You may also withdraw consent for data processing at any time. To exercise these rights, contact our Privacy Officer at <a href="mailto:privacy@primecare.ca" style={{ color: '#00897b' }}>privacy@primecare.ca</a>.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>Third-Party Services</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    We may share information with trusted third parties who assist in operating our services, including payment processors (Stripe), cloud hosting (Cloudflare), and analytics providers. These parties are contractually obligated to maintain confidentiality.
                </p>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 style={{ color: '#333', fontSize: '1.5rem', marginBottom: '1rem' }}>Contact Us</h2>
                <p style={{ lineHeight: '1.8', color: '#444' }}>
                    For privacy-related inquiries:<br />
                    Privacy Officer<br />
                    PrimeCare Health Services<br />
                    Email: <a href="mailto:privacy@primecare.ca" style={{ color: '#00897b' }}>privacy@primecare.ca</a>
                </p>
            </section>

            <div style={{ marginTop: '3rem', paddingTop: '2rem', borderTop: '1px solid #eee' }}>
                <Link to={RouteRegistry.HOME} data-cy="btn-back-to-home" style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
