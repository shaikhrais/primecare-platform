import React from 'react';

interface UserQuickViewModalProps {
    isOpen: boolean;
    onClose: () => void;
    user: any;
}

export const UserQuickViewModal: React.FC<UserQuickViewModalProps> = ({ isOpen, onClose, user }) => {
    if (!isOpen || !user) return null;

    return (
        <div style={{
            position: 'fixed',
            inset: 0,
            backgroundColor: 'rgba(0,0,0,0.5)',
            display: 'flex',
            justifyContent: 'flex-end',
            zIndex: 1000
        }} onClick={onClose}>
            <div style={{
                width: '100%',
                maxWidth: '500px',
                backgroundColor: 'white',
                height: '100%',
                overflowY: 'auto',
                padding: '2rem',
                boxShadow: '-4px 0 20px rgba(0,0,0,0.1)'
            }} onClick={e => e.stopPropagation()}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                    <h2 data-cy="h2-shared.user-quick-view-modal-0" style={{ margin: 0 }}>User Details</h2>
                    <button data-cy="btn-shared.user-quick-view-modal-0" onClick={onClose} style={{ border: 'none', background: 'none', fontSize: '1.5rem', cursor: 'pointer' }}>×</button>
                </div>

                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <div style={{ width: '80px', height: '80px', borderRadius: '50%', backgroundColor: '#e0f2fe', color: '#0369a1', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', margin: '0 auto 1rem auto' }}>
                        {user.profile?.fullName?.charAt(0) || user.email.charAt(0)}
                    </div>
                    <h3 data-cy="h3-shared.user-quick-view-modal-0" style={{ margin: '0 0 0.5rem 0' }}>{user.profile?.fullName}</h3>
                    <p style={{ margin: 0, color: '#6b7280' }}>{user.email}</p>
                    <div style={{ marginTop: '1rem', display: 'flex', gap: '0.5rem', justifyContent: 'center' }}>
                        {user.roles.map((r: string) => (
                            <span key={r} style={{ padding: '0.25rem 0.75rem', backgroundColor: '#f3f4f6', borderRadius: '9999px', fontSize: '0.875rem' }}>{r.toUpperCase()}</span>
                        ))}
                    </div>
                </div>

                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: '2rem' }}>
                    <h4 style={{ color: '#6b7280', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Contact Information</h4>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', fontSize: '0.875rem', color: '#9ca3af' }}>Email</label>
                        <div style={{ fontWeight: '500' }}>{user.email}</div>
                    </div>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', fontSize: '0.875rem', color: '#9ca3af' }}>Verification Status</label>
                        <div style={{ fontWeight: '500', color: user.profile?.isVerified ? 'green' : 'orange' }}>
                            {user.profile?.isVerified ? 'Verified' : 'Pending Verification'}
                        </div>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: '2rem', marginTop: '1rem' }}>
                    <h4 style={{ color: '#6b7280', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Performance Metrics</h4>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div style={{ backgroundColor: '#f9fafb', padding: '1rem', borderRadius: '0.5rem', textAlign: 'center' }}>
                            <div style={{ fontSize: '1.5rem', fontWeight: 'bold' }}>12</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Completed Shifts</div>
                        </div>
                        <div style={{ backgroundColor: '#f9fafb', padding: '1rem', borderRadius: '0.5rem', textAlign: 'center' }}>
                            <div style={{ fontSize: '1.5rem', fontWeight: 'bold' }}>4.8</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Average Rating</div>
                        </div>
                    </div>
                </div>

                <div style={{ marginTop: '3rem', display: 'grid', gap: '1rem' }}>
                    <button data-cy="btn-shared.user-quick-view-modal-1" style={{ width: '100%', padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                        View Full Profile
                    </button>
                    <button data-cy="btn-shared.user-quick-view-modal-2" style={{ width: '100%', padding: '0.75rem', backgroundColor: 'white', border: '1px solid #d1d5db', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                        Download Compliance Report
                    </button>
                </div>
            </div>
        </div>
    );
};
