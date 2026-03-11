import React, { useState } from 'react';
import { Target, AlertTriangle, ArrowRight, ShieldCheck, Zap } from 'lucide-react';

interface SEOKeyword {
    id: string;
    keyword: string;
    searchVolume: number;
    competingPages: {
        url: string;
        currentRank: number;
        trafficShare: number;
    }[];
    status: 'OPTIMAL' | 'CANNIBALIZED' | 'RESOLVING';
}

export const KeywordCannibalizationMonitor: React.FC = () => {
    const [keywords] = useState<SEOKeyword[]>([
        {
            id: '1',
            keyword: 'senior care Columbus OH',
            searchVolume: 5400,
            competingPages: [
                { url: '/services/senior-care', currentRank: 12, trafficShare: 60 },
                { url: '/blog/what-is-senior-care', currentRank: 15, trafficShare: 40 }
            ],
            status: 'CANNIBALIZED'
        },
        {
            id: '2',
            keyword: 'hospice vs palliative care',
            searchVolume: 12500,
            competingPages: [
                { url: '/resources/hospice-vs-palliative', currentRank: 3, trafficShare: 98 },
                { url: '/faq/end-of-life', currentRank: 85, trafficShare: 2 }
            ],
            status: 'OPTIMAL'
        },
        {
            id: '3',
            keyword: 'dementia home care',
            searchVolume: 8200,
            competingPages: [
                { url: '/services/dementia-care', currentRank: 22, trafficShare: 55 },
                { url: '/services/alzheimers-care', currentRank: 24, trafficShare: 45 }
            ],
            status: 'CANNIBALIZED'
        }
    ]);

    const cannibalizedCount = keywords.filter(k => k.status === 'CANNIBALIZED').length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px' }}>
                        <Target size={28} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Keyword Cannibalization Monitor</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Detect when multiple PrimeCare pages are fighting each other for the same Google rank.</p>
                    </div>
                </div>

                 <div style={{ padding: '8px 16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px solid #FECACA', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.75rem', color: '#991B1B', fontWeight: 700, textTransform: 'uppercase' }}>Active Cannibalizations</div>
                    <div style={{ fontSize: '1.4rem', fontWeight: 900, color: '#DC2626' }}>{cannibalizedCount} detected</div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                {keywords.map(kw => {
                    const isCannibalized = kw.status === 'CANNIBALIZED';
                    
                    return (
                        <div key={kw.id} style={{ display: 'flex', flexWrap: 'wrap', gap: '24px', padding: '24px', border: `1px solid ${isCannibalized ? '#FECACA' : '#E2E8F0'}`, borderRadius: '12px', backgroundColor: isCannibalized ? '#FFF5F5' : 'white' }}>
                            <div style={{ flex: '1 1 200px' }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>Target Keyword</div>
                                <div style={{ fontWeight: 900, fontSize: '1.2rem', color: '#0F172A', marginBottom: '4px' }}>"{kw.keyword}"</div>
                                <div style={{ fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                    Search Volume: <strong>{kw.searchVolume.toLocaleString()}/mo</strong>
                                </div>
                            </div>

                            <div style={{ flex: '2 1 400px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Competing URLs in Google Index</div>
                                
                                {kw.competingPages.map((page, idx) => (
                                    <div key={idx} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', backgroundColor: 'white', padding: '12px 16px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                            <div style={{ width: '32px', height: '32px', borderRadius: '50%', backgroundColor: '#F1F5F9', color: '#475569', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 800, fontSize: '0.8rem' }}>
                                                #{page.currentRank}
                                            </div>
                                            <div style={{ color: '#0284C7', fontFamily: 'monospace', fontSize: '0.9rem', fontWeight: 600 }}>{page.url}</div>
                                        </div>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.8rem', fontWeight: 700, color: '#334155' }}>
                                            <div style={{ width: '60px', height: '6px', borderRadius: '3px', backgroundColor: '#E2E8F0', overflow: 'hidden' }}>
                                                <div style={{ width: `${page.trafficShare}%`, height: '100%', backgroundColor: isCannibalized ? '#F59E0B' : '#10B981' }} />
                                            </div>
                                            {page.trafficShare}% Share
                                        </div>
                                    </div>
                                ))}
                            </div>

                            <div style={{ flex: '1 1 200px', display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: '12px', paddingLeft: '24px', borderLeft: '1px solid #E2E8F0' }}>
                                {isCannibalized ? (
                                    <>
                                        <div style={{ color: '#DC2626', fontWeight: 800, fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                            <AlertTriangle size={16} /> SEO DILUTION DETECTED
                                        </div>
                                        <p style={{ margin: 0, fontSize: '0.8rem', color: '#64748B' }}>Google is confused about which page to rank, keeping both off Page 1.</p>
                                        <button style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '6px', padding: '10px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px', fontSize: '0.85rem', width: '100%' }}>
                                            <Zap size={14} /> Setup 301 Redirect
                                        </button>
                                    </>
                                ) : (
                                    <>
                                        <div style={{ color: '#10B981', fontWeight: 800, fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                            <ShieldCheck size={16} /> OPTIMAL STRUCTURE
                                        </div>
                                        <p style={{ margin: 0, fontSize: '0.8rem', color: '#64748B' }}>Clear hierarchy established. Primary page holds 90%+ of rank weight.</p>
                                    </>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Mitigation Strategy:</strong> When Keyword Cannibalization is flagged, the SEO team must quickly implement a <code>301 Redirect</code> or deploy a <code>rel="canonical"</code> tag pointing the weaker blog post to the primary lead-generating Services page, consolidating Google rank authority and pushing PrimeCare to Page 1.
            </div>
        </div>
    );
};
