import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function SeniorCarePage() {
    return (
        <div style={{ padding: '2rem', maxWidth: '800px', margin: '0 auto', fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>{ContentRegistry.SERVICES.SENIOR_CARE.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>
            <h1 style={{ color: '#004d40', fontSize: '2.5rem' }}>{ContentRegistry.SERVICES.SENIOR_CARE.TITLE}</h1>
            <p style={{ fontSize: '1.2rem', color: '#555', lineHeight: '1.8', margin: '1rem 0 2rem' }}>
                {ContentRegistry.SERVICES.SENIOR_CARE.DESCRIPTION}
            </p>

            <div style={{ backgroundColor: '#f9fafb', padding: '2rem', borderRadius: '8px', marginBottom: '2rem' }}>
                <h3 style={{ color: '#333', marginBottom: '1rem' }}>Our Senior Care Services Include:</h3>
                <ul style={{ lineHeight: '1.8', color: '#444' }}>
                    <li>Personal Hygiene & Grooming Assistance</li>
                    <li>Medication Reminders & Management</li>
                    <li>Meal Preparation & Nutrition Support</li>
                    <li>Companionship & Social Engagement</li>
                    <li>Mobility Assistance & Fall Prevention</li>
                </ul>
            </div>

            <Link to={RouteRegistry.BOOKING} style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: '#004d40', color: 'white', textDecoration: 'none', borderRadius: '4px', fontWeight: 'bold' }}>
                Inquire About Senior Care
            </Link>
            <br /><br />
            <Link to={RouteRegistry.SERVICES} style={{ color: '#666', textDecoration: 'underline' }}>Back to Services</Link>
        </div>
    );
}
