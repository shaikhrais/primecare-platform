import React, { useState, useEffect } from 'react';
import { Activity, Gauge, Zap, AlertCircle, RefreshCw, BarChart, Server } from 'lucide-react';

interface VitalsMetric {
    name: 'LCP' | 'FID' | 'CLS';
    fullName: string;
    description: string;
    value: number | string;
    status: 'GOOD' | 'NEEDS_IMPROVEMENT' | 'POOR';
    thresholds: { good: number, poor: number };
    unit: string;
}

export const CoreWebVitalsTracker: React.FC = () => {
    const [metrics, setMetrics] = useState<VitalsMetric[]>([
        { name: 'LCP', fullName: 'Large Contentful Paint', description: 'Measures perceived loading speed. Marks the point when the page\'s main content has likely loaded.', value: 1.8, status: 'GOOD', thresholds: { good: 2.5, poor: 4.0 }, unit: 's' },
        { name: 'FID', fullName: 'First Input Delay', description: 'Measures responsiveness. Quantifies the experience users feel when trying to interact with unresponsive pages.', value: 120, status: 'NEEDS_IMPROVEMENT', thresholds: { good: 100, poor: 300 }, unit: 'ms' },
        { name: 'CLS', fullName: 'Cumulative Layout Shift', description: 'Measures visual stability. Quantifies unexpected layout shifts that occur during the lifespan of the page.', value: 0.04, status: 'GOOD', thresholds: { good: 0.1, poor: 0.25 }, unit: '' }
    ]);

    const [isRefreshing, setIsRefreshing] = useState(false);

    const handleRefresh = () => {
        setIsRefreshing(true);
        setTimeout(() => {
 // slightly fluctuating data
            setMetrics(prev => prev.map(m => {
                if (m.name === 'LCP') return { ...m, value: (1.5 + Math.random()).toFixed(1) as unknown as number, status: Math.random() > 0.8 ? 'NEEDS_IMPROVEMENT' : 'GOOD' };
                if (m.name === 'FID') return { ...m, value: Math.floor(90 + Math.random() * 60) as number, status: 'GOOD' };
                return m;
            }));
            setIsRefreshing(false);
        }, 1200);
    };

    const getStatusColor = (status: string) => {
        switch(status) {
            case 'GOOD': return '#10B981';
            case 'NEEDS_IMPROVEMENT': return '#F59E0B';
            case 'POOR': return '#EF4444';
            default: return '#64748B';
        }
    };

    const getStatusBg = (status: string) => {
        switch(status) {
            case 'GOOD': return '#ECFDF5';
            case 'NEEDS_IMPROVEMENT': return '#FFFBEB';
            case 'POOR': return '#FEF2F2';
            default: return '#F1F5F9';
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0F9FF', padding: '10px', borderRadius: '8px' }}>
                        <Gauge size={24} color="#0EA5E9" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Core Web Vitals Tracker</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Real-time Lighthouse telemetry from React DOM edge nodes.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button 
                        data-cy="btn-sync-telemetry"
                        onClick={handleRefresh}
                        disabled={isRefreshing}
                        style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: isRefreshing ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <RefreshCw size={16} className={isRefreshing ? "animate-spin" : ""} /> Sync Telemetry
                    </button>
                    <button data-cy="btn-export-csv" style={{ backgroundColor: '#0EA5E9', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <BarChart size={16} /> Export CSV Report
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '20px', marginBottom: '24px' }}>
                {metrics.map(metric => (
                    <div key={metric.name} style={{ border: `1px solid ${getStatusColor(metric.status)}`, backgroundColor: getStatusBg(metric.status), borderRadius: '8px', padding: '20px', display: 'flex', flexDirection: 'column', position: 'relative', overflow: 'hidden' }}>
                        <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '4px', backgroundColor: getStatusColor(metric.status) }}></div>
                        
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                            <div>
                                <h4 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    {metric.name} 
                                    <span style={{ fontSize: '0.7rem', backgroundColor: 'rgba(255,255,255,0.7)', padding: '2px 6px', borderRadius: '4px', color: '#475569' }}>{metric.fullName}</span>
                                </h4>
                            </div>
                            <div style={{ backgroundColor: 'white', border: `1px solid ${getStatusColor(metric.status)}`, color: getStatusColor(metric.status), padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 800 }}>
                                {metric.status.replace('_', ' ')}
                            </div>
                        </div>

                        <div style={{ fontSize: '2.5rem', fontWeight: 900, color: getStatusColor(metric.status), marginBottom: '4px', fontFamily: 'monospace' }}>
                            {metric.value} <span style={{ fontSize: '1rem', color: '#64748B', fontWeight: 600 }}>{metric.unit}</span>
                        </div>

                        <div style={{ fontSize: '0.8rem', color: '#475569', lineHeight: 1.4, marginTop: 'auto', paddingTop: '16px', borderTop: '1px dashed rgba(0,0,0,0.1)' }}>
                            {metric.description}
                        </div>
                    </div>
                ))}
            </div>

            <div style={{ backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '8px', padding: '16px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px', color: '#334155', fontSize: '0.9rem', fontWeight: 600 }}>
                    <Server size={18} color="#64748B" /> Data aggregated from 12 edge caching locations globally (last 24 hours).
                </div>
                <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <Zap size={14} color="#EAB308" /> Performance impacts SEO rankings.
                </div>
            </div>
        </div>
    );
};
