import React, { useState } from 'react';
import { Gauge, Zap, LayoutDashboard, MousePointerClick, AlertTriangle, ShieldCheck, TrendingDown } from 'lucide-react';

interface Metric {
    id: string;
    name: string;
    abbr: string;
    description: string;
    currentValue: string;
    status: 'GOOD' | 'NEEDS_IMPROVEMENT' | 'POOR';
    impact: string;
}

export const SeoCoreWebVitals: React.FC = () => {
    const [metrics] = useState<Metric[]>([
        { id: '1', name: 'Largest Contentful Paint', abbr: 'LCP', description: 'Measures loading performance. How long does the main hero banner take to render?', currentValue: '3.2s', status: 'POOR', impact: 'Google penalizes pages > 2.5s' },
        { id: '2', name: 'First Input Delay', abbr: 'FID', description: 'Measures interactivity. How fast does the site react when a user clicks a button?', currentValue: '45ms', status: 'GOOD', impact: 'Fast response. No penalty.' },
        { id: '3', name: 'Cumulative Layout Shift', abbr: 'CLS', description: 'Measures visual stability. Does the text jump around while images load?', currentValue: '0.15', status: 'NEEDS_IMPROVEMENT', impact: 'Frustrates users on mobile.' }
    ]);

    const getStatusColor = (status: Metric['status']) => {
        switch (status) {
            case 'GOOD': return '#10B981';
            case 'NEEDS_IMPROVEMENT': return '#F59E0B';
            case 'POOR': return '#DC2626';
            default: return '#64748B';
        }
    };

    const getStatusBg = (status: Metric['status']) => {
        switch (status) {
            case 'GOOD': return '#F0FDF4';
            case 'NEEDS_IMPROVEMENT': return '#FFFBEB';
            case 'POOR': return '#FEF2F2';
            default: return '#F8FAFC';
        }
    };

    const getIcon = (abbr: string, color: string) => {
        switch (abbr) {
            case 'LCP': return <Zap size={24} color={color} />;
            case 'FID': return <MousePointerClick size={24} color={color} />;
            case 'CLS': return <LayoutDashboard size={24} color={color} />;
            default: return <Gauge size={24} color={color} />;
        }
    };

    const isFailing = metrics.some(m => m.status === 'POOR');

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <Gauge size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 data-cy="h3-seo-core-web-vitals-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>SEO Core Web Vitals Monitor</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Tracks Google's strict technical page-speed metrics. Slow pages are algorithmically punished.</p>
                    </div>
                </div>

                {isFailing && (
                    <div style={{ padding: '8px 16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px solid #FECACA', display: 'flex', alignItems: 'center', gap: '8px', color: '#991B1B', fontWeight: 700, fontSize: '0.85rem' }}>
                        <TrendingDown size={18} /> LCP Rank Penalty Active
                    </div>
                )}
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {metrics.map(metric => (
                    <div key={metric.id} style={{ display: 'flex', flexWrap: 'wrap', gap: '24px', padding: '20px', borderRadius: '12px', backgroundColor: getStatusBg(metric.status), border: `1px solid ${getStatusColor(metric.status)}40` }}>
                        
                        <div style={{ flex: '0 0 auto', display: 'flex', alignItems: 'center', justifyContent: 'center', width: '48px', height: '48px', backgroundColor: 'white', borderRadius: '50%', boxShadow: '0 2px 4px rgba(0,0,0,0.05)' }}>
                            {getIcon(metric.abbr, getStatusColor(metric.status))}
                        </div>

                        <div style={{ flex: '1 1 300px' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '4px' }}>
                                <h4 style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>{metric.name} ({metric.abbr})</h4>
                                {metric.status === 'GOOD' && <ShieldCheck size={16} color="#10B981" />}
                                {(metric.status === 'POOR' || metric.status === 'NEEDS_IMPROVEMENT') && <AlertTriangle size={16} color={getStatusColor(metric.status)} />}
                            </div>
                            <p style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#475569', lineHeight: 1.4 }}>{metric.description}</p>
                            
                            <div style={{ fontSize: '0.8rem', fontWeight: 600, color: getStatusColor(metric.status), display: 'flex', alignItems: 'center', gap: '4px' }}>
                                SEO Impact: {metric.impact}
                            </div>
                        </div>

                        <div style={{ flex: '0 0 auto', display: 'flex', flexDirection: 'column', alignItems: 'flex-end', justifyContent: 'center', paddingLeft: '24px', borderLeft: `1px solid ${getStatusColor(metric.status)}30` }}>
                            <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Current Measurement</div>
                            <div style={{ fontSize: '1.8rem', fontWeight: 900, color: getStatusColor(metric.status) }}>{metric.currentValue}</div>
                            {metric.status === 'POOR' && <button data-cy="btn-seo-core-web-vitals-0" style={{ marginTop: '8px', padding: '4px 12px', backgroundColor: '#DC2626', color: 'white', border: 'none', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800, cursor: 'pointer' }}>Generate Dev Ticket</button>}
                        </div>
                    </div>
                ))}
            </div>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Technical SEO Override:</strong> You can write the best blog post in the world, but if the page takes 4 seconds to load (Poor LCP), Google's algorithm will forcibly demote PrimeCare to Page 2. This dashboard acts as a bridge between the CMO and the Engineering team.
            </div>
        </div>
    );
};
