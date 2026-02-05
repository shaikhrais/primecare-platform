import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

function ChatWidget() {
    const [isOpen, setIsOpen] = useState(false);
    const [showTooltip, setShowTooltip] = useState(true);

    const handleChat = () => {
        setIsOpen(!isOpen);
        setShowTooltip(false);
    };

    return (
        <div style={{ position: 'fixed', bottom: '2rem', right: '2rem', zIndex: 9999 }}>
            {/* Chat Panel */}
            {isOpen && (
                <div style={{
                    position: 'absolute',
                    bottom: '70px',
                    right: 0,
                    width: '320px',
                    backgroundColor: 'white',
                    borderRadius: '16px',
                    boxShadow: '0 10px 40px rgba(0,0,0,0.2)',
                    overflow: 'hidden',
                }}>
                    {/* Header */}
                    <div style={{ backgroundColor: '#004d40', color: 'white', padding: '1.25rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div>
                            <h3 style={{ fontSize: '1.1rem', margin: 0 }}>Chat with us</h3>
                            <p style={{ fontSize: '0.8rem', opacity: 0.9, margin: '0.25rem 0 0 0' }}>We typically reply in minutes</p>
                        </div>
                        <button onClick={() => setIsOpen(false)} style={{ background: 'none', border: 'none', color: 'white', fontSize: '1.25rem', cursor: 'pointer' }}>✕</button>
                    </div>

                    {/* Options */}
                    <div style={{ padding: '1rem' }}>
                        <p style={{ color: '#666', fontSize: '0.9rem', marginBottom: '1rem' }}>How would you like to reach us?</p>

                        <a href="tel:+14165551234" style={{
                            display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem',
                            backgroundColor: '#f8f9fa', borderRadius: '12px', textDecoration: 'none', color: '#333', marginBottom: '0.75rem',
                            transition: 'background 0.2s',
                        }}
                            onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#e9ecef'}
                            onMouseOut={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                        >
                            <span style={{ fontSize: '1.5rem' }}>📞</span>
                            <div>
                                <div style={{ fontWeight: 'bold' }}>Call Us</div>
                                <div style={{ fontSize: '0.85rem', color: '#666' }}>(416) 555-1234</div>
                            </div>
                        </a>

                        <a href="https://wa.me/14165551234?text=Hi, I'm interested in your services" target="_blank" rel="noopener noreferrer" style={{
                            display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem',
                            backgroundColor: '#25D366', borderRadius: '12px', textDecoration: 'none', color: 'white', marginBottom: '0.75rem',
                        }}>
                            <span style={{ fontSize: '1.5rem' }}>💬</span>
                            <div>
                                <div style={{ fontWeight: 'bold' }}>WhatsApp</div>
                                <div style={{ fontSize: '0.85rem', opacity: 0.9 }}>Chat instantly</div>
                            </div>
                        </a>

                        <a href="mailto:info@primecare.ca" style={{
                            display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem',
                            backgroundColor: '#f8f9fa', borderRadius: '12px', textDecoration: 'none', color: '#333',
                            transition: 'background 0.2s',
                        }}
                            onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#e9ecef'}
                            onMouseOut={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                        >
                            <span style={{ fontSize: '1.5rem' }}>✉️</span>
                            <div>
                                <div style={{ fontWeight: 'bold' }}>Email Us</div>
                                <div style={{ fontSize: '0.85rem', color: '#666' }}>info@primecare.ca</div>
                            </div>
                        </a>
                    </div>

                    {/* Footer */}
                    <div style={{ padding: '1rem', borderTop: '1px solid #eee', textAlign: 'center' }}>
                        <Link to={RouteRegistry.CONTACT} style={{ color: '#004d40', textDecoration: 'none', fontWeight: 'bold', fontSize: '0.9rem' }}>
                            Or visit our Contact Page →
                        </Link>
                    </div>
                </div>
            )}

            {/* Floating Button */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                {showTooltip && !isOpen && (
                    <div style={{
                        backgroundColor: 'white',
                        padding: '0.75rem 1rem',
                        borderRadius: '50px',
                        boxShadow: '0 4px 15px rgba(0,0,0,0.15)',
                        fontSize: '0.9rem',
                        color: '#333',
                        animation: 'pulse 2s infinite',
                    }}>
                        Chat with us 👋
                    </div>
                )}
                <button
                    onClick={handleChat}
                    style={{
                        width: '56px',
                        height: '56px',
                        borderRadius: '50%',
                        backgroundColor: isOpen ? '#333' : '#f59e0b',
                        border: 'none',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        boxShadow: '0 4px 15px rgba(0,0,0,0.2)',
                        transition: 'transform 0.2s, background-color 0.2s',
                    }}
                    onMouseOver={(e) => e.currentTarget.style.transform = 'scale(1.1)'}
                    onMouseOut={(e) => e.currentTarget.style.transform = 'scale(1)'}
                >
                    <span style={{ fontSize: '1.5rem' }}>{isOpen ? '✕' : '💬'}</span>
                </button>
            </div>
        </div>
    );
}

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
                            <Link to={RouteRegistry.HOME} style={{ display: 'flex', alignItems: 'center', textDecoration: 'none', marginBottom: '1rem' }}>
                                <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ height: '60px', width: 'auto', filter: 'brightness(0) invert(1)' }} />
                            </Link>
                            <p style={{ color: '#f59e0b', fontSize: '1.1rem', fontWeight: '600' }}>{ContentRegistry.APP.NAME}</p>
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

            {/* Chat Widget - Separate from footer for proper fixed positioning */}
            <ChatWidget />
        </>
    );
}
