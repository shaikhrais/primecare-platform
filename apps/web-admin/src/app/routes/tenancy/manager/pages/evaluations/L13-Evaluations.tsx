// ================================================================
// PAGE IDENTITY: L13 · Evaluations
// Type: List | Owner: manager
// ================================================================
import React, { useState } from 'react';

const MOCK = Array.from({ length: 10 }, (_, i) => ({ id: i + 1 }));

export default function Evaluations() {
    const [search, setSearch] = useState('');
    const [filter, setFilter] = useState('all');
    return (
        <div role="main" aria-label="Evaluations" data-cy="L13-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>📝 Evaluations</h1>
                    <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Manage and filter records</p>
                </div>
                <button data-cy="btn-manager.evaluations-0" style={{ padding: '10px 20px', background: '#7C3AED', color: 'white', border: 'none', borderRadius: '8px', fontWeight: 700, cursor: 'pointer' }}>+ Add New</button>
            </div>
            <div style={{ display: 'flex', gap: '12px', marginBottom: '20px' }}>
                <input data-cy="input-manager.evaluations-0" type="text" placeholder="Search..." value={search} onChange={e => setSearch(e.target.value)} style={{ flex: 1, padding: '10px 16px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem' }} />
                {['all','active','pending','closed'].map(s => (
                    <button data-cy="btn-manager.evaluations-1" key={s} onClick={() => setFilter(s)} style={{ padding: '8px 16px', borderRadius: '8px', border: filter === s ? '2px solid #7C3AED' : '1px solid #E2E8F0', background: filter === s ? '#7C3AED10' : 'white', color: filter === s ? '#7C3AED' : '#64748B', fontWeight: 600, fontSize: '0.8rem', cursor: 'pointer', textTransform: 'capitalize' }}>{s}</button>
                ))}
            </div>
            <div style={{ background: 'white', borderRadius: '12px', border: '1px solid #E2E8F0', overflow: 'hidden' }}>
                <table data-cy="table-manager.evaluations" style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead><tr style={{ background: '#F8FAFC', borderBottom: '2px solid #E2E8F0' }}>
                                <th style={{ padding: '12px 16px', textAlign: 'left', fontWeight: 700, color: '#64748B', fontSize: '0.75rem', textTransform: 'uppercase' }}>Staff</th>
                                <th style={{ padding: '12px 16px', textAlign: 'left', fontWeight: 700, color: '#64748B', fontSize: '0.75rem', textTransform: 'uppercase' }}>Review Period</th>
                                <th style={{ padding: '12px 16px', textAlign: 'left', fontWeight: 700, color: '#64748B', fontSize: '0.75rem', textTransform: 'uppercase' }}>Evaluator</th>
                                <th style={{ padding: '12px 16px', textAlign: 'left', fontWeight: 700, color: '#64748B', fontSize: '0.75rem', textTransform: 'uppercase' }}>Score</th>
                                <th style={{ padding: '12px 16px', textAlign: 'left', fontWeight: 700, color: '#64748B', fontSize: '0.75rem', textTransform: 'uppercase' }}>Date</th>
                                <th style={{ padding: '12px 16px', textAlign: 'left', fontWeight: 700, color: '#64748B', fontSize: '0.75rem', textTransform: 'uppercase' }}>Status</th>
                    </tr></thead>
                    <tbody>{MOCK.map(r => (
                        <tr key={r.id} style={{ borderBottom: '1px solid #F1F5F9', cursor: 'pointer' }} onMouseEnter={e => e.currentTarget.style.background='#F8FAFC'} onMouseLeave={e => e.currentTarget.style.background='transparent'}>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: '#334155' }}>—</td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: '#334155' }}>—</td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: '#334155' }}>—</td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: '#334155' }}>—</td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: '#334155' }}>—</td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: '#334155' }}>—</td>
                        </tr>
                    ))}</tbody>
                </table>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '12px 16px', borderTop: '1px solid #E2E8F0', fontSize: '0.8rem', color: '#64748B' }}>
                    <span>Showing 1–10 of 48</span>
                    <div style={{ display: 'flex', gap: '4px' }}>{[1,2,3,4].map(n => (
                        <button data-cy="btn-manager.evaluations-2" key={n} style={{ width: '32px', height: '32px', borderRadius: '6px', border: n===1? '2px solid #7C3AED':'1px solid #E2E8F0', background: n===1?'#7C3AED10':'white', cursor: 'pointer', fontWeight: n===1?700:400, color: n===1?'#7C3AED':'#64748B' }}>{n}</button>
                    ))}</div>
                </div>
            </div>
        </div>
    );
}
