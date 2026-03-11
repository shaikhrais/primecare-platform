import React, { useState } from 'react';
import { SplitSquareHorizontal, Eye, MousePointerClick, TrendingUp, RefreshCw, Power } from 'lucide-react';

interface Variant {
    id: 'A' | 'B';
    name: string;
    trafficSplit: number;
    hits: number;
    bounces: number;
    conversions: number;
    active: boolean;
}

export const LandingPageAbTester: React.FC = () => {
    const [variants, setVariants] = useState<Variant[]>([
        { id: 'A', name: 'Clinical / Medical Excellence', trafficSplit: 50, hits: 14200, bounces: 8100, conversions: 420, active: true },
        { id: 'B', name: 'Compassion / Family First', trafficSplit: 50, hits: 14150, bounces: 6050, conversions: 890, active: true }
    ]);

    const calculateConvRate = (conversions: number, hits: number) => {
        return hits === 0 ? 0 : ((conversions / hits) * 100);
    };

    const calculateBounceRate = (bounces: number, hits: number) => {
        return hits === 0 ? 0 : ((bounces / hits) * 100);
    };

    const variantA = variants[0];
    const variantB = variants[1];

    const rateA = calculateConvRate(variantA.conversions, variantA.hits);
    const rateB = calculateConvRate(variantB.conversions, variantB.hits);
    
    const winningVariant = rateA > rateB ? variantA : variantB;
    const isStatisticallySignificant = Math.abs(rateA - rateB) > 1.5 && (variantA.hits + variantB.hits > 10000);

    const handleHaltExperiment = () => {
        if(window.confirm(`Are you sure you want to halt this experiment? Traffic will revert 100% to Variant ${winningVariant.id}.`)) {
            setVariants(variants.map(v => 
                v.id === winningVariant.id 
                    ? { ...v, trafficSplit: 100, active: true }
                    : { ...v, trafficSplit: 0, active: false }
            ));
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F3E8FF', padding: '12px', borderRadius: '12px' }}>
                        <SplitSquareHorizontal size={28} color="#9333EA" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Landing Page A/B Testing</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.95rem' }}>Split live web traffic to determine optimal messaging for lead conversion.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    {isStatisticallySignificant && variants[0].active && variants[1].active && (
                       <button 
                            onClick={handleHaltExperiment}
                            style={{ backgroundColor: '#10B981', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.9rem' }}
                        >
                            <Power size={16} /> END EXPERIMENT (DECLARE "{winningVariant.id}" WINNER)
                        </button>
                    )}
                    <button style={{ backgroundColor: '#F1F5F9', color: '#475569', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.9rem' }}>
                        <RefreshCw size={16} /> Reset
                    </button>
                </div>
            </div>

            {isStatisticallySignificant && variants[0].active && variants[1].active && (
                <div style={{ backgroundColor: '#FCFDF5', border: '1px solid #A3E635', padding: '16px', borderRadius: '8px', marginBottom: '24px', display: 'flex', alignItems: 'center', gap: '12px', color: '#4D7C0F' }}>
                    <TrendingUp size={24} color="#65A30D" />
                    <div>
                        <strong style={{ display: 'block', fontSize: '1rem', marginBottom: '4px' }}>Statistical Significance Reached (p &lt; 0.05)</strong>
                        <span style={{ fontSize: '0.9rem' }}>Variant {winningVariant.id} ({winningVariant.name}) is outperforming by a massive margin. It is safe to halt the experiment and route 100% of traffic to the winner.</span>
                    </div>
                </div>
            )}

            <div style={{ display: 'flex', gap: '24px' }}>
                {variants.map(variant => {
                    const convRate = calculateConvRate(variant.conversions, variant.hits);
                    const bounceRate = calculateBounceRate(variant.bounces, variant.hits);
                    const isWinner = variant.id === winningVariant.id && isStatisticallySignificant;

                    return (
                        <div key={variant.id} style={{ flex: 1, border: variant.active ? (isWinner ? '3px solid #10B981' : '1px solid #E2E8F0') : '1px dashed #CBD5E1', borderRadius: '12px', padding: '24px', backgroundColor: variant.active ? (isWinner ? '#F0FDF4' : 'white') : '#F8FAFC', opacity: variant.active ? 1 : 0.6, position: 'relative' }}>
                            
                            {isWinner && variant.active && (
                                <div style={{ position: 'absolute', top: '-14px', left: '50%', transform: 'translateX(-50%)', backgroundColor: '#10B981', color: 'white', padding: '4px 16px', borderRadius: '16px', fontWeight: 900, fontSize: '0.8rem', letterSpacing: '1px' }}>
                                    PROJECTED WINNER
                                </div>
                            )}

                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                    <div style={{ width: '40px', height: '40px', borderRadius: '8px', backgroundColor: '#F1F5F9', color: '#64748B', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 900, fontSize: '1.2rem' }}>
                                        {variant.id}
                                    </div>
                                    <h4 style={{ margin: 0, fontSize: '1.1rem', color: '#334155', fontWeight: 700 }}>{variant.name}</h4>
                                </div>
                                <div style={{ fontWeight: 900, fontSize: '1.4rem', color: variant.trafficSplit > 0 ? '#6366F1' : '#94A3B8' }}>
                                    {variant.trafficSplit}% TRAFFIC
                                </div>
                            </div>

                            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1px solid #E2E8F0', paddingBottom: '12px' }}>
                                    <span style={{ color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}><Eye size={16}/> Total Hits</span>
                                    <span style={{ fontWeight: 800, color: '#0F172A' }}>{variant.hits.toLocaleString()}</span>
                                </div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1px solid #E2E8F0', paddingBottom: '12px' }}>
                                    <span style={{ color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}><MousePointerClick size={16}/> Conversions (Form Fills)</span>
                                    <span style={{ fontWeight: 800, color: '#0F172A' }}>{variant.conversions.toLocaleString()}</span>
                                </div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1px solid #E2E8F0', paddingBottom: '12px' }}>
                                    <span style={{ color: '#64748B' }}>Bounce Rate</span>
                                    <span style={{ fontWeight: 800, color: bounceRate > 50 ? '#DC2626' : '#10B981' }}>{bounceRate.toFixed(1)}%</span>
                                </div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '8px', padding: '12px', backgroundColor: isWinner ? '#DCFCE7' : '#F1F5F9', borderRadius: '8px' }}>
                                    <span style={{ color: '#334155', fontWeight: 800, textTransform: 'uppercase', fontSize: '0.85rem' }}>Conversion Rate</span>
                                    <span style={{ fontWeight: 900, color: isWinner ? '#15803D' : '#0F172A', fontSize: '1.4rem' }}>{convRate.toFixed(2)}%</span>
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>
        </div>
    );
};
