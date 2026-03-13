import React from 'react';
import { AlertTriangle } from 'lucide-react';

interface AllergyBannerProps {
    allergies: string[];
}

export const AllergyBanner: React.FC<AllergyBannerProps> = ({ allergies }) => {
    if (!allergies || allergies.length === 0) return null;

    return (
        <div style={{
            backgroundColor: '#FEF2F2',
            border: '2px solid #EF4444',
            borderLeft: '8px solid #EF4444',
            padding: '16px',
            marginBottom: '16px',
            borderRadius: '8px',
            display: 'flex',
            alignItems: 'flex-start',
            gap: '12px',
            boxShadow: '0 4px 6px -1px rgba(239, 68, 68, 0.1)'
        }}>
            <AlertTriangle size={24} color="#EF4444" style={{ flexShrink: 0, marginTop: '2px' }} />
            <div>
                <h3 data-cy="h3-psw.allergy-banner-0" style={{ margin: '0 0 4px 0', color: '#991B1B', fontSize: '1rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '0.5px' }}>
                    CRITICAL ALLERGIES DETECTED
                </h3>
                <ul style={{ margin: 0, paddingLeft: '16px', color: '#B91C1C', fontWeight: 600, fontSize: '0.9rem' }}>
                    {allergies.map((allergy, idx) => (
                        <li key={idx} style={{ marginBottom: '2px' }}>{allergy}</li>
                    ))}
                </ul>
            </div>
        </div>
    );
};
