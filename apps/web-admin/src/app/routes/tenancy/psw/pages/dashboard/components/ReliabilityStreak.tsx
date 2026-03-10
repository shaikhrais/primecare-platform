import React from 'react';
import { Flame } from 'lucide-react';
import { Sparkline } from '@/shared/components/charts/Sparkline';

interface ReliabilityStreakProps {
    score: number;
    streakDays: number;
    trendData: number[];
}

export const ReliabilityStreak: React.FC<ReliabilityStreakProps> = ({ score, streakDays, trendData }) => {
    return (
        <div className="pc-card" style={{ padding: '20px', borderLeft: `4px solid #f59e0b`, display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', position: 'relative', overflow: 'hidden' }}>
            <div style={{ zIndex: 2 }}>
                <div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>
                    Reliability Score
                </div>
                <div style={{ display: 'flex', alignItems: 'baseline', gap: '12px' }}>
                    <div style={{ fontSize: '2.2rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px' }}>
                        {score}%
                    </div>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', marginTop: '4px', backgroundColor: '#FEF3C7', padding: '4px 8px', borderRadius: '12px', width: 'max-content' }}>
                    <Flame size={14} color="#D97706" />
                    <span style={{ fontSize: '0.8rem', fontWeight: 700, color: '#D97706' }}>{streakDays} Day On-Time Streak!</span>
                </div>
            </div>
            <div style={{ zIndex: 2, alignSelf: 'flex-end', marginBottom: '8px' }}>
                <Sparkline data={trendData} color="#f59e0b" width={80} height={24} />
            </div>

            {/* Background flame decoration if streak > 5 */}
            {streakDays >= 5 && (
                <Flame
                    size={120}
                    color="#FDE68A"
                    style={{ position: 'absolute', right: '-20px', top: '-20px', opacity: 0.3, zIndex: 1, transform: 'rotate(15deg)' }}
                />
            )}
        </div>
    );
};
