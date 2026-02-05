import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry } = MarketingRegistry;

export default function LoginPage() {
    return (
        <div style={{ padding: '80px 20px', textAlign: 'center', backgroundColor: '#ffffff', minHeight: '80vh' }}>
            <div style={{ maxWidth: '600px', margin: '0 auto', backgroundColor: 'white', padding: '40px', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.08)' }}>
                <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ width: 'clamp(120px, 40%, 240px)', height: 'auto', marginBottom: '30px' }} />
                <h1 style={{ color: '#00897b', marginBottom: '10px' }}>Family Member Login</h1>
                <p style={{ color: '#64748b', fontSize: '1.1rem', marginBottom: '40px' }}>
                    Access your care plans, schedule, and communicate with your care team.
                </p>

                <div style={{ display: 'grid', gap: '20px' }}>
                    <a href="https://primecare-admin.pages.dev/login?role=client" style={{
                        backgroundColor: '#00897b', color: 'white', padding: '16px', borderRadius: '8px',
                        textDecoration: 'none', fontWeight: 'bold', fontSize: '1.2rem', transition: 'transform 0.2s'
                    }}>
                        Login to Web Portal
                    </a>

                    <div style={{ marginTop: '40px', borderTop: '1px solid #e2e8f0', paddingTop: '40px' }}>
                        <p style={{ fontWeight: 'bold', color: '#334155', marginBottom: '20px' }}>Download the Mobile App</p>
                        <div style={{ display: 'flex', justifyContent: 'center', gap: '20px', flexWrap: 'wrap' }}>
                            <button style={{ backgroundColor: '#1e293b', color: 'white', padding: '10px 20px', borderRadius: '6px', border: 'none', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                🍎 App Store
                            </button>
                            <button style={{ backgroundColor: '#1e293b', color: 'white', padding: '10px 20px', borderRadius: '6px', border: 'none', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                🤖 Google Play
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
