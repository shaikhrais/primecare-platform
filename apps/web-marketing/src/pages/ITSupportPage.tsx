import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function ITSupportPage() {
    return (
        <div style={{ padding: '2rem', maxWidth: '800px', margin: '0 auto', fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>{ContentRegistry.SERVICES.IT_SUPPORT.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>
            <h1 style={{ color: '#00897b', fontSize: '2.5rem' }}>{ContentRegistry.SERVICES.IT_SUPPORT.TITLE}</h1>
            <p style={{ fontSize: '1.2rem', color: '#555', lineHeight: '1.8', margin: '1rem 0 2rem' }}>
                {ContentRegistry.SERVICES.IT_SUPPORT.DESCRIPTION}
            </p>

            <div style={{ backgroundColor: '#f3e5f5', padding: '2rem', borderRadius: '8px', marginBottom: '2rem' }}>
                <h3 style={{ color: '#4a148c', marginBottom: '1rem' }}>Healthcare IT Solutions:</h3>
                <ul style={{ lineHeight: '1.8', color: '#4a148c' }}>
                    <li>EMR/EHR System Implementation & Support</li>
                    <li>Telehealth Setup & Troubleshooting</li>
                    <li>Cybersecurity & HIPAA/PHIPA Compliance</li>
                    <li>Network Infrastructure for Clinics</li>
                    <li>24/7 Remote Helpdesk</li>
                </ul>
            </div>

            <Link to={RouteRegistry.BOOKING} style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: '#4a148c', color: 'white', textDecoration: 'none', borderRadius: '4px', fontWeight: 'bold' }}>
                Get IT Support
            </Link>
            <br /><br />
            <Link to={RouteRegistry.SERVICES} style={{ color: '#666', textDecoration: 'underline' }}>Back to Services</Link>
        </div>
    );
}
