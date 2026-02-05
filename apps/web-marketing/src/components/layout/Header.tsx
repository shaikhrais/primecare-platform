import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function Header() {
    const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

    const toggleMenu = () => setIsMobileMenuOpen(!isMobileMenuOpen);

    return (
        <header style={{ position: 'sticky', top: 0, zIndex: 1000, backgroundColor: 'white', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
            <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '1rem 2rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                {/* Logo */}
                <Link to={RouteRegistry.HOME} style={{ textDecoration: 'none', display: 'flex', alignItems: 'center' }}>
                    <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ height: '40px', width: 'auto' }} />
                    <span style={{ marginLeft: '10px', color: '#004d40', fontSize: '1.5rem', fontWeight: 'bold' }}>
                        {ContentRegistry.APP.NAME}
                    </span>
                </Link>

                {/* Desktop Nav */}
                <nav className="desktop-nav" style={{ display: 'none', gap: '2rem', alignItems: 'center' }}>
                    <style>{`@media (min-width: 768px) { .desktop-nav { display: flex !important; } .mobile-toggle { display: none !important; } }`}</style>
                    <Link to={RouteRegistry.HOME} style={{ textDecoration: 'none', color: '#333' }}>Home</Link>
                    <Link to={RouteRegistry.ABOUT} style={{ textDecoration: 'none', color: '#333' }}>About</Link>
                    <Link to={RouteRegistry.SERVICES} style={{ textDecoration: 'none', color: '#333' }}>Services</Link>
                    <Link to={RouteRegistry.BLOG} style={{ textDecoration: 'none', color: '#333' }}>Blog</Link>
                    <Link to={RouteRegistry.CAREERS} style={{ textDecoration: 'none', color: '#333' }}>Careers</Link>
                    <Link to={RouteRegistry.CONTACT} style={{ textDecoration: 'none', color: '#333' }}>Contact</Link>
                    <Link to={RouteRegistry.BOOKING} style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', borderRadius: '4px', textDecoration: 'none' }}>
                        Book Now
                    </Link>
                </nav>

                {/* Mobile Toggle */}
                <button className="mobile-toggle" onClick={toggleMenu} style={{ background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer' }}>
                    ☰
                </button>
            </div>

            {/* Mobile Menu */}
            {isMobileMenuOpen && (
                <div style={{ backgroundColor: 'white', borderTop: '1px solid #eee', padding: '1rem 2rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <Link to={RouteRegistry.HOME} onClick={toggleMenu} style={{ textDecoration: 'none', color: '#333' }}>Home</Link>
                    <Link to={RouteRegistry.SERVICES} onClick={toggleMenu} style={{ textDecoration: 'none', color: '#333' }}>Services</Link>
                    <Link to={RouteRegistry.BLOG} onClick={toggleMenu} style={{ textDecoration: 'none', color: '#333' }}>Blog</Link>
                    <Link to={RouteRegistry.CONTACT} onClick={toggleMenu} style={{ textDecoration: 'none', color: '#333' }}>Contact</Link>
                </div>
            )}
        </header>
    );
}
