import React from 'react';
import { DollarSign } from 'lucide-react';

interface FundingThermometerProps {
    totalHours: number;
    hoursUsed: number;
}

export const FundingThermometer: React.FC<FundingThermometerProps> = ({ totalHours, hoursUsed }) => {
    
    const percentage = Math.min((hoursUsed / totalHours) * 100, 100);
    const hoursRemaining = totalHours - hoursUsed;

    const getLiquidColor = () => {
        if (percentage > 90) return '#EF4444'; // Red - almost out
        if (percentage > 75) return '#F59E0B'; // Amber - warning
        return '#3B82F6'; // Blue - healthy
    };

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '16px', border: '2px solid #E2E8F0', padding: '32px', display: 'flex', gap: '32px', alignItems: 'center' }}>
            
            {/* The Visual Thermometer */}
            <div style={{ width: '80px', height: '250px', backgroundColor: '#F1F5F9', borderRadius: '40px', border: '4px solid #CBD5E1', position: 'relative', overflow: 'hidden', flexShrink: 0 }}>
                {/* The "Liquid" */}
                <div style={{
                    position: 'absolute',
                    bottom: 0, left: 0, right: 0,
                    height: `${percentage}%`,
                    backgroundColor: getLiquidColor(),
                    transition: 'height 1.5s cubic-bezier(0.4, 0, 0.2, 1)',
                    borderTopLeftRadius: percentage === 100 ? '40px' : '0',
                    borderTopRightRadius: percentage === 100 ? '40px' : '0',
                    boxShadow: 'inset 0 10px 10px -10px rgba(0,0,0,0.5)'
                }} >
                    {/* Bubbles / Shading overlay for skeuomorphism */}
                    <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '100%', background: 'linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(255,255,255,0.3) 20%, rgba(255,255,255,0) 40%)' }}></div>
                </div>

                {/* Markers */}
                <div style={{ position: 'absolute', top: '25%', left: 0, right: 0, borderTop: '2px solid rgba(0,0,0,0.1)', zIndex: 1 }}></div>
                <div style={{ position: 'absolute', top: '50%', left: 0, right: 0, borderTop: '2px dashed rgba(0,0,0,0.2)', zIndex: 1 }}></div>
                <div style={{ position: 'absolute', top: '75%', left: 0, right: 0, borderTop: '2px solid rgba(0,0,0,0.1)', zIndex: 1 }}></div>
            </div>

            {/* Typography & Stats */}
            <div style={{ flex: 1 }}>
                <h2 data-cy="h2-client.funding-thermometer-0" style={{ fontSize: '2rem', fontWeight: 900, color: '#0F172A', margin: '0 0 16px 0', display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <DollarSign size={32} color={getLiquidColor()} /> Care Funding
                </h2>
                
                <p style={{ fontSize: '1.25rem', color: '#475569', marginBottom: '24px', lineHeight: '1.6' }}>
                    You have <strong style={{ color: '#0F172A' }}>{hoursRemaining} hours</strong> of subsidized care remaining this month.
                </p>

                <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 1fr) minmax(0, 1fr)', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '12px', border: '1px solid #E2E8F0' }}>
                        <div style={{ color: '#64748B', fontSize: '1rem', fontWeight: 700, textTransform: 'uppercase' }}>Used</div>
                        <div style={{ color: getLiquidColor(), fontSize: '2.5rem', fontWeight: 900, lineHeight: 1, marginTop: '8px' }}>{hoursUsed}h</div>
                    </div>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '12px', border: '1px solid #E2E8F0' }}>
                        <div style={{ color: '#64748B', fontSize: '1rem', fontWeight: 700, textTransform: 'uppercase' }}>Allowed</div>
                        <div style={{ color: '#0F172A', fontSize: '2.5rem', fontWeight: 900, lineHeight: 1, marginTop: '8px' }}>{totalHours}h</div>
                    </div>
                </div>

                {percentage > 90 && (
                    <div style={{ marginTop: '24px', backgroundColor: '#FEF2F2', padding: '16px', borderRadius: '12px', border: '2px solid #EF4444', color: '#B91C1C', fontWeight: 800, fontSize: '1.1rem' }}>
                        ⚠️ Your care fund is almost empty. Extra visits will be billed out-of-pocket.
                    </div>
                )}
            </div>

        </section>
    );
};
