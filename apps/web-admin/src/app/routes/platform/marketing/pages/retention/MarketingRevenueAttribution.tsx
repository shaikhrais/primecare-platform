import React, { useState } from 'react';
import { DollarSign, Map, Link, ArrowRight, MousePointerClick, TrendingUp, HandCoins } from 'lucide-react';

interface AttributionMetric {
    id: string;
    campaignName: string;
    utmSource: string;
    spend: number;
    clicksTracked: number;
    leadsCaptured: number;
    contractsSigned: number;
    actualBilledRevenue: number; // The Holy Grail Metric
}

import { apiClient } from '@/shared/utils/apiClient';

export const MarketingRevenueAttribution: React.FC = () => {
    const [metrics, setMetrics] = useState<AttributionMetric[]>([]);
    const [loading, setLoading] = useState(true);

    React.useEffect(() => {
        const fetchMetrics = async () => {
            try {
                const res = await apiClient.get('/v1/system/marketing/revenue-attribution');
                if (res.ok) {
                    const data = await res.json();
                    setMetrics(data);
                }
            } catch (error) {
                console.error("Failed to load attribution metrics", error);
            } finally {
                setLoading(false);
            }
        };
        fetchMetrics();
    }, []);

    const totalSpend = metrics.reduce((sum, m) => sum + m.spend, 0);
    const totalRevenue = metrics.reduce((sum, m) => sum + m.actualBilledRevenue, 0);
    const globalROAS = (totalRevenue / totalSpend).toFixed(2); // Return on Ad Spend

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#ECFCCB', padding: '12px', borderRadius: '8px', border: '1px solid #D9F99D' }}>
                        <HandCoins size={28} color="#4D7C0F" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Marketing Revenue Attribution (MRA)</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>The Holy Grail. Maps exact $ spend to actual invoiced patient revenue (LTV).</p>
                    </div>
                </div>

                <div style={{ padding: '8px 16px', backgroundColor: '#F0FDF4', borderRadius: '8px', border: '1px solid #BBF7D0', display: 'flex', alignItems: 'center', gap: '12px' }}>
                     <TrendingUp size={20} color="#16A34A" />
                     <div>
                        <div style={{ fontSize: '0.75rem', color: '#166534', fontWeight: 700, textTransform: 'uppercase' }}>Global Network ROAS</div>
                        <div style={{ fontSize: '1.2rem', fontWeight: 900, color: '#16A34A' }}>{globalROAS}x Return</div>
                     </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {loading ? <div style={{ textAlign: 'center', padding: '24px', color: '#64748B' }}>Syncing revenue attribution models...</div> : (metrics.map(metric => {
                    const roas = (metric.actualBilledRevenue / metric.spend) || 0;
                    const isProfitable = roas > 3; // >3x ROI is generally considered profitable
                    const isTotalLoss = metric.contractsSigned === 0;

                    return (
                        <div key={metric.id} style={{ display: 'flex', alignItems: 'center', padding: '16px', backgroundColor: isTotalLoss ? '#FEF2F2' : 'white', border: `1px solid ${isTotalLoss ? '#FECACA' : '#E2E8F0'}`, borderRadius: '8px' }}>
                            
                            {/* Campaign Info */}
                            <div style={{ flex: '1 1 200px' }}>
                                <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#0F172A', marginBottom: '4px' }}>{metric.campaignName}</div>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '4px', fontFamily: 'monospace' }}>
                                    <Link size={12}/> {metric.utmSource}
                                </div>
                            </div>

                            {/* Funnel Flow Visualizer */}
                            <div style={{ flex: '2 1 400px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px' }}>
                                
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Budget Invested</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 800, color: '#DC2626' }}>${metric.spend.toLocaleString()}</div>
                                </div>

                                <ArrowRight size={16} color="#CBD5E1" />

                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Clicks / Traffic</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 800, color: '#334155' }}><MousePointerClick size={14} style={{verticalAlign:'middle'}}/> {metric.clicksTracked.toLocaleString()}</div>
                                </div>

                                <ArrowRight size={16} color="#CBD5E1" />

                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Leads Caught</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 800, color: '#334155' }}>{metric.leadsCaptured}</div>
                                </div>

                                <ArrowRight size={16} color="#CBD5E1" />

                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Contracts Signed</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 800, color: '#0F172A' }}>{metric.contractsSigned}</div>
                                </div>
                            </div>

                            {/* Ultimate ROI Output */}
                            <div style={{ flex: '0 0 200px', display: 'flex', flexDirection: 'column', alignItems: 'flex-end', paddingLeft: '24px', borderLeft: '1px solid #E2E8F0' }}>
                                <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Actual Invoiced Revenue</div>
                                <div style={{ fontSize: '1.5rem', fontWeight: 900, color: isTotalLoss ? '#DC2626' : '#16A34A', display: 'flex', alignItems: 'center' }}>
                                    <DollarSign size={20} strokeWidth={3}/> {metric.actualBilledRevenue.toLocaleString()}
                                </div>
                                <div style={{ fontSize: '0.8rem', fontWeight: 800, color: isTotalLoss ? '#991B1B' : (isProfitable ? '#166534' : '#CA8A04'), backgroundColor: isTotalLoss ? '#FEE2E2' : (isProfitable ? '#DCFCE7' : '#FEF9C3'), padding: '2px 8px', borderRadius: '4px', marginTop: '4px' }}>
                                    ROAS: {roas.toFixed(1)}x
                                </div>
                            </div>

                        </div>
                    );
                }))}
            </div>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', fontSize: '0.9rem', color: '#0F172A', lineHeight: 1.5 }}>
                <strong>The Ultimate Boardroom Proof:</strong> Most agencies only track 'Leads Generated', which is a vanity metric. Because PrimeCare's CRM is vertically integrated into our Billing Engine, this dashboard maps exactly which ad campaign generated specific contracts. It proves that the $350 spent on 'Hospital Discharge Flyers' generated $92,000 in actual billed care services, allowing the CEO to confidently re-allocate millions in marketing budget based on mathematical truth, not guesswork.
            </div>
        </div>
    );
};
