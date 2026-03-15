// ================================================================
// PAGE IDENTITY: T27 · Provider Social
// Type: Tool | Owner: psw
// ================================================================
import React, { useState } from 'react';

export default function ProviderSocial() {
    const [tab, setTab] = useState(0);
    const tabs = ['Feed','Announcements','Peer Recognition','Team Updates'];
    return (
        <div role="main" aria-label="Provider Social" data-cy="T27-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>📱 Provider Social</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Configure and manage tool settings</p>
            </div>
            <div style={{ display: 'flex', gap: '8px', marginBottom: '24px', flexWrap: 'wrap' }}>
                {tabs.map((t, i) => (
                    <button data-cy="btn-psw.provider-social-0" key={i} onClick={() => setTab(i)} style={{ padding: '10px 20px', borderRadius: '8px', border: tab===i?'2px solid #065F46':'1px solid #E2E8F0', background: tab===i?'#065F4610':'white', color: tab===i?'#065F46':'#64748B', fontWeight: 600, fontSize: '0.8rem', cursor: 'pointer' }}>{t}</button>
                ))}
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Feed</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Announcements</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Peer Recognition</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Team Updates</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
            </div>
        </div>
    );
}
