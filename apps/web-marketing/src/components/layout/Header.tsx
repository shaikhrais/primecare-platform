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
                    color: 'var(--text)',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '6px',
                    fontWeight: 600,
                    fontSize: '0.95rem',
                    transition: 'var(--pc-transition)',
                }}
            >
                {label}
                <span style={{ fontSize: '0.6rem', opacity: 0.6 }}>▼</span>
            </span>

            {isOpen && (
                <div className="glass-effect" style={{
                    position: 'absolute',
                    top: '100%',
                    left: 0,
                    backgroundColor: 'var(--bg-elev)',
                    minWidth: '240px',
                    boxShadow: 'var(--shadow-lg)',
                    borderRadius: '12px',
                    padding: '0.75rem 0',
                    zIndex: 1000,
                    border: '1px solid var(--line)',
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
                                    padding: '0.75rem 1.25rem',
                                    display: 'flex',
                                    justifyContent: 'space-between',
                                    alignItems: 'center',
                                    cursor: 'pointer',
                                    color: 'var(--text)',
                                    fontWeight: 500,
                                    transition: 'var(--pc-transition)',
                                }}
                                    onMouseOver={(e) => e.currentTarget.style.background = 'var(--line)'}
                                    onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}
                                >
                                    {item.label}
                                    <span style={{ fontSize: '0.6rem', opacity: 0.5 }}>▶</span>
                                </div>
                            ) : (
                                <Link
                                    to={item.link}
                                    data-cy={`nav-dropdown-item-${item.label.toLowerCase().replace(/\s+/g, '-')}`}
                                    style={{
                                        display: 'block',
                                        padding: '0.75rem 1.25rem',
                                        textDecoration: 'none',
                                        color: 'var(--text)',
                                        fontWeight: 500,
                                        transition: 'var(--pc-transition)',
                                    }}
                                    onMouseOver={(e) => e.currentTarget.style.background = 'var(--line)'}
                                    onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}
                                >
                                    {item.label}
                                </Link>
                            )}

                            {/* Submenu */}
                            {item.submenu && activeSubmenu === index && (
                                <div className="glass-effect" style={{
                                    position: 'absolute',
                                    top: 0,
                                    left: '100%',
                                    backgroundColor: 'var(--bg-elev)',
                                    minWidth: '220px',
                                    boxShadow: 'var(--shadow-lg)',
                                    borderRadius: '12px',
                                    padding: '0.75rem 0',
                                    border: '1px solid var(--line)',
                                }}>
                                    {item.submenu.map((subitem, subindex) => (
                                        <Link
                                            key={subindex}
                                            to={subitem.link}
                                            data-cy={`nav-submenu-item-${subitem.label.toLowerCase().replace(/\s+/g, '-')}`}
                                            style={{
                                                display: 'block',
                                                padding: '0.75rem 1.25rem',
                                                textDecoration: 'none',
                                                color: 'var(--text)',
                                                fontWeight: 500,
                                                transition: 'var(--pc-transition)',
                                            }}
                                            onMouseOver={(e) => e.currentTarget.style.background = 'var(--line)'}
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
    const [isFullscreen, setIsFullscreen] = useState(false);

    const toggleFullscreen = () => {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(err => {
                console.error(`Error attempting to enable full-screen mode: ${err.message}`);
            });
            setIsFullscreen(true);
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
                setIsFullscreen(false);
            }
        }
    };

    const toggleMenu = () => setIsMobileMenuOpen(!isMobileMenuOpen);
    const toggleMobileSubmenu = (menu: string) => setMobileSubmenu(mobileSubmenu === menu ? null : menu);

    const aboutMenu = {
        label: 'About',
        items: [
            { label: 'Our Story', link: RouteRegistry.ABOUT },
            {
                label: 'Join Our Team',
                link: '#',
                submenu: [
                    { label: 'Careers', link: RouteRegistry.CAREERS },
                    { label: 'Volunteer', link: RouteRegistry.VOLUNTEER },
                    { label: 'Partnerships', link: RouteRegistry.FRANCHISE },
                ]
            },
            { label: 'Testimonials', link: RouteRegistry.TESTIMONIALS },
            { label: 'Insights Blog', link: RouteRegistry.BLOG },
            { label: 'Contact', link: RouteRegistry.CONTACT },
        ]
    };

    const servicesMenu = {
        label: 'Care Services',
        items: [
            { label: 'Senior Home Care', link: RouteRegistry.SERVICE_SENIOR },
            { label: 'Medical Foot Care', link: RouteRegistry.SERVICE_FOOT_CARE },
            { label: 'Facility Solutions', link: RouteRegistry.SERVICE_FACILITY_FOOT_CARE },
            { label: 'Professional Staffing', link: RouteRegistry.SERVICE_STAFFING },
            { label: 'Training Programs', link: RouteRegistry.SERVICE_EDUCATION },
        ]
    };

    const educationMenu = {
        label: 'Education Hub',
        items: [
            { label: 'Foot Care Certificate', link: RouteRegistry.SERVICE_CERTIFICATE },
            { label: 'PSW Excellence Program', link: RouteRegistry.SERVICE_PSW_TRAINING },
        ]
    };

    return (
        <header className="glass-effect" style={{
            position: 'sticky',
            top: 0,
            zIndex: 1000,
            backgroundColor: 'rgba(255,255,255,0.1)',
            backdropFilter: 'blur(12px)',
            borderBottom: '1px solid rgba(255,255,255,0.1)',
            boxShadow: '0 4px 30px rgba(0, 0, 0, 0.1)'
        }}>
            {/* Top Bar - High Utility */}
            <div style={{
                backgroundColor: 'var(--primary-dark)',
                color: 'white',
                padding: '0.6rem var(--space-4)',
                fontSize: '0.8rem',
                fontWeight: 600,
            }}>
                <div style={{
                    maxWidth: 'var(--container-max)',
                    margin: '0 auto',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    flexWrap: 'wrap',
                    gap: '0.75rem',
                }}>
                    <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap', alignItems: 'center' }}>
                        {/* Full Screen Toggle */}
                        <button
                            data-cy="btn-fullscreen"
                            onClick={toggleFullscreen}
                            title={isFullscreen ? "Exit Fullscreen" : "Enter Fullscreen"}
                            style={{
                                width: '32px',
                                height: '32px',
                                borderRadius: '8px',
                                border: '1px solid rgba(255,255,255,0.2)',
                                background: 'rgba(255,255,255,0.1)',
                                color: 'white',
                                cursor: 'pointer',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontSize: '1rem',
                                transition: 'var(--pc-transition)'
                            }}
                        >
                            {isFullscreen ? (
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3" />
                                </svg>
                            ) : (
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3" />
                                </svg>
                            )}
                        </button>

                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', background: 'rgba(255,255,255,0.1)', padding: '4px 12px', borderRadius: '10px', border: '1px solid rgba(255,255,255,0.1)' }}>
                            <span style={{ fontSize: '0.7rem', opacity: 0.8, textTransform: 'uppercase', letterSpacing: '0.05em', fontWeight: 800 }}>Mode</span>
                            <select
                                id="themePick"
                                data-cy="theme-selector"
                                defaultValue={localStorage.getItem('psw_theme') || 'midnight'}
                                onChange={(e) => {
                                    const v = e.target.value;
                                    document.documentElement.setAttribute('data-theme', v);
                                    localStorage.setItem('psw_theme', v);
                                }}
                                style={{
                                    height: '24px',
                                    borderRadius: '6px',
                                    border: 'none',
                                    background: 'transparent',
                                    color: 'white',
                                    fontSize: '0.75rem',
                                    fontWeight: 700,
                                    cursor: 'pointer',
                                    outline: 'none',
                                    appearance: 'none',
                                    paddingRight: '10px'
                                }}
                            >
                                <option value="midnight" style={{ color: 'black' }}>🌌 Midnight</option>
                                <option value="light" style={{ color: 'black' }}>☀️ Light</option>
                                <option value="ocean" style={{ color: 'black' }}>🌊 Ocean</option>
                                <option value="grape" style={{ color: 'black' }}>🍇 Grape</option>
                                <option value="contrast" style={{ color: 'black' }}>🏁 Contrast</option>
                            </select>
                        </div>
                        <a href="mailto:care@primecare.ca" data-cy="lnk-topbar-email" style={{ color: 'white', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.5rem', opacity: 0.9 }}>
                            <span style={{ opacity: 0.7 }}>✉</span> care@primecare.ca
                        </a>
                        <a href="tel:+14165551234" data-cy="lnk-topbar-phone" style={{ color: 'white', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.5rem', opacity: 0.9 }}>
                            <span style={{ opacity: 0.7 }}>📞</span> (416) 555-1234
                        </a>
                    </div>
                    <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                        <Link to={RouteRegistry.LOGIN} data-cy="link-family-portal" style={{ color: 'white', textDecoration: 'none', opacity: 0.9 }}>Family Portal</Link>
                        <span style={{ opacity: 0.3 }}>|</span>
                        <Link to="/caregiver-login" data-cy="link-caregiver-portal" style={{ color: 'white', textDecoration: 'none', opacity: 0.9 }}>Caregiver Portal</Link>
                        <span style={{ opacity: 0.3 }}>|</span>
                        <Link to={RouteRegistry.LOGIN_STAFF} data-cy="link-staff-hub" style={{ color: 'white', textDecoration: 'none', opacity: 0.9 }}>Staff Hub</Link>
                    </div>
                </div>
            </div>

            {/* Main Nav - Gold Standard Aesthetic */}
            <div style={{
                maxWidth: 'var(--container-max)',
                margin: '0 auto',
                padding: '0.75rem var(--space-4)',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                height: 'var(--header-height)',
            }}>
                {/* Logo */}
                <Link to={RouteRegistry.HOME} data-cy="logo-link" style={{ textDecoration: 'none', display: 'flex', alignItems: 'center' }}>
                    <img
                        src="/logo.png"
                        alt="PrimeCare Logo"
                        style={{ height: 'clamp(50px, 6vw, 70px)', width: 'auto', transition: 'var(--pc-transition)' }}
                    />
                </Link>

                {/* Desktop Nav */}
                <nav className="desktop-nav" style={{ display: 'none', gap: 'var(--space-6)', alignItems: 'center' }}>
                    <style>{`
                        @media (min-width: 1024px) { 
                            .desktop-nav { display: flex !important; } 
                            .mobile-toggle { display: none !important; } 
                        }
                    `}</style>

                    <Dropdown {...aboutMenu} />
                    <Dropdown {...servicesMenu} />
                    <Dropdown {...educationMenu} />

                    <Link to={RouteRegistry.SERVICE_IT} data-cy="nav-healthtech" style={{
                        textDecoration: 'none',
                        color: 'var(--text)',
                        fontWeight: 600,
                        fontSize: '0.95rem',
                        transition: 'var(--pc-transition)'
                    }}>HealthTech</Link>

                    <Link
                        to={RouteRegistry.BOOKING}
                        data-cy="btn-book-assessment"
                        className="btn btn-primary"
                        style={{
                            padding: '0.7rem 1.75rem',
                            borderRadius: '50px',
                            textDecoration: 'none',
                            fontWeight: 800,
                            fontSize: '0.95rem',
                        }}
                    >
                        Book Assessment
                    </Link>
                </nav>

                {/* Mobile Toggle */}
                <button className="mobile-toggle" data-cy="btn-mobile-menu" onClick={toggleMenu} style={{ background: 'none', border: 'none', fontSize: '1.75rem', cursor: 'pointer', color: 'var(--primary)' }}>
                    {isMobileMenuOpen ? '✕' : '☰'}
                </button>
            </div>

            {/* Mobile Menu - Premium Experience */}
            {isMobileMenuOpen && (
                <div className="glass-effect" style={{
                    position: 'absolute',
                    top: '100%',
                    left: 0,
                    width: '100%',
                    backgroundColor: 'var(--bg-elev)',
                    borderTop: '1px solid var(--line)',
                    padding: '1.5rem 0',
                    maxHeight: 'calc(100vh - 120px)',
                    overflowY: 'auto',
                    boxShadow: 'var(--shadow-huge)',
                }}>
                    <div className="container">
                        {[aboutMenu, servicesMenu, educationMenu].map((menu, i) => (
                            <div key={i} style={{ marginBottom: '1rem' }}>
                                <div
                                    onClick={() => toggleMobileSubmenu(menu.label)}
                                    style={{
                                        padding: '1rem 0',
                                        display: 'flex',
                                        justifyContent: 'space-between',
                                        cursor: 'pointer',
                                        fontWeight: 800,
                                        color: 'var(--text)',
                                        borderBottom: '1px solid var(--line)',
                                        fontSize: '1.1rem'
                                    }}
                                >
                                    {menu.label} <span style={{ opacity: 0.5 }}>{mobileSubmenu === menu.label ? '−' : '+'}</span>
                                </div>
                                {mobileSubmenu === menu.label && (
                                    <div style={{ padding: '0.5rem 0 1rem 1.5rem' }}>
                                        {menu.items.map((item: any, id: number) => (
                                            <React.Fragment key={id}>
                                                {item.submenu ? (
                                                    (item.submenu as any[]).map((sub: any, sid: number) => (
                                                        <Link key={sid} to={sub.link} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 0', color: 'var(--text-muted)', textDecoration: 'none', fontWeight: 500 }}>
                                                            {sub.label}
                                                        </Link>
                                                    ))
                                                ) : (
                                                    <Link to={item.link} data-cy={`mobile-nav-${item.label.toLowerCase().replace(/\s+/g, '-')}`} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 0', color: 'var(--text-muted)', textDecoration: 'none', fontWeight: 500 }}>
                                                        {item.label}
                                                    </Link>
                                                )}
                                            </React.Fragment>
                                        ))}
                                    </div>
                                )}
                            </div>
                        ))}

                        <Link to={RouteRegistry.BLOG} data-cy="mobile-nav-insights" onClick={toggleMenu} style={{ display: 'block', padding: '1rem 0', color: 'var(--text)', textDecoration: 'none', fontWeight: 800, fontSize: '1.1rem' }}>Insights & News</Link>

                        <div style={{ marginTop: '2rem' }}>
                            <Link
                                to={RouteRegistry.BOOKING}
                                onClick={toggleMenu}
                                className="btn btn-primary"
                                style={{
                                    display: 'block',
                                    padding: '1.25rem',
                                    borderRadius: '16px',
                                    textDecoration: 'none',
                                    textAlign: 'center',
                                    fontWeight: 800,
                                    fontSize: '1.1rem',
                                }}
                            >
                                Book Assessment Now
                            </Link>
                        </div>
                    </div>
                </div>
            )}
        </header>
    );
}
