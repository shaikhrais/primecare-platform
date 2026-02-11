import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { AnimatedSection } from './AnimatedSection';

const { RouteRegistry } = MarketingRegistry;

interface CTASectionProps {
    title?: string;
    subtitle?: string;
    primaryCTA?: { text: string; link: string };
    secondaryCTA?: { text: string; link: string };
}

export function CTASection({
    title = "Ready to Get Started?",
    subtitle = "Book a free consultation today and discover how we can help you or your loved ones live better.",
    primaryCTA = { text: "Book Free Consultation", link: RouteRegistry.BOOKING },
    secondaryCTA = { text: "Contact Us", link: RouteRegistry.CONTACT },
}: CTASectionProps) {
    return (
        <section style={{
            padding: '4rem 2rem',
            backgroundColor: 'white',
            textAlign: 'center',
        }}>
            <div style={{ maxWidth: '700px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 data-cy="cta-title" style={{ fontSize: '2rem', marginBottom: '1rem', color: '#333' }}>
                        {title}
                    </h2>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.1}>
                    <p style={{ fontSize: '1.1rem', color: '#666', marginBottom: '2rem' }}>
                        {subtitle}
                    </p>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.2}>
                    <div style={{ display: 'flex', justifyContent: 'center', gap: '1rem', flexWrap: 'wrap' }}>
                        <Link
                            to={primaryCTA.link}
                            data-cy="cta-primary"
                            style={{
                                padding: '1rem 2rem',
                                backgroundColor: '#00897b',
                                color: 'white',
                                textDecoration: 'none',
                                borderRadius: '8px',
                                fontWeight: 'bold',
                                transition: 'transform 0.2s, box-shadow 0.2s',
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.transform = 'translateY(-3px)';
                                e.currentTarget.style.boxShadow = '0 6px 20px rgba(0,77,64,0.3)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.boxShadow = 'none';
                            }}
                        >
                            {primaryCTA.text}
                        </Link>
                        <Link
                            to={secondaryCTA.link}
                            data-cy="cta-secondary"
                            style={{
                                padding: '1rem 2rem',
                                backgroundColor: 'white',
                                color: '#00897b',
                                textDecoration: 'none',
                                borderRadius: '8px',
                                fontWeight: 'bold',
                                border: '2px solid #00897b',
                                transition: 'all 0.2s',
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.backgroundColor = '#00897b';
                                e.currentTarget.style.color = 'white';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.backgroundColor = 'white';
                                e.currentTarget.style.color = '#00897b';
                            }}
                        >
                            {secondaryCTA.text}
                        </Link>
                    </div>
                </AnimatedSection>
            </div>
        </section>
    );
}

export default CTASection;
