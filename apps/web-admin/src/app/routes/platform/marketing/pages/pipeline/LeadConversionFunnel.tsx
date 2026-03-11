import React, { useState } from 'react';
import { Filter, MousePointerClick, UserPlus, FileSignature, AlertTriangle, ChevronRight, Magnet, ArrowDownToLine } from 'lucide-react';

interface FunnelStage {
    id: string;
    stageName: string;
    visitorCount: number;
    dropoffCount: number;
    color: string;
    icon: React.ReactNode;
}

export const LeadConversionFunnel: React.FC = () => {
 // 30-day funnel data
    const [stages] = useState<FunnelStage[]>([
        { id: '1', stageName: 'Website Visitors (Organic + Ads)', visitorCount: 8520, dropoffCount: 6100, color: '#38BDF8', icon: <MousePointerClick size={20} /> },
        { id: '2', stageName: 'Care Cost Calculator Started', visitorCount: 2420, dropoffCount: 1540, color: '#6366F1', icon: <Filter size={20} /> },
        { id: '3', stageName: 'Email Leads Captured', visitorCount: 880, dropoffCount: 520, color: '#8B5CF6', icon: <UserPlus size={20} /> },
        { id: '4', stageName: 'Clinical Assessment Booked', visitorCount: 360, dropoffCount: 110, color: '#D946EF', icon: <Magnet size={20} /> },
        { id: '5', stageName: 'Signed Care Contracts', visitorCount: 250, dropoffCount: 0, color: '#10B981', icon: <FileSignature size={20} /> }
    ]);

    const maxVisitors = stages[0].visitorCount;
    const totalConversionRate = ((stages[stages.length - 1].visitorCount / maxVisitors) * 100).toFixed(1);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '32px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '12px', borderRadius: '12px' }}>
                        <ArrowDownToLine size={28} color="#6366F1" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Lead Conversion Funnel (30 Days)</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.95rem' }}>Visualize exactly where potential clients are dropping out of the sales pipeline.</p>
                    </div>
                </div>

                <div style={{ textAlign: 'right', backgroundColor: '#F8FAFC', padding: '12px 24px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                    <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '1px' }}>Total Conversion Rate</div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: '#10B981', display: 'flex', alignItems: 'center', gap: '6px', justifyContent: 'flex-end' }}>
                        {totalConversionRate}%
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '8px', position: 'relative' }}>
                {stages.map((stage, index) => {
                    const widthPercent = Math.max((stage.visitorCount / maxVisitors) * 100, 15); // Min 15% width for visibility
                    const nextStage = stages[index + 1];
                    const conversionToNext = nextStage ? ((nextStage.visitorCount / stage.visitorCount) * 100).toFixed(1) : null;
                    
                    return (
                        <div key={stage.id} style={{ width: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                            <div style={{ 
                                width: `${widthPercent}%`, 
                                minWidth: '400px',
                                backgroundColor: stage.color, 
                                borderRadius: '8px', 
                                padding: '16px 24px', 
                                display: 'flex', 
                                justifyContent: 'space-between', 
                                alignItems: 'center',
                                color: 'white',
                                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
                                transition: 'all 0.3s ease',
                                position: 'relative'
                            }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px', fontWeight: 700, fontSize: '1.1rem' }}>
                                    <div style={{ backgroundColor: 'rgba(255,255,255,0.2)', padding: '6px', borderRadius: '6px', display: 'flex' }}>
                                        {stage.icon}
                                    </div>
                                    {stage.stageName}
                                </div>
                                <div style={{ fontSize: '1.4rem', fontWeight: 900 }}>
                                    {stage.visitorCount.toLocaleString()}
                                </div>
                                
                                {/* Drop-off flag (except for last stage) */}
                                {stage.dropoffCount > 0 && (
                                    <div style={{ position: 'absolute', right: '-180px', top: '50%', transform: 'translateY(-50%)', backgroundColor: '#FEF2F2', border: '1px solid #FECACA', padding: '8px 12px', borderRadius: '8px', color: '#EF4444', display: 'flex', alignItems: 'center', gap: '8px', width: '140px' }}>
                                        <AlertTriangle size={16} />
                                        <div style={{ display: 'flex', flexDirection: 'column' }}>
                                            <span style={{ fontSize: '0.75rem', fontWeight: 800 }}>LOST LEADS</span>
                                            <span style={{ fontWeight: 900, fontSize: '1.1rem' }}>{stage.dropoffCount.toLocaleString()}</span>
                                        </div>
                                    </div>
                                )}
                            </div>

                            {/* Conversion Arrow between stages */}
                            {nextStage && (
                                <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', margin: '16px 0', color: '#94A3B8' }}>
                                    <div style={{ 
                                        backgroundColor: '#F1F5F9', border: '1px solid #E2E8F0', padding: '4px 12px', borderRadius: '16px', fontSize: '0.8rem', fontWeight: 800, color: '#475569', zIndex: 1
                                    }}>
                                        {conversionToNext}% Conversion
                                    </div>
                                    <div style={{ width: '2px', height: '24px', backgroundColor: '#E2E8F0', marginTop: '-12px' }}></div>
                                    <ChevronRight size={24} style={{ transform: 'rotate(90deg)', marginTop: '-8px' }} color="#CBD5E1"/>
                                </div>
                            )}
                        </div>
                    );
                })}
            </div>

            <div style={{ marginTop: '48px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Strategic Insight:</strong> The largest pipeline leak occurs between "Care Calculator" and "Email Lead Captured" (63% abandonment). We have deployed the <code>AbandonedInquirySweeper</code> to automatically SMS and Email these 1,540 lost leads to recover marketing ROI.
            </div>
        </div>
    );
};
