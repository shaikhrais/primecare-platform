import React from 'react';
import { AlertCircle } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';
import { useDialog } from '@/shared/hooks/useDialog';

export const SosButton: React.FC = () => {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const { confirm, DialogRenderer } = useDialog();

    const handleSosClick = async () => {
        const ok = await confirm('Emergency SOS', t('common.sos_confirm', 'Are you sure you want to trigger an Emergency SOS? Dispatch will be alerted immediately with your location.'), { variant: 'danger', confirmLabel: 'Trigger SOS' });
        if (ok) {
            showToast(t('common.sos_triggered', 'SOS Triggered! Dispatch is being notified.'), 'error');
        }
    };

    return (
        <>
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
            <DialogRenderer />
        </>
    );
};

export default SosButton;
