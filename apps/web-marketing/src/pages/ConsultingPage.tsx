import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function ConsultingPage() {
    const services = [
        { icon: '📊', title: 'Governance Review', text: 'Board governance assessment and improvement strategies' },
        { icon: '⚙️', title: 'Operations Consulting', text: 'Streamline workflows and improve efficiency' },
        { icon: '📋', title: 'Policy Development', text: 'Healthcare policies and compliance frameworks' },
        { icon: '🎓', title: 'Staff Training', text: 'Custom training programs for healthcare teams' },
        { icon: '💻', title: 'Digital Strategy', text: 'Technology roadmaps and EMR implementation' },
        { icon: '📈', title: 'Quality Improvement', text: 'Continuous improvement and accreditation prep' },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            <Helmet><title>Healthcare Consulting | {ContentRegistry.APP.NAME}</title></Helmet>

            <header style={{ background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Healthcare Consulting</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Governance, operations, and digital transformation advisory</p>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                    <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '3rem', color: '#333' }}>Advisory Services</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2rem' }}>
                        {services.map((s, i) => (
                            <AnimatedSection key={i} animation="slideUp" delay={i * 0.1}>
                                <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '12px', height: '100%' }}>
                                    <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>{s.icon}</div>
                                    <h3 style={{ color: '#00897b', marginBottom: '0.5rem' }}>{s.title}</h3>
                                    <p style={{ color: '#666' }}>{s.text}</p>
                                </div>
                            </AnimatedSection>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto', textAlign: 'center' }}>
                    <h2 style={{ fontSize: '2rem', marginBottom: '1rem', color: '#333' }}>Industries We Serve</h2>
                    <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'center', gap: '1rem', marginTop: '2rem' }}>
                        {['Long Term Care', 'Hospitals', 'Retirement Homes', 'Clinics', 'Municipalities', 'Healthcare Startups'].map((i, idx) => (
                            <span key={idx} style={{ padding: '0.75rem 1.5rem', backgroundColor: 'white', borderRadius: '50px', color: '#00897b', fontWeight: '500' }}>{i}</span>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#00897b', color: 'white', textAlign: 'center' }}>
                <h2 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Schedule a Consultation</h2>
                <p style={{ marginBottom: '2rem', opacity: 0.9 }}>Let's discuss how we can help your organization</p>
                <Link to={RouteRegistry.CONTACT} style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: 'white', color: '#00897b', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>Contact Us</Link>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
