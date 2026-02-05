import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function StaffingPage() {
    const services = [
        { icon: '👩‍⚕️', title: 'PSW Staffing', text: 'Certified Personal Support Workers for home care, LTC, and hospitals' },
        { icon: '💉', title: 'Nursing Staff', text: 'RNs, RPNs, and specialized nurses for all healthcare settings' },
        { icon: '🦶', title: 'Foot Care Nurses', text: 'Certified foot care specialists for clinics and facilities' },
        { icon: '📋', title: 'Administrative', text: 'Healthcare admin, coordinators, and office support staff' },
    ];

    const benefits = [
        'Pre-screened and vetted candidates',
        'Criminal record checks completed',
        'Credentials verified with CNO',
        'Flexible contract options',
        '24/7 replacement guarantee',
        'Ongoing performance monitoring',
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>Healthcare Staffing | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <header style={{ background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Healthcare Staffing</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Quality healthcare professionals for LTC homes, hospitals, and clinics</p>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                    <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '3rem', color: '#333' }}>Staffing Services</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem' }}>
                        {services.map((s, i) => (
                            <AnimatedSection key={i} animation="slideUp" delay={i * 0.1}>
                                <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '12px', textAlign: 'center', height: '100%' }}>
                                    <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>{s.icon}</div>
                                    <h3 style={{ color: '#004d40', marginBottom: '0.5rem' }}>{s.title}</h3>
                                    <p style={{ color: '#666' }}>{s.text}</p>
                                </div>
                            </AnimatedSection>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '3rem', alignItems: 'center' }}>
                    <div>
                        <h2 style={{ fontSize: '2rem', marginBottom: '1.5rem', color: '#333' }}>Why Choose Us?</h2>
                        <ul style={{ listStyle: 'none', padding: 0 }}>
                            {benefits.map((b, i) => (
                                <li key={i} style={{ padding: '0.75rem 0', display: 'flex', alignItems: 'center', gap: '1rem', color: '#555' }}>
                                    <span style={{ color: '#004d40', fontWeight: 'bold' }}>✓</span> {b}
                                </li>
                            ))}
                        </ul>
                    </div>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.05)' }}>
                        <h3 style={{ marginBottom: '1rem', color: '#333' }}>Request Staff</h3>
                        <p style={{ color: '#666', marginBottom: '1.5rem' }}>Contact us for staffing solutions</p>
                        <Link to={RouteRegistry.CONTACT} style={{ display: 'block', padding: '1rem', backgroundColor: '#004d40', color: 'white', textDecoration: 'none', borderRadius: '8px', textAlign: 'center', fontWeight: 'bold' }}>Get a Quote</Link>
                    </div>
                </div>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#004d40', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
