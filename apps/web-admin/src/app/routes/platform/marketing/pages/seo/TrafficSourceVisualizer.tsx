import React, { useState } from 'react';
import { BarChart3, TrendingUp, HandCoins, Globe, PieChart, Activity } from 'lucide-react';

interface TrafficSource {
    id: string;
    source: 'Organic SEO' | 'Google Ads (PPC)' | 'Direct' | 'Social Media';
    totalVisitors: number;
    bounceRate: number;
    leadsGenerated: number;
    estimatedCpa: number; // Cost Per Acquisition
}

export const TrafficSourceVisualizer: React.FC = () => {
    const [data] = useState<TrafficSource[]>([
        { id: '1', source: 'Organic SEO', totalVisitors: 12500, bounceRate: 45, leadsGenerated: 180, estimatedCpa: 15.50 }, // Low CPA
        { id: '2', source: 'Google Ads (PPC)', totalVisitors: 8400, bounceRate: 52, leadsGenerated: 210, estimatedCpa: 145.00 }, // High CPA
        { id: '3', source: 'Direct', totalVisitors: 2100, bounceRate: 30, leadsGenerated: 45, estimatedCpa: 0 },
        { id: '4', source: 'Social Media', totalVisitors: 3200, bounceRate: 75, leadsGenerated: 15, estimatedCpa: 85.00 }
    ]);

    const totalLeads = data.reduce((sum, d) => sum + d.leadsGenerated, 0);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px' }}>
                        <BarChart3 size={28} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-traffic-source-visualizer-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Traffic & Acquisition Value (ROI)</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Compare long-term 'Free' Organic SEO leads vs expensive Pay-Per-Click Ad campaigns.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px', marginBottom: '32px' }}>
                 <div style={{ flex: 1, backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', padding: '24px', borderRadius: '12px', display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <Globe size={32} color="#0284C7" />
                    <div>
                        <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Organic SEO Leads</div>
                        <div style={{ fontSize: '2rem', fontWeight: 900, color: '#0F172A' }}>{data[0].leadsGenerated} <span style={{ fontSize: '1rem', color: '#10B981', fontWeight: 700 }}>({((data[0].leadsGenerated/totalLeads)*100).toFixed(0)}%)</span></div>
                    </div>
                </div>

                <div style={{ flex: 1, backgroundColor: '#FEF2F2', border: '1px solid #FECACA', padding: '24px', borderRadius: '12px', display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <HandCoins size={32} color="#DC2626" />
                    <div>
                        <div style={{ fontSize: '0.8rem', color: '#991B1B', fontWeight: 700, textTransform: 'uppercase' }}>Paid Ads (PPC) Leads</div>
                        <div style={{ fontSize: '2rem', fontWeight: 900, color: '#DC2626' }}>{data[1].leadsGenerated} <span style={{ fontSize: '1rem', color: '#B91C1C', fontWeight: 700 }}>({((data[1].leadsGenerated/totalLeads)*100).toFixed(0)}%)</span></div>
                    </div>
                </div>
            </div>

            <table data-cy="table-traffic-source-visualizer" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.95rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Traffic Source</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Total Visitors</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Bounce Rate</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Leads Generated</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Est. Cost Per Lead (CPA)</th>
                    </tr>
                </thead>
                <tbody>
                    {data.map(src => {
                        const isOrganic = src.source === 'Organic SEO';
                        const isExpensive = src.estimatedCpa > 100;

                        return (
                            <tr key={src.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: isOrganic ? '#F0FDF4' : 'transparent' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    {isOrganic ? <Activity size={16} color="#16A34A" /> : <PieChart size={16} color="#64748B" />}
                                    {src.source}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center', color: '#334155', fontWeight: 600 }}>
                                    {src.totalVisitors.toLocaleString()}
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    <span style={{ color: src.bounceRate > 60 ? '#DC2626' : '#64748B', fontWeight: 700 }}>
                                        {src.bounceRate}%
                                    </span>
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center', fontWeight: 900, fontSize: '1.1rem', color: '#0F172A' }}>
                                    {src.leadsGenerated}
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right' }}>
                                    <div style={{ fontWeight: 900, fontSize: '1.2rem', color: isExpensive ? '#DC2626' : (src.estimatedCpa === 0 ? '#64748B' : '#10B981') }}>
                                        ${src.estimatedCpa.toFixed(2)}
                                    </div>
                                    {isOrganic && <div style={{ fontSize: '0.75rem', color: '#16A34A', fontWeight: 800 }}>PROFITABLE</div>}
                                    {isExpensive && <div style={{ fontSize: '0.75rem', color: '#DC2626', fontWeight: 800 }}>HIGH COST</div>}
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#EFF6FF', borderRadius: '8px', border: '1px solid #BFDBFE', fontSize: '0.85rem', color: '#1E3A8A' }}>
                <strong>Executive Summary:</strong> While Google Ads generate leads faster, the Cost Per Acquisition (CPA) is nearly 10x higher than Organic SEO. This dashboard proves to the board of directors that investing capital into Long-Term Content Marketing yields a vastly superior profit margin over time.
            </div>
        </div>
    );
};
