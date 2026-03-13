import React from 'react';

interface CustomerQuickViewModalProps {
    isOpen: boolean;
    onClose: () => void;
    customer: any;
}

export const CustomerQuickViewModal: React.FC<CustomerQuickViewModalProps> = ({ isOpen, onClose, customer }) => {
    if (!isOpen || !customer) return null;

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
                    <h2 data-cy="h2-shared.customer-quick-view-modal-0" style={{ margin: 0 }}>Client Profile</h2>
                    <button data-cy="btn-shared.customer-quick-view-modal-0" onClick={onClose} style={{ border: 'none', background: 'none', fontSize: '1.5rem', cursor: 'pointer' }}>×</button>
                </div>

                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <div style={{ width: '80px', height: '80px', borderRadius: '50%', backgroundColor: '#dcfce7', color: '#166534', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', margin: '0 auto 1rem auto' }}>
                        {customer.fullName?.charAt(0) || '?'}
                    </div>
                    <h3 data-cy="h3-shared.customer-quick-view-modal-0" style={{ margin: '0 0 0.5rem 0' }}>{customer.fullName || 'Anonymous Client'}</h3>
                    <p style={{ margin: 0, color: '#6b7280' }}>{customer.user?.email}</p>
                    <div style={{ marginTop: '1rem' }}>
                        <span style={{
                            padding: '0.25rem 0.75rem',
                            backgroundColor: customer.user?.status === 'active' ? '#dcfce7' : '#fee2e2',
                            color: customer.user?.status === 'active' ? '#166534' : '#991b1b',
                            borderRadius: '9999px', fontSize: '0.875rem', textTransform: 'uppercase', fontWeight: 'bold'
                        }}>
                            {customer.user?.status || 'Unknown'}
                        </span>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: '2rem' }}>
                    <h4 style={{ color: '#6b7280', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Care Overview</h4>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div style={{ backgroundColor: '#f9fafb', padding: '1rem', borderRadius: '0.5rem' }}>
                            <div style={{ fontSize: '1.25rem', fontWeight: 'bold' }}>3</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Active Care Plans</div>
                        </div>
                        <div style={{ backgroundColor: '#f9fafb', padding: '1rem', borderRadius: '0.5rem' }}>
                            <div style={{ fontSize: '1.25rem', fontWeight: 'bold' }}>12</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Completed Visits</div>
                        </div>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: '2rem' }}>
                    <h4 style={{ color: '#6b7280', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Actions</h4>
                    <div style={{ display: 'grid', gap: '1rem' }}>
                        <button data-cy="btn-shared.customer-quick-view-modal-1" style={{ width: '100%', padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                            View Full Medical Record
                        </button>
                        <button data-cy="btn-shared.customer-quick-view-modal-2" style={{ width: '100%', padding: '0.75rem', backgroundColor: 'white', border: '1px solid #d1d5db', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                            Create New Care Plan
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};
