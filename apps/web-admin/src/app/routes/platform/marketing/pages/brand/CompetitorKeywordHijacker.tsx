import React, { useState } from 'react';
import { Target, Search, ArrowUpRight, ShieldAlert, DollarSign } from 'lucide-react';

interface CompetitorKeyword {
    id: string;
    competitor: string;
    keyword: string;
    searchVolume: number;
    estimatedCpc: number;
    competitorPresence: 'ACTIVE' | 'DROPPED_OUT' | 'WEAK';
}

export const CompetitorKeywordHijacker: React.FC = () => {
    const [keywords, setKeywords] = useState<CompetitorKeyword[]>([
        { id: '1', competitor: 'Visiting Angels', keyword: 'visiting angels cost per hour', searchVolume: 5400, estimatedCpc: 4.50, competitorPresence: 'ACTIVE' },
        { id: '2', competitor: 'Home Instead', keyword: 'home instead dementia care', searchVolume: 3200, estimatedCpc: 6.20, competitorPresence: 'ACTIVE' },
        { id: '3', competitor: 'Right at Home', keyword: 'right at home reviews', searchVolume: 1800, estimatedCpc: 2.15, competitorPresence: 'DROPPED_OUT' }, // Vulnerability!
        { id: '4', competitor: 'Local Agency X', keyword: 'agency x vs others', searchVolume: 450, estimatedCpc: 1.10, competitorPresence: 'WEAK' }
    ]);

    const handleHijack = (id: string, e: React.MouseEvent) => {
        e.stopPropagation();
        setKeywords(keywords.map(k => 
            k.id === id ? { ...k, competitorPresence: 'ACTIVE' } : k // Simulate PrimeCare taking it over
        ));
    };

    const vulnerabilities = keywords.filter(k => k.competitorPresence === 'DROPPED_OUT' || k.competitorPresence === 'WEAK').length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px' }}>
                        <Target size={28} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Competitor Keyword SEM Hijacker</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Automatically detect when rival agencies stop bidding on their own branded search terms.</p>
                    </div>
                </div>

                <div style={{ padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Exploitable Keywords</div>
                    <div style={{ fontSize: '1.4rem', fontWeight: 900, color: vulnerabilities > 0 ? '#DC2626' : '#10B981' }}>{vulnerabilities} detected</div>
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.95rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Rival Agency</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Branded Keyword</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Search Vol. / Mo.</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Defense Status</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Action</th>
                    </tr>
                </thead>
                <tbody>
                    {keywords.map(kw => {
                        const isVulnerable = kw.competitorPresence !== 'ACTIVE';

                        return (
                            <tr key={kw.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: isVulnerable ? '#FEF2F2' : 'transparent' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', fontWeight: 800, color: '#0F172A' }}>
                                    {kw.competitor}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', fontFamily: 'monospace', color: '#334155' }}>
                                    "{kw.keyword}"
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center', color: '#475569', fontWeight: 600 }}>
                                    {kw.searchVolume.toLocaleString()}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right', paddingRight: '24px' }}>
                                    {kw.competitorPresence === 'ACTIVE' && <span style={{ color: '#16A34A', fontWeight: 700, fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', justifyContent: 'flex-end' }}>DEFENDED</span>}
                                    {kw.competitorPresence === 'DROPPED_OUT' && <span style={{ color: '#DC2626', fontWeight: 800, fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', justifyContent: 'flex-end' }}><ShieldAlert size={14}/> BUDGET CUT DETECTED</span>}
                                    {kw.competitorPresence === 'WEAK' && <span style={{ color: '#D97706', fontWeight: 700, fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', justifyContent: 'flex-end' }}>LOW BID DEFENSE</span>}
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    {isVulnerable ? (
                                        <button 
                                            onClick={(e) => handleHijack(kw.id, e)}
                                            style={{ backgroundColor: '#DC2626', color: 'white', border: 'none', borderRadius: '6px', padding: '8px 16px', fontWeight: 800, cursor: 'pointer', display: 'inline-flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', whiteSpace: 'nowrap' }}
                                        >
                                            Buy Ad: ${kw.estimatedCpc.toFixed(2)}/click
                                        </button>
                                    ) : (
                                        <div style={{ color: '#94A3B8', fontSize: '0.8rem', fontWeight: 600 }}>Too Expensive</div>
                                    )}
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
            
            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>SEM Aggression Tactics:</strong> If a major competitor cuts their Google Ads budget and stops defending their own name (e.g., 'Right at Home reviews'), this system instantly alerts PrimeCare to buy that exact keyword. When a family searches for the competitor, PrimeCare's ad appears first, effectively stealing their branded search traffic.
            </div>
        </div>
    );
};
