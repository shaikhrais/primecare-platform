import React from 'react';
import { AlertOctagon, HeartPulse, TrendingDown, Info } from 'lucide-react';

interface BurnoutGaugeProps {
    staffName: string;
    metrics: {
        consecutiveDays: number;
        overtimeHoursWeek: number;
        acuityScoreAvg: number; // 0-100 complexity of assigned patients
    };
}

export const BurnoutGauge: React.FC<BurnoutGaugeProps> = ({ staffName, metrics }) => {
    
    // Formula for burnout (0-100 risk score)
    // - Every consecutive day over 5 adds 10%
    // - Every hour of OT adds 2%
    // - Acuity > 70 adds 15% base stress
    let riskScore = 0;
    
    if (metrics.consecutiveDays > 5) riskScore += (metrics.consecutiveDays - 5) * 15;
    riskScore += metrics.overtimeHoursWeek * 2;
    if (metrics.acuityScoreAvg > 70) riskScore += 15;
    
    riskScore = Math.min(100, Math.max(0, riskScore));

    const getRiskColor = () => {
        if (riskScore < 40) return '#10B981'; // Green
        if (riskScore < 75) return '#F59E0B'; // Amber
        return '#EF4444'; // Red
    };

    // SVG arc math
    const radius = 60;
    const circumference = 2 * Math.PI * radius;
    const strokeDashoffset = circumference - (riskScore / 100) * circumference;

    return (
        <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #E2E8F0', display: 'flex', gap: '32px', alignItems: 'center', width: 'fit-content' }}>
            
            {/* SVG Gauge */}
            <div style={{ position: 'relative', width: '140px', height: '140px' }}>
                <svg width="140" height="140" viewBox="0 0 140 140" style={{ transform: 'rotate(-90deg)' }}>
                    {/* Background Ring */}
                    <circle
                        cx="70" cy="70" r={radius}
                        fill="transparent" stroke="#F1F5F9" strokeWidth="12"
                    />
                    {/* Progress Ring */}
                    <circle
                        cx="70" cy="70" r={radius}
                        fill="transparent" 
                        stroke={getRiskColor()} 
                        strokeWidth="12"
                        strokeDasharray={circumference}
                        strokeDashoffset={strokeDashoffset}
                        strokeLinecap="round"
                        style={{ transition: 'stroke-dashoffset 1s ease-in-out, stroke 0.5s ease' }}
                    />
                </svg>
                <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: '1.75rem', fontWeight: 900, color: '#0F172A', lineHeight: '1' }}>{Math.round(riskScore)}</span>
                    <span style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '1px' }}>Risk %</span>
                </div>
            </div>

            {/* Metrics Breakdown */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', minWidth: '200px' }}>
                <div>
                    <h3 data-cy="h3-manager.burnout-gauge-0" style={{ margin: '0 0 4px 0', fontSize: '1.1rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <HeartPulse color={getRiskColor()} /> Burnout Telemetry
                    </h3>
                    <p style={{ margin: 0, color: '#64748B', fontSize: '0.85rem' }}>Forecasting flight-risk for <strong>{staffName}</strong>.</p>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.85rem' }}>
                        <span style={{ color: '#475569' }}>Consecutive Days</span>
                        <span style={{ fontWeight: 800, color: metrics.consecutiveDays > 5 ? '#EF4444' : '#0F172A' }}>{metrics.consecutiveDays} days</span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.85rem' }}>
                        <span style={{ color: '#475569' }}>Weekly Overtime</span>
                        <span style={{ fontWeight: 800, color: metrics.overtimeHoursWeek > 4 ? '#F59E0B' : '#0F172A' }}>{metrics.overtimeHoursWeek} hrs</span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.85rem' }}>
                        <span style={{ color: '#475569' }}>Patient Acuity Avg</span>
                        <span style={{ fontWeight: 800, color: '#0F172A' }}>{metrics.acuityScoreAvg}/100</span>
                    </div>
                </div>

                {riskScore >= 75 && (
                    <div style={{ backgroundColor: '#FEF2F2', padding: '8px', borderRadius: '8px', display: 'flex', alignItems: 'flex-start', gap: '8px', color: '#991B1B', fontSize: '0.75rem', border: '1px solid #FECACA' }}>
                        <AlertOctagon size={14} style={{ flexShrink: 0, marginTop: '2px' }} />
                        <span style={{ fontWeight: 600 }}>Critical Burnout Risk. Suggest immediate stand-down or rotation to standard acuity.</span>
                    </div>
                )}
            </div>
        </div>
    );
};
