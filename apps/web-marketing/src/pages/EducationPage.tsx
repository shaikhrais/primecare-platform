import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function EducationPage() {
    return (
        <div style={{ padding: '2rem', maxWidth: '800px', margin: '0 auto', fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>{ContentRegistry.SERVICES.EDUCATION.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>
            <h1 style={{ color: '#00897b', fontSize: '2.5rem' }}>{ContentRegistry.SERVICES.EDUCATION.TITLE}</h1>
            <p style={{ fontSize: '1.2rem', color: '#555', lineHeight: '1.8', margin: '1rem 0 2rem' }}>
                {ContentRegistry.SERVICES.EDUCATION.DESCRIPTION}
            </p>

            <div style={{ backgroundColor: '#e0f7fa', padding: '2rem', borderRadius: '8px', marginBottom: '2rem' }}>
                <h3 style={{ color: '#006064', marginBottom: '1rem' }}>Training Modules Available:</h3>
                <ul style={{ lineHeight: '1.8', color: '#006064' }}>
                    <li>Advanced Wound Care Management</li>
                    <li>Palliative Care Best Practices</li>
                    <li>Dementia & Alzheimer's Care certification</li>
                    <li>Infection Control & Prevention</li>
                    <li>Professional Ethics & Documentation</li>
                </ul>
            </div>

            <Link to={RouteRegistry.BOOKING} style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: '#006064', color: 'white', textDecoration: 'none', borderRadius: '4px', fontWeight: 'bold' }}>
                Register for Training
            </Link>
            <br /><br />
            <Link to={RouteRegistry.SERVICES} style={{ color: '#666', textDecoration: 'underline' }}>Back to Services</Link>
        </div>
    );
}
