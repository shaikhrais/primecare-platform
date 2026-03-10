import React from 'react';
import { TrendingUp, DollarSign } from 'lucide-react';
import { Sparkline } from '@/shared/components/charts/Sparkline';

interface EarningsProjectionsProps {
    currentEarnings: number;
    targetEarnings: number;
    trendData: number[];
}

export const EarningsProjections: React.FC<EarningsProjectionsProps> = ({ currentEarnings, targetEarnings, trendData }) => {
    const progress = Math.min((currentEarnings / targetEarnings) * 100, 100);
    const radius = 24;
    const circumference = 2 * Math.PI * radius;
    const strokeDashoffset = circumference - (progress / 100) * circumference;

    return (
        <div className="pc-card" style={{ padding: '20px', borderLeft: `4px solid #10b981`, display: 'flex', flexDirection: 'column', gap: '16px', position: 'relative', overflow: 'hidden' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>
                        Weekly Earnings Target
                    </div>
                    <div style={{ display: 'flex', alignItems: 'baseline', gap: '4px' }}>
                        <DollarSign size={20} color="var(--text-100)" style={{ transform: 'translateY(2px)' }} />
                        <span style={{ fontSize: '2.4rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px', lineHeight: 1 }}>
                            {currentEarnings}
                        </span>
                        <span style={{ color: 'var(--text-300)', fontSize: '1rem', fontWeight: 600 }}>/ ${targetEarnings}</span>
                    </div>
                </div>

                <div style={{ position: 'relative', width: '60px', height: '60px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <svg width="60" height="60" style={{ transform: 'rotate(-90deg)' }}>
                        <circle
                            cx="30" cy="30" r={radius}
                            stroke="#D1FAE5" strokeWidth="6" fill="transparent"
                        />
                        <circle
                            cx="30" cy="30" r={radius}
                            stroke="#10b981" strokeWidth="6" fill="transparent"
                            strokeDasharray={circumference}
                            strokeDashoffset={strokeDashoffset}
                            strokeLinecap="round"
                            style={{ transition: 'stroke-dashoffset 1s ease-out' }}
                        />
                    </svg>
                    <div style={{ position: 'absolute', fontSize: '0.75rem', fontWeight: 800, color: '#10b981' }}>
                        {Math.round(progress)}%
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', paddingTop: '8px', borderTop: '1px solid #F3F4F6' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <div style={{ backgroundColor: '#D1FAE5', padding: '4px 8px', borderRadius: '12px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                        <TrendingUp size={14} color="#059669" />
                        <span style={{ fontSize: '0.75rem', fontWeight: 700, color: '#059669' }}>+$120 from yesterday</span>
                    </div>
                </div>
                <div style={{ marginRight: '-8px' }}>
                    <Sparkline data={trendData} color="#10b981" width={80} height={24} />
                </div>
            </div>
        </div>
    );
};
