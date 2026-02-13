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
            padding: '8rem 2rem',
            backgroundColor: 'var(--bg-900)',
            textAlign: 'center',
            borderTop: '1px solid var(--line)'
        }}>
            <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 data-cy="cta-title" style={{ fontSize: '3.5rem', fontWeight: 800, marginBottom: '1.5rem', color: 'var(--text)', letterSpacing: '-1.5px' }}>
                        {title}
                    </h2>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.1}>
                    <p data-cy="cta-subtitle" style={{ fontSize: '1.25rem', color: 'var(--text-muted)', marginBottom: '3.5rem', lineHeight: '1.6', fontWeight: 500 }}>
                        {subtitle}
                    </p>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.2}>
                    <div style={{ display: 'flex', justifyContent: 'center', gap: '1rem', flexWrap: 'wrap' }}>
                        <Link
                            to={primaryCTA.link}
                            data-cy="cta-primary"
                            style={{
                                padding: '1.2rem 3rem',
                                backgroundColor: 'var(--brand-500)',
                                color: 'white',
                                textDecoration: 'none',
                                borderRadius: '4px',
                                fontWeight: 700,
                                fontSize: '1.1rem',
                                transition: 'var(--pc-transition)'
                            }}
                        >
                            {primaryCTA.text}
                        </Link>
                        <Link
                            to={secondaryCTA.link}
                            data-cy="cta-secondary"
                            style={{
                                padding: '1.2rem 3rem',
                                backgroundColor: '#FFFFFF',
                                color: 'var(--text)',
                                textDecoration: 'none',
                                borderRadius: '4px',
                                fontWeight: 700,
                                fontSize: '1.1rem',
                                border: '1px solid var(--line)',
                                transition: 'var(--pc-transition)',
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
