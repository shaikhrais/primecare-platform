import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry } = MarketingRegistry;

export function WhyChooseUsSection() {
    return (
        <section style={{ padding: '6rem 2rem' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))',
                    gap: '4rem',
                    alignItems: 'center',
                }}>
                    <div>
                        <h2 style={{ fontSize: '2.5rem', marginBottom: '1.5rem', color: '#333' }}>
                            {ContentRegistry.WHY_CHOOSE_US.TITLE}
                        </h2>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                            {ContentRegistry.WHY_CHOOSE_US.POINTS.map((point, index) => (
                                <div key={index} style={{ display: 'flex', gap: '1rem', alignItems: 'flex-start' }}>
                                    <div style={{
                                        width: '40px',
                                        height: '40px',
                                        backgroundColor: '#e0f2f1',
                                        borderRadius: '50%',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        flexShrink: 0,
                                        color: '#004d40',
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
                            ))}
                        </div>
                    </div>
                    <div>
                        <img
                            src="https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=600&q=80"
                            alt="Caregiver with senior"
                            style={{
                                width: '100%',
                                borderRadius: '20px',
                                boxShadow: '0 20px 60px rgba(0,0,0,0.15)',
                            }}
                        />
                    </div>
                </div>
            </div>
        </section>
    );
}

export default WhyChooseUsSection;
