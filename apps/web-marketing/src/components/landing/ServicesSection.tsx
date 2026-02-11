import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { AnimatedSection } from './AnimatedSection';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

interface Service {
    icon: string;
    title: string;
    description: string;
    link: string;
}

interface ServicesSectionProps {
    services?: Service[];
}

const defaultServices: Service[] = [
    {
        icon: '🦶',
        title: 'Foot Care Nursing',
        description: 'Professional diabetic foot care, nail care, and wound management by certified nurses.',
        link: RouteRegistry.SERVICE_FOOT_CARE,
    },
    {
        icon: '👴',
        title: 'Senior Home Care',
        description: 'Compassionate personal support for daily activities, companionship, and medication management.',
        link: RouteRegistry.SERVICE_SENIOR,
    },
    {
        icon: '📚',
        title: 'Healthcare Education',
        description: 'Professional training programs for PSWs and healthcare workers seeking certification.',
        link: RouteRegistry.SERVICE_EDUCATION,
    },
    {
        icon: '💻',
        title: 'IT Support',
        description: 'Healthcare technology solutions, EMR setup, and HIPAA-compliant IT infrastructure.',
        link: RouteRegistry.SERVICE_IT,
    },
];

export function ServicesSection({ services = defaultServices }: ServicesSectionProps) {
    return (
        <section style={{ padding: '6rem 2rem', backgroundColor: '#f8f9fa' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2
                        data-cy="services-header"
                        style={{
                            fontSize: '2.5rem',
                            textAlign: 'center',
                            marginBottom: '1rem',
                            color: '#333',
                        }}>
                        Our Services
                    </h2>
                    <p style={{
                        textAlign: 'center',
                        fontSize: '1.2rem',
                        color: '#666',
                        marginBottom: '4rem',
                        maxWidth: '600px',
                        margin: '0 auto 4rem auto',
                    }}>
                        Comprehensive healthcare solutions tailored to your unique needs
                    </p>
                </AnimatedSection>

                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                    gap: '2rem'
                }}>
                    {services.map((service, index) => (
                        <AnimatedSection
                            key={index}
                            animation="slideUp"
                            delay={index * 0.1}
                        >
                            <Link
                                to={service.link}
                                data-cy={`lnk-service-card-${index}`}
                                style={{ textDecoration: 'none', display: 'block', height: '100%' }}
                            >
                                <div style={{
                                    backgroundColor: 'white',
                                    padding: '2.5rem',
                                    borderRadius: '16px',
                                    boxShadow: '0 4px 20px rgba(0,0,0,0.05)',
                                    transition: 'transform 0.3s, box-shadow 0.3s',
                                    height: '100%',
                                    cursor: 'pointer',
                                }}
                                    onMouseEnter={(e) => {
                                        e.currentTarget.style.transform = 'translateY(-8px)';
                                        e.currentTarget.style.boxShadow = '0 12px 40px rgba(0,0,0,0.12)';
                                    }}
                                    onMouseLeave={(e) => {
                                        e.currentTarget.style.transform = 'translateY(0)';
                                        e.currentTarget.style.boxShadow = '0 4px 20px rgba(0,0,0,0.05)';
                                    }}
                                >
                                    <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>{service.icon}</div>
                                    <h3 style={{ fontSize: '1.4rem', marginBottom: '1rem', color: '#00897b' }}>
                                        {service.title}
                                    </h3>
                                    <p style={{ color: '#666', lineHeight: '1.7' }}>{service.description}</p>
                                    <div style={{ marginTop: '1.5rem', color: '#00897b', fontWeight: 'bold' }}>
                                        Learn More →
                                    </div>
                                </div>
                            </Link>
                        </AnimatedSection>
                    ))}
                </div>
            </div>
        </section>
    );
}

export default ServicesSection;
