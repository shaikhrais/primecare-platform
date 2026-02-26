import React, { useState, useEffect } from 'react';

export const ConnectionStatusBanner: React.FC = () => {
    const [isOnline, setIsOnline] = useState(navigator.onLine);

    useEffect(() => {
        const handleOnline = () => setIsOnline(true);
        const handleOffline = () => setIsOnline(false);

        window.addEventListener('online', handleOnline);
        window.addEventListener('offline', handleOffline);

        return () => {
            window.removeEventListener('online', handleOnline);
            window.removeEventListener('offline', handleOffline);
        };
    }, []);

    if (isOnline) return null;

    return (
        <div
            data-cy="offline-banner"
            style={{
                backgroundColor: '#EF4444',
                color: '#FFFFFF',
                padding: '8px 24px',
                textAlign: 'center',
                fontSize: '0.85rem',
                fontWeight: 700,
                position: 'sticky',
                top: '72px', // Below topbar
                zIndex: 800
            }}
        >
            ⚠️ You are currently offline. Changes will be synced when connection is restored.
        </div>
    );
};
