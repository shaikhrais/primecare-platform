import React, { useState } from 'react';
import { Route, Lock, Zap, Clock, ShieldCheck, Search, Database } from 'lucide-react';

interface ApiRoute {
    id: string;
    path: string;
    method: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH';
    authLevel: 'PUBLIC' | 'STAFF' | 'ADMIN' | 'SYSTEM';
    latencyMs: number;
    usage7d: number;
}

export const ApiEndpointRegistry: React.FC = () => {
    const [routes, setRoutes] = useState<ApiRoute[]>([
        { id: '1', path: '/api/v1/auth/login', method: 'POST', authLevel: 'PUBLIC', latencyMs: 145, usage7d: 42000 },
        { id: '2', path: '/api/v1/patients/{id}/vitals', method: 'GET', authLevel: 'STAFF', latencyMs: 85, usage7d: 18500 },
        { id: '3', path: '/api/v1/billing/stripe/webhook', method: 'POST', authLevel: 'SYSTEM', latencyMs: 220, usage7d: 3400 },
        { id: '4', path: '/api/v1/admin/tenant/settings', method: 'PUT', authLevel: 'ADMIN', latencyMs: 410, usage7d: 85 },
        { id: '5', path: '/api/v1/public/job-board', method: 'GET', authLevel: 'PUBLIC', latencyMs: 45, usage7d: 112000 }
    ]);

    const [searchTerm, setSearchTerm] = useState('');

    const getMethodColor = (method: string) => {
        switch(method) {
            case 'GET': return '#3B82F6';
            case 'POST': return '#10B981';
            case 'PUT': return '#F59E0B';
            case 'DELETE': return '#EF4444';
            default: return '#64748B';
        }
    };

    const getAuthColor = (auth: string) => {
        switch(auth) {
            case 'PUBLIC': return { bg: '#F1F5F9', text: '#64748B' };
            case 'STAFF': return { bg: '#E0E7FF', text: '#4338CA' };
            case 'ADMIN': return { bg: '#FEF2F2', text: '#DC2626' };
            case 'SYSTEM': return { bg: '#FEF08A', text: '#854D0E' };
            default: return { bg: '#F1F5F9', text: '#64748B' };
        }
    };

    const filtered = routes.filter(r => r.path.toLowerCase().includes(searchTerm.toLowerCase()));

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F3E8FF', padding: '10px', borderRadius: '8px' }}>
                        <Route size={24} color="#9333EA" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>API Endpoint Registry</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Global view of all active service routes, handlers, and latency metrics.</p>
                    </div>
                </div>

                <div style={{ position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '10px' }} />
                    <input 
                        type="text" 
                        placeholder="Search routes..." 
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        style={{ padding: '8px 12px 8px 32px', borderRadius: '6px', border: '1px solid #CBD5E1', outline: 'none', width: '250px' }}
                    />
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Main Table */}
                <div style={{ flex: 3 }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem' }}>
                        <thead>
                            <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Method</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Route Path</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Auth Scope</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Avg Latency</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>7d Traffic</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filtered.map(r => (
                                <tr key={r.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                                    <td style={{ padding: '12px' }}>
                                        <span style={{ color: getMethodColor(r.method), fontWeight: 800 }}>{r.method}</span>
                                    </td>
                                    <td style={{ padding: '12px', fontFamily: 'monospace', color: '#0F172A', fontWeight: 600 }}>
                                        {r.path}
                                    </td>
                                    <td style={{ padding: '12px' }}>
                                        <span style={{ 
                                            backgroundColor: getAuthColor(r.authLevel).bg, 
                                            color: getAuthColor(r.authLevel).text, 
                                            padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700 
                                        }}>
                                            {r.authLevel}
                                        </span>
                                    </td>
                                    <td style={{ padding: '12px' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '6px', color: r.latencyMs > 300 ? '#EF4444' : '#10B981', fontWeight: 600 }}>
                                            {r.latencyMs > 300 ? <Zap size={14} /> : <Clock size={14} />} {r.latencyMs}ms
                                        </div>
                                    </td>
                                    <td style={{ padding: '12px', color: '#475569', fontWeight: 500 }}>
                                        {r.usage7d.toLocaleString()} reqs
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>

                {/* Status Panel */}
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', padding: '20px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <div style={{ fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: '1px solid #E2E8F0', paddingBottom: '12px' }}>
                        <Database size={18} color="#9333EA" /> System Health
                    </div>
                    
                    <div>
                        <div style={{ color: '#64748B', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Active API Surface</div>
                        <div style={{ color: '#0F172A', fontSize: '1.5rem', fontWeight: 800 }}>142 Routes</div>
                    </div>

                    <div>
                        <div style={{ color: '#64748B', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Global Latency P95</div>
                        <div style={{ color: '#10B981', fontSize: '1.5rem', fontWeight: 800 }}>114ms</div>
                    </div>

                    <div style={{ marginTop: 'auto', backgroundColor: '#F0FDF4', border: '1px solid #BBF7D0', borderRadius: '6px', padding: '12px', color: '#16A34A', fontSize: '0.8rem', display: 'flex', alignItems: 'flex-start', gap: '8px' }}>
                        <ShieldCheck size={16} style={{ flexShrink: 0, marginTop: '2px' }} />
                        <span>All endpoints are currently responding successfully. Zero 500-level errors detected in the last hour.</span>
                    </div>
                </div>
            </div>
        </div>
    );
};
