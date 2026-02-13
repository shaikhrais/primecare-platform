import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { AnimatedSection } from './AnimatedSection';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export function MissionSection() {
    return (
        <section style={{
            padding: '8rem 2rem',
            backgroundColor: 'var(--brand-500)',
            color: 'white',
            textAlign: 'center',
        }}>
            <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 data-cy="mission-title" style={{ fontSize: '3rem', marginBottom: '1.5rem', fontWeight: 800 }}>
                        {ContentRegistry.ABOUT.MISSION}
                    </h2>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.2}>
                    <p style={{ fontSize: '1.4rem', lineHeight: '1.8', opacity: 0.95, marginBottom: '3.5rem', fontWeight: 500 }} data-cy="mission-text">
                        {ContentRegistry.ABOUT.MISSION_TEXT}
                    </p>
                </AnimatedSection>

                <AnimatedSection animation="scaleUp" delay={0.4}>
                    <Link
                        to={RouteRegistry.ABOUT}
                        data-cy="btn-mission-learn-more"
                        style={{
                            display: 'inline-block',
                            padding: '1.2rem 3rem',
                            backgroundColor: 'white',
                            color: 'var(--brand-500)',
                            textDecoration: 'none',
                            borderRadius: '4px',
                            fontWeight: '700',
                            fontSize: '1.1rem',
                            transition: 'var(--pc-transition)',
                        }}
                    >
                        Learn About Us
                    </Link>
                </AnimatedSection>
            </div>
        </section>
    );
}

export default MissionSection;
