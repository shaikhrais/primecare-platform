/**
 * VolunteerPage Data + Sub-Components
 * Extracted from VolunteerPage.tsx
 */
import React from 'react';
import { AnimatedSection } from '../../components/landing';

export const volunteerOpportunities = [
    { icon: '👴', title: 'Companion Visits', description: 'Spend quality time with seniors, providing companionship and conversation.' },
    { icon: '📚', title: 'Activity Assistance', description: 'Help organize and run activities like games, crafts, and reading sessions.' },
    { icon: '🚗', title: 'Transportation Support', description: 'Assist seniors with transportation to medical appointments or errands.' },
    { icon: '🎉', title: 'Event Planning', description: 'Help plan and execute community events and holiday celebrations.' },
    { icon: '💻', title: 'Tech Help', description: 'Teach seniors how to use smartphones, tablets, and video calling.' },
    { icon: '🌿', title: 'Garden & Outdoor', description: 'Assist with gardening projects and outdoor activities.' },
];

export function OpportunitiesSection() {
    return (
        <section style={{ padding: '5rem 2rem' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '1rem', color: '#333' }}>Volunteer Opportunities</h2>
                    <p style={{ textAlign: 'center', color: '#666', marginBottom: '3rem', maxWidth: '600px', margin: '0 auto 3rem auto' }}>Choose how you'd like to contribute to our community</p>
                </AnimatedSection>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2rem' }}>
                    {volunteerOpportunities.map((opp, index) => (
                        <AnimatedSection key={index} animation="slideUp" delay={index * 0.1}>
                            <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '12px', textAlign: 'center', height: '100%' }}>
                                <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>{opp.icon}</div>
                                <h3 style={{ fontSize: '1.25rem', marginBottom: '0.75rem', color: '#00897b' }}>{opp.title}</h3>
                                <p style={{ color: '#666', lineHeight: '1.6' }}>{opp.description}</p>
                            </div>
                        </AnimatedSection>
                    ))}
                </div>
            </div>
        </section>
    );
}

export function ImpactStatsSection() {
    return (
        <section style={{ padding: '4rem 2rem', backgroundColor: '#00897b', color: 'white' }}>
            <div style={{ maxWidth: '1000px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))', gap: '2rem', textAlign: 'center' }}>
                <div><div style={{ fontSize: '3rem', fontWeight: 'bold' }}>500+</div><div style={{ opacity: 0.9 }}>Active Volunteers</div></div>
                <div><div style={{ fontSize: '3rem', fontWeight: 'bold' }}>10,000+</div><div style={{ opacity: 0.9 }}>Hours Donated</div></div>
                <div><div style={{ fontSize: '3rem', fontWeight: 'bold' }}>2,000+</div><div style={{ opacity: 0.9 }}>Seniors Helped</div></div>
            </div>
        </section>
    );
}

interface VolunteerFormProps {
    formData: { name: string; email: string; phone: string; availability: string; interests: string; experience: string };
    setFormData: React.Dispatch<React.SetStateAction<typeof formData>>;
    status: 'idle' | 'sending' | 'success' | 'error';
    onSubmit: (e: React.FormEvent) => void;
}

export function VolunteerForm({ formData, setFormData, status, onSubmit }: VolunteerFormProps) {
    const inputStyle = { width: '100%', padding: '0.75rem', border: '1px solid #ddd', borderRadius: '8px', fontSize: '1rem' };
    const labelStyle = { display: 'block' as const, marginBottom: '0.5rem', fontWeight: 'bold' as const, color: '#333' };
    return (
        <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
            <div style={{ maxWidth: '600px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp"><h2 style={{ fontSize: '2rem', textAlign: 'center', marginBottom: '2rem', color: '#333' }}>Apply to Volunteer</h2></AnimatedSection>
                {status === 'success' && <div style={{ padding: '1rem', backgroundColor: '#e8f5e9', borderRadius: '8px', marginBottom: '1rem', color: '#2e7d32' }}>Application received! We will be in touch shortly.</div>}
                {status === 'error' && <div style={{ padding: '1rem', backgroundColor: '#ffebee', borderRadius: '8px', marginBottom: '1rem', color: '#c62828' }}>Something went wrong. Please try again or contact us directly.</div>}
                <form onSubmit={onSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.05)' }}>
                    <div style={{ marginBottom: '1.5rem' }}><label style={labelStyle}>Full Name *</label><input data-cy="inp-name" type="text" required value={formData.name} onChange={(e) => setFormData({ ...formData, name: e.target.value })} style={inputStyle} /></div>
                    <div style={{ marginBottom: '1.5rem' }}><label style={labelStyle}>Email *</label><input data-cy="inp-email" type="email" required value={formData.email} onChange={(e) => setFormData({ ...formData, email: e.target.value })} style={inputStyle} /></div>
                    <div style={{ marginBottom: '1.5rem' }}><label style={labelStyle}>Phone</label><input data-cy="inp-phone" type="tel" value={formData.phone} onChange={(e) => setFormData({ ...formData, phone: e.target.value })} style={inputStyle} /></div>
                    <div style={{ marginBottom: '1.5rem' }}><label style={labelStyle}>Availability</label>
                        <select data-cy="sel-availability" value={formData.availability} onChange={(e) => setFormData({ ...formData, availability: e.target.value })} style={inputStyle}>
                            <option value="">Select availability</option><option value="weekdays">Weekdays</option><option value="weekends">Weekends</option><option value="evenings">Evenings</option><option value="flexible">Flexible</option>
                        </select>
                    </div>
                    <div style={{ marginBottom: '1.5rem' }}><label style={labelStyle}>Areas of Interest</label><textarea value={formData.interests} onChange={(e) => setFormData({ ...formData, interests: e.target.value })} placeholder="Which volunteer opportunities interest you?" rows={3} style={{ ...inputStyle, resize: 'vertical' as const }} /></div>
                    <button data-cy="btn-submit-volunteer" type="submit" disabled={status === 'sending'} style={{ width: '100%', padding: '1rem', backgroundColor: status === 'sending' ? '#ccc' : '#00897b', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1rem', fontWeight: 'bold', cursor: status === 'sending' ? 'not-allowed' : 'pointer' }}>{status === 'sending' ? 'Submitting...' : 'Submit Application'}</button>
                </form>
            </div>
        </section>
    );
}
