import React, { useState } from 'react';
import { Search, MapPin, TrendingUp, TrendingDown, Crosshair, AlertTriangle } from 'lucide-react';

interface SeoKeyword {
    id: string;
    keyword: string;
    zipCode: string;
    neighborhood: string;
    searchVolume: number;
    currentRank: number;
    previousRank: number;
    difficulty: number;
}

export const LocalSeoRankTracker: React.FC = () => {
    const [keywords] = useState<SeoKeyword[]>([
        { id: '1', keyword: '24/7 dementia care', zipCode: '10021', neighborhood: 'Upper East Side', searchVolume: 1250, currentRank: 2, previousRank: 4, difficulty: 85 },
        { id: '2', keyword: 'hospice nurse near me', zipCode: '90210', neighborhood: 'Beverly Hills', searchVolume: 3400, currentRank: 11, previousRank: 9, difficulty: 92 },
        { id: '3', keyword: 'post stroke rehab at home', zipCode: '33345', neighborhood: 'Suburban Hub', searchVolume: 850, currentRank: 1, previousRank: 1, difficulty: 45 },
        { id: '4', keyword: 'senior transportation services', zipCode: '10021', neighborhood: 'Upper East Side', searchVolume: 4200, currentRank: 24, previousRank: 24, difficulty: 70 }
    ]);

    const getRankColor = (rank: number) => {
        if (rank <= 3) return '#10B981'; // Top 3 (Green)
        if (rank <= 10) return '#3B82F6'; // Page 1 (Blue)
        return '#64748B'; // Page 2+ (Gray)
    };

    const getRankChange = (current: number, previous: number) => {
        const diff = previous - current;
        if (diff > 0) return <span style={{ color: '#16A34A', display: 'flex', alignItems: 'center', gap: '2px', fontWeight: 700 }}><TrendingUp size={14}/> +{diff}</span>;
        if (diff < 0) return <span style={{ color: '#DC2626', display: 'flex', alignItems: 'center', gap: '2px', fontWeight: 700 }}><TrendingDown size={14}/> {diff}</span>;
        return <span style={{ color: '#94A3B8', fontWeight: 600 }}>--</span>;
    };

    const pageTwoKeywords = keywords.filter(k => k.currentRank > 10 && k.currentRank <= 20).length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F1F5F9', padding: '12px', borderRadius: '8px' }}>
                        <Search size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Local SEO Rank Tracker</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Monitor PrimeCare's organic Google search position isolated by high-value ZIP codes.</p>
                    </div>
                </div>
            </div>

            {pageTwoKeywords > 0 && (
                <div style={{ backgroundColor: '#FFFBEB', border: '1px solid #FDE68A', padding: '16px', borderRadius: '8px', marginBottom: '24px', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                    <AlertTriangle size={20} color="#D97706" style={{ flexShrink: 0 }} />
                    <div>
                        <strong style={{ color: '#92400E', display: 'block', marginBottom: '4px' }}>Strategic SEO Opportunity: Moving from Page 2 to Page 1</strong>
                        <span style={{ color: '#B45309', fontSize: '0.9rem' }}>You have {pageTwoKeywords} highly-searched keywords stranded on Page 2 of Google (Ranks 11-20). Pushing these to Page 1 will exponentially increase organic traffic and reduce paid ad spend.</span>
                    </div>
                </div>
            )}

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.95rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Search Keyword</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Geographic Target</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Search Vol. / Mo.</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Google Rank</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>7-Day Chg</th>
                    </tr>
                </thead>
                <tbody>
                    {keywords.map(kw => {
                        const isFallen = kw.currentRank > 10 && kw.previousRank <= 10;

                        return (
                            <tr key={kw.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: isFallen ? '#FEF2F2' : 'transparent' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', fontWeight: 800, color: '#0F172A' }}>
                                    "{kw.keyword}"
                                    {kw.difficulty > 80 && <span style={{ backgroundColor: '#F1F5F9', color: '#64748B', padding: '2px 6px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 700, marginLeft: '8px' }}>HARD</span>}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px', color: '#334155', fontWeight: 600 }}>
                                        <MapPin size={16} color="#64748B"/> {kw.zipCode}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#94A3B8', marginLeft: '22px' }}>{kw.neighborhood}</div>
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center', color: '#475569', fontWeight: 600 }}>
                                    {kw.searchVolume.toLocaleString()}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    <div style={{ 
                                        display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                                        width: '36px', height: '36px', borderRadius: '50%',
                                        backgroundColor: `${getRankColor(kw.currentRank)}20`,
                                        color: getRankColor(kw.currentRank),
                                        fontWeight: 900, fontSize: '1.2rem',
                                        border: `2px solid ${getRankColor(kw.currentRank)}`
                                    }}>
                                        #{kw.currentRank}
                                    </div>
                                    {isFallen && <div style={{ fontSize: '0.7rem', color: '#DC2626', fontWeight: 800, marginTop: '4px' }}>DROPPED OFF PAGE 1</div>}
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right' }}>
                                    {getRankChange(kw.currentRank, kw.previousRank)}
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
};
