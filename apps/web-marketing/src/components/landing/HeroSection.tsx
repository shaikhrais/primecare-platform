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
            background: `linear-gradient(rgba(255, 255, 255, 0.8), rgba(255, 255, 255, 0.8)), url('https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=1920&q=80')`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            color: 'var(--text)',
            padding: '8rem 2rem',
            textAlign: 'center',
            minHeight: '80vh',
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
            alignItems: 'center',
        }} data-cy="hero">
            <div style={{ maxWidth: '950px' }}>
                <div
                    data-cy="hero-promo-badge"
                    className="chip"
                    style={{
                        display: 'inline-block',
                        backgroundColor: '#F3F4F6',
                        color: 'var(--brand-500)',
                        marginBottom: '2rem',
                        fontSize: '0.9rem',
                        fontWeight: 700,
                        padding: '6px 16px',
                        borderRadius: '4px'
                    }}>
                    🎉 LIMITED TIME: 20% OFF FIRST VISIT
                </div>

                <h1 data-cy="hero-title" style={{
                    fontSize: 'clamp(2.5rem, 6vw, 4rem)',
                    marginBottom: '1.2rem',
                    fontWeight: '800',
                    lineHeight: '1.1',
                    letterSpacing: '-0.02em',
                    color: 'var(--text)'
                }}>
                    {ContentRegistry.HERO.TITLE}
                </h1>

                <p data-cy="hero-subtitle" style={{
                    fontSize: 'clamp(1.1rem, 2vw, 1.3rem)',
                    marginBottom: '2.5rem',
                    lineHeight: '1.6',
                    maxWidth: '700px',
                    margin: '0 auto 2.5rem auto',
                    fontWeight: 500,
                    color: 'var(--text-300)'
                }}>
                    {ContentRegistry.HERO.SUBTITLE}
                </p>

                {/* Countdown Timer */}
                <div data-cy="hero-timer" style={{ marginBottom: '3rem' }}>
                    <p style={{ marginBottom: '1rem', fontSize: '0.85rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '1px', color: 'var(--brand-500)' }}>Offer ends in:</p>
                    <CountdownTimer targetDate={promoEndDate} />
                </div>

                {/* CTA Buttons */}
                <div style={{ display: 'flex', justifyContent: 'center', gap: '1rem', flexWrap: 'wrap' }}>
                    <Link
                        to={RouteRegistry.BOOKING}
                        data-cy="ctaBookNow"
                        style={{
                            padding: '1.2rem 3rem',
                            backgroundColor: 'var(--brand-500)',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '4px',
                            fontSize: '1.1rem',
                            fontWeight: '700',
                            transition: 'var(--pc-transition)'
                        }}
                    >
                        {ContentRegistry.HERO.CTA_PRIMARY}
                    </Link>
                    <Link
                        to={RouteRegistry.SERVICES}
                        data-cy="hero-cta-secondary"
                        style={{
                            padding: '1.2rem 3rem',
                            backgroundColor: '#FFFFFF',
                            color: 'var(--text)',
                            textDecoration: 'none',
                            borderRadius: '4px',
                            fontSize: '1.1rem',
                            fontWeight: '700',
                            border: '1px solid var(--line)',
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
