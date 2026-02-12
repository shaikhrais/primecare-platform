import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { AnimatedSection } from './AnimatedSection';

const { ContentRegistry } = MarketingRegistry;

export function WhyChooseUsSection() {
    return (
        <section style={{ padding: '6rem 2rem' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
                    gap: '4rem',
                    alignItems: 'center',
                }}>
                    <AnimatedSection animation="slideRight">
                        <h2 data-cy="why-choose-us-title" style={{ fontSize: '2.5rem', marginBottom: '1.5rem', color: '#333' }}>
                            {ContentRegistry.WHY_CHOOSE_US.TITLE}
                        </h2>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                            {ContentRegistry.WHY_CHOOSE_US.POINTS.map((point, index) => (
                                <AnimatedSection
                                    key={index}
                                    animation="fadeInUp"
                                    delay={0.2 + index * 0.15}
                                >
                                    <div style={{ display: 'flex', gap: '1rem', alignItems: 'flex-start' }}>
                                        <div style={{
                                            width: '40px',
                                            height: '40px',
                                            backgroundColor: '#e0f2f1',
                                            borderRadius: '50%',
                                            display: 'flex',
                                            alignItems: 'center',
                                            justifyContent: 'center',
                                            flexShrink: 0,
                                            color: '#00897b',
                                            fontWeight: 'bold',
                                        }}>
                                            ✓
                                        </div>
                                        <div>
                                            <h4 style={{ fontSize: '1.2rem', marginBottom: '0.5rem', color: '#333' }}>
                                                {point.title}
                                            </h4>
                                            <p style={{ color: '#666', lineHeight: '1.6' }}>{point.text}</p>
                                        </div>
                                    </div>
                                </AnimatedSection>
                            ))}
                        </div>
                    </AnimatedSection>

                    <AnimatedSection animation="slideLeft" delay={0.3}>
                        <img
                            src="https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=600&q=80"
                            alt="Caregiver with senior"
                            style={{
                                width: '100%',
                                borderRadius: '20px',
                                boxShadow: '0 20px 60px rgba(0,0,0,0.15)',
                            }}
                        />
                    </AnimatedSection>
                </div>
            </div>
        </section>
    );
}

export default WhyChooseUsSection;
