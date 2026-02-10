import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function VolunteerPage() {
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        phone: '',
        availability: '',
        interests: '',
        experience: '',
    });

    const opportunities = [
        {
            icon: '👴',
            title: 'Companion Visits',
            description: 'Spend quality time with seniors, providing companionship and conversation.',
        },
        {
            icon: '📚',
            title: 'Activity Assistance',
            description: 'Help organize and run activities like games, crafts, and reading sessions.',
        },
        {
            icon: '🚗',
            title: 'Transportation Support',
            description: 'Assist seniors with transportation to medical appointments or errands.',
        },
        {
            icon: '🎉',
            title: 'Event Planning',
            description: 'Help plan and execute community events and holiday celebrations.',
        },
        {
            icon: '💻',
            title: 'Tech Help',
            description: 'Teach seniors how to use smartphones, tablets, and video calling.',
        },
        {
            icon: '🌿',
            title: 'Garden & Outdoor',
            description: 'Assist with gardening projects and outdoor activities.',
        },
    ];

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        alert('Thank you for your interest in volunteering! We will contact you soon.');
    };

    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}>
            <Helmet>
                <title>Volunteer With Us | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Make a difference in seniors' lives. Join our volunteer program and contribute to your community." />
            </Helmet>

            {/* Hero */}
            <header style={{
                background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1559027615-cd4628902d4a?w=1920&q=80')`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
                color: 'white',
                padding: '5rem 2rem',
                textAlign: 'center',
            }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>
                        Volunteer With Us
                    </h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '600px', margin: '0 auto' }}>
                        Make a meaningful difference in seniors' lives through compassionate volunteering
                    </p>
                </AnimatedSection>
            </header>

            {/* Opportunities */}
            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                    <AnimatedSection animation="fadeInUp">
                        <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '1rem', color: '#333' }}>
                            Volunteer Opportunities
                        </h2>
                        <p style={{ textAlign: 'center', color: '#666', marginBottom: '3rem', maxWidth: '600px', margin: '0 auto 3rem auto' }}>
                            Choose how you'd like to contribute to our community
                        </p>
                    </AnimatedSection>

                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2rem' }}>
                        {opportunities.map((opp, index) => (
                            <AnimatedSection key={index} animation="slideUp" delay={index * 0.1}>
                                <div style={{
                                    backgroundColor: '#f8f9fa',
                                    padding: '2rem',
                                    borderRadius: '12px',
                                    textAlign: 'center',
                                    height: '100%',
                                }}>
                                    <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>{opp.icon}</div>
                                    <h3 style={{ fontSize: '1.25rem', marginBottom: '0.75rem', color: '#00897b' }}>{opp.title}</h3>
                                    <p style={{ color: '#666', lineHeight: '1.6' }}>{opp.description}</p>
                                </div>
                            </AnimatedSection>
                        ))}
                    </div>
                </div>
            </section>

            {/* Impact Stats */}
            <section style={{ padding: '4rem 2rem', backgroundColor: '#00897b', color: 'white' }}>
                <div style={{ maxWidth: '1000px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))', gap: '2rem', textAlign: 'center' }}>
                    <div>
                        <div style={{ fontSize: '3rem', fontWeight: 'bold' }}>500+</div>
                        <div style={{ opacity: 0.9 }}>Active Volunteers</div>
                    </div>
                    <div>
                        <div style={{ fontSize: '3rem', fontWeight: 'bold' }}>10,000+</div>
                        <div style={{ opacity: 0.9 }}>Hours Donated</div>
                    </div>
                    <div>
                        <div style={{ fontSize: '3rem', fontWeight: 'bold' }}>2,000+</div>
                        <div style={{ opacity: 0.9 }}>Seniors Helped</div>
                    </div>
                </div>
            </section>

            {/* Application Form */}
            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '600px', margin: '0 auto' }}>
                    <AnimatedSection animation="fadeInUp">
                        <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '2rem', color: '#333' }}>
                            Apply to Volunteer
                        </h2>
                    </AnimatedSection>

                    <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.05)' }}>
                        <div style={{ marginBottom: '1.5rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold', color: '#333' }}>Full Name *</label>
                            <input
                                data-cy="inp-name"
                                type="text"
                                required
                                value={formData.name}
                                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #ddd', borderRadius: '8px', fontSize: '1rem' }}
                            />
                        </div>
                        <div style={{ marginBottom: '1.5rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold', color: '#333' }}>Email *</label>
                            <input
                                data-cy="inp-email"
                                type="email"
                                required
                                value={formData.email}
                                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #ddd', borderRadius: '8px', fontSize: '1rem' }}
                            />
                        </div>
                        <div style={{ marginBottom: '1.5rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold', color: '#333' }}>Phone</label>
                            <input
                                data-cy="inp-phone"
                                type="tel"
                                value={formData.phone}
                                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #ddd', borderRadius: '8px', fontSize: '1rem' }}
                            />
                        </div>
                        <div style={{ marginBottom: '1.5rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold', color: '#333' }}>Availability</label>
                            <select
                                data-cy="sel-availability"
                                value={formData.availability}
                                onChange={(e) => setFormData({ ...formData, availability: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #ddd', borderRadius: '8px', fontSize: '1rem' }}
                            >
                                <option value="">Select availability</option>
                                <option value="weekdays">Weekdays</option>
                                <option value="weekends">Weekends</option>
                                <option value="evenings">Evenings</option>
                                <option value="flexible">Flexible</option>
                            </select>
                        </div>
                        <div style={{ marginBottom: '1.5rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold', color: '#333' }}>Areas of Interest</label>
                            <textarea
                                value={formData.interests}
                                onChange={(e) => setFormData({ ...formData, interests: e.target.value })}
                                placeholder="Which volunteer opportunities interest you?"
                                rows={3}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid #ddd', borderRadius: '8px', fontSize: '1rem', resize: 'vertical' }}
                            />
                        </div>
                        <button
                            data-cy="btn-submit-volunteer"
                            type="submit"
                            style={{
                                width: '100%',
                                padding: '1rem',
                                backgroundColor: '#00897b',
                                color: 'white',
                                border: 'none',
                                borderRadius: '8px',
                                fontSize: '1rem',
                                fontWeight: 'bold',
                                cursor: 'pointer',
                            }}
                        >
                            Submit Application
                        </button>
                    </form>
                </div>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>
                    ← Back to Home
                </Link>
            </div>
        </div>
    );
}
