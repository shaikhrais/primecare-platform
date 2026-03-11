import React, { useState } from 'react';
import { Crosshair, Map, DollarSign, Activity, TrendingUp, TrendingDown, Layers } from 'lucide-react';

interface GeoCampaign {
    id: string;
    zipCode: string;
    neighborhood: string;
    campaignName: string;
    adSpendUsd: number;
    impressions: number;
    clicks: number;
    conversions: number;
}

export const GeoFencedAdDashboard: React.FC = () => {
    const [campaigns] = useState<GeoCampaign[]>([
        { id: '1', zipCode: '10021', neighborhood: 'Upper East Side', campaignName: '24/7 Premium Dementia Care', adSpendUsd: 1250, impressions: 45000, clicks: 1200, conversions: 18 },
        { id: '2', zipCode: '33345', neighborhood: 'Sunrise Suburbs', campaignName: 'Weekend Respite Companionship', adSpendUsd: 450, impressions: 12000, clicks: 800, conversions: 4 },
        { id: '3', zipCode: '90210', neighborhood: 'Beverly Hills', campaignName: 'Post-Op Stroke Rehab Nurses', adSpendUsd: 3200, impressions: 85000, clicks: 4100, conversions: 42 }
    ]);

    const calculateCPA = (spend: number, conversions: number) => {
        if (conversions === 0) return 0;
        return spend / conversions;
    };

    const calculateCTR = (clicks: number, impressions: number) => {
        return ((clicks / impressions) * 100).toFixed(2);
    };

    const totalSpend = campaigns.reduce((sum, c) => sum + c.adSpendUsd, 0);
    const totalConversions = campaigns.reduce((sum, c) => sum + c.conversions, 0);
    const averageCPA = calculateCPA(totalSpend, totalConversions);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '12px', borderRadius: '8px' }}>
                        <Crosshair size={28} color="#6366F1" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Geo-Fenced Ad Performance</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Track Cost-Per-Acquisition (CPA) isolated by specific ZIP code boundaries.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '16px' }}>
                    <div style={{ padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', textAlign: 'right' }}>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Total Meta/Google Spend</div>
                        <div style={{ fontSize: '1.2rem', fontWeight: 900, color: '#0F172A' }}>${totalSpend.toLocaleString()}</div>
                    </div>
                    <div style={{ padding: '8px 16px', backgroundColor: '#DCFCE7', borderRadius: '8px', border: '1px solid #BBF7D0', textAlign: 'right' }}>
                        <div style={{ fontSize: '0.75rem', color: '#166534', fontWeight: 700, textTransform: 'uppercase' }}>Avg. Cost Per Client</div>
                        <div style={{ fontSize: '1.2rem', fontWeight: 900, color: '#15803D' }}>${averageCPA.toFixed(2)}</div>
                    </div>
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Geo-Target Area</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Active Campaign</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Ad Spend</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Funnel Metrics</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>CPA (Acquisition Cost)</th>
                    </tr>
                </thead>
                <tbody>
                    {campaigns.map((camp) => {
                        const cpa = calculateCPA(camp.adSpendUsd, camp.conversions);
                        const isExpensive = cpa > 100;

                        return (
                            <tr key={camp.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'top' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, color: '#0F172A' }}>
                                        <Map size={16} color="#64748B" /> {camp.zipCode}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B', marginLeft: '24px' }}>
                                        {camp.neighborhood}
                                    </div>
                                </td>
                                <td style={{ padding: '16px 12px', verticalAlign: 'top' }}>
                                    <div style={{ fontWeight: 600, color: '#334155' }}>"{camp.campaignName}"</div>
                                     <div style={{ fontSize: '0.75rem', color: '#6366F1', marginTop: '4px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                        <Layers size={12} /> Facebook + Google Search Network
                                    </div>
                                </td>
                                <td style={{ padding: '16px 12px', verticalAlign: 'top', textAlign: 'right', fontWeight: 700, color: '#0F172A' }}>
                                    ${camp.adSpendUsd.toLocaleString()}
                                </td>
                                <td style={{ padding: '16px 12px', verticalAlign: 'top', textAlign: 'right' }}>
                                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '4px' }}>
                                        <div style={{ fontSize: '0.85rem', color: '#334155', fontWeight: 600 }}>{((camp.conversions / camp.clicks) * 100).toFixed(1)}% Conv. Rate</div>
                                        <div style={{ fontSize: '0.75rem', color: '#64748B' }}>{calculateCTR(camp.clicks, camp.impressions)}% CTR • {camp.conversions} Signed</div>
                                    </div>
                                </td>
                                <td style={{ padding: '16px 12px', verticalAlign: 'top', textAlign: 'right' }}>
                                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '4px' }}>
                                        <div style={{ fontWeight: 900, fontSize: '1.2rem', color: isExpensive ? '#DC2626' : '#10B981', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                            {isExpensive ? <TrendingUp size={16} /> : <TrendingDown size={16} />} 
                                            ${cpa.toFixed(2)}
                                        </div>
                                        {isExpensive && <div style={{ fontSize: '0.7rem', color: '#DC2626', backgroundColor: '#FEF2F2', padding: '2px 6px', borderRadius: '4px', fontWeight: 800 }}>KILL CAMPAIGN?</div>}
                                    </div>
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
};
