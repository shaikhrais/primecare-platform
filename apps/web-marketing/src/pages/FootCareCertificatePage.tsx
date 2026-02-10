import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function FootCareCertificatePage() {
    const curriculum = [
        'Anatomy of the Foot and Lower Limb',
        'Diabetic Foot Assessment',
        'Nail Care Techniques',
        'Callus and Corn Management',
        'Ingrown Toenail Treatment',
        'Fungal Nail Care',
        'Wound Care Basics',
        'Documentation and Charting',
    ];

    const features = [
        { icon: '📚', title: '40+ Hours Training', text: 'Comprehensive theory and hands-on practice' },
        { icon: '🏥', title: 'Clinical Placement', text: 'Real patient experience at LTC homes' },
        { icon: '📜', title: 'Accredited', text: 'Recognized by Foot Care Nurses Association' },
        { icon: '💼', title: 'Start Your Business', text: 'Learn how to build your foot care practice' },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>Foot Care Nurse Certificate | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <header style={{ background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <div style={{ display: 'inline-block', padding: '0.5rem 1rem', backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: '50px', marginBottom: '1rem', fontSize: '0.9rem' }}>Now Enrolling</div>
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Foot Care Nurse Certificate Program</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Basic & Advanced Diabetic Foot Care with Wound Care</p>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem' }}>
                    {features.map((f, i) => (
                        <AnimatedSection key={i} animation="scaleUp" delay={i * 0.1}>
                            <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '12px', textAlign: 'center' }}>
                                <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>{f.icon}</div>
                                <h3 style={{ color: '#00897b', marginBottom: '0.5rem' }}>{f.title}</h3>
                                <p style={{ color: '#666' }}>{f.text}</p>
                            </div>
                        </AnimatedSection>
                    ))}
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                    <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '2rem', color: '#333' }}>Curriculum</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '1rem' }}>
                        {curriculum.map((item, i) => (
                            <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', backgroundColor: 'white', borderRadius: '8px' }}>
                                <span style={{ color: '#00897b', fontWeight: 'bold' }}>✓</span>
                                <span style={{ color: '#555' }}>{item}</span>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '600px', margin: '0 auto', backgroundColor: '#00897b', color: 'white', padding: '3rem', borderRadius: '16px', textAlign: 'center' }}>
                    <h2 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Ready to Enroll?</h2>
                    <div style={{ fontSize: '2.5rem', fontWeight: 'bold', marginBottom: '0.5rem' }}>$1,495</div>
                    <p style={{ opacity: 0.9, marginBottom: '2rem' }}>Includes all materials and clinical placement</p>
                    <Link to={RouteRegistry.CONTACT} data-cy="btn-enroll-now" style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: 'white', color: '#00897b', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>Register Now</Link>
                </div>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} data-cy="btn-back-to-home" style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
