import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Service {
    id: string;
    name: string;
    description: string;
    price: number;
    link: string;
    icon: string;
    image: string;
    features: string[];
}

export default function ServicesPage() {
    const services: Service[] = [
        {
            id: 'foot-care',
            name: ContentRegistry.SERVICES.FOOT_CARE.TITLE,
            description: ContentRegistry.SERVICES.FOOT_CARE.DESCRIPTION,
            price: 75,
            link: RouteRegistry.SERVICE_FOOT_CARE,
            icon: '🦶',
            image: 'https://images.unsplash.com/photo-1519824145371-296894a0daa9?w=600&q=80',
            features: ['Diabetic foot assessment', 'Nail care & trimming', 'Callus removal', 'Wound care'],
        },
        {
            id: 'senior-care',
            name: ContentRegistry.SERVICES.SENIOR_CARE.TITLE,
            description: ContentRegistry.SERVICES.SENIOR_CARE.DESCRIPTION,
            price: 35,
            link: RouteRegistry.SERVICE_SENIOR,
            icon: '👴',
            image: 'https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=600&q=80',
            features: ['Personal care assistance', 'Medication reminders', 'Companionship', 'Light housekeeping'],
        },
        {
            id: 'education',
            name: ContentRegistry.SERVICES.EDUCATION.TITLE,
            description: ContentRegistry.SERVICES.EDUCATION.DESCRIPTION,
            price: 150,
            link: RouteRegistry.SERVICE_EDUCATION,
            icon: '📚',
            image: 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=600&q=80',
            features: ['PSW certification', 'CPR/First Aid', 'Dementia care training', 'Continuing education'],
        },
        {
            id: 'it-support',
            name: ContentRegistry.SERVICES.IT_SUPPORT.TITLE,
            description: ContentRegistry.SERVICES.IT_SUPPORT.DESCRIPTION,
            price: 90,
            link: RouteRegistry.SERVICE_IT,
            icon: '💻',
            image: 'https://images.unsplash.com/photo-1551434678-e076c223a692?w=600&q=80',
            features: ['EMR/EHR setup', 'HIPAA compliance', 'Tech support', 'Staff training'],
        },
    ];

    return (
        <div style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}>
            <Helmet>
                <title>Our Services | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content="Explore our comprehensive healthcare services including foot care nursing, senior home care, healthcare education, and IT support." />
            </Helmet>

            {/* Hero */}
            <header style={{
                background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=1920&q=80')`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
                color: 'white',
                padding: '5rem 2rem',
                textAlign: 'center',
            }}>
                <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', marginBottom: '1rem' }}>
                    {ContentRegistry.SERVICES.TITLE}
                </h1>
                <p style={{ fontSize: '1.25rem', opacity: 0.95, maxWidth: '600px', margin: '0 auto' }}>
                    {ContentRegistry.SERVICES.SUBTITLE}
                </p>
            </header>

            {/* Services Grid */}
            <section style={{ padding: '5rem 2rem', maxWidth: '1400px', margin: '0 auto' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '4rem' }}>
                    {services.map((service, index) => (
                        <div
                            key={service.id}
                            style={{
                                display: 'grid',
                                gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))',
                                gap: '3rem',
                                alignItems: 'center',
                                padding: '2rem',
                                backgroundColor: index % 2 === 0 ? 'white' : '#f8f9fa',
                                borderRadius: '20px',
                            }}
                        >
                            <div style={{ order: index % 2 === 0 ? 1 : 2 }}>
                                <img
                                    src={service.image}
                                    alt={service.name}
                                    style={{
                                        width: '100%',
                                        height: '350px',
                                        objectFit: 'cover',
                                        borderRadius: '16px',
                                        boxShadow: '0 20px 50px rgba(0,0,0,0.1)',
                                    }}
                                />
                            </div>
                            <div style={{ order: index % 2 === 0 ? 2 : 1 }}>
                                <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>{service.icon}</div>
                                <h2 style={{ fontSize: '2rem', marginBottom: '0.5rem', color: '#333' }}>
                                    {service.name}
                                </h2>
                                <div style={{
                                    fontSize: '1.5rem',
                                    fontWeight: 'bold',
                                    color: '#00897b',
                                    marginBottom: '1rem'
                                }}>
                                    Starting at ${service.price}/hour
                                </div>
                                <p style={{
                                    color: '#666',
                                    lineHeight: '1.8',
                                    fontSize: '1.1rem',
                                    marginBottom: '1.5rem',
                                }} data-cy={`service-desc-${service.id}`}>
                                    {service.description}
                                </p>

                                <ul style={{
                                    listStyle: 'none',
                                    padding: 0,
                                    margin: '0 0 2rem 0',
                                    display: 'grid',
                                    gridTemplateColumns: 'repeat(2, 1fr)',
                                    gap: '0.75rem',
                                }} data-cy={`service-features-${service.id}`}>
                                    {service.features.map((feature, i) => (
                                        <li key={i} style={{
                                            display: 'flex',
                                            alignItems: 'center',
                                            gap: '0.5rem',
                                            color: '#444',
                                        }} data-cy={`service-feature-${i}`}>
                                            <span style={{ color: '#00897b' }}>✓</span>
                                            {feature}
                                        </li>
                                    ))}
                                </ul>

                                <Link
                                    to={service.link}
                                    data-cy={`btn-learn-more-${service.id}`}
                                    style={{
                                        display: 'inline-block',
                                        padding: '1rem 2rem',
                                        backgroundColor: '#00897b',
                                        color: 'white',
                                        textDecoration: 'none',
                                        borderRadius: '8px',
                                        fontWeight: 'bold',
                                        transition: 'background-color 0.2s',
                                    }}
                                >
                                    Learn More →
                                </Link>
                            </div>
                        </div>
                    ))}
                </div>
            </section>

            {/* CTA Section */}
            <section style={{
                padding: '5rem 2rem',
                background: 'linear-gradient(135deg, #00897b 0%, #00695c 100%)',
                color: 'white',
                textAlign: 'center',
            }}>
                <h2 style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>Not Sure Which Service You Need?</h2>
                <p style={{ fontSize: '1.25rem', marginBottom: '2rem', opacity: 0.9, maxWidth: '600px', margin: '0 auto 2rem auto' }}>
                    Our care coordinators will help you find the perfect solution for your needs. Schedule a free consultation today.
                </p>
                <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', flexWrap: 'wrap' }}>
                    <Link
                        to={RouteRegistry.BOOKING}
                        data-cy="btn-services-booking"
                        style={{
                            padding: '1rem 2.5rem',
                            backgroundColor: 'white',
                            color: '#00897b',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontWeight: 'bold',
                            fontSize: '1.1rem',
                        }}
                    >
                        Book Free Consultation
                    </Link>
                    <Link
                        to={RouteRegistry.CONTACT}
                        data-cy="btn-services-contact"
                        style={{
                            padding: '1rem 2.5rem',
                            backgroundColor: 'transparent',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontWeight: 'bold',
                            fontSize: '1.1rem',
                            border: '2px solid white',
                        }}
                    >
                        Contact Us
                    </Link>
                </div>
            </section>

            {/* Back to Home */}
            <div style={{ textAlign: 'center', padding: '3rem 2rem' }}>
                <Link to={RouteRegistry.HOME} style={{ color: '#00897b', textDecoration: 'none' }}>
                    ← Back to Home
                </Link>
            </div>
        </div>
    );
}
