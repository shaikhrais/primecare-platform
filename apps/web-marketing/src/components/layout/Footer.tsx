import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function Footer() {
    return (
        <footer style={{ backgroundColor: '#004d40', color: 'white', padding: '3rem 2rem' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem' }}>
                <div>
                    <h3 style={{ fontSize: '1.25rem', marginBottom: '1rem' }}>{ContentRegistry.APP.NAME}</h3>
                    <p style={{ opacity: 0.8 }}>{ContentRegistry.APP.TAGLINE}</p>
                </div>
                <div>
                    <h4 style={{ fontSize: '1.1rem', marginBottom: '1rem' }}>Quick Links</h4>
                    <ul style={{ listStyle: 'none', padding: 0, opacity: 0.8 }}>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.HOME} style={{ color: 'white', textDecoration: 'none' }}>Home</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.SERVICES} style={{ color: 'white', textDecoration: 'none' }}>Services</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.BLOG} style={{ color: 'white', textDecoration: 'none' }}>Blog</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.CAREERS} style={{ color: 'white', textDecoration: 'none' }}>Careers</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.CONTACT} style={{ color: 'white', textDecoration: 'none' }}>Contact</Link></li>
                    </ul>
                </div>
                <div>
                    <h4 style={{ fontSize: '1.1rem', marginBottom: '1rem' }}>Services</h4>
                    <ul style={{ listStyle: 'none', padding: 0, opacity: 0.8 }}>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.SERVICE_FOOT_CARE} style={{ color: 'white', textDecoration: 'none' }}>Foot Care</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.SERVICE_SENIOR} style={{ color: 'white', textDecoration: 'none' }}>Senior Care</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.SERVICE_EDUCATION} style={{ color: 'white', textDecoration: 'none' }}>Nurse Education</Link></li>
                    </ul>
                </div>
                <div>
                    <h4 style={{ fontSize: '1.1rem', marginBottom: '1rem' }}>Legal</h4>
                    <ul style={{ listStyle: 'none', padding: 0, opacity: 0.8 }}>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.PRIVACY} style={{ color: 'white', textDecoration: 'none' }}>Privacy Policy</Link></li>
                        <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.TERMS} style={{ color: 'white', textDecoration: 'none' }}>Terms of Service</Link></li>
                    </ul>
                </div>
            </div>
            <div style={{ textAlign: 'center', marginTop: '3rem', paddingTop: '1rem', borderTop: '1px solid rgba(255,255,255,0.1)', opacity: 0.6, fontSize: '0.9rem' }}>
                © {new Date().getFullYear()} {ContentRegistry.APP.NAME}. All rights reserved.
            </div>
        </footer>
    );
}
