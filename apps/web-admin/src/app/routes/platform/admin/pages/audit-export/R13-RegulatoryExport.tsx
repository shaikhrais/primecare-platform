// ================================================================
// PAGE IDENTITY: R13 · Regulatory Export
// Type: Report | Owner: admin
// ================================================================
import React, { useState } from 'react';

export default function RegulatoryExport() {
    const [dateRange, setDateRange] = useState('last-30');
    const [fmt, setFmt] = useState('pdf');
    return (
        <div data-cy="R13-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>📑 Regulatory Export</h1>
                    <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Generate and export reports</p>
                </div>
                <div style={{ display: 'flex', gap: '8px' }}>
                    <select value={dateRange} onChange={e => setDateRange(e.target.value)} style={{ padding: '8px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem' }}>
                        <option value="last-7">Last 7 Days</option><option value="last-30">Last 30 Days</option><option value="last-90">Last 90 Days</option><option value="ytd">Year to Date</option>
                    </select>
                    <select value={fmt} onChange={e => setFmt(e.target.value)} style={{ padding: '8px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem' }}>
                        <option value="pdf">PDF</option><option value="csv">CSV</option><option value="xlsx">Excel</option>
                    </select>
                    <button style={{ padding: '8px 20px', background: '#7C3AED', color: 'white', border: 'none', borderRadius: '8px', fontWeight: 700, cursor: 'pointer' }}>Export</button>
                </div>
            </div>
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 180px', textAlign: 'center' }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Reg. Reports</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#7C3AED' }}>—</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 180px', textAlign: 'center' }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Submissions</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#7C3AED' }}>—</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 180px', textAlign: 'center' }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Next Due</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#7C3AED' }}>—</div>
                    </div>
            </div>
            <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0' }}>
                <h3 style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginTop: 0 }}>Report Preview</h3>
                <div style={{ height: '300px', background: 'linear-gradient(135deg, #7C3AED05 0%, #7C3AED10 100%)', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8' }}>Report data renders here</div>
            </div>
        </div>
    );
}
