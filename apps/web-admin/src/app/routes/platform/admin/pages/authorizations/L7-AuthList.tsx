// ================================================================
// PAGE IDENTITY: L7 · Authorization List
// Registry ID:   page.admin.authorizations
// Type:          List
// Owner:         admin
// ================================================================
import React from 'react';
import EmptyState from '@/shared/components/layout/EmptyState';

export const AuthList: React.FC = () => {
    return (
        <div style={{ padding: '2rem', maxWidth: '1200px', margin: '0 auto' }}>
            <h1 style={{ fontSize: '2rem', fontWeight: 700, color: 'var(--text-main)', marginBottom: '0.5rem' }}>Auth List</h1>
            <p style={{ color: 'var(--text-light)', marginBottom: '2rem' }}>Platform feature currently undergoing active development.</p>
            
            <EmptyState 
                title="Service Unavailable"
                description="This module is currently stubbed in the platform registry. Full UI components will be available in the next release."
                icon="ðŸš§"
            />
        </div>
    );
};

export default AuthList;
