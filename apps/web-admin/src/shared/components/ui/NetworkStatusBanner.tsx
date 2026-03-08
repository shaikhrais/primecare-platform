import React from 'react';
import { useAuth } from '@/shared/context/AuthContext';

/**
 * #7: Network status banner — shows when user goes offline or API is unreachable.
 * Auto-hides when connectivity is restored.
 */
export const NetworkStatusBanner: React.FC = () => {
    const { isOnline } = useAuth();

    if (isOnline) return null;

    return (
        <div style={{
            position: 'fixed', top: 0, left: 0, right: 0, zIndex: 9999,
            background: 'linear-gradient(90deg, #f59e0b, #d97706)',
            color: '#fff', textAlign: 'center',
            padding: '8px 16px', fontSize: 13, fontWeight: 600,
            fontFamily: "'Inter', sans-serif",
            boxShadow: '0 2px 8px rgba(0,0,0,0.15)',
        }}>
            ⚠️ You are offline — changes may not be saved. Reconnecting...
        </div>
    );
};

export default NetworkStatusBanner;
