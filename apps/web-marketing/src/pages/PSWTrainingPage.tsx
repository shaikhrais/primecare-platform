import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function PSWTrainingPage() {
    const modules = [
        'Personal Care Techniques', 'Safety and Mobility', 'Nutrition and Meal Prep',
        'Dementia Care', 'Communication Skills', 'First Aid and CPR',
        'Medication Assistance', 'Documentation', 'Clinical Placement',
    ];

    const features = [
        { icon: '⏱️', title: '600+ Hours', text: 'Comprehensive training program' },
        { icon: '🏥', title: 'Clinical Placement', text: 'Hands-on experience in care settings' },
        { icon: '📜', title: 'Certificate', text: 'Recognized PSW certification upon completion' },
        { icon: '💼', title: 'Job Placement', text: 'Career support and job connections' },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            <Helmet><title>PSW Training Program | {ContentRegistry.APP.NAME}</title></Helmet>

            <header style={{ background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>PSW Training Program</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Start your career as a Personal Support Worker</p>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem' }}>
                    {features.map((f, i) => (
                        <AnimatedSection key={i} animation="scaleUp" delay={i * 0.1}>
                            <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '12px', textAlign: 'center' }}>
                                <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>{f.icon}</div>
                                <h3 style={{ color: '#004d40', marginBottom: '0.5rem' }}>{f.title}</h3>
                                <p style={{ color: '#666' }}>{f.text}</p>
                            </div>
                        </AnimatedSection>
                    ))}
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                    <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '2rem', color: '#333' }}>Training Modules</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem' }}>
                        {modules.map((m, i) => (
                            <div key={i} style={{ padding: '1rem', backgroundColor: 'white', borderRadius: '8px', display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                                <span style={{ color: '#004d40', fontWeight: 'bold' }}>✓</span>
                                <span style={{ color: '#555' }}>{m}</span>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#004d40', color: 'white', textAlign: 'center' }}>
                <h2 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Start Your Healthcare Career</h2>
                <p style={{ marginBottom: '2rem', opacity: 0.9 }}>Next cohort starting soon - limited spots available</p>
                <Link to={RouteRegistry.CONTACT} style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: 'white', color: '#004d40', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>Apply Now</Link>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#004d40', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
