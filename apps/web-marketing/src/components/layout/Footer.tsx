import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import ChatWidget from '../ChatWidget';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function Footer() {
    return (
        <>
            <footer style={{ backgroundColor: '#0a1628', color: 'white', fontFamily: 'system-ui, sans-serif' }}>
                {/* Top Section */}
                <div style={{ padding: '3rem 2rem', borderBottom: '1px solid rgba(255,255,255,0.1)' }}>
                    <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '2rem' }}>
                        {/* Head Office */}
                        <div>
                            <h4 style={{ color: '#f59e0b', fontSize: '1rem', marginBottom: '1rem', fontWeight: '600' }}>Head Office</h4>
                            <p style={{ opacity: 0.8, lineHeight: '1.6', fontSize: '0.9rem' }}>
                                Suite #200, 123 Healthcare Ave,<br />
                                Toronto, ON M5V 2K7
                            </p>
                        </div>

                        {/* Contact */}
                        <div>
                            <h4 style={{ color: '#f59e0b', fontSize: '1rem', marginBottom: '1rem', fontWeight: '600' }}>Contact</h4>
                            <div style={{ opacity: 0.8, fontSize: '0.9rem' }}>
                                <p style={{ marginBottom: '0.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                    <span>✉️</span>
                                    <a href="mailto:info@primecare.ca" style={{ color: 'white', textDecoration: 'none' }}>info@primecare.ca</a>
                                </p>
                                <p style={{ marginBottom: '0.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                    <span>📞</span>
                                    <a href="tel:+14165551234" style={{ color: 'white', textDecoration: 'none' }}>(+1) 416-555-1234</a>
                                </p>
                                <p style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                    <span>🕐</span>
                                    Mon - Sat, 8AM to 8PM
                                </p>
                            </div>
                        </div>

                        {/* Login Links */}
                        <div>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginTop: '1.5rem' }}>
                                <Link to="/caregiver-login" style={{ color: 'white', textDecoration: 'none', opacity: 0.8, fontSize: '0.9rem' }}>Caregiver Login</Link>
                                <Link to="/login" style={{ color: 'white', textDecoration: 'none', opacity: 0.8, fontSize: '0.9rem' }}>Family Login</Link>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Main Links Section */}
                <div style={{ padding: '3rem 2rem' }}>
                    <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '2rem' }}>
                        {/* Logo */}
                        <div>
                            <style>{`
                                @media (max-width: 600px) {
                                    .footer-logo { height: 50px !important; }
                                }
                            `}</style>
                            <Link to={RouteRegistry.HOME} style={{ display: 'flex', alignItems: 'center', textDecoration: 'none', marginBottom: '1rem' }}>
                                <img
                                    src="/logo.png"
                                    alt={ContentRegistry.APP.NAME}
                                    className="footer-logo"
                                    style={{ height: '80px', width: 'auto' }}
                                />
                            </Link>
                        </div>

                        {/* Company */}
                        <div>
                            <h4 style={{ color: '#f59e0b', fontSize: '1rem', marginBottom: '1rem', fontWeight: '600' }}>Company</h4>
                            <ul style={{ listStyle: 'none', padding: 0, opacity: 0.8, fontSize: '0.9rem' }}>
                                <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.ABOUT} style={{ color: 'white', textDecoration: 'none' }}>About</Link></li>
                                <li><Link to={RouteRegistry.CAREERS} style={{ color: 'white', textDecoration: 'none' }}>Careers</Link></li>
                            </ul>
                        </div>

                        {/* Services */}
                        <div>
                            <h4 style={{ color: '#f59e0b', fontSize: '1rem', marginBottom: '1rem', fontWeight: '600' }}>Services</h4>
                            <ul style={{ listStyle: 'none', padding: 0, opacity: 0.8, fontSize: '0.9rem' }}>
                                <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.SERVICE_SENIOR} style={{ color: 'white', textDecoration: 'none' }}>Personal Care</Link></li>
                                <li style={{ marginBottom: '0.5rem' }}><Link to={RouteRegistry.SERVICE_FOOT_CARE} style={{ color: 'white', textDecoration: 'none' }}>Diabetic Foot Care</Link></li>
                                <li style={{ marginBottom: '0.5rem' }}><Link to="/education/foot-care-certificate" style={{ color: 'white', textDecoration: 'none' }}>Nurse Education</Link></li>
                                <li style={{ marginBottom: '0.5rem' }}><Link to="/services/facility-foot-care" style={{ color: 'white', textDecoration: 'none' }}>Foot Clinics</Link></li>
                                <li style={{ marginBottom: '0.5rem' }}><Link to="/services/staffing" style={{ color: 'white', textDecoration: 'none' }}>Healthcare Staffing</Link></li>
                                <li><Link to={RouteRegistry.SERVICE_IT} style={{ color: 'white', textDecoration: 'none' }}>IT Managed Services</Link></li>
                            </ul>
                        </div>

                        {/* Quick Links */}
                        <div>
                            <h4 style={{ color: '#f59e0b', fontSize: '1rem', marginBottom: '1rem', fontWeight: '600' }}>Quick Links</h4>
                            <ul style={{ listStyle: 'none', padding: 0, opacity: 0.8, fontSize: '0.9rem' }}>
                                <li style={{ marginBottom: '0.5rem' }}><Link to="/faq" style={{ color: 'white', textDecoration: 'none' }}>FAQ's</Link></li>
                                <li style={{ marginBottom: '0.5rem' }}><Link to="/testimonials" style={{ color: 'white', textDecoration: 'none' }}>Testimonials</Link></li>
                                <li><Link to={RouteRegistry.BLOG} style={{ color: 'white', textDecoration: 'none' }}>Blog</Link></li>
                            </ul>

                            {/* Social Icons */}
                            <div style={{ display: 'flex', gap: '1rem', marginTop: '1.5rem' }}>
                                <a href="https://facebook.com" target="_blank" rel="noopener noreferrer" style={{ color: 'white', opacity: 0.8, fontSize: '1.25rem' }}>📘</a>
                                <a href="https://twitter.com" target="_blank" rel="noopener noreferrer" style={{ color: 'white', opacity: 0.8, fontSize: '1.25rem' }}>𝕏</a>
                                <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" style={{ color: 'white', opacity: 0.8, fontSize: '1.25rem' }}>💼</a>
                                <a href="https://instagram.com" target="_blank" rel="noopener noreferrer" style={{ color: 'white', opacity: 0.8, fontSize: '1.25rem' }}>📷</a>
                                <a href="https://youtube.com" target="_blank" rel="noopener noreferrer" style={{ color: 'white', opacity: 0.8, fontSize: '1.25rem' }}>▶️</a>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Copyright */}
                <div style={{ backgroundColor: 'rgba(0,0,0,0.2)', padding: '1rem 2rem', textAlign: 'center', fontSize: '0.85rem', opacity: 0.6 }}>
                    © {new Date().getFullYear()} {ContentRegistry.APP.NAME}. All rights reserved. |
                    <Link to={RouteRegistry.PRIVACY} style={{ color: 'white', textDecoration: 'none', marginLeft: '0.5rem' }}>Privacy Policy</Link> |
                    <Link to={RouteRegistry.TERMS} style={{ color: 'white', textDecoration: 'none', marginLeft: '0.5rem' }}>Terms of Service</Link>
                </div>
            </footer>

            {/* Chat Widget with AI Chat and Voice Call */}
            <ChatWidget />
        </>
    );
}
