import React, { useState } from 'react';
import { AlertOctagon, TriangleAlert, Bug, Activity, RefreshCw, FileQuestion } from 'lucide-react';

interface ErrorEvent {
    id: string;
    componentName: string;
    errorMessage: string;
    occurrences: number;
    lastSeen: string;
    status: 'OPEN' | 'INVESTIGATING' | 'RESOLVED';
}

export const ErrorBoundaryAggregator: React.FC = () => {
    const [errors, setErrors] = useState<ErrorEvent[]>([
        { id: '1', componentName: '<BillingInvoiceTable />', errorMessage: "TypeError: Cannot read properties of undefined (reading 'map')", occurrences: 142, lastSeen: '10 minutes ago', status: 'OPEN' },
        { id: '2', componentName: '<PswShiftSelector />', errorMessage: "RangeError: Invalid time value", occurrences: 56, lastSeen: '1 hour ago', status: 'INVESTIGATING' },
        { id: '3', componentName: '<InteractivePlayground />', errorMessage: "Error: Maximum update depth exceeded. This can happen when a component repeatedly calls setState...", occurrences: 12, lastSeen: '4 hours ago', status: 'OPEN' },
        { id: '4', componentName: '<DynamicTokenEditor />', errorMessage: "SyntaxError: Unexpected token '}', is not valid JSON", occurrences: 3, lastSeen: '2 days ago', status: 'RESOLVED' }
    ]);
    const [isRefreshing, setIsRefreshing] = useState(false);

    const handleStatusChange = (id: string, newStatus: ErrorEvent['status']) => {
        setErrors(prev => prev.map(e => e.id === id ? { ...e, status: newStatus } : e));
    };

    const handleRefresh = () => {
        setIsRefreshing(true);
        setTimeout(() => {
            setIsRefreshing(false);
        }, 800);
    };

    const getStatusStyles = (status: string) => {
        switch(status) {
            case 'OPEN': return { bg: '#FEF2F2', text: '#DC2626', border: '#FECACA' };
            case 'INVESTIGATING': return { bg: '#FFFBEB', text: '#D97706', border: '#FDE68A' };
            case 'RESOLVED': return { bg: '#F0FDF4', text: '#16A34A', border: '#BBF7D0' };
            default: return { bg: '#F8FAFC', text: '#64748B', border: '#E2E8F0' };
        }
    };

    const totalOpenCrashes = errors.filter(e => e.status === 'OPEN').reduce((sum, e) => sum + e.occurrences, 0);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '10px', borderRadius: '8px' }}>
                        <AlertOctagon size={24} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Frontend Error Aggregator</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Catch and group React 18 Error Boundaries from production clusters.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: '#FEF2F2', border: '1px solid #FECACA', borderRadius: '8px', color: '#DC2626', fontWeight: 700, fontSize: '0.9rem' }}>
                        <Activity size={18} /> {totalOpenCrashes} Active Unhandled Crashes
                    </div>
                    <button 
                        onClick={handleRefresh}
                        style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <RefreshCw size={16} className={isRefreshing ? "animate-spin" : ""} /> Sync Telemetry
                    </button>
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Faulting Component</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Exception Stack Trace</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, width: '100px' }}>Hit Count</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, width: '160px', textAlign: 'right' }}>Resolution State</th>
                    </tr>
                </thead>
                <tbody>
                    {errors.map(error => (
                        <tr key={error.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: error.status === 'RESOLVED' ? '#F8FAFC' : 'white', opacity: error.status === 'RESOLVED' ? 0.6 : 1 }}>
                            <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                    <div style={{ fontFamily: 'monospace', fontWeight: 800, color: '#0F172A' }}>
                                        {error.componentName}
                                    </div>
                                    <div style={{ fontSize: '0.75rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                        Last seen {error.lastSeen}
                                    </div>
                                </div>
                            </td>
                            <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                <div style={{ backgroundColor: '#F1F5F9', border: '1px solid #E2E8F0', padding: '8px', borderRadius: '6px', fontFamily: 'monospace', fontSize: '0.8rem', color: '#334155', display: 'flex', alignItems: 'flex-start', gap: '8px' }}>
                                    <Bug size={14} color="#EF4444" style={{ flexShrink: 0, marginTop: '2px' }} />
                                    <span style={{ wordBreak: 'break-word' }}>{error.errorMessage}</span>
                                </div>
                            </td>
                            <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontWeight: 800, color: error.occurrences > 100 ? '#EF4444' : '#0F172A', fontSize: '1.1rem' }}>
                                    {error.occurrences}
                                    {error.occurrences > 100 && <TriangleAlert size={16} color="#EF4444" />}
                                </div>
                            </td>
                            <td style={{ padding: '12px', verticalAlign: 'top', textAlign: 'right' }}>
                                <select 
                                    value={error.status}
                                    onChange={(e) => handleStatusChange(error.id, e.target.value as any)}
                                    style={{ 
                                        padding: '6px 12px', borderRadius: '6px', outline: 'none', fontWeight: 700, fontSize: '0.75rem', cursor: 'pointer',
                                        border: `1px solid ${getStatusStyles(error.status).border}`,
                                        backgroundColor: getStatusStyles(error.status).bg,
                                        color: getStatusStyles(error.status).text,
                                        width: '100%'
                                    }}
                                >
                                    <option value="OPEN">🔴 OPEN TICKET</option>
                                    <option value="INVESTIGATING">🟡 INVESTIGATING</option>
                                    <option value="RESOLVED">🟢 RESOLVED</option>
                                </select>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div style={{ marginTop: '24px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '12px' }}>
                <FileQuestion size={20} color="#94A3B8" style={{ flexShrink: 0 }} />
                <span>
                    When a React component crashes violently in the user's browser, <code>&lt;ErrorBoundary&gt;</code> wrappers prevent the entire page application from white-screening. This dashboard intercepts those global window errors and groups them by stack-trace fingerprint for forensic review.
                </span>
            </div>
        </div>
    );
};
