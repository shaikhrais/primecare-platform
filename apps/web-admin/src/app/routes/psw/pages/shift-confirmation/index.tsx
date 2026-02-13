import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

export default function ShiftConfirmation() {
    const navigate = useNavigate();
    const { showToast } = useNotification();

    const handleAccept = () => {
        showToast('Shift accepted!', 'success');
        navigate('/shifts');
    };

    const handleDecline = () => {
        showToast('Shift declined', 'info');
        navigate('/shifts');
    };

    return (
        <div style={{ maxWidth: '600px', margin: '0 auto', padding: '2rem' }} data-cy="form.shiftConfirmation.page">
            <div style={{ backgroundColor: 'white', padding: '2.5rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb', textAlign: 'center' }}>
                <h2 style={{ fontSize: '1.75rem', marginBottom: '1rem' }} data-cy="page.title">New Shift Available</h2>
                <p style={{ color: '#6b7280', marginBottom: '2rem' }} data-cy="page.subtitle">You have been assigned a new visit for Client Sarah Miller tomorrow at 9:00 AM.</p>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <button
                        data-cy="btn.shift.decline"
                        onClick={handleDecline}
                        style={{ flex: 1, padding: '1rem', borderRadius: '0.75rem', border: '1px solid #d1d5db', background: 'none', cursor: 'pointer', fontWeight: 600 }}
                    >
                        Decline
                    </button>
                    <button
                        data-cy="btn.shift.accept"
                        onClick={handleAccept}
                        style={{ flex: 1, padding: '1rem', borderRadius: '0.75rem', background: '#004d40', color: 'white', border: 'none', cursor: 'pointer', fontWeight: 600 }}
                    >
                        Accept Shift
                    </button>
                </div>
            </div>
        </div>
    );
}
