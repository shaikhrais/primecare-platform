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
            backgroundColor: 'var(--bg-800)',
            textAlign: 'center',
            borderTop: '1px solid var(--card-border)'
        }}>
            <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 data-cy="cta-title" style={{ fontSize: '3.2rem', fontWeight: 900, marginBottom: '1.5rem', color: 'var(--text-100)', letterSpacing: '-1.5px' }}>
                        {title}
                    </h2>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.1}>
                    <p data-cy="cta-subtitle" style={{ fontSize: '1.25rem', color: 'var(--text-300)', marginBottom: '3.5rem', lineHeight: '1.6' }}>
                        {subtitle}
                    </p>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.2}>
                    <div style={{ display: 'flex', justifyContent: 'center', gap: '1.5rem', flexWrap: 'wrap' }}>
                        <Link
                            to={primaryCTA.link}
                            data-cy="cta-primary"
                            style={{
                                padding: '1.4rem 3.5rem',
                                backgroundColor: 'var(--brand-500)',
                                color: 'var(--bg-900)',
                                textDecoration: 'none',
                                borderRadius: '50px',
                                fontWeight: 900,
                                fontSize: '1.1rem',
                                boxShadow: '0 8px 30px rgba(46, 196, 182, 0.4)',
                                transition: 'var(--pc-transition)'
                            }}
                        >
                            {primaryCTA.text}
                        </Link>
                        <Link
                            to={secondaryCTA.link}
                            data-cy="cta-secondary"
                            style={{
                                padding: '1.4rem 3.5rem',
                                backgroundColor: 'transparent',
                                color: 'var(--text-100)',
                                textDecoration: 'none',
                                borderRadius: '50px',
                                fontWeight: 900,
                                fontSize: '1.1rem',
                                border: '2px solid rgba(255,255,255,0.2)',
                                transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.borderColor = 'var(--text-100)';
                                e.currentTarget.style.background = 'rgba(255,255,255,0.05)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.borderColor = 'rgba(255,255,255,0.2)';
                                e.currentTarget.style.background = 'transparent';
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
