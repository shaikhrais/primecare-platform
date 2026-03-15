// ================================================================
// PAGE IDENTITY: T1 · Global Search
// Type: Tool | Owner: admin
// ================================================================
import React, { useState } from 'react';

export default function SearchPage() {
    const [tab, setTab] = useState(0);
    const tabs = ['Clients','Staff','Schedules','Documents'];
    return (
        <div data-cy="page.container" role="main" aria-label="Search" data-cy="T1-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>🔍 Global Search</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Configure and manage tool settings</p>
            </div>
            <div style={{ display: 'flex', gap: '8px', marginBottom: '24px', flexWrap: 'wrap' }}>
                {tabs.map((t, i) => (
                    <button data-cy="btn-admin.search-page-0" key={i} onClick={() => setTab(i)} style={{ padding: '10px 20px', borderRadius: '8px', border: tab===i?'2px solid #374151':'1px solid #E2E8F0', background: tab===i?'#37415110':'white', color: tab===i?'#374151':'#64748B', fontWeight: 600, fontSize: '0.8rem', cursor: 'pointer' }}>{t}</button>
                ))}
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Clients</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Staff</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Schedules</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
                        <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0' }}>
                            <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#0F172A', marginBottom: '8px' }}>Documents</div>
                            <div style={{ height: '120px', background: '#F8FAFC', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8', fontSize: '0.8rem' }}>Content area</div>
                        </div>
            </div>
        </div>
    );
}
