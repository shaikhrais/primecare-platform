import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry } = MarketingRegistry;

export default function CaregiverLoginPage() {
    return (
        <div style={{ padding: '80px 20px', textAlign: 'center', backgroundColor: '#ffffff', minHeight: '80vh', color: '#1e293b' }}>
            <div style={{ maxWidth: '600px', margin: '0 auto', backgroundColor: 'white', padding: '40px', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.08)', border: '1px solid #e2e8f0' }}>
                <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ width: 'clamp(120px, 40%, 240px)', height: 'auto', marginBottom: '30px' }} />
                <h1 style={{ color: '#00897b', marginBottom: '10px' }}>Caregiver (PSW) Portal</h1>
                <p style={{ color: '#64748b', fontSize: '1.1rem', marginBottom: '40px' }}>
                    Manage your shifts, view client notes, and track your performance.
                </p>

                <div style={{ display: 'grid', gap: '20px' }}>
                    <a href="https://primecare-admin.pages.dev/login?role=psw" data-cy="link-psw-portal" style={{
                        backgroundColor: '#00897b', color: 'white', padding: '16px', borderRadius: '8px',
                        textDecoration: 'none', fontWeight: 'bold', fontSize: '1.2rem', transition: 'transform 0.2s'
                    }}>
                        Enter Staff Web Portal
                    </a>

                    <div style={{ marginTop: '10px', fontSize: '0.9rem', color: '#64748b' }}>
                        Looking for a different portal? <br />
                        <a href="/login" style={{ color: '#00897b', textDecoration: 'none', fontWeight: '600' }}>Family Login</a>
                        <span style={{ margin: '0 8px', opacity: 0.5 }}>•</span>
                        <a href="/staff-login" style={{ color: '#00897b', textDecoration: 'none', fontWeight: '600' }}>Staff Login</a>
                    </div>

                    <div style={{ marginTop: '40px', borderTop: '1px solid #e2e8f0', paddingTop: '40px' }}>
                        <p style={{ fontWeight: 'bold', marginBottom: '20px', color: '#334155' }}>Get the Staff App</p>
                        <div style={{ display: 'flex', justifyContent: 'center', gap: '20px', flexWrap: 'wrap' }}>
                            <button style={{ backgroundColor: '#1e293b', color: 'white', padding: '10px 20px', borderRadius: '6px', border: 'none', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                🍎 iOS Version
                            </button>
                            <button style={{ backgroundColor: '#1e293b', color: 'white', padding: '10px 20px', borderRadius: '6px', border: 'none', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                🤖 Android APK
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
