import React, { useState } from 'react';
import { LayoutDashboard, Radio, Cpu, Network, ShieldAlert, ArrowRightCircle } from 'lucide-react';

interface ComponentBottleneck {
    componentId: string;
    routeCalled: string;
    avgLatencyMs: number;
    impactLevel: 'CRITICAL' | 'MODERATE' | 'LOW';
    percentTrafficAffected: number;
}

export const ApiLatencyHeatmap: React.FC = () => {
    const [bottlenecks] = useState<ComponentBottleneck[]>([
        { componentId: '<FamilyPatientFeed />', routeCalled: 'GET /api/v1/patient/timeline', avgLatencyMs: 1450, impactLevel: 'CRITICAL', percentTrafficAffected: 38 },
        { componentId: '<BillingInvoiceTable />', routeCalled: 'GET /api/v1/finance/invoices', avgLatencyMs: 820, impactLevel: 'MODERATE', percentTrafficAffected: 12 },
        { componentId: '<HeroMarketingBanner />', routeCalled: 'GET /api/v1/cms/promotions', avgLatencyMs: 120, impactLevel: 'LOW', percentTrafficAffected: 85 },
        { componentId: '<PswShiftSelector />', routeCalled: 'GET /api/v1/hr/available-shifts', avgLatencyMs: 1100, impactLevel: 'CRITICAL', percentTrafficAffected: 22 }
    ]);

    const getImpactBg = (impact: string) => {
        if (impact === 'CRITICAL') return '#FEF2F2';
        if (impact === 'MODERATE') return '#FFFBEB';
        return '#ECFDF5';
    };

    const getImpactColor = (impact: string) => {
        if (impact === 'CRITICAL') return '#DC2626';
        if (impact === 'MODERATE') return '#D97706';
        return '#10B981';
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '10px', borderRadius: '8px' }}>
                        <Network size={24} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Component-API Latency Heatmap</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Correlate slow React UI renders directly to backend network bottlenecks.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                <div style={{ flex: 2, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {bottlenecks.map(b => (
                        <div key={b.componentId} style={{ border: `1px solid ${getImpactColor(b.impactLevel)}`, borderRadius: '8px', padding: '16px', backgroundColor: getImpactBg(b.impactLevel), display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <div style={{ display: 'flex', gap: '24px', alignItems: 'center' }}>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800, fontFamily: 'monospace' }}>
                                        <LayoutDashboard size={16} color="#64748B" /> {b.componentId}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>React View Node</div>
                                </div>

                                <ArrowRightCircle size={20} color="#CBD5E1" />

                                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800, fontFamily: 'monospace' }}>
                                        <Server size={16} color="#64748B" /> {b.routeCalled}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>Backend Route Config</div>
                                </div>
                            </div>

                            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '4px' }}>
                                <div style={{ fontSize: '1.4rem', fontWeight: 800, color: getImpactColor(b.impactLevel) }}>
                                    {b.avgLatencyMs} <span style={{ fontSize: '0.8rem', fontWeight: 600 }}>ms avg.</span>
                                </div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 700, backgroundColor: 'rgba(255,255,255,0.6)', padding: '2px 8px', borderRadius: '12px', color: '#475569' }}>
                                    Affecting {b.percentTrafficAffected}% of global traffic
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                <div style={{ flex: 1, backgroundColor: '#1E293B', borderRadius: '8px', padding: '20px', color: '#F8FAFC', display: 'flex', flexDirection: 'column' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, marginBottom: '16px', color: '#E2E8F0', borderBottom: '1px solid #334155', paddingBottom: '16px' }}>
                        <Cpu size={18} /> Network Diagnostic
                    </div>

                    <p style={{ fontSize: '0.85rem', color: '#CBD5E1', lineHeight: 1.6, marginTop: 0 }}>
                        The heatmap isolates React components that are rendering slowly not due to complex DOM calculation, but because they are blocked waiting on sluggish JSON payloads from the PostgreSQL APIs.
                    </p>

                    <div style={{ marginTop: 'auto', backgroundColor: '#FEF2F2', border: '1px solid #FECACA', borderRadius: '8px', padding: '16px', color: '#991B1B' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, fontSize: '0.85rem', marginBottom: '8px' }}>
                            <ShieldAlert size={16} /> Action Required
                        </div>
                        <div style={{ fontSize: '0.8rem', lineHeight: 1.5 }}>
                            The backend route <code>/api/v1/patient/timeline</code> is currently stalling the <code>&lt;FamilyPatientFeed /&gt;</code> view for 1.4 seconds. Flag this to backend engineers for Redis caching.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};
