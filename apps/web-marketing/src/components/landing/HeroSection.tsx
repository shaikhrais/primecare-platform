import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { CountdownTimer } from './CountdownTimer';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

interface HeroSectionProps {
    promoEndDate: Date;
}

export function HeroSection({ promoEndDate }: HeroSectionProps) {
    return (
        <header style={{
            background: `linear-gradient(135deg, rgba(0,77,64,0.9) 0%, rgba(0,105,92,0.85) 100%), url('https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=1920&q=80')`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            color: 'white',
            padding: '6rem 2rem',
            textAlign: 'center',
            minHeight: '80vh',
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
            alignItems: 'center',
        }}>
            <div style={{ maxWidth: '900px' }}>
                <div style={{
                    display: 'inline-block',
                    padding: '0.5rem 1.5rem',
                    backgroundColor: 'rgba(255,255,255,0.2)',
                    borderRadius: '50px',
                    fontSize: '0.9rem',
                    marginBottom: '2rem',
                    backdropFilter: 'blur(10px)',
                }}>
                    🎉 Limited Time Offer - 20% Off First Visit
                </div>

                <h1 style={{
                    fontSize: 'clamp(2.5rem, 5vw, 4rem)',
                    marginBottom: '1.5rem',
                    fontWeight: '700',
                    lineHeight: '1.2',
                }}>
                    {ContentRegistry.HERO.TITLE}
                </h1>

                <p style={{
                    fontSize: 'clamp(1.1rem, 2vw, 1.4rem)',
                    marginBottom: '2.5rem',
                    opacity: 0.95,
                    lineHeight: '1.7',
                    maxWidth: '700px',
                    margin: '0 auto 2.5rem auto',
                }}>
                    {ContentRegistry.HERO.SUBTITLE}
                </p>

                {/* Countdown Timer */}
                <div style={{ marginBottom: '3rem' }}>
                    <p style={{ marginBottom: '1rem', fontSize: '1rem', opacity: 0.9 }}>Offer ends in:</p>
                    <CountdownTimer targetDate={promoEndDate} />
                </div>

                {/* CTA Buttons */}
                <div style={{ display: 'flex', justifyContent: 'center', gap: '1rem', flexWrap: 'wrap' }}>
                    <Link
                        to={RouteRegistry.BOOKING}
                        style={{
                            padding: '1.25rem 2.5rem',
                            backgroundColor: 'white',
                            color: '#004d40',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontSize: '1.1rem',
                            fontWeight: 'bold',
                            boxShadow: '0 4px 20px rgba(0,0,0,0.2)',
                        }}
                    >
                        {ContentRegistry.HERO.CTA_PRIMARY}
                    </Link>
                    <Link
                        to={RouteRegistry.SERVICES}
                        style={{
                            padding: '1.25rem 2.5rem',
                            backgroundColor: 'transparent',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontSize: '1.1rem',
                            fontWeight: 'bold',
                            border: '2px solid white',
                        }}
                    >
                        {ContentRegistry.HERO.CTA_SECONDARY}
                    </Link>
                </div>
            </div>
        </header>
    );
}

export default HeroSection;
