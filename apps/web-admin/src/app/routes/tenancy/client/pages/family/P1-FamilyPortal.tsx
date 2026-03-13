// ================================================================
// PAGE IDENTITY: P1 · Family Portal
// Type: Portal | Owner: client
// ================================================================
import React from 'react';

export default function FamilyPortal() {
    return (
        <div data-cy="P1-page" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ background: 'linear-gradient(135deg, #B45309 0%, #B45309CC 100%)', borderRadius: '16px', padding: '32px', marginBottom: '24px', color: 'white' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: '0 0 8px' }}>🏠 Family Portal</h1>
                <p style={{ opacity: 0.9, fontSize: '0.9rem', margin: 0 }}>Welcome to your personalized portal</p>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '16px' }}>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>📊</div>
                        <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A' }}>Welcome</div>
                        <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '4px' }}>View and manage welcome</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>📋</div>
                        <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A' }}>Care Schedule</div>
                        <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '4px' }}>View and manage care schedule</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>💬</div>
                        <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A' }}>Messages</div>
                        <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '4px' }}>View and manage messages</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>📁</div>
                        <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A' }}>Documents</div>
                        <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '4px' }}>View and manage documents</div>
                    </div>
            </div>
        </div>
    );
}
