import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { Dropdown, TopBar, MobileMenu, aboutMenu, servicesMenu, educationMenu } from './HeaderParts';

const { RouteRegistry } = MarketingRegistry;

export default function Header() {
    const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
    const [isFullscreen, setIsFullscreen] = useState(false);

    const toggleFullscreen = () => {
        if (!document.fullscreenElement) { document.documentElement.requestFullscreen().catch(err => console.error(`Error: ${err.message}`)); setIsFullscreen(true); }
        else { if (document.exitFullscreen) { document.exitFullscreen(); setIsFullscreen(false); } }
    };
    const toggleMenu = () => setIsMobileMenuOpen(!isMobileMenuOpen);

    return (
        <header style={{ position: 'sticky', top: 0, zIndex: 1000, backgroundColor: '#FFFFFF', borderBottom: '1px solid var(--line)', boxShadow: '0 2px 10px rgba(0, 0, 0, 0.02)' }}>
            <TopBar isFullscreen={isFullscreen} toggleFullscreen={toggleFullscreen} />
            <div style={{ maxWidth: 'var(--container-max)', margin: '0 auto', padding: '0 var(--space-8)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', height: '80px' }}>
                <Link to={RouteRegistry.HOME} data-cy="logo-link" style={{ textDecoration: 'none', display: 'flex', alignItems: 'center' }}>
                    <img src="/logo.png" alt="PrimeCare Logo" data-cy="logo-img" style={{ height: '54px', width: 'auto', transition: 'var(--pc-transition)' }} />
                </Link>
                <nav className="desktop-nav" style={{ display: 'none', gap: 'var(--space-6)', alignItems: 'center' }}>
                    <style>{`@media (min-width: 1024px) { .desktop-nav { display: flex !important; margin-left: auto; } .mobile-toggle { display: none !important; } }`}</style>
                    <Dropdown {...aboutMenu} /><Dropdown {...servicesMenu} /><Dropdown {...educationMenu} />
                    <Link to={RouteRegistry.SERVICE_IT} data-cy="nav-healthtech" style={{ textDecoration: 'none', color: 'var(--text)', fontWeight: 600, fontSize: '0.95rem', transition: 'var(--pc-transition)' }}>HealthTech</Link>
                    <Link to={RouteRegistry.BOOKING} data-cy="btn-book-assessment" className="btn btn-primary" style={{ padding: '0.6rem 1.5rem', borderRadius: '4px', textDecoration: 'none', fontWeight: 700, fontSize: '0.9rem', marginLeft: '1rem' }}>Book Assessment</Link>
                </nav>
                <button className="mobile-toggle" data-cy="btn-mobile-menu" onClick={toggleMenu} style={{ background: 'none', border: 'none', fontSize: '1.75rem', cursor: 'pointer', color: 'var(--primary)' }}>{isMobileMenuOpen ? '✕' : '☰'}</button>
            </div>
            <MobileMenu menus={[aboutMenu, servicesMenu, educationMenu]} isMobileMenuOpen={isMobileMenuOpen} toggleMenu={toggleMenu} />
        </header>
    );
}
