import { AdminRegistry } from 'prime-care-shared';
import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar } from 'recharts';
import { PredictiveStaffingWidget } from './components/PredictiveStaffingWidget';

const { ContentRegistry } = AdminRegistry;

const data = [
    { name: 'Mon', risk: 12, performance: 85 },
    { name: 'Tue', risk: 15, performance: 88 },
    { name: 'Wed', risk: 45, performance: 72 }, // Alert spike
    { name: 'Thu', risk: 20, performance: 80 },
    { name: 'Fri', risk: 10, performance: 92 },
];

export default function AIInsights() {
    return (
        <div style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>{ContentRegistry.INSIGHTS.TITLE}</h1>
                <p style={{ color: '#6B7280' }}>{ContentRegistry.INSIGHTS.SUBTITLE}</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ borderLeft: '4px solid #F59E0B', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{ContentRegistry.INSIGHTS.CARDS.BURNOUT.LABEL}</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#B45309' }}>High (15%)</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>{ContentRegistry.INSIGHTS.CARDS.BURNOUT.DESC}</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #10B981', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{ContentRegistry.INSIGHTS.CARDS.COMPLIANCE.LABEL}</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>98.2%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>{ContentRegistry.INSIGHTS.CARDS.COMPLIANCE.DESC}</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #3B82F6', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{ContentRegistry.INSIGHTS.CARDS.DEMAND.LABEL}</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>+12%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>{ContentRegistry.INSIGHTS.CARDS.DEMAND.DESC}</p>
                </div>
            </div>

            <div style={{ marginBottom: '32px' }}>
                <PredictiveStaffingWidget />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '24px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">{ContentRegistry.INSIGHTS.CHARTS.RISK_PERFORMANCE}</div>
                    <div className="pc-card-b" style={{ height: '300px' }}>
                        <ResponsiveContainer width="100%" height="100%">
                            <LineChart data={data}>
                                <CartesianGrid strokeDasharray="3 3" />
                                <XAxis dataKey="name" />
                                <YAxis />
                                <Tooltip />
                                <Line type="monotone" dataKey="risk" stroke="#EF4444" strokeWidth={3} dot={{ r: 6 }} />
                                <Line type="monotone" dataKey="performance" stroke="#3B82F6" strokeWidth={3} />
                            </LineChart>
                        </ResponsiveContainer>
                    </div>
                </div>

                <div className="pc-card">
                    <div className="pc-card-h">{ContentRegistry.INSIGHTS.TIPS.TITLE}</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '16px' }}>
                            <div style={{ padding: '12px', backgroundColor: '#EFF6FF', borderRadius: '8px', border: '1px solid #DBEAFE' }}>
                                <div style={{ fontWeight: '700', fontSize: '14px', color: '#1E40AF' }}>{ContentRegistry.INSIGHTS.TIPS.DOC_GAP.TITLE}</div>
                                <p style={{ fontSize: '13px', color: '#1E40AF', marginTop: '4px' }}>{ContentRegistry.INSIGHTS.TIPS.DOC_GAP.DESC}</p>
                            </div>
                            <div style={{ padding: '12px', backgroundColor: '#ECFDF5', borderRadius: '8px', border: '1px solid #D1FAE5' }}>
                                <div style={{ fontWeight: '700', fontSize: '14px', color: '#065F46' }}>{ContentRegistry.INSIGHTS.TIPS.STAFF_OPT.TITLE}</div>
                                <p style={{ fontSize: '13px', color: '#065F46', marginTop: '4px' }}>{ContentRegistry.INSIGHTS.TIPS.STAFF_OPT.DESC}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
