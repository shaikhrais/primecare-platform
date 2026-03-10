import React from 'react';
import { AlertCircle } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';

export const SosButton: React.FC = () => {
    const { t } = useTranslation();
    const { showToast } = useNotification();

    const handleSosClick = () => {
        // In reality, this would trigger an immediate high-priority websocket alert to the dispatcher
        // alongside sending current GPS coordinates.
        if (window.confirm(t('common.sos_confirm', 'Are you sure you want to trigger an Emergency SOS? Dispatch will be alerted immediately with your location.'))) {
            showToast(t('common.sos_triggered', 'SOS Triggered! Dispatch is being notified.'), 'error');

            // Stub for the actual API call
            // apiClient.post(ApiRegistry.PSW.SOS, { lat, lng })
        }
    };

    return (
        <button
            onClick={handleSosClick}
            data-cy="btn-sos-floating"
            style={{
                position: 'fixed',
                top: 'env(safe-area-inset-top, 16px)',
                right: '16px',
                width: '48px',
                height: '48px',
                borderRadius: '50%',
                backgroundColor: '#ef4444',
                color: 'white',
                border: '4px solid #fca5a5',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                cursor: 'pointer',
                zIndex: 9999,
                boxShadow: '0 10px 15px -3px rgba(239, 68, 68, 0.4)'
            }}
            aria-label="Emergency SOS"
            title="Emergency SOS"
        >
            <AlertCircle size={28} />
        </button>
    );
};

export default SosButton;
