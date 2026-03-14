import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { servicesList, ServiceCard, ServicesCTA } from './sections/ServicesSections';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function ServicesPage() {
    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}>
            <Helmet>
                <title>Our Services | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Explore our comprehensive healthcare services including foot care nursing, senior home care, healthcare education, and IT support." />
            </Helmet>
            <header style={{ background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=1920&q=80')`, backgroundSize: 'cover', backgroundPosition: 'center', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>{ContentRegistry.SERVICES.TITLE}</h1>
                <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '600px', margin: '0 auto' }}>{ContentRegistry.SERVICES.SUBTITLE}</p>
            </header>
            <section style={{ padding: '5rem 2rem', maxWidth: '1400px', margin: '0 auto' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '4rem' }}>
                    {servicesList.map((service, index) => <ServiceCard key={service.id} service={service} index={index} />)}
                </div>
            </section>
            <ServicesCTA />
            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
