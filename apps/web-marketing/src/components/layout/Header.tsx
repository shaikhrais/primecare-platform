import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

interface DropdownProps {
    label: string;
    items: { label: string; link: string; submenu?: { label: string; link: string }[] }[];
}

function Dropdown({ label, items }: DropdownProps) {
    const [isOpen, setIsOpen] = useState(false);
    const [activeSubmenu, setActiveSubmenu] = useState<number | null>(null);

    return (
        <div
            style={{ position: 'relative' }}
            onMouseEnter={() => setIsOpen(true)}
            onMouseLeave={() => { setIsOpen(false); setActiveSubmenu(null); }}
        >
            <span
                style={{
                    cursor: 'pointer',
                    color: '#333',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '4px'
                }}
            >
                {label}
                <span style={{ fontSize: '0.7rem' }}>▼</span>
            </span>

            {isOpen && (
                <div style={{
                    position: 'absolute',
                    top: '100%',
                    left: 0,
                    backgroundColor: 'white',
                    minWidth: '220px',
                    boxShadow: '0 4px 20px rgba(0,0,0,0.15)',
                    borderRadius: '8px',
                    padding: '0.5rem 0',
                    zIndex: 1000,
                }}>
                    {items.map((item, index) => (
                        <div
                            key={index}
                            style={{ position: 'relative' }}
                            onMouseEnter={() => item.submenu && setActiveSubmenu(index)}
                            onMouseLeave={() => setActiveSubmenu(null)}
                        >
                            {item.submenu ? (
                                <div style={{
                                    padding: '0.75rem 1rem',
                                    display: 'flex',
                                    justifyContent: 'space-between',
                                    alignItems: 'center',
                                    cursor: 'pointer',
                                    color: '#333',
                                    transition: 'background 0.2s',
                                }}
                                    onMouseOver={(e) => e.currentTarget.style.background = '#f5f5f5'}
                                    onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}
                                >
                                    {item.label}
                                    <span style={{ fontSize: '0.7rem' }}>▶</span>
                                </div>
                            ) : (
                                <Link
                                    to={item.link}
                                    style={{
                                        display: 'block',
                                        padding: '0.75rem 1rem',
                                        textDecoration: 'none',
                                        color: '#333',
                                        transition: 'background 0.2s',
                                    }}
                                    onMouseOver={(e) => e.currentTarget.style.background = '#f5f5f5'}
                                    onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}
                                >
                                    {item.label}
                                </Link>
                            )}

                            {/* Submenu */}
                            {item.submenu && activeSubmenu === index && (
                                <div style={{
                                    position: 'absolute',
                                    top: 0,
                                    left: '100%',
                                    backgroundColor: 'white',
                                    minWidth: '200px',
                                    boxShadow: '0 4px 20px rgba(0,0,0,0.15)',
                                    borderRadius: '8px',
                                    padding: '0.5rem 0',
                                }}>
                                    {item.submenu.map((subitem, subindex) => (
                                        <Link
                                            key={subindex}
                                            to={subitem.link}
                                            style={{
                                                display: 'block',
                                                padding: '0.75rem 1rem',
                                                textDecoration: 'none',
                                                color: '#333',
                                                transition: 'background 0.2s',
                                            }}
                                            onMouseOver={(e) => e.currentTarget.style.background = '#f5f5f5'}
                                            onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}
                                        >
                                            {subitem.label}
                                        </Link>
                                    ))}
                                </div>
                            )}
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}

export default function Header() {
    const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
    const [mobileSubmenu, setMobileSubmenu] = useState<string | null>(null);

    const toggleMenu = () => setIsMobileMenuOpen(!isMobileMenuOpen);
    const toggleMobileSubmenu = (menu: string) => setMobileSubmenu(mobileSubmenu === menu ? null : menu);

    const aboutMenu = {
        label: 'About Us',
        items: [
            { label: 'About the Company', link: RouteRegistry.ABOUT },
            {
                label: 'Join Us',
                link: '#',
                submenu: [
                    { label: 'Careers - Apply Now', link: RouteRegistry.CAREERS },
                    { label: 'Volunteer', link: '/volunteer' },
                    { label: 'Franchise Opportunity', link: '/franchise' },
                ]
            },
            { label: 'Family Testimonials', link: '/testimonials' },
            { label: 'Blog', link: RouteRegistry.BLOG },
            { label: 'Contact Us', link: RouteRegistry.CONTACT },
        ]
    };

    const servicesMenu = {
        label: 'Senior Care',
        items: [
            { label: 'Personal Care for Seniors', link: RouteRegistry.SERVICE_SENIOR },
            { label: 'Diabetic Foot Care', link: RouteRegistry.SERVICE_FOOT_CARE },
            { label: 'Foot Care at Facilities', link: '/services/facility-foot-care' },
            { label: 'Healthcare Staffing', link: '/services/staffing' },
            { label: 'Training & Education', link: RouteRegistry.SERVICE_EDUCATION },
        ]
    };

    const educationMenu = {
        label: 'Education',
        items: [
            { label: 'Foot Care Nurse Certificate', link: '/education/foot-care-certificate' },
            { label: 'PSW Training Program', link: '/education/psw-training' },
            { label: 'Contact Us for Education', link: RouteRegistry.CONTACT },
        ]
    };

    return (
        <header style={{ position: 'sticky', top: 0, zIndex: 1000, backgroundColor: 'white', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
            {/* Top Bar */}
            <div style={{
                backgroundColor: '#00897b',
                color: 'white',
                padding: '0.5rem 2rem',
                fontSize: '0.875rem',
            }}>
                <div style={{
                    maxWidth: '1200px',
                    margin: '0 auto',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    flexWrap: 'wrap',
                    gap: '0.5rem',
                }}>
                    <div style={{ display: 'flex', gap: '1.5rem' }}>
                        <a href="mailto:info@primecare.ca" style={{ color: 'white', textDecoration: 'none' }}>
                            📧 info@primecare.ca
                        </a>
                        <a href="tel:+14165551234" style={{ color: 'white', textDecoration: 'none' }}>
                            📞 (416) 555-1234
                        </a>
                    </div>
                    <div style={{ display: 'flex', gap: '1rem' }}>
                        <Link to="/login" style={{ color: 'white', textDecoration: 'none' }}>Family Login</Link>
                        <span style={{ opacity: 0.5 }}>|</span>
                        <Link to="/caregiver-login" style={{ color: 'white', textDecoration: 'none' }}>Caregiver Login</Link>
                    </div>
                </div>
            </div>

            {/* Main Nav */}
            <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '1rem 2rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                {/* Logo */}
                <Link to={RouteRegistry.HOME} style={{ textDecoration: 'none', display: 'flex', alignItems: 'center' }}>
                    <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ height: '100px', width: 'auto', transition: 'height 0.3s ease' }} />
                </Link>

                {/* Desktop Nav */}
                <nav className="desktop-nav" style={{ display: 'none', gap: '2rem', alignItems: 'center' }}>
                    <style>{`@media (min-width: 900px) { .desktop-nav { display: flex !important; } .mobile-toggle { display: none !important; } }`}</style>

                    <Dropdown {...aboutMenu} />
                    <Dropdown {...servicesMenu} />
                    <Dropdown {...educationMenu} />
                    <Link to="/consulting" style={{ textDecoration: 'none', color: '#333' }}>Healthcare Consulting</Link>
                    <Link to={RouteRegistry.SERVICE_IT} style={{ textDecoration: 'none', color: '#333' }}>HealthTech & IT</Link>

                    <Link
                        to={RouteRegistry.BOOKING}
                        style={{
                            padding: '0.75rem 1.5rem',
                            backgroundColor: '#00897b',
                            color: 'white',
                            borderRadius: '50px',
                            textDecoration: 'none',
                            fontWeight: 'bold',
                            transition: 'transform 0.2s, box-shadow 0.2s',
                        }}
                        onMouseOver={(e) => {
                            e.currentTarget.style.transform = 'translateY(-2px)';
                            e.currentTarget.style.boxShadow = '0 4px 15px rgba(0,77,64,0.3)';
                        }}
                        onMouseOut={(e) => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = 'none';
                        }}
                    >
                        Book Now
                    </Link>
                </nav>

                {/* Mobile Toggle */}
                <button className="mobile-toggle" onClick={toggleMenu} style={{ background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer' }}>
                    {isMobileMenuOpen ? '✕' : '☰'}
                </button>
            </div>

            {/* Mobile Menu */}
            {isMobileMenuOpen && (
                <div style={{ backgroundColor: 'white', borderTop: '1px solid #eee', padding: '1rem 0' }}>
                    {/* About Section */}
                    <div>
                        <div
                            onClick={() => toggleMobileSubmenu('about')}
                            style={{ padding: '0.75rem 2rem', display: 'flex', justifyContent: 'space-between', cursor: 'pointer', fontWeight: 'bold', color: '#00897b' }}
                        >
                            About Us <span>{mobileSubmenu === 'about' ? '−' : '+'}</span>
                        </div>
                        {mobileSubmenu === 'about' && (
                            <div style={{ paddingLeft: '2rem', backgroundColor: '#f9f9f9' }}>
                                <Link to={RouteRegistry.ABOUT} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>About the Company</Link>
                                <Link to={RouteRegistry.CAREERS} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Careers</Link>
                                <Link to="/volunteer" onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Volunteer</Link>
                                <Link to="/franchise" onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Franchise</Link>
                                <Link to="/testimonials" onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Testimonials</Link>
                            </div>
                        )}
                    </div>

                    {/* Services Section */}
                    <div>
                        <div
                            onClick={() => toggleMobileSubmenu('services')}
                            style={{ padding: '0.75rem 2rem', display: 'flex', justifyContent: 'space-between', cursor: 'pointer', fontWeight: 'bold', color: '#00897b' }}
                        >
                            Senior Care <span>{mobileSubmenu === 'services' ? '−' : '+'}</span>
                        </div>
                        {mobileSubmenu === 'services' && (
                            <div style={{ paddingLeft: '2rem', backgroundColor: '#f9f9f9' }}>
                                <Link to={RouteRegistry.SERVICE_SENIOR} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Personal Care</Link>
                                <Link to={RouteRegistry.SERVICE_FOOT_CARE} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Foot Care</Link>
                                <Link to="/services/staffing" onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Staffing</Link>
                            </div>
                        )}
                    </div>

                    {/* Education Section */}
                    <div>
                        <div
                            onClick={() => toggleMobileSubmenu('education')}
                            style={{ padding: '0.75rem 2rem', display: 'flex', justifyContent: 'space-between', cursor: 'pointer', fontWeight: 'bold', color: '#00897b' }}
                        >
                            Education <span>{mobileSubmenu === 'education' ? '−' : '+'}</span>
                        </div>
                        {mobileSubmenu === 'education' && (
                            <div style={{ paddingLeft: '2rem', backgroundColor: '#f9f9f9' }}>
                                <Link to="/education/foot-care-certificate" onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>Foot Care Nurse Certificate</Link>
                                <Link to="/education/psw-training" onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 1rem', color: '#333', textDecoration: 'none' }}>PSW Training</Link>
                            </div>
                        )}
                    </div>

                    <Link to={RouteRegistry.BLOG} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 2rem', color: '#333', textDecoration: 'none' }}>Blog</Link>
                    <Link to={RouteRegistry.CONTACT} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 2rem', color: '#333', textDecoration: 'none' }}>Contact</Link>

                    <div style={{ padding: '1rem 2rem' }}>
                        <Link
                            to={RouteRegistry.BOOKING}
                            onClick={toggleMenu}
                            style={{
                                display: 'block',
                                padding: '0.75rem',
                                backgroundColor: '#00897b',
                                color: 'white',
                                borderRadius: '8px',
                                textDecoration: 'none',
                                textAlign: 'center',
                                fontWeight: 'bold',
                            }}
                        >
                            Book Now
                        </Link>
                    </div>
                </div>
            )}
        </header>
    );
}
