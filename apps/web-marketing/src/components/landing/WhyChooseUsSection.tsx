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
                        <h2 data-cy="why-choose-us-title" style={{ fontSize: '2.5rem', marginBottom: '1.5rem', color: 'var(--text)', fontWeight: 800 }}>
                            {ContentRegistry.WHY_CHOOSE_US.TITLE}
                        </h2>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                            {ContentRegistry.WHY_CHOOSE_US.POINTS.map((point, index) => (
                                <AnimatedSection
                                    key={index}
                                    animation="fadeInUp"
                                    delay={0.2 + index * 0.15}
                                >
                                    <div style={{ display: 'flex', gap: '1rem', alignItems: 'flex-start' }} data-cy={`why-choose-us-point-${index}`}>
                                        <div style={{
                                            width: '40px',
                                            height: '40px',
                                            backgroundColor: 'var(--bg-800)',
                                            borderRadius: '50%',
                                            display: 'flex',
                                            alignItems: 'center',
                                            justifyContent: 'center',
                                            flexShrink: 0,
                                            color: 'var(--brand-500)',
                                            fontWeight: 'bold',
                                            border: '1px solid var(--line)'
                                        }}>
                                            ✓
                                        </div>
                                        <div>
                                            <h4 style={{ fontSize: '1.2rem', marginBottom: '0.5rem', color: 'var(--text)', fontWeight: 700 }} data-cy={`why-choose-us-point-title-${index}`}>
                                                {point.title}
                                            </h4>
                                            <p style={{ color: 'var(--text-300)', lineHeight: '1.6' }} data-cy={`why-choose-us-point-text-${index}`}>{point.text}</p>
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
                                borderRadius: '16px',
                                border: '1px solid var(--line)',
                                boxShadow: '0 10px 30px rgba(0,0,0,0.05)',
                            }}
                        />
                    </AnimatedSection>
                </div>
            </div>
        </section>
    );
}

export default WhyChooseUsSection;
