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
        <section style={{ padding: '8rem 2rem', backgroundColor: 'var(--bg-900)' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2
                        data-cy="services-header"
                        style={{
                            fontSize: '3rem',
                            textAlign: 'center',
                            marginBottom: '1rem',
                            fontWeight: 800,
                            color: 'var(--text)',
                            letterSpacing: '-1px'
                        }}>
                        Our Core Solutions
                    </h2>
                    <p style={{
                        textAlign: 'center',
                        fontSize: '1.25rem',
                        color: 'var(--text-300)',
                        marginBottom: '5rem',
                        maxWidth: '700px',
                        margin: '0 auto 5rem auto',
                        lineHeight: '1.6'
                    }}>
                        Premium healthcare services powered by compassion and advanced healthcare technology.
                    </p>
                </AnimatedSection>

                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
                    gap: '2.5rem'
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
                                    backgroundColor: 'var(--bg-800)',
                                    padding: '3rem 2.5rem',
                                    borderRadius: '16px',
                                    border: '1px solid var(--line)',
                                    transition: 'all 0.3s ease',
                                    height: '100%',
                                    cursor: 'pointer',
                                    position: 'relative',
                                    overflow: 'hidden'
                                }}
                                    onMouseEnter={(e) => {
                                        e.currentTarget.style.transform = 'translateY(-8px)';
                                        e.currentTarget.style.borderColor = 'var(--brand-500)';
                                        e.currentTarget.style.boxShadow = '0 10px 30px rgba(0,0,0,0.05)';
                                    }}
                                    onMouseLeave={(e) => {
                                        e.currentTarget.style.transform = 'translateY(0)';
                                        e.currentTarget.style.borderColor = 'var(--line)';
                                        e.currentTarget.style.boxShadow = 'none';
                                    }}
                                >
                                    <div style={{ fontSize: '3.5rem', marginBottom: '1.5rem', display: 'inline-block' }}>{service.icon}</div>
                                    <h3 style={{ fontSize: '1.6rem', fontWeight: 900, marginBottom: '1rem', color: 'var(--text-100)', letterSpacing: '.2px' }}>
                                        {service.title}
                                    </h3>
                                    <p style={{ color: 'var(--text-300)', lineHeight: '1.8', fontSize: '1rem' }}>{service.description}</p>
                                    <div style={{ marginTop: '2rem', color: 'var(--brand-500)', fontWeight: 900, fontSize: '0.9rem', textTransform: 'uppercase', letterSpacing: '2px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        Explore Service <span style={{ transition: 'transform 0.3s' }}>→</span>
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
