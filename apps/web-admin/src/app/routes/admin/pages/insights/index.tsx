import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar } from 'recharts';
import { PredictiveStaffingWidget } from './components/PredictiveStaffingWidget';

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
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>PrimeCare AI Insights</h1>
                <p style={{ color: '#6B7280' }}>Predictive models and clinical intelligence for your agency.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ borderLeft: '4px solid #F59E0B', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Staff Burnout Risk</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#B45309' }}>High (15%)</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>3 PSWs exceed recommended overtime hours.</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #10B981', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Compliance Probability</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>98.2%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Based on automated documentation audits.</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #3B82F6', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Shift Demand Forecast</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>+12%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Expected increase in weekend shift requests.</p>
                </div>
            </div>

            <div style={{ marginBottom: '32px' }}>
                <PredictiveStaffingWidget />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '24px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">Risk vs. Performance (Weekly Prediction)</div>
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
                    <div className="pc-card-h">AI-Generated Care Tips</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '16px' }}>
                            <div style={{ padding: '12px', backgroundColor: '#EFF6FF', borderRadius: '8px', border: '1px solid #DBEAFE' }}>
                                <div style={{ fontWeight: '700', fontSize: '14px', color: '#1E40AF' }}>Documentation Gap</div>
                                <p style={{ fontSize: '13px', color: '#1E40AF', marginTop: '4px' }}>Client "John S." has missing daily notes for the last 48 hours. Risk: Moderate.</p>
                            </div>
                            <div style={{ padding: '12px', backgroundColor: '#ECFDF5', borderRadius: '8px', border: '1px solid #D1FAE5' }}>
                                <div style={{ fontWeight: '700', fontSize: '14px', color: '#065F46' }}>Staff Optimization</div>
                                <p style={{ fontSize: '13px', color: '#065F46', marginTop: '4px' }}>PSWs in the North region are under-utilized by 15% on Mondays.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
