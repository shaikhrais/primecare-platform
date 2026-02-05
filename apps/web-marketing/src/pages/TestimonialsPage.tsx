import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';
import { AnimatedSection } from '../components/landing';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function TestimonialsPage() {
    const testimonials = [
        { name: 'Janet Fraser', relation: 'Daughter of Client', rating: 5, text: 'The care my mother receives is exceptional. The caregivers are compassionate and professional.', image: 'https://randomuser.me/api/portraits/women/44.jpg' },
        { name: 'Lori Duff', relation: 'Family Member', rating: 5, text: 'Outstanding foot care service. The nurse was gentle and thorough. Highly recommend!', image: 'https://randomuser.me/api/portraits/women/68.jpg' },
        { name: 'Christine Cordero', relation: 'Client', rating: 5, text: 'Professional and caring staff. They treat my father with such respect and dignity.', image: 'https://randomuser.me/api/portraits/women/32.jpg' },
        { name: 'Manpreet Dhaliwal', relation: 'RN Graduate', rating: 5, text: 'Excellent foot care nurse training program. Well-structured with great clinical placements.', image: 'https://randomuser.me/api/portraits/women/55.jpg' },
        { name: 'Ravinder Kaur', relation: 'Family Member', rating: 5, text: 'The overnight care service gave us peace of mind. Caregivers are attentive and reliable.', image: 'https://randomuser.me/api/portraits/women/61.jpg' },
        { name: 'Dr. Steven Nitsopoulos', relation: 'Healthcare Partner', rating: 5, text: 'Great collaboration on IT solutions. Professional team with deep healthcare expertise.', image: 'https://randomuser.me/api/portraits/men/46.jpg' },
    ];

    const videoTestimonials = [
        { name: 'The Johnson Family', title: 'Home Care Experience', thumbnail: 'https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=400&h=225&fit=crop' },
        { name: 'Sarah M.', title: 'Foot Care Nurse Graduate', thumbnail: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=225&fit=crop' },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, sans-serif' }}>
            <Helmet>
                <title>Family Testimonials | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Read what families say about our care services. 5-star rated senior care provider in Toronto and GTA." />
            </Helmet>

            <header style={{ background: 'linear-gradient(135deg, rgba(0,77,64,0.9), rgba(0,105,92,0.85))', color: 'white', padding: '5rem 2rem', textAlign: 'center' }}>
                <AnimatedSection animation="fadeInUp">
                    <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>Family Testimonials</h1>
                    <p style={{ fontSize: '1.25rem', opacity: 0.95 }}>Read what our clients and their families say about us</p>
                    <div style={{ marginTop: '2rem', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '1rem' }}>
                        <span style={{ fontSize: '2rem' }}>⭐⭐⭐⭐⭐</span>
                        <span style={{ fontSize: '1.25rem' }}>5.0 Based on 75+ Reviews</span>
                    </div>
                </AnimatedSection>
            </header>

            <section style={{ padding: '5rem 2rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '2rem' }}>
                        {testimonials.map((t, i) => (
                            <AnimatedSection key={i} animation="fadeInUp" delay={i * 0.1}>
                                <div style={{ backgroundColor: '#f8f9fa', padding: '2rem', borderRadius: '16px', height: '100%' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '1rem' }}>
                                        <img src={t.image} alt={t.name} style={{ width: '60px', height: '60px', borderRadius: '50%', objectFit: 'cover' }} />
                                        <div>
                                            <h3 style={{ fontSize: '1.1rem', color: '#333', marginBottom: '0.25rem' }}>{t.name}</h3>
                                            <div style={{ color: '#666', fontSize: '0.875rem' }}>{t.relation}</div>
                                        </div>
                                    </div>
                                    <div style={{ color: '#f59e0b', marginBottom: '1rem' }}>{'⭐'.repeat(t.rating)}</div>
                                    <p style={{ color: '#555', lineHeight: '1.6', fontStyle: 'italic' }}>"{t.text}"</p>
                                </div>
                            </AnimatedSection>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#f8f9fa' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto', textAlign: 'center' }}>
                    <h2 style={{ fontSize: '2rem', marginBottom: '2rem', color: '#333' }}>Video Testimonials</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem' }}>
                        {videoTestimonials.map((v, i) => (
                            <div key={i} style={{ position: 'relative', borderRadius: '12px', overflow: 'hidden', cursor: 'pointer' }}>
                                <img src={v.thumbnail} alt={v.title} style={{ width: '100%', height: '200px', objectFit: 'cover' }} />
                                <div style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                    <div style={{ width: '60px', height: '60px', backgroundColor: 'white', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem' }}>▶</div>
                                </div>
                                <div style={{ position: 'absolute', bottom: '1rem', left: '1rem', color: 'white' }}>
                                    <div style={{ fontWeight: 'bold' }}>{v.name}</div>
                                    <div style={{ fontSize: '0.875rem', opacity: 0.9 }}>{v.title}</div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            <section style={{ padding: '5rem 2rem', backgroundColor: '#00897b', color: 'white', textAlign: 'center' }}>
                <h2 style={{ fontSize: '2rem', marginBottom: '1.5rem' }}>Share Your Experience</h2>
                <p style={{ marginBottom: '2rem', opacity: 0.9 }}>We'd love to hear about your experience with PrimeCare</p>
                <a href="https://g.page/r/CXt4g7X1U2NMEAE/review" target="_blank" rel="noopener noreferrer" style={{ display: 'inline-block', padding: '1rem 2rem', backgroundColor: 'white', color: '#00897b', textDecoration: 'none', borderRadius: '50px', fontWeight: 'bold' }}>
                    Leave a Google Review
                </a>
            </section>

            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>← Back to Home</Link>
            </div>
        </div>
    );
}
