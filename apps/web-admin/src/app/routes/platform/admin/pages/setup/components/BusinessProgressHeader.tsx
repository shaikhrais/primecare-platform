import React from 'react';

interface BusinessProgressHeaderProps {
    score: number;
}

export const BusinessProgressHeader: React.FC<BusinessProgressHeaderProps> = ({ score }) => {
    return (
        <div style={{ background: 'white', padding: '2.5rem', borderRadius: '2rem', border: '1px solid #e5e7eb', marginBottom: '3rem', boxShadow: '0 1px 3px 0 rgba(0, 0, 0, 0.1)' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '1.5rem' }}>
                <div>
                    <div style={{ fontSize: '0.875rem', fontWeight: '700', color: '#4f46e5', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Overall Readiness</div>
                    <div style={{ fontSize: '2.5rem', fontWeight: '900', color: '#111827' }}>{score}%</div>
                </div>
                <div style={{ textAlign: 'right', color: '#6b7280', fontSize: '0.875rem' }}>
                    Completing all wizards unlocks full automation.
                </div>
            </div>
            <div style={{ width: '100%', height: '16px', background: '#f3f4f6', borderRadius: '8px', overflow: 'hidden', display: 'flex' }}>
                <div style={{
                    width: `${score}%`,
                    height: '100%',
                    background: 'linear-gradient(90deg, #4f46e5 0%, #06b6d4 100%)',
                    transition: 'width 1s cubic-bezier(0.4, 0, 0.2, 1)'
                }} />
            </div>
        </div>
    );
};
