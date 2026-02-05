import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { AnimatedSection } from './AnimatedSection';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export function MissionSection() {
    return (
        <section style={{
            padding: '6rem 2rem',
            background: 'linear-gradient(135deg, #00897b 0%, #00695c 100%)',
            color: 'white',
            textAlign: 'center',
        }}>
            <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                <AnimatedSection animation="fadeInUp">
                    <h2 style={{ fontSize: '2.5rem', marginBottom: '1.5rem' }}>
                        {ContentRegistry.ABOUT.MISSION}
                    </h2>
                </AnimatedSection>

                <AnimatedSection animation="fadeInUp" delay={0.2}>
                    <p style={{ fontSize: '1.3rem', lineHeight: '1.8', opacity: 0.95, marginBottom: '3rem' }}>
                        {ContentRegistry.ABOUT.MISSION_TEXT}
                    </p>
                </AnimatedSection>

                <AnimatedSection animation="scaleUp" delay={0.4}>
                    <Link
                        to={RouteRegistry.ABOUT}
                        style={{
                            display: 'inline-block',
                            padding: '1rem 2.5rem',
                            backgroundColor: 'white',
                            color: '#00897b',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontWeight: 'bold',
                            fontSize: '1.1rem',
                            transition: 'transform 0.2s, box-shadow 0.2s',
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.transform = 'scale(1.05)';
                            e.currentTarget.style.boxShadow = '0 10px 30px rgba(0,0,0,0.2)';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.boxShadow = 'none';
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
