import React, { useState } from 'react';
import { CreditCard, Users } from 'lucide-react';

interface CoPaySliderProps {
    totalInvoiceAmount: number;
    primaryPayerName: string;
    secondaryPayerName: string;
}

export const CoPaySlider: React.FC<CoPaySliderProps> = ({ totalInvoiceAmount, primaryPayerName, secondaryPayerName }) => {
    // Percentage state (0 to 100)
    const [primaryPercentage, setPrimaryPercentage] = useState(50);

    const secondaryPercentage = 100 - primaryPercentage;
    const primaryAmount = (totalInvoiceAmount * (primaryPercentage / 100)).toFixed(2);
    const secondaryAmount = (totalInvoiceAmount * (secondaryPercentage / 100)).toFixed(2);

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E2E8F0', padding: '32px', display: 'flex', flexDirection: 'column', gap: '32px' }}>
            
            <div>
                <h2 data-cy="h2-co-pay-slider-0" style={{ fontSize: '1.5rem', fontWeight: 900, color: '#0F172A', margin: '0 0 8px 0', display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <CreditCard color="#10B981" /> Co-Pay Invoice Splitter
                </h2>
                <p style={{ color: '#64748B', margin: 0 }}>Adjust the slider below to divide this month's ${totalInvoiceAmount} out-of-pocket invoice between family members.</p>
            </div>

            {/* The Visual Slider */}
            <div style={{ position: 'relative', height: '80px', display: 'flex', alignItems: 'center' }}>
                
                {/* Custom Track Background */}
                <div style={{ position: 'absolute', inset: '0 16px', height: '24px', backgroundColor: '#E2E8F0', borderRadius: '12px', overflow: 'hidden', top: '50%', transform: 'translateY(-50%)' }}>
                    
                    {/* Primary Color Fill */}
                    <div style={{ position: 'absolute', left: 0, top: 0, bottom: 0, width: `${primaryPercentage}%`, backgroundColor: '#3B82F6', transition: 'width 0.1s linear' }}></div>
                    {/* Secondary Color Fill */}
                    <div style={{ position: 'absolute', right: 0, top: 0, bottom: 0, width: `${secondaryPercentage}%`, backgroundColor: '#8B5CF6', transition: 'width 0.1s linear' }}></div>
                    
                </div>

                {/* The actual input over top (invisible track, visible thumb) */}
                <input data-cy="input-co-pay-slider-0" 
                    type="range"
                    min="0"
                    max="100"
                    value={primaryPercentage}
                    onChange={(e) => setPrimaryPercentage(parseInt(e.target.value))}
                    className="copay-slider-input"
                    style={{ position: 'absolute', inset: 0, width: '100%', margin: 0, zIndex: 2, cursor: 'grab' }}
                />

                <style>{`
                    .copay-slider-input {
                        -webkit-appearance: none;
                        appearance: none;
                        background: transparent;
                    }

                    .copay-slider-input::-webkit-slider-thumb {
                        -webkit-appearance: none;
                        height: 48px;
                        width: 48px;
                        border-radius: 50%;
                        background: white;
                        border: 6px solid #0F172A;
                        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.3);
                        cursor: pointer;
                        margin-top: -12px;
                    }

                    .copay-slider-input::-moz-range-thumb {
                        height: 48px;
                        width: 48px;
                        border-radius: 50%;
                        background: white;
                        border: 6px solid #0F172A;
                        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.3);
                        cursor: pointer;
                    }
                    
                    .copay-slider-input:active {
                        cursor: grabbing;
                    }
                `}</style>

            </div>

            {/* The Math readout */}
            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 1fr) minmax(0, 1fr)', gap: '24px' }}>
                
                {/* Primary Card */}
                <div style={{ backgroundColor: '#EFF6FF', padding: '24px', borderRadius: '12px', border: '1px solid #BFDBFE' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                        <div>
                            <div style={{ fontWeight: 800, color: '#1E3A8A', fontSize: '1.25rem' }}>{primaryPayerName}</div>
                            <div style={{ color: '#3B82F6', fontWeight: 700 }}>{primaryPercentage}%</div>
                        </div>
                        <Users size={24} color="#60A5FA" />
                    </div>
                    <div style={{ fontSize: '2.5rem', fontWeight: 900, color: '#1D4ED8', marginTop: '16px' }}>
                        ${primaryAmount}
                    </div>
                </div>

                {/* Secondary Card */}
                <div style={{ backgroundColor: '#FAF5FF', padding: '24px', borderRadius: '12px', border: '1px solid #E9D5FF' }}>
                     <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                        <div>
                            <div style={{ fontWeight: 800, color: '#4C1D95', fontSize: '1.25rem' }}>{secondaryPayerName}</div>
                            <div style={{ color: '#8B5CF6', fontWeight: 700 }}>{secondaryPercentage}%</div>
                        </div>
                        <Users size={24} color="#C084FC" />
                    </div>
                    <div style={{ fontSize: '2.5rem', fontWeight: 900, color: '#6D28D9', marginTop: '16px' }}>
                        ${secondaryAmount}
                    </div>
                </div>

            </div>

        </section>
    );
};
