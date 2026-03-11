import React, { useState, useEffect } from 'react';
import { TrendingUp, TrendingDown, DollarSign } from 'lucide-react';

export const LiveMarginThermometer: React.FC = () => {
    const [stats, setStats] = useState({ grossBilled: 0, payrollCost: 0, margin: 0 });

    useEffect(() => {
        // Simulating websocket data stream reflecting active shifts
        const interval = setInterval(() => {
            const randomGross = 15000 + (Math.random() * 1000);
            const randomPayroll = randomGross * (0.65 + (Math.random() * 0.05)); // 65-70% overhead
            
            setStats({
                grossBilled: randomGross,
                payrollCost: randomPayroll,
                margin: ((randomGross - randomPayroll) / randomGross) * 100
            });
        }, 3000);

        return () => clearInterval(interval);
    }, []);

    if (stats.grossBilled === 0) return <div style={{ height: '100px', backgroundColor: '#F1F5F9', borderRadius: '12px' }} />;

    const isHealthy = stats.margin >= 30;

    return (
        <div style={{ backgroundColor: '#1E293B', borderRadius: '12px', padding: '20px', color: 'white', display: 'flex', flexDirection: 'column', gap: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h3 style={{ margin: 0, fontSize: '0.95rem', fontWeight: 600, color: '#94A3B8' }}>Live Gross Margin</h3>
                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', backgroundColor: isHealthy ? '#064E3B' : '#7F1D1D', padding: '4px 8px', borderRadius: '8px', color: isHealthy ? '#34D399' : '#FCA5A5', fontSize: '0.8rem', fontWeight: 700 }}>
                    {isHealthy ? <TrendingUp size={14} /> : <TrendingDown size={14} />}
                    {stats.margin.toFixed(1)}%
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                <div>
                    <div style={{ fontSize: '0.75rem', color: '#64748B', marginBottom: '4px' }}>Active Billable</div>
                    <div style={{ fontSize: '1.25rem', fontWeight: 800, color: '#E2E8F0', display: 'flex', alignItems: 'center' }}>
                        <DollarSign size={16} color="#94A3B8" />
                        {stats.grossBilled.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                    </div>
                </div>
                <div>
                    <div style={{ fontSize: '0.75rem', color: '#64748B', marginBottom: '4px' }}>Mkt Payroll Burden</div>
                    <div style={{ fontSize: '1.25rem', fontWeight: 800, color: '#E2E8F0', display: 'flex', alignItems: 'center' }}>
                        <DollarSign size={16} color="#94A3B8" />
                        {stats.payrollCost.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                    </div>
                </div>
            </div>

            {/* Visual Bar */}
            <div style={{ height: '8px', backgroundColor: '#334155', borderRadius: '4px', overflow: 'hidden', display: 'flex' }}>
                <div style={{ width: `${100 - stats.margin}%`, backgroundColor: '#475569' }} />
                <div style={{ width: `${stats.margin}%`, backgroundColor: isHealthy ? '#10B981' : '#EF4444', transition: 'width 0.5s ease-in-out', position: 'relative' }}>
                    <div style={{ position: 'absolute', top: 0, bottom: 0, left: 0, right: 0, backgroundImage: 'linear-gradient(45deg, rgba(255,255,255,0.15) 25%, transparent 25%, transparent 50%, rgba(255,255,255,0.15) 50%, rgba(255,255,255,0.15) 75%, transparent 75%, transparent)', backgroundSize: '1rem 1rem', opacity: 0.5 }}></div>
                </div>
            </div>
        </div>
    );
};
