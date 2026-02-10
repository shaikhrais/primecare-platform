import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';

const { ContentRegistry } = MarketingRegistry;

export default function StaffLoginPage() {
    return (
        <div style={{ padding: '80px 20px', textAlign: 'center', backgroundColor: '#ffffff', minHeight: '80vh', color: '#1e293b' }}>
            <div style={{ maxWidth: '600px', margin: '0 auto', backgroundColor: 'white', padding: '40px', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.08)', border: '1px solid #e2e8f0' }}>
                <img src="/logo.png" alt={ContentRegistry.APP.NAME} style={{ width: 'clamp(120px, 40%, 240px)', height: 'auto', marginBottom: '30px' }} />
                <h1 style={{ color: '#00897b', marginBottom: '10px' }}>Staff Portal</h1>
                <p style={{ color: '#64748b', fontSize: '1.1rem', marginBottom: '40px' }}>
                    Access administrative tools, manage clients, and coordinate care.
                </p>

                <div style={{ display: 'grid', gap: '20px' }}>
                    <a href="https://primecare-admin.pages.dev/login?role=staff" data-cy="link-staff-portal" style={{
                        backgroundColor: '#00897b', color: 'white', padding: '16px', borderRadius: '8px',
                        textDecoration: 'none', fontWeight: 'bold', fontSize: '1.2rem', transition: 'transform 0.2s'
                    }}>
                        Enter Staff Portal
                    </a>

                    <div style={{ marginTop: '40px', borderTop: '1px solid #e2e8f0', paddingTop: '40px' }}>
                        <p style={{ fontWeight: 'bold', marginBottom: '20px', color: '#334155' }}>Staff Support</p>
                        <p style={{ color: '#64748b' }}>
                            Need help accessing the portal? Contact IT Support at <a href="mailto:it@primecare.ca" style={{ color: '#00897b' }}>it@primecare.ca</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
