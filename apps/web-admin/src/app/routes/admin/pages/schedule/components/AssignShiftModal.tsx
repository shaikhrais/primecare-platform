import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface Visit {
    id: string;
    requestedStartAt: string;
    client: { fullName: string };
    status: string;
}

interface AssignShiftModalProps {
    isOpen: boolean;
    onClose: () => void;
    selectedVisit: Visit | null;
    psws: any[];
    assignedPswId: string;
    setAssignedPswId: (id: string) => void;
    handleAssign: () => void;
    handleDeleteVisit: () => void;
    openEditModal: () => void;
    suggestions: any[];
    onFetchSuggestions: () => void;
    onOffer: (pswIds: string[]) => void;
    isSuggesting: boolean;
}

export const AssignShiftModal: React.FC<AssignShiftModalProps> = ({
    isOpen,
    onClose,
    selectedVisit,
    psws,
    assignedPswId,
    setAssignedPswId,
    handleAssign,
    handleDeleteVisit,
    openEditModal,
    suggestions,
    onFetchSuggestions,
    onOffer,
    isSuggesting
}) => {
    if (!isOpen || !selectedVisit) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%' }}>
                <h3 style={{ marginTop: 0 }}>{t(ContentRegistry.SCHEDULE.ACTIONS.ASSIGN)}</h3>
                <div style={{ margin: '1rem 0' }}>
                    <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Client:</strong> {selectedVisit.client?.fullName || 'N/A'}</p>
                    <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Visit:</strong> {new Date(selectedVisit.requestedStartAt).toLocaleString()}</p>
                    <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Status:</strong> {selectedVisit.status.toUpperCase()}</p>
                </div>

                <div style={{ marginTop: '1.5rem' }}>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.SCHEDULE.MODAL.SELECT_PSW)}</label>
                    <select
                        data-cy="modal-select-psw"
                        value={assignedPswId}
                        onChange={(e) => setAssignedPswId(e.target.value)}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    >
                        <option value="">{t(ContentRegistry.SCHEDULE.MODAL.CHOOSE_WORKER)}</option>
                        {psws.map(psw => (
                            <option key={psw.id} value={psw.PswProfile?.id}>
                                {psw.PswProfile?.fullName} (Verified)
                            </option>
                        ))}
                    </select>
                </div>

                {/* Suggestions Section */}
                <div style={{ marginTop: '1.5rem', borderTop: '1px solid #f3f4f6', paddingTop: '1rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                        <label style={{ fontSize: '0.875rem', fontWeight: 'bold' }}>Smart Suggestions</label>
                        <button
                            onClick={onFetchSuggestions}
                            disabled={isSuggesting}
                            style={{ fontSize: '0.75rem', color: '#004d40', fontWeight: '600', background: 'none', border: 'none', cursor: 'pointer' }}
                        >
                            {isSuggesting ? 'Thinking...' : 'Refresh Suggestions'}
                        </button>
                    </div>

                    {suggestions.length > 0 ? (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                            {suggestions.map(s => (
                                <div key={s.id} style={{ padding: '0.75rem', backgroundColor: '#f9fafb', borderRadius: '0.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                    <div>
                                        <p style={{ margin: 0, fontSize: '0.875rem', fontWeight: '600' }}>{s.fullName}</p>
                                        <p style={{ margin: 0, fontSize: '0.75rem', color: '#6b7280' }}>{s.reasons.join(', ')}</p>
                                    </div>
                                    <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                                        <span style={{ fontSize: '0.75rem', fontWeight: 'bold', color: '#059669' }}>{s.score}%</span>
                                        <button
                                            onClick={() => setAssignedPswId(s.id)}
                                            style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem', backgroundColor: '#e5e7eb', border: 'none', borderRadius: '0.25rem', cursor: 'pointer' }}
                                        >
                                            Select
                                        </button>
                                    </div>
                                </div>
                            ))}
                            <button
                                onClick={() => onOffer(suggestions.map(s => s.id))}
                                style={{ marginTop: '0.5rem', padding: '0.5rem', backgroundColor: '#ecfdf5', color: '#065f46', border: '1px solid #a7f3d0', borderRadius: '0.5rem', fontSize: '0.875rem', fontWeight: '600', cursor: 'pointer' }}
                            >
                                Send Offer to Top {suggestions.length} PSWs
                            </button>
                        </div>
                    ) : (
                        <p style={{ fontSize: '0.75rem', color: '#9ca3af', textAlign: 'center', margin: '1rem 0' }}>Click refresh to see smart service provider matches.</p>
                    )}
                </div>

                <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                    <button data-cy="btn-modal-cancel-visit" onClick={handleDeleteVisit} style={{ padding: '0.75rem', backgroundColor: '#fef2f2', color: '#991b1b', border: '1px solid #fecaca', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}>{t(ContentRegistry.SCHEDULE.ACTIONS.CANCEL_VISIT)}</button>
                    <button
                        data-cy="btn-modal-edit-visit"
                        onClick={openEditModal}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: '1px solid #d1d5db', borderRadius: '0.5rem', cursor: 'pointer', fontWeight: '600', color: '#374151' }}
                    >
                        {t(ContentRegistry.SCHEDULE.ACTIONS.EDIT)}
                    </button>
                    <div style={{ flex: 1 }} />
                    <button data-cy="btn-modal-close" onClick={onClose} style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}>{t(ContentRegistry.SCHEDULE.ACTIONS.CLOSE)}</button>
                    <button
                        data-cy="btn-modal-confirm-assign"
                        onClick={handleAssign}
                        disabled={!assignedPswId}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', opacity: assignedPswId ? 1 : 0.5, cursor: 'pointer' }}
                    >
                        {t(ContentRegistry.SCHEDULE.ACTIONS.CONFIRM_ASSIGN)}
                    </button>
                </div>
            </div>
        </div>
    );
};
