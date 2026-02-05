import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface AdminLayoutProps {
    children: React.ReactNode;
}

export default function AdminLayout({ children }: AdminLayoutProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const [isProfileOpen, setIsProfileOpen] = useState(false);

    const menuItems = [
        { label: 'Dashboard', path: RouteRegistry.DASHBOARD, icon: '📊' },
        { label: 'Users & PSWs', path: RouteRegistry.USERS, icon: '👥' },
        { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
        { label: 'Lead Inquiries', path: '/leads', icon: '📥' },
        { label: 'Settings', path: '/settings', icon: '⚙️' },
    ];

    const handleLogout = () => {
        // Simple logout for now
        navigate(RouteRegistry.LOGIN);
    };

    return (
        <div style={{ display: 'flex', minHeight: '100vh', backgroundColor: '#f9fafb', fontFamily: 'Inter, system-ui, sans-serif' }}>
            {/* Sidebar */}
            <aside style={{
                width: '260px',
                backgroundColor: '#004d40',
                color: 'white',
                display: 'flex',
                flexDirection: 'column',
                position: 'fixed',
                height: '100vh',
                zIndex: 100,
            }}>
                <div style={{ padding: '1.5rem', borderBottom: '1px solid rgba(255,255,255,0.1)' }}>
                    <h1 style={{ fontSize: '1.25rem', fontWeight: 'bold', margin: 0, color: '#4db6ac' }}>
                        PrimeCare <span style={{ color: 'white', fontWeight: 'normal' }}>Admin</span>
                    </h1>
                </div>

                <nav style={{ flex: 1, padding: '1rem 0' }}>
                    {menuItems.map((item) => {
                        const isActive = location.pathname === item.path;
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '0.75rem',
                                    padding: '0.75rem 1.5rem',
                                    textDecoration: 'none',
                                    color: isActive ? 'white' : 'rgba(255,255,255,0.7)',
                                    backgroundColor: isActive ? 'rgba(255,255,255,0.1)' : 'transparent',
                                    borderLeft: isActive ? '4px solid #4db6ac' : '4px solid transparent',
                                    transition: 'all 0.2s',
                                }}
                            >
                                <span style={{ fontSize: '1.2rem' }}>{item.icon}</span>
                                <span style={{ fontWeight: isActive ? '600' : '400' }}>{item.label}</span>
                            </Link>
                        );
                    })}
                </nav>

                <div style={{ padding: '1rem', borderTop: '1px solid rgba(255,255,255,0.1)' }}>
                    <p style={{ fontSize: '0.75rem', opacity: 0.5, margin: 0 }}>Logged in as Admin</p>
                </div>
            </aside>

            {/* Main Content */}
            <main style={{ flex: 1, marginLeft: '260px', display: 'flex', flexDirection: 'column' }}>
                {/* Header */}
                <header style={{
                    height: '64px',
                    backgroundColor: 'white',
                    borderBottom: '1px solid #e5e7eb',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'flex-end',
                    padding: '0 2rem',
                    position: 'sticky',
                    top: 0,
                    zIndex: 90,
                }}>
                    <div style={{ position: 'relative' }}>
                        <button
                            onClick={() => setIsProfileOpen(!isProfileOpen)}
                            style={{
                                background: 'none',
                                border: 'none',
                                cursor: 'pointer',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '0.5rem',
                                color: '#374151',
                                fontWeight: '500',
                            }}
                        >
                            <div style={{ width: '32px', height: '32px', borderRadius: '50%', backgroundColor: '#004d40', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.875rem' }}>
                                A
                            </div>
                            <span>Administrator</span>
                            <span>▼</span>
                        </button>

                        {isProfileOpen && (
                            <div style={{
                                position: 'absolute',
                                top: '100%',
                                right: 0,
                                width: '160px',
                                backgroundColor: 'white',
                                boxShadow: '0 10px 15px -3px rgba(0,0,0,0.1)',
                                borderRadius: '0.5rem',
                                border: '1px solid #e5e7eb',
                                padding: '0.5rem 0',
                                marginTop: '0.5rem',
                            }}>
                                <button style={{ width: '100%', textAlign: 'left', padding: '0.5rem 1rem', background: 'none', border: 'none', cursor: 'pointer', color: '#374151' }}>Profile</button>
                                <button style={{ width: '100%', textAlign: 'left', padding: '0.5rem 1rem', background: 'none', border: 'none', cursor: 'pointer', color: '#374151' }}>Settings</button>
                                <div style={{ borderTop: '1px solid #e5e7eb', margin: '0.5rem 0' }} />
                                <button
                                    onClick={handleLogout}
                                    style={{ width: '100%', textAlign: 'left', padding: '0.5rem 1rem', background: 'none', border: 'none', cursor: 'pointer', color: '#dc2626', fontWeight: '500' }}
                                >
                                    Log out
                                </button>
                            </div>
                        )}
                    </div>
                </header>

                {/* Page Content */}
                <div style={{ padding: '2rem', flex: 1 }}>
                    {children}
                </div>
            </main>
        </div>
    );
}
