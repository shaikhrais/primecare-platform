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
                    <h2 data-cy="h2-shared.lead-quick-view-modal-0" style={{ margin: 0 }}>Inquiry Details</h2>
                    <button data-cy="btn-shared.lead-quick-view-modal-0" onClick={onClose} style={{ border: 'none', background: 'none', fontSize: '1.5rem', cursor: 'pointer' }}>×</button>
                </div>

                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <div style={{ width: '80px', height: '80px', borderRadius: '50%', backgroundColor: '#fef3c7', color: '#92400e', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', margin: '0 auto 1rem auto' }}>
                        {lead.fullName.charAt(0)}
                    </div>
                    <h3 data-cy="h3-shared.lead-quick-view-modal-0" style={{ margin: '0 0 0.5rem 0' }}>{lead.fullName}</h3>
                    <p style={{ margin: 0, color: '#6b7280' }}>{lead.email}</p>
                    <div style={{ marginTop: '1rem' }}>
                        <span style={{
                            padding: '0.25rem 0.75rem',
                            backgroundColor: lead.status === 'new' ? '#eff6ff' : '#ecfdf5',
                            color: lead.status === 'new' ? '#1e40af' : '#065f46',
                            borderRadius: '9999px', fontSize: '0.875rem', textTransform: 'uppercase', fontWeight: 'bold'
                        }}>
                            {lead.status}
                        </span>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: '2rem' }}>
                    <h4 style={{ color: '#6b7280', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Message</h4>
                    <div style={{ backgroundColor: '#f9fafb', padding: '1rem', borderRadius: '0.5rem', fontSize: '0.95rem', lineHeight: '1.5', color: '#374151' }}>
                        {lead.message}
                    </div>
                    <div style={{ marginTop: '1rem', display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem', color: '#6b7280' }}>
                        <span>Received via Website</span>
                        <span>{new Date(lead.createdAt).toLocaleString()}</span>
                    </div>
                </div>

                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: '2rem', marginTop: '2rem' }}>
                    <h4 style={{ color: '#6b7280', textTransform: 'uppercase', fontSize: '0.75rem', marginBottom: '1rem' }}>Quick Actions</h4>
                    <div style={{ display: 'grid', gap: '1rem' }}>
                        <a href={`mailto:${lead.email}`} style={{ textDecoration: 'none' }}>
                            <button data-cy="btn-shared.lead-quick-view-modal-1" style={{ width: '100%', padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                                Reply via Email
                            </button>
                        </a>
                        {lead.status === 'new' && (
                            <button data-cy="btn-shared.lead-quick-view-modal-2" onClick={() => onStatusUpdate(lead.id, 'contacted')} style={{ width: '100%', padding: '0.75rem', backgroundColor: 'white', border: '1px solid #d1d5db', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                                Mark as Contacted
                            </button>
                        )}
                        {lead.status !== 'converted' && (
                            <button data-cy="btn-shared.lead-quick-view-modal-3" onClick={() => onStatusUpdate(lead.id, 'converted')} style={{ width: '100%', padding: '0.75rem', backgroundColor: '#ecfdf5', color: '#065f46', border: '1px solid #065f46', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
                                Convert to Client
                            </button>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};
