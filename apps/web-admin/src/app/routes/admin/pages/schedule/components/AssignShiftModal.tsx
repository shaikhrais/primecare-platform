import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

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
    openEditModal
}) => {
    if (!isOpen || !selectedVisit) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%' }}>
                <h3 style={{ marginTop: 0 }}>{ContentRegistry.SCHEDULE.ACTIONS.ASSIGN}</h3>
                <div style={{ margin: '1rem 0' }}>
                    <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Client:</strong> {selectedVisit.client?.fullName || 'N/A'}</p>
                    <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Visit:</strong> {new Date(selectedVisit.requestedStartAt).toLocaleString()}</p>
                    <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Status:</strong> {selectedVisit.status.toUpperCase()}</p>
                </div>

                <div style={{ marginTop: '1.5rem' }}>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{ContentRegistry.SCHEDULE.MODAL.SELECT_PSW}</label>
                    <select
                        data-cy="modal-select-psw"
                        value={assignedPswId}
                        onChange={(e) => setAssignedPswId(e.target.value)}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    >
                        <option value="">{ContentRegistry.SCHEDULE.MODAL.CHOOSE_WORKER}</option>
                        {psws.map(psw => (
                            <option key={psw.id} value={psw.PswProfile?.id}>
                                {psw.PswProfile?.fullName} (Verified)
                            </option>
                        ))}
                    </select>
                </div>

                <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                    <button data-cy="btn-modal-cancel-visit" onClick={handleDeleteVisit} style={{ padding: '0.75rem', backgroundColor: '#fef2f2', color: '#991b1b', border: '1px solid #fecaca', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}>{ContentRegistry.SCHEDULE.ACTIONS.CANCEL_VISIT}</button>
                    <button
                        data-cy="btn-modal-edit-visit"
                        onClick={openEditModal}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: '1px solid #d1d5db', borderRadius: '0.5rem', cursor: 'pointer', fontWeight: '600', color: '#374151' }}
                    >
                        {ContentRegistry.SCHEDULE.ACTIONS.EDIT}
                    </button>
                    <div style={{ flex: 1 }} />
                    <button data-cy="btn-modal-close" onClick={onClose} style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}>{ContentRegistry.SCHEDULE.ACTIONS.CLOSE}</button>
                    <button
                        data-cy="btn-modal-confirm-assign"
                        onClick={handleAssign}
                        disabled={!assignedPswId}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', opacity: assignedPswId ? 1 : 0.5, cursor: 'pointer' }}
                    >
                        {ContentRegistry.SCHEDULE.ACTIONS.CONFIRM_ASSIGN}
                    </button>
                </div>
            </div>
        </div>
    );
};
