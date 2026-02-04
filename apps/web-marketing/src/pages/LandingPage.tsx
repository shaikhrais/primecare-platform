import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from '@primecare/shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function LandingPage() {
    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            {/* Navbar */}
            <nav style={{ display: 'flex', justifyContent: 'space-between', padding: '1.5rem 2rem', backgroundColor: 'white', alignItems: 'center', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
                <div style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#004d40' }}>{ContentRegistry.APP.NAME}</div>
                <div style={{ display: 'flex', gap: '2rem' }}>
                    <Link to={RouteRegistry.SERVICES} style={{ textDecoration: 'none', color: '#333' }}>Services</Link>
                    <Link to={RouteRegistry.BLOG} style={{ textDecoration: 'none', color: '#333' }}>Blog</Link>
                    <Link to={RouteRegistry.CONTACT} style={{ textDecoration: 'none', color: '#333' }}>Contact</Link>
                </div>
                <Link
                    to={RouteRegistry.SERVICES}
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', textDecoration: 'none', borderRadius: '4px', fontWeight: 'bold' }}
                >
                    {ContentRegistry.HERO.CTA_PRIMARY}
                </Link>
            </nav>

            {/* Hero */}
            <header style={{
                backgroundColor: '#e0f2f1', padding: '5rem 2rem', textAlign: 'center',
                backgroundImage: 'linear-gradient(to bottom, #e0f2f1, #fff)'
            }}>
                <h1 style={{ fontSize: '3.5rem', marginBottom: '1.5rem', color: '#004d40' }}>{ContentRegistry.HERO.TITLE}</h1>
                <p style={{ fontSize: '1.5rem', marginBottom: '3rem', color: '#555', maxWidth: '800px', margin: '0 auto 3rem auto' }}>
                    {ContentRegistry.HERO.SUBTITLE}
                </p>
                <div style={{ display: 'flex', justifyContent: 'center', gap: '1rem' }}>
                    <Link
                        to={RouteRegistry.SERVICES}
                        style={{ padding: '1rem 2rem', backgroundColor: '#004d40', color: 'white', textDecoration: 'none', borderRadius: '4px', fontSize: '1.1rem', fontWeight: 'bold' }}
                    >
                        {ContentRegistry.HERO.CTA_PRIMARY}
                    </Link>
                    <Link
                        to={RouteRegistry.SERVICES}
                        style={{ padding: '1rem 2rem', backgroundColor: 'white', color: '#004d40', textDecoration: 'none', borderRadius: '4px', fontSize: '1.1rem', fontWeight: 'bold', border: '1px solid #004d40' }}
                    >
                        {ContentRegistry.HERO.CTA_SECONDARY}
                    </Link>
                </div>
            </header>

            {/* Features Preview */}
            <section style={{ padding: '4rem 2rem', maxWidth: '1200px', margin: '0 auto', textAlign: 'center' }}>
                <h2 style={{ fontSize: '2.5rem', marginBottom: '3rem', color: '#333' }}>Why Choose {ContentRegistry.APP.NAME}?</h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem' }}>
                    <div style={{ padding: '2rem', border: '1px solid #eee', borderRadius: '8px' }}>
                        <h3 style={{ fontSize: '1.5rem', marginBottom: '1rem', color: '#004d40' }}>Qualified PSWs</h3>
                        <p style={{ color: '#666' }}>All our Personal Support Workers are fully vetted, certified, and background checked.</p>
                    </div>
                    <div style={{ padding: '2rem', border: '1px solid #eee', borderRadius: '8px' }}>
                        <h3 style={{ fontSize: '1.5rem', marginBottom: '1rem', color: '#004d40' }}>Flexible Scheduling</h3>
                        <p style={{ color: '#666' }}>Book care when you need it. Morning, afternoon, or overnight support available.</p>
                    </div>
                    <div style={{ padding: '2rem', border: '1px solid #eee', borderRadius: '8px' }}>
                        <h3 style={{ fontSize: '1.5rem', marginBottom: '1rem', color: '#004d40' }}>Real-time Updates</h3>
                        <p style={{ color: '#666' }}>Track visits and get peace of mind with our mobile app tracking.</p>
                    </div>
                </div>
            </section>
        </div>
    );
}
