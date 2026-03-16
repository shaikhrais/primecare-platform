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
            backgroundColor: 'var(--pc-bg-overlay)',
            display: 'flex',
            justifyContent: 'flex-end',
            zIndex: 1000
        }} onClick={onClose}>
            <div style={{
                width: '100%',
                maxWidth: '500px',
                backgroundColor: 'var(--pc-surface-card)',
                height: '100%',
                overflowY: 'auto',
                padding: '2rem',
                boxShadow: 'var(--pc-shadow-xl)',
                color: 'var(--pc-text-primary)'
            }} onClick={e => e.stopPropagation()}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                    <h2 data-cy="h2-shared.customer-quick-view-modal-0" style={{ margin: 0 }}>Client Profile</h2>
                    <button data-cy="btn-shared.customer-quick-view-modal-0" onClick={onClose} style={{ border: 'none', background: 'none', fontSize: '1.5rem', cursor: 'pointer', color: 'var(--pc-text-tertiary)' }}>×</button>
                </div>

                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <div style={{ width: '80px', height: '80px', borderRadius: '50%', backgroundColor: 'var(--pc-success-bg)', color: 'var(--pc-success)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', margin: '0 auto 1rem auto' }}>
                        {customer.fullName?.charAt(0) || '?'}
                    </div>
                    <h3 data-cy="h3-shared.customer-quick-view-modal-0" style={{ margin: '0 0 0.5rem 0' }}>{customer.fullName || 'Anonymous Client'}</h3>
                    <p style={{ margin: 0, color: 'var(--pc-text-secondary)' }}>{customer.user?.email}</p>
                    <div style={{ marginTop: '1rem' }}>
                        <span style={{
                            padding: '0.25rem 0.75rem',
                            backgroundColor: customer.user?.status === 'active' ? 'var(--pc-success-bg)' : 'var(--pc-error-bg)',
                            color: customer.user?.status === 'active' ? 'var(--pc-success)' : 'var(--pc-error)',
                            borderRadius: '9999px', fontSize: '0.875rem', textTransform: 'uppercase', fontWeight: 'bold'
                        }}>
                            {customer.user?.status || 'Unknown'}
                        </span>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid var(--pc-border-primary)', paddingTop: '2rem' }}>
                    <h4 style={{ color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Care Overview</h4>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1.5rem' }}>
                        <div style={{ backgroundColor: 'var(--pc-bg-secondary)', padding: '1rem', borderRadius: 'var(--pc-radius-md)' }}>
                            <div style={{ fontSize: '1.25rem', fontWeight: 'bold' }}>3</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-secondary)' }}>Active Care Plans</div>
                        </div>
                        <div style={{ backgroundColor: 'var(--pc-bg-secondary)', padding: '1rem', borderRadius: 'var(--pc-radius-md)' }}>
                            <div style={{ fontSize: '1.25rem', fontWeight: 'bold' }}>12</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-secondary)' }}>Completed Visits</div>
                        </div>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid var(--pc-border-primary)', paddingTop: '2rem' }}>
                    <h4 style={{ color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Actions</h4>
                    <div style={{ display: 'grid', gap: '1rem' }}>
                        <button data-cy="btn-shared.customer-quick-view-modal-1" style={{ width: '100%', padding: '0.75rem', backgroundColor: 'var(--pc-primary-dark)', color: 'var(--pc-text-on-primary)', border: 'none', borderRadius: 'var(--pc-radius-md)', fontWeight: 'bold', cursor: 'pointer' }}>
                            View Full Medical Record
                        </button>
                        <button data-cy="btn-shared.customer-quick-view-modal-2" style={{ width: '100%', padding: '0.75rem', backgroundColor: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-secondary)', borderRadius: 'var(--pc-radius-md)', fontWeight: 'bold', cursor: 'pointer', color: 'var(--pc-text-primary)' }}>
                            Create New Care Plan
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};
