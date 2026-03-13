// ================================================================
// PAGE IDENTITY: H15 · PSW Training Hub
// Type: Hub | Owner: psw
// ================================================================
import React from 'react';

export default function PswTrainingHub() {
    return (
        <div data-cy="H15-page" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ marginBottom: '28px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>🎓 PSW Training Hub</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Central hub for all related activities</p>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '16px' }}>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', cursor: 'pointer', transition: 'all 0.15s' }} onMouseEnter={e => { e.currentTarget.style.borderColor='#065F46'; e.currentTarget.style.boxShadow='0 4px 12px #065F4620'; }} onMouseLeave={e => { e.currentTarget.style.borderColor='#E2E8F0'; e.currentTarget.style.boxShadow='none'; }}>
                        <div style={{ fontSize: '2rem', marginBottom: '12px' }}>📊</div>
                        <div style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginBottom: '4px' }}>Required Courses</div>
                        <div style={{ fontSize: '0.8rem', color: '#94A3B8' }}>Manage required courses settings and data</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', cursor: 'pointer', transition: 'all 0.15s' }} onMouseEnter={e => { e.currentTarget.style.borderColor='#065F46'; e.currentTarget.style.boxShadow='0 4px 12px #065F4620'; }} onMouseLeave={e => { e.currentTarget.style.borderColor='#E2E8F0'; e.currentTarget.style.boxShadow='none'; }}>
                        <div style={{ fontSize: '2rem', marginBottom: '12px' }}>📋</div>
                        <div style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginBottom: '4px' }}>Certifications</div>
                        <div style={{ fontSize: '0.8rem', color: '#94A3B8' }}>Manage certifications settings and data</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', cursor: 'pointer', transition: 'all 0.15s' }} onMouseEnter={e => { e.currentTarget.style.borderColor='#065F46'; e.currentTarget.style.boxShadow='0 4px 12px #065F4620'; }} onMouseLeave={e => { e.currentTarget.style.borderColor='#E2E8F0'; e.currentTarget.style.boxShadow='none'; }}>
                        <div style={{ fontSize: '2rem', marginBottom: '12px' }}>💬</div>
                        <div style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginBottom: '4px' }}>Progress Tracker</div>
                        <div style={{ fontSize: '0.8rem', color: '#94A3B8' }}>Manage progress tracker settings and data</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', cursor: 'pointer', transition: 'all 0.15s' }} onMouseEnter={e => { e.currentTarget.style.borderColor='#065F46'; e.currentTarget.style.boxShadow='0 4px 12px #065F4620'; }} onMouseLeave={e => { e.currentTarget.style.borderColor='#E2E8F0'; e.currentTarget.style.boxShadow='none'; }}>
                        <div style={{ fontSize: '2rem', marginBottom: '12px' }}>📁</div>
                        <div style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginBottom: '4px' }}>Resources</div>
                        <div style={{ fontSize: '0.8rem', color: '#94A3B8' }}>Manage resources settings and data</div>
                    </div>
            </div>
        </div>
    );
}
