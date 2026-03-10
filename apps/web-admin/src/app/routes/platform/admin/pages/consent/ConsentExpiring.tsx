import React from 'react';
import EmptyState from '@/shared/components/layout/EmptyState';

export const ConsentExpiring: React.FC = () => {
    return (
        <div style={{ padding: '2rem', maxWidth: '1200px', margin: '0 auto' }}>
            <h1 style={{ fontSize: '2rem', fontWeight: 700, color: 'var(--text-main)', marginBottom: '0.5rem' }}>Consent Expiring</h1>
            <p style={{ color: 'var(--text-light)', marginBottom: '2rem' }}>Platform feature currently undergoing active development.</p>
            
            <EmptyState 
                title="Service Unavailable"
                description="This module is currently stubbed in the platform registry. Full UI components will be available in the next release."
                icon="🚧"
            />
        </div>
    );
};

export default ConsentExpiring;
