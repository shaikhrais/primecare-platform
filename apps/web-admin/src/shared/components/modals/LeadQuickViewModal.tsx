import React from 'react';

interface LeadQuickViewModalProps {
    isOpen: boolean;
    onClose: () => void;
    lead: any;
    onStatusUpdate: (id: string, status: string) => void;
}

export const LeadQuickViewModal: React.FC<LeadQuickViewModalProps> = ({ isOpen, onClose, lead, onStatusUpdate }) => {
    if (!isOpen || !lead) return null;

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
                    <h2 data-cy="h2-shared.lead-quick-view-modal-0" style={{ margin: 0 }}>Inquiry Details</h2>
                    <button data-cy="btn-shared.lead-quick-view-modal-0" onClick={onClose} style={{ border: 'none', background: 'none', fontSize: '1.5rem', cursor: 'pointer', color: 'var(--pc-text-tertiary)' }}>×</button>
                </div>

                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <div style={{ width: '80px', height: '80px', borderRadius: '50%', backgroundColor: 'var(--pc-warning-bg)', color: 'var(--pc-warning)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', margin: '0 auto 1rem auto' }}>
                        {lead.fullName.charAt(0)}
                    </div>
                    <h3 data-cy="h3-shared.lead-quick-view-modal-0" style={{ margin: '0 0 0.5rem 0' }}>{lead.fullName}</h3>
                    <p style={{ margin: 0, color: 'var(--pc-text-secondary)' }}>{lead.email}</p>
                    <div style={{ marginTop: '1rem' }}>
                        <span style={{
                            padding: '0.25rem 0.75rem',
                            backgroundColor: lead.status === 'new' ? 'var(--pc-info-bg)' : 'var(--pc-success-bg)',
                            color: lead.status === 'new' ? 'var(--pc-info)' : 'var(--pc-success)',
                            borderRadius: '9999px', fontSize: '0.875rem', textTransform: 'uppercase', fontWeight: 'bold'
                        }}>
                            {lead.status}
                        </span>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid var(--pc-border-primary)', paddingTop: '2rem' }}>
                    <h4 style={{ color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Message</h4>
                    <div style={{ backgroundColor: 'var(--pc-bg-secondary)', padding: '1rem', borderRadius: 'var(--pc-radius-md)', fontSize: '0.95rem', lineHeight: '1.5', color: 'var(--pc-text-primary)' }}>
                        {lead.message}
                    </div>
                    <div style={{ marginTop: '1rem', display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem', color: 'var(--pc-text-secondary)' }}>
                        <span>Received via Website</span>
                        <span>{new Date(lead.createdAt).toLocaleString()}</span>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid var(--pc-border-primary)', paddingTop: '2rem', marginTop: '2rem' }}>
                    <h4 style={{ color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Quick Actions</h4>
                    <div style={{ display: 'grid', gap: '1rem' }}>
                        <a href={`mailto:${lead.email}`} style={{ textDecoration: 'none' }}>
                            <button data-cy="btn-shared.lead-quick-view-modal-1" style={{ width: '100%', padding: '0.75rem', backgroundColor: 'var(--pc-primary-dark)', color: 'var(--pc-text-on-primary)', border: 'none', borderRadius: 'var(--pc-radius-md)', fontWeight: 'bold', cursor: 'pointer' }}>
                                Reply via Email
                            </button>
                        </a>
                        {lead.status === 'new' && (
                            <button data-cy="btn-shared.lead-quick-view-modal-2" onClick={() => onStatusUpdate(lead.id, 'contacted')} style={{ width: '100%', padding: '0.75rem', backgroundColor: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-secondary)', borderRadius: 'var(--pc-radius-md)', fontWeight: 'bold', cursor: 'pointer', color: 'var(--pc-text-primary)' }}>
                                Mark as Contacted
                            </button>
                        )}
                        {lead.status !== 'converted' && (
                            <button data-cy="btn-shared.lead-quick-view-modal-3" onClick={() => onStatusUpdate(lead.id, 'converted')} style={{ width: '100%', padding: '0.75rem', backgroundColor: 'var(--pc-success-bg)', color: 'var(--pc-success)', border: '1px solid var(--pc-success)', borderRadius: 'var(--pc-radius-md)', fontWeight: 'bold', cursor: 'pointer' }}>
                                Convert to Client
                            </button>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};
