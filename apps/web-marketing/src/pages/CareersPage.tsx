import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';
import { BenefitsSection, JobListingsSection, GeneralApplicationCTA } from './sections/CareersSections';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function CareersPage() {
    const [selectedDepartment, setSelectedDepartment] = useState('all');

    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}>
            <Helmet>
                <title>Careers - Apply Now | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Join our team of healthcare professionals. We're hiring PSWs, nurses, and healthcare staff across Toronto and GTA." />
            </Helmet>
            <header style={{ background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=1920&q=80')`, backgroundSize: 'cover', backgroundPosition: 'center', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Careers at {ContentRegistry.APP.NAME}</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '600px', margin: '0 auto' }}>Join our passionate team making a difference in seniors' lives every day</p>
                </AnimatedSection>
            </header>
            <BenefitsSection />
            <JobListingsSection selectedDepartment={selectedDepartment} setSelectedDepartment={setSelectedDepartment} />
            <GeneralApplicationCTA />
            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
