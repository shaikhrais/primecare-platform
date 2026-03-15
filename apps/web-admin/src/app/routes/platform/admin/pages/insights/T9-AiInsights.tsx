// ================================================================
// PAGE IDENTITY: T9 � AI Insights
// Registry ID:   page.admin.insights
// Type:          Tool
// Owner:         admin
// ================================================================
import { AdminRegistry , getButtonById } from 'prime-care-shared';
import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, AreaChart, Area } from 'recharts';
import { PredictiveStaffingWidget } from './components/PredictiveStaffingWidget';

const { ContentRegistry, ButtonRegistry } = AdminRegistry;

const data = [
    { name: 'Mon', risk: 12, performance: 85, sentiment: 0.8 },
    { name: 'Tue', risk: 15, performance: 88, sentiment: 0.75 },
    { name: 'Wed', risk: 45, performance: 72, sentiment: -0.2 }, // Alert spike
    { name: 'Thu', risk: 20, performance: 80, sentiment: 0.4 },
    { name: 'Fri', risk: 10, performance: 92, sentiment: 0.9 },
];

export default function AIInsights() {
    const refreshBtn = getButtonById('btn-ai-insights-refresh');

    return (
        <div data-cy="page.container" role="main" aria-label="AI Insights" style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>{ContentRegistry.INSIGHTS.TITLE}</h1>
                    <p style={{ color: '#6B7280' }}>{ContentRegistry.INSIGHTS.SUBTITLE}</p>
                </div>
                <button
                    className="btn secondary"
                    data-cy="btn-ai-insights-refresh"
                >
                    {refreshBtn?.label || 'Recalculate Insights'}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ borderLeft: '4px solid #F59E0B', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{ContentRegistry.INSIGHTS.CARDS.BURNOUT.LABEL}</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#B45309' }}>High (15%)</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>{ContentRegistry.INSIGHTS.CARDS.BURNOUT.DESC}</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #10B981', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Clinical Sentiment</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#059669' }}>Positive (+0.82)</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Aggregated score from patient notes and staff feedback.</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #3B82F6', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{ContentRegistry.INSIGHTS.CARDS.DEMAND.LABEL}</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>+12%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>{ContentRegistry.INSIGHTS.CARDS.DEMAND.DESC}</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">Sentiment Analysis Stream</div>
                    <div className="pc-card-b" style={{ height: '300px' }}>
                        <ResponsiveContainer width="100%" height="100%">
                            <AreaChart data={data}>
                                <defs>
                                    <linearGradient id="colorSentiment" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="#10B981" stopOpacity={0.8} />
                                        <stop offset="95%" stopColor="#10B981" stopOpacity={0} />
                                    </linearGradient>
                                </defs>
                                <CartesianGrid strokeDasharray="3 3" />
                                <XAxis dataKey="name" />
                                <YAxis />
                                <Tooltip />
                                <Area type="monotone" dataKey="sentiment" stroke="#10B981" fillOpacity={1} fill="url(#colorSentiment)" />
                            </AreaChart>
                        </ResponsiveContainer>
                    </div>
                </div>
                <div className="pc-card">
                    <div className="pc-card-h">AI Strategy Alerts</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '12px' }}>
                            <div style={{ padding: '12px', background: '#FEE2E2', borderRadius: '8px', borderLeft: '4px solid #EF4444' }}>
                                <div style={{ fontSize: '13px', fontWeight: 'bold', color: '#991B1B' }}>Urgent Coverage Gap</div>
                                <p style={{ fontSize: '12px', color: '#B91C1C' }}>Wednesday afternoon shows 40% risk of missed visits in North Region.</p>
                            </div>
                            <div style={{ padding: '12px', background: '#FEF3C7', borderRadius: '8px', borderLeft: '4px solid #F59E0B' }}>
                                <div style={{ fontSize: '13px', fontWeight: 'bold', color: '#92400E' }}>Burnout Warning</div>
                                <p style={{ fontSize: '12px', color: '#B45309' }}>PSW Jane Doe has exceeded 60h/week for two consecutive cycles.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <PredictiveStaffingWidget />
        </div>
    );
}
