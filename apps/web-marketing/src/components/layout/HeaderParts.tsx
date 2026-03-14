/**
 * Header Sub-Components
 * Extracted from Header.tsx — Dropdown, TopBar, MobileMenu
 */
import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { RouteRegistry } = MarketingRegistry;

interface DropdownProps { label: string; items: { label: string; link: string; submenu?: { label: string; link: string }[] }[]; }

export function Dropdown({ label, items }: DropdownProps) {
    const [isOpen, setIsOpen] = useState(false);
    const [activeSubmenu, setActiveSubmenu] = useState<number | null>(null);
    return (
        <div style={{ position: 'relative' }} onMouseEnter={() => setIsOpen(true)} onMouseLeave={() => { setIsOpen(false); setActiveSubmenu(null); }}>
            <span data-cy={`nav-dropdown-${label.toLowerCase().replace(/\s+/g, '-')}`} style={{ cursor: 'pointer', color: 'var(--text)', display: 'flex', alignItems: 'center', gap: '6px', fontWeight: 600, fontSize: '0.95rem', transition: 'var(--pc-transition)' }}>
                {label}<span style={{ fontSize: '0.6rem', opacity: 0.6 }}>▼</span>
            </span>
            {isOpen && (
                <div style={{ position: 'absolute', top: '100%', left: 0, backgroundColor: 'var(--bg-900)', minWidth: '220px', boxShadow: '0 10px 30px rgba(0,0,0,0.05)', borderRadius: '8px', padding: '0.5rem 0', zIndex: 1000, border: '1px solid var(--line)', marginTop: '0.5rem' }}>
                    {items.map((item, index) => (
                        <div key={index} style={{ position: 'relative' }} onMouseEnter={() => item.submenu && setActiveSubmenu(index)} onMouseLeave={() => setActiveSubmenu(null)}>
                            {item.submenu ? (
                                <div style={{ padding: '0.75rem 1.25rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'pointer', color: 'var(--text)', fontWeight: 500, transition: 'var(--pc-transition)' }} onMouseOver={(e) => e.currentTarget.style.background = 'var(--line)'} onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}>{item.label}<span style={{ fontSize: '0.6rem', opacity: 0.5 }}>▶</span></div>
                            ) : (
                                <Link to={item.link} data-cy={`nav-dropdown-item-${item.label.toLowerCase().replace(/\s+/g, '-')}`} style={{ display: 'block', padding: '0.75rem 1.25rem', textDecoration: 'none', color: 'var(--text)', fontWeight: 500, transition: 'var(--pc-transition)' }} onMouseOver={(e) => e.currentTarget.style.background = 'var(--line)'} onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}>{item.label}</Link>
                            )}
                            {item.submenu && activeSubmenu === index && (
                                <div style={{ position: 'absolute', top: 0, left: 'calc(100% + 5px)', backgroundColor: 'var(--bg-900)', minWidth: '200px', boxShadow: '0 10px 30px rgba(0,0,0,0.05)', borderRadius: '8px', padding: '0.5rem 0', border: '1px solid var(--line)' }}>
                                    {item.submenu.map((subitem, subindex) => (
                                        <Link key={subindex} to={subitem.link} data-cy={`nav-submenu-item-${subitem.label.toLowerCase().replace(/\s+/g, '-')}`} style={{ display: 'block', padding: '0.75rem 1.25rem', textDecoration: 'none', color: 'var(--text)', fontWeight: 500, transition: 'var(--pc-transition)' }} onMouseOver={(e) => e.currentTarget.style.background = 'var(--line)'} onMouseOut={(e) => e.currentTarget.style.background = 'transparent'}>{subitem.label}</Link>
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

export function TopBar({ isFullscreen, toggleFullscreen }: { isFullscreen: boolean; toggleFullscreen: () => void }) {
    return (
        <div style={{ backgroundColor: 'var(--bg-800)', color: 'var(--text-300)', padding: '0.5rem var(--space-8)', fontSize: '0.8rem', fontWeight: 600, borderBottom: '1px solid var(--line)' }}>
            <div style={{ maxWidth: 'var(--container-max)', margin: '0 auto', display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '0.75rem' }}>
                <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap', alignItems: 'center' }}>
                    <button data-cy="btn-fullscreen" onClick={toggleFullscreen} title={isFullscreen ? "Exit Fullscreen" : "Enter Fullscreen"} style={{ width: '30px', height: '30px', borderRadius: '6px', border: '1px solid var(--line)', background: '#FFFFFF', color: 'var(--text)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.9rem', transition: 'var(--pc-transition)' }}>
                        {isFullscreen ? (
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3" /></svg>
                        ) : (
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3" /></svg>
                        )}
                    </button>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', background: 'rgba(0, 135, 90, 0.05)', padding: '4px 12px', borderRadius: '4px', border: '1px solid var(--brand-500)' }}><span style={{ fontSize: '0.65rem', color: 'var(--brand-500)', textTransform: 'uppercase', letterSpacing: '0.05rem', fontWeight: 800 }}>Verified Site</span></div>
                    <a href="mailto:care@primecare.ca" data-cy="lnk-topbar-email" style={{ color: 'var(--text-300)', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.5rem' }}><span style={{ opacity: 0.6 }}>✉</span> care@primecare.ca</a>
                    <a href="tel:+14165551234" data-cy="lnk-topbar-phone" style={{ color: 'var(--text-300)', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.5rem' }}><span style={{ opacity: 0.6 }}>📞</span> (416) 555-1234</a>
                </div>
                <div style={{ display: 'flex', gap: '1.25rem', alignItems: 'center' }}>
                    <Link to={RouteRegistry.LOGIN} data-cy="link-family-portal" style={{ color: 'var(--text-300)', textDecoration: 'none' }}>Family Portal</Link>
                    <span style={{ opacity: 0.2, color: 'var(--text-300)' }}>|</span>
                    <Link to="/caregiver-login" data-cy="link-caregiver-portal" style={{ color: 'var(--text-300)', textDecoration: 'none' }}>Caregiver Portal</Link>
                    <span style={{ opacity: 0.2, color: 'var(--text-300)' }}>|</span>
                    <Link to={RouteRegistry.LOGIN_STAFF} data-cy="link-staff-hub" style={{ color: 'var(--text-300)', textDecoration: 'none' }}>Staff Hub</Link>
                </div>
            </div>
        </div>
    );
}

export interface NavMenu { label: string; items: { label: string; link: string; submenu?: { label: string; link: string }[] }[]; }

export function MobileMenu({ menus, isMobileMenuOpen, toggleMenu }: { menus: NavMenu[]; isMobileMenuOpen: boolean; toggleMenu: () => void }) {
    const [mobileSubmenu, setMobileSubmenu] = useState<string | null>(null);
    const toggleMobileSubmenu = (menu: string) => setMobileSubmenu(mobileSubmenu === menu ? null : menu);
    if (!isMobileMenuOpen) return null;
    return (
        <div className="glass-effect" style={{ position: 'absolute', top: '100%', left: 0, width: '100%', backgroundColor: 'var(--bg-elev)', borderTop: '1px solid var(--line)', padding: '1.5rem 0', maxHeight: 'calc(100vh - 120px)', overflowY: 'auto', boxShadow: 'var(--shadow-huge)' }}>
            <div className="container">
                {menus.map((menu, i) => (
                    <div key={i} style={{ marginBottom: '1rem' }}>
                        <div onClick={() => toggleMobileSubmenu(menu.label)} style={{ padding: '1rem 0', display: 'flex', justifyContent: 'space-between', cursor: 'pointer', fontWeight: 800, color: 'var(--text)', borderBottom: '1px solid var(--line)', fontSize: '1.1rem' }}>{menu.label} <span style={{ opacity: 0.5 }}>{mobileSubmenu === menu.label ? '−' : '+'}</span></div>
                        {mobileSubmenu === menu.label && (
                            <div style={{ padding: '0.5rem 0 1rem 1.5rem' }}>
                                {menu.items.map((item: any, id: number) => (
                                    <React.Fragment key={id}>
                                        {item.submenu ? (item.submenu as any[]).map((sub: any, sid: number) => (
                                            <Link key={sid} to={sub.link} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 0', color: 'var(--text-muted)', textDecoration: 'none', fontWeight: 500 }}>{sub.label}</Link>
                                        )) : (
                                            <Link to={item.link} data-cy={`mobile-nav-${item.label.toLowerCase().replace(/\s+/g, '-')}`} onClick={toggleMenu} style={{ display: 'block', padding: '0.75rem 0', color: 'var(--text-muted)', textDecoration: 'none', fontWeight: 500 }}>{item.label}</Link>
                                        )}
                                    </React.Fragment>
                                ))}
                            </div>
                        )}
                    </div>
                ))}
                <Link to={RouteRegistry.BLOG} data-cy="mobile-nav-insights" onClick={toggleMenu} style={{ display: 'block', padding: '1rem 0', color: 'var(--text)', textDecoration: 'none', fontWeight: 800, fontSize: '1.1rem' }}>Insights & News</Link>
                <div style={{ marginTop: '2rem' }}>
                    <Link to={RouteRegistry.BOOKING} onClick={toggleMenu} className="btn btn-primary" style={{ display: 'block', padding: '1.25rem', borderRadius: '16px', textDecoration: 'none', textAlign: 'center', fontWeight: 800, fontSize: '1.1rem' }}>Book Assessment Now</Link>
                </div>
            </div>
        </div>
    );
}

export const aboutMenu: NavMenu = { label: 'About', items: [{ label: 'Our Story', link: RouteRegistry.ABOUT }, { label: 'Join Our Team', link: '#', submenu: [{ label: 'Careers', link: RouteRegistry.CAREERS }, { label: 'Volunteer', link: RouteRegistry.VOLUNTEER }, { label: 'Partnerships', link: RouteRegistry.FRANCHISE }] }, { label: 'Testimonials', link: RouteRegistry.TESTIMONIALS }, { label: 'Insights Blog', link: RouteRegistry.BLOG }, { label: 'Contact', link: RouteRegistry.CONTACT }] };
export const servicesMenu: NavMenu = { label: 'Care Services', items: [{ label: 'Senior Home Care', link: RouteRegistry.SERVICE_SENIOR }, { label: 'Medical Foot Care', link: RouteRegistry.SERVICE_FOOT_CARE }, { label: 'Facility Solutions', link: RouteRegistry.SERVICE_FACILITY_FOOT_CARE }, { label: 'Professional Staffing', link: RouteRegistry.SERVICE_STAFFING }, { label: 'Training Programs', link: RouteRegistry.SERVICE_EDUCATION }] };
export const educationMenu: NavMenu = { label: 'Education Hub', items: [{ label: 'Foot Care Certificate', link: RouteRegistry.SERVICE_CERTIFICATE }, { label: 'PSW Excellence Program', link: RouteRegistry.SERVICE_PSW_TRAINING }] };
