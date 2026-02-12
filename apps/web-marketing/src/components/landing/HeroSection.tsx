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
            background: `linear-gradient(135deg, rgba(11, 18, 32, 0.94) 0%, rgba(14, 33, 64, 0.88) 100%), url('https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=1920&q=80')`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            color: 'white',
            padding: '8rem 2rem',
            textAlign: 'center',
            minHeight: '85vh',
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
            alignItems: 'center',
        }} data-cy="hero">
            <div style={{ maxWidth: '950px' }}>
                <div
                    data-cy="hero-promo-badge"
                    style={{
                        display: 'inline-block',
                        padding: '0.6rem 2rem',
                        backgroundColor: 'rgba(46, 196, 182, 0.15)',
                        border: '1px solid var(--brand-500)',
                        borderRadius: '50px',
                        fontSize: '0.95rem',
                        fontWeight: 700,
                        color: 'var(--brand-500)',
                        marginBottom: '2.5rem',
                        backdropFilter: 'blur(10px)',
                        letterSpacing: '0.5px'
                    }}>
                    🎉 LIMITED TIME: 20% OFF FIRST VISIT
                </div>

                <h1 data-cy="hero-title" style={{
                    fontSize: 'clamp(2.8rem, 6vw, 4.5rem)',
                    marginBottom: '1.5rem',
                    fontWeight: '900',
                    lineHeight: '1.1',
                    textShadow: '0 4px 20px rgba(0,0,0,0.5)',
                    letterSpacing: '-0.04em',
                    color: 'var(--text-100)'
                }}>
                    {ContentRegistry.HERO.TITLE}
                </h1>

                <p data-cy="hero-subtitle" style={{
                    fontSize: 'clamp(1.2rem, 2.2vw, 1.5rem)',
                    marginBottom: '3rem',
                    opacity: 1,
                    lineHeight: '1.6',
                    maxWidth: '750px',
                    margin: '0 auto 3rem auto',
                    textShadow: '0 2px 8px rgba(0,0,0,0.4)',
                    fontWeight: 500,
                    color: 'var(--text-200)'
                }}>
                    {ContentRegistry.HERO.SUBTITLE}
                </p>

                {/* Countdown Timer */}
                <div data-cy="hero-timer" style={{ marginBottom: '3.5rem' }}>
                    <p style={{ marginBottom: '1.2rem', fontSize: '1rem', fontWeight: 700, opacity: 0.9, textTransform: 'uppercase', letterSpacing: '2px', color: 'var(--brand-500)' }}>Offer ends in:</p>
                    <CountdownTimer targetDate={promoEndDate} />
                </div>

                {/* CTA Buttons */}
                <div style={{ display: 'flex', justifyContent: 'center', gap: '1.5rem', flexWrap: 'wrap' }}>
                    <Link
                        to={RouteRegistry.BOOKING}
                        data-cy="ctaBookNow"
                        style={{
                            padding: '1.4rem 3.5rem',
                            backgroundColor: 'var(--brand-500)',
                            color: 'var(--bg-900)',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontSize: '1.15rem',
                            fontWeight: '900',
                            boxShadow: '0 8px 30px rgba(46, 196, 182, 0.4)',
                            transition: 'var(--pc-transition)'
                        }}
                    >
                        {ContentRegistry.HERO.CTA_PRIMARY}
                    </Link>
                    <Link
                        to={RouteRegistry.SERVICES}
                        data-cy="hero-cta-secondary"
                        style={{
                            padding: '1.4rem 3.5rem',
                            backgroundColor: 'transparent',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '50px',
                            fontSize: '1.15rem',
                            fontWeight: '900',
                            border: '2px solid rgba(255,255,255,0.3)',
                            backdropFilter: 'blur(5px)',
                            transition: 'var(--pc-transition)'
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
