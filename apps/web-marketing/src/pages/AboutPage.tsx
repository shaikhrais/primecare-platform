import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { ValuesSection, TimelineSection, TeamSection, AboutCTA } from './sections/AboutSections';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function AboutPage() {
    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }} data-cy="about-page-container">
            <Helmet>
                <title>About Us | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Learn about PrimeCare's mission to deliver compassionate, professional healthcare services in the comfort of your home." />
            </Helmet>
            <header style={{ background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=1920&q=80')`, backgroundSize: 'cover', backgroundPosition: 'center', color: 'white', padding: '6rem 2rem', textAlign: 'center' }}>
                <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>About {ContentRegistry.APP.NAME}</h1>
                <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '700px', margin: '0 auto' }}>Dedicated to delivering compassionate, professional healthcare in the comfort of your home since 2010.</p>
            </header>
            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '4rem', alignItems: 'center' }}>
                    <div>
                        <h2 style={{ fontSize: '2.5rem', marginBottom: '1.5rem', color: '#00897b' }}>{ContentRegistry.ABOUT.MISSION}</h2>
                        <p style={{ fontSize: '1.2rem', lineHeight: '1.8', color: '#444', marginBottom: '2rem' }} data-cy="about-mission-text">{ContentRegistry.ABOUT.MISSION_TEXT}</p>
                        <p style={{ fontSize: '1.1rem', lineHeight: '1.8', color: '#666' }}>At PrimeCare, we believe that quality healthcare should be accessible to everyone, regardless of age or ability. Our team of certified professionals is committed to providing personalized care that respects the dignity and independence of every client.</p>
                    </div>
                    <div><img src="https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=600&q=80" alt="Healthcare team" style={{ width: '100%', borderRadius: '20px', boxShadow: '0 20px 50px rgba(0,0,0,0.15)' }} /></div>
                </div>
            </section>
            <ValuesSection />
            <TimelineSection />
            <TeamSection />
            <AboutCTA />
            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
