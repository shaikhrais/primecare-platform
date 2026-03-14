import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';
import { OpportunitiesSection, ImpactStatsSection, VolunteerForm } from './sections/VolunteerSections';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function VolunteerPage() {
    const [formData, setFormData] = useState({ name: '', email: '', phone: '', availability: '', interests: '', experience: '' });
    const [status, setStatus] = useState<'idle' | 'sending' | 'success' | 'error'>('idle');

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault(); setStatus('sending');
        try {
            const res = await fetch(`${API_URL}/v1/public/volunteers`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(formData) });
            if (res.ok) { setStatus('success'); setFormData({ name: '', email: '', phone: '', availability: '', interests: '', experience: '' }); } else { setStatus('error'); }
        } catch (e) { setStatus('error'); }
    };

    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}>
            <Helmet>
                <title>Volunteer With Us | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Make a difference in seniors' lives. Join our volunteer program and contribute to your community." />
            </Helmet>
            <header style={{ background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1559027615-cd4628902d4a?w=1920&q=80')`, backgroundSize: 'cover', backgroundPosition: 'center', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Volunteer With Us</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '600px', margin: '0 auto' }}>Make a meaningful difference in seniors' lives through compassionate volunteering</p>
                </AnimatedSection>
            </header>
            <OpportunitiesSection />
            <ImpactStatsSection />
            <VolunteerForm formData={formData} setFormData={setFormData} status={status} onSubmit={handleSubmit} />
            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
