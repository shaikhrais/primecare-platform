import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry } = MarketingRegistry;

export default function CaregiverLoginPage() {
    return (
        <div style={{ padding: '80px 20px', textAlign: 'center', backgroundColor: '#0f172a', minHeight: '80vh', color: 'white' }}>
            <div style={{ maxWidth: '600px', margin: '0 auto', backgroundColor: 'rgba(255,255,255,0.05)', padding: '40px', borderRadius: '12px', backdropFilter: 'blur(10px)', border: '1px solid rgba(255,255,255,0.1)' }}>
                <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ height: '120px', width: 'auto', marginBottom: '30px', filter: 'brightness(0) invert(1)' }} />
                <h1 style={{ color: '#4ade80', marginBottom: '10px' }}>Caregiver (PSW) Portal</h1>
                <p style={{ opacity: 0.8, fontSize: '1.1rem', marginBottom: '40px' }}>
                    Manage your shifts, view client notes, and track your performance.
                </p>

                <div style={{ display: 'grid', gap: '20px' }}>
                    <a href="https://primecare-admin.pages.dev/login?role=psw" style={{
                        backgroundColor: '#00897b', color: 'white', padding: '16px', borderRadius: '8px',
                        textDecoration: 'none', fontWeight: 'bold', fontSize: '1.2rem'
                    }}>
                        Enter Staff Web Portal
                    </a>

                    <div style={{ marginTop: '40px', borderTop: '1px solid rgba(255,255,255,0.1)', paddingTop: '40px' }}>
                        <p style={{ fontWeight: 'bold', marginBottom: '20px' }}>Get the Staff App</p>
                        <div style={{ display: 'flex', justifyContent: 'center', gap: '20px', flexWrap: 'wrap' }}>
                            <button style={{ backgroundColor: 'white', color: 'black', padding: '10px 20px', borderRadius: '6px', border: 'none' }}>
                                🍎 iOS Version
                            </button>
                            <button style={{ backgroundColor: 'white', color: 'black', padding: '10px 20px', borderRadius: '6px', border: 'none' }}>
                                🤖 Android APK
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
