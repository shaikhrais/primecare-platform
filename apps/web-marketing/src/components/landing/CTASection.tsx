import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

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
                <h2 style={{ fontSize: '2rem', marginBottom: '1rem', color: '#333' }}>
                    {title}
                </h2>
                <p style={{ fontSize: '1.1rem', color: '#666', marginBottom: '2rem' }}>
                    {subtitle}
                </p>
                <div style={{ display: 'flex', justifyContent: 'center', gap: '1rem', flexWrap: 'wrap' }}>
                    <Link
                        to={primaryCTA.link}
                        style={{
                            padding: '1rem 2rem',
                            backgroundColor: '#004d40',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '8px',
                            fontWeight: 'bold',
                        }}
                    >
                        {primaryCTA.text}
                    </Link>
                    <Link
                        to={secondaryCTA.link}
                        style={{
                            padding: '1rem 2rem',
                            backgroundColor: 'white',
                            color: '#004d40',
                            textDecoration: 'none',
                            borderRadius: '8px',
                            fontWeight: 'bold',
                            border: '2px solid #004d40',
                        }}
                    >
                        {secondaryCTA.text}
                    </Link>
                </div>
            </div>
        </section>
    );
}

export default CTASection;
