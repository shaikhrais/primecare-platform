import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { useNavigate } from 'react-router-dom';
import { ClientServiceFields, DateTimeFields, AssignmentFields, SecondaryVisitFields } from './components/VisitFormFields';
import { AdvancedRecurrenceBuilder } from './components/AdvancedRecurrenceBuilder';
import { InlineCreateClient, InlineCreateService, InlineCreatePsw } from './components/InlineCreationForms';
import { type VisitFormData, DEFAULT_FORM, formFromVisit, fetchModalData, buildPayload } from './visitModalHelpers';

const { ApiRegistry, ContentRegistry } = AdminRegistry;

interface CreateVisitModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSuccess: () => void;
    initialClientId?: string;
    initialClientName?: string;
    visit?: any;
}

export const CreateVisitModal: React.FC<CreateVisitModalProps> = ({
    isOpen, onClose, onSuccess, initialClientId, initialClientName, visit
}) => {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);
    const [clients, setClients] = useState<any[]>([]);
    const [services, setServices] = useState<any[]>([]);
    const [psws, setPsws] = useState<any[]>([]);

    const [isCreatingClient, setIsCreatingClient] = useState(false);
    const [isCreatingService, setIsCreatingService] = useState(false);
    const [isCreatingPsw, setIsCreatingPsw] = useState(false);

    const [formData, setFormData] = useState<VisitFormData>({ ...DEFAULT_FORM, clientId: initialClientId || '' });

    useEffect(() => {
        if (isOpen) {
            loadData();
            setFormData(visit ? formFromVisit(visit) : { ...DEFAULT_FORM, clientId: initialClientId || '' });
        }
    }, [isOpen, initialClientId, visit]);

    const loadData = async () => {
        try {
            const data = await fetchModalData();
            setClients(data.clients); setServices(data.services); setPsws(data.psws);
        } catch (error) { console.error('Failed to fetch modal data', error); }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        const payload = buildPayload(formData);
        try {
            const response = visit
                ? await apiClient.patch(ApiRegistry.ADMIN.VISITS_UPDATE(visit.id), payload)
                : await apiClient.post(ApiRegistry.ADMIN.VISITS, payload);
            if (response.ok) {
                showToast(visit ? ContentRegistry.MODALS.CREATE_VISIT.SUCCESS_UPDATE : ContentRegistry.MODALS.CREATE_VISIT.SUCCESS_CREATE, 'success');
                onSuccess(); onClose();
            } else {
                const err = await response.json();
                showToast(err.error || (visit ? ContentRegistry.MODALS.CREATE_VISIT.ERROR_UPDATE : ContentRegistry.MODALS.CREATE_VISIT.ERROR_CREATE), 'error');
            }
        } catch (error) { showToast(visit ? ContentRegistry.MODALS.CREATE_VISIT.ERROR_UPDATE : ContentRegistry.MODALS.CREATE_VISIT.ERROR_CREATE, 'error'); }
        finally { setLoading(false); }
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} data-cy="modal-create-visit" role="dialog" aria-modal="true" aria-labelledby="modal-title">
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '550px', width: '90%', maxHeight: '90vh', overflowY: 'auto', position: 'relative' }}>
                <button data-cy="btn-shared.create-visit-modal-0" 
                    onClick={onClose} 
                    style={{ position: 'absolute', top: '1rem', right: '1rem', background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#6b7280' }}
                    aria-label="Close modal"
                >
                    &times;
                </button>
                <h3 data-cy="h3-shared.create-visit-modal-0" id="modal-title" style={{ marginTop: 0, fontSize: '1.25rem', fontWeight: 'bold' }}>{visit ? ContentRegistry.MODALS.CREATE_VISIT.TITLE_EDIT : ContentRegistry.MODALS.CREATE_VISIT.TITLE_CREATE}</h3>
                <form data-cy="form-shared.create-visit-modal" onSubmit={handleSubmit} style={{ marginTop: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                    <ClientServiceFields
                        clientId={formData.clientId} serviceId={formData.serviceId} clients={clients} services={services}
                        onClientChange={(e) => setFormData(p => ({ ...p, clientId: e.target.value }))}
                        onServiceChange={(e) => setFormData(p => ({ ...p, serviceId: e.target.value }))}
                        fixedClientName={visit ? (clients.find(c => c.id === formData.clientId)?.fullName || 'Loading...') : (initialClientId ? initialClientName : undefined)}
                        disabled={loading}
                        onCreateClient={() => setIsCreatingClient(true)}
                        onCreateService={() => setIsCreatingService(true)}
                        isCreatingClient={isCreatingClient}
                        isCreatingService={isCreatingService}
                        inlineClientForm={<InlineCreateClient 
                            onCancel={() => setIsCreatingClient(false)} 
                            onSuccess={async (newId) => { await loadData(); setFormData(p => ({ ...p, clientId: newId })); setIsCreatingClient(false); }} 
                        />}
                        inlineServiceForm={<InlineCreateService 
                            onCancel={() => setIsCreatingService(false)} 
                            onSuccess={async (newId) => { await loadData(); setFormData(p => ({ ...p, serviceId: newId })); setIsCreatingService(false); }} 
                        />}
                    />
                    <DateTimeFields
                        requestedStartAt={formData.requestedStartAt} durationMinutes={formData.durationMinutes}
                        onStartChange={(e) => setFormData(p => ({ ...p, requestedStartAt: e.target.value }))}
                        onDurationChange={(e) => setFormData(p => ({ ...p, durationMinutes: Number(e.target.value) }))}
                        disabled={loading}
                    />
                    <AssignmentFields
                        assignmentType={formData.assignmentType} assignedPswId={formData.assignedPswId} psws={psws}
                        onTypeChange={(type) => setFormData(p => ({ ...p, assignmentType: type }))}
                        onPswChange={(e) => setFormData(p => ({ ...p, assignedPswId: e.target.value }))}
                        disabled={loading}
                        onCreatePsw={() => setIsCreatingPsw(true)}
                        isCreatingPsw={isCreatingPsw}
                        inlinePswForm={<InlineCreatePsw 
                            onCancel={() => setIsCreatingPsw(false)} 
                            onSuccess={async (newId) => { await loadData(); setFormData(p => ({ ...p, assignedPswId: newId })); setIsCreatingPsw(false); }} 
                        />}
                    />
                    <SecondaryVisitFields
                        priority={formData.priority} recurrence={formData.recurrence} clientNotes={formData.clientNotes}
                        onPriorityChange={(e) => setFormData(p => ({ ...p, priority: e.target.value as any }))}
                        onRecurrenceChange={(e) => setFormData(p => ({ ...p, recurrence: e.target.value as any }))}
                        onNotesChange={(e) => setFormData(p => ({ ...p, clientNotes: e.target.value }))}
                        isEdit={!!visit} disabled={loading}
                    />
                    {formData.recurrence === 'advanced' && (
                        <div style={{ marginTop: '-0.5rem' }}>
                            <AdvancedRecurrenceBuilder 
                                value={formData.advancedRRule}
                                onChange={(rrule, endDate) => setFormData(p => ({ ...p, advancedRRule: rrule, advancedUntil: endDate }))}
                                startDate={formData.requestedStartAt}
                                disabled={loading}
                            />
                        </div>
                    )}
                    <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                        <button data-cy="btn-shared.create-visit-modal-1" type="button" onClick={onClose} disabled={loading} style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', backgroundColor: 'transparent', cursor: 'pointer' }}>{ContentRegistry.MODALS.CREATE_VISIT.CANCEL}</button>
                        <button type="submit" disabled={loading} data-cy="btn-submit-visit" style={{ flex: 2, padding: '0.75rem', borderRadius: '0.5rem', border: 'none', backgroundColor: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer', opacity: loading ? 0.7 : 1 }}>
                            {loading ? ContentRegistry.MODALS.CREATE_VISIT.PROCESSING : (visit ? ContentRegistry.MODALS.CREATE_VISIT.SUBMIT_SAVE : ContentRegistry.MODALS.CREATE_VISIT.SUBMIT_CREATE)}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};
