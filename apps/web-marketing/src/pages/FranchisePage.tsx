import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function FranchisePage() {
    const benefits = [
        { icon: '📈', title: 'Proven Model', text: 'Established systems for success' },
        { icon: '🎓', title: 'Training', text: '2-week program plus ongoing support' },
        { icon: '💼', title: 'Marketing', text: 'National campaigns and local support' },
        { icon: '🔧', title: 'Technology', text: 'Proprietary scheduling software' },
        { icon: '🤝', title: 'Territory', text: 'Exclusive geographic territory' },
        { icon: '📊', title: 'Coaching', text: 'Regular business coaching sessions' },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>Franchise Opportunity | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <header style={{
                background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))',
                color: 'white', padding: '5rem 2rem', textAlign: 'center',
            }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Franchise Opportunity</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Own a rewarding business in home healthcare</p>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '1000px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '2rem', textAlign: 'center' }}>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px' }}>
                        <div style={{ fontSize: '2rem', fontWeight: 'bold', color: '#004d40' }}>$75K-$150K</div>
                        <div style={{ color: '#666' }}>Total Investment</div>
                    </div>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px' }}>
                        <div style={{ fontSize: '2rem', fontWeight: 'bold', color: '#004d40' }}>$35K</div>
                        <div style={{ color: '#666' }}>Franchise Fee</div>
                    </div>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px' }}>
                        <div style={{ fontSize: '2rem', fontWeight: 'bold', color: '#004d40' }}>6%</div>
                        <div style={{ color: '#666' }}>Royalty Fee</div>
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                    <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '3rem', color: '#333' }}>Why Choose Us?</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem' }}>
                        {benefits.map((b, i) => (
                            <AnimatedSection key={i} animation="slideUp" delay={i * 0.1}>
                                <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '12px', textAlign: 'center' }}>
                                    <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>{b.icon}</div>
                                    <h3 style={{ color: '#004d40', marginBottom: '0.5rem' }}>{b.title}</h3>
                                    <p style={{ color: '#666' }}>{b.text}</p>
                                </div>
                            </AnimatedSection>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#004d40', color: 'white', textAlign: 'center' }}>
                <h2 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Ready to Get Started?</h2>
                <p style={{ marginBottom: '2rem', opacity: 0.9 }}>Contact us for a franchise information kit</p>
                <Link to={RouteRegistry.CONTACT} style={{ padding: '1rem 2rem', backgroundColor: 'white', color: '#004d40', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>Contact Us</Link>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#004d40', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
