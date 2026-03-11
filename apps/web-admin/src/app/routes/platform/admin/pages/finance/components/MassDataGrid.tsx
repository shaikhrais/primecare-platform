import React, { useState } from 'react';
import { Database, Download, Filter, Search } from 'lucide-react';

import { apiClient } from '@/shared/utils/apiClient';

export const MassDataGrid: React.FC = () => {
    const [rows, setRows] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');

    React.useEffect(() => {
        const fetchLedger = async () => {
            try {
                const res = await apiClient.get('/v1/system/financial');
                if (res.ok) {
                    const data = await res.json();
                    setRows(data.map((tx: any) => ({
                        id: tx.id.slice(0, 13), // short ID
                        date: new Date(tx.createdAt).toISOString().split('T')[0],
                        tenant: tx.tenantId?.slice(0, 8) || 'Global',
                        type: tx.type || 'SYSTEM_SYNC',
                        amount: parseFloat(tx.amount || 0).toFixed(2),
                        status: tx.status === 'posted' ? 'CLEARED' : tx.status === 'pending' ? 'PENDING' : 'FLAGGED',
                        hash: tx.reference || tx.id.slice(-8).toUpperCase()
                    })));
                }
            } catch (error) {
                console.error("Failed to load global ledger data", error);
            } finally {
                setLoading(false);
            }
        };
        fetchLedger();
    }, []);


    const filteredRows = rows.filter(r => 
        r.id.includes(searchTerm) || 
        r.tenant.toLowerCase().includes(searchTerm.toLowerCase()) || 
        r.hash.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div style={{ display: 'flex', flexDirection: 'column', height: '600px', backgroundColor: 'white', borderRadius: '12px', border: '1px solid #CBD5E1', overflow: 'hidden' }}>
            {/* Toolbar */}
            <div style={{ backgroundColor: '#F8FAFC', padding: '16px 24px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800 }}>
                    <Database size={20} color="#10B981" /> 
                    Global Ledger Table <span style={{ color: '#94A3B8', fontWeight: 600, fontSize: '0.85rem', marginLeft: '8px' }}>(Showing {filteredRows.length} of {rows.length} rows)</span>
                </div>
                
                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ position: 'relative' }}>
                        <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '10px' }} />
                        <input 
                            type="text" 
                            placeholder="Search Hash or ID..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            style={{ padding: '8px 16px 8px 36px', borderRadius: '6px', border: '1px solid #CBD5E1', width: '250px', fontSize: '0.9rem' }}
                        />
                    </div>
                    <button style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: 'white', border: '1px solid #CBD5E1', borderRadius: '6px', cursor: 'pointer', fontWeight: 600, color: '#475569' }}>
                        <Filter size={16} /> Filter
                    </button>
                    <button style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: '#10B981', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 600, color: 'white' }}>
                        <Download size={16} /> CSV
                    </button>
                </div>
            </div>

            {/* Hyper-Dense Excel-style Table */}
            <div style={{ flex: 1, overflow: 'auto', backgroundColor: 'white' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem' }}>
                    <thead style={{ position: 'sticky', top: 0, backgroundColor: '#F1F5F9', borderBottom: '2px solid #CBD5E1', zIndex: 1, textAlign: 'left', fontWeight: 800, color: '#475569' }}>
                        <tr>
                            <th style={{ padding: '12px' }}>Ledger ID</th>
                            <th style={{ padding: '12px' }}>Timestamp</th>
                            <th style={{ padding: '12px' }}>Tenant Routing</th>
                            <th style={{ padding: '12px' }}>Operation Type</th>
                            <th style={{ padding: '12px', textAlign: 'right' }}>Net Amount (USD)</th>
                            <th style={{ padding: '12px', textAlign: 'center' }}>Settlement Status</th>
                            <th style={{ padding: '12px', fontFamily: 'monospace' }}>Tx Hash</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? <tr><td colSpan={7} style={{ padding: '24px', textAlign: 'center', color: '#64748B' }}>Loading millions of records...</td></tr> : filteredRows.map((row, idx) => (
                            <tr key={idx} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: idx % 2 === 0 ? 'white' : '#FAFAFA' }}>
                                <td style={{ padding: '8px 12px', color: '#3B82F6', fontWeight: 600 }}>{row.id}</td>
                                <td style={{ padding: '8px 12px', color: '#64748B' }}>{row.date}</td>
                                <td style={{ padding: '8px 12px', fontWeight: 600, color: '#334155' }}>{row.tenant}</td>
                                <td style={{ padding: '8px 12px' }}>
                                    <span style={{ backgroundColor: '#EEF2FF', color: '#4F46E5', padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700 }}>
                                        {row.type}
                                    </span>
                                </td>
                                <td style={{ padding: '8px 12px', textAlign: 'right', fontWeight: 800, fontFamily: 'monospace' }}>
                                    ${row.amount}
                                </td>
                                <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                    {row.status === 'CLEARED' && <span style={{ color: '#10B981', fontWeight: 700 }}>● CLEARED</span>}
                                    {row.status === 'PENDING' && <span style={{ color: '#F59E0B', fontWeight: 700 }}>○ PENDING</span>}
                                    {row.status === 'FLAGGED' && <span style={{ color: '#EF4444', fontWeight: 700 }}>⚠ FLAGGED</span>}
                                </td>
                                <td style={{ padding: '8px 12px', fontFamily: 'monospace', color: '#94A3B8', fontSize: '0.75rem' }}>{row.hash}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                {filteredRows.length === 0 && (
                    <div style={{ padding: '48px', textAlign: 'center', color: '#94A3B8' }}>No ledger entries match that exact query.</div>
                )}
            </div>
        </div>
    );
};
