import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

// Components
import { ClientServiceFields, DateTimeFields, AssignmentFields } from './components/VisitFormFields';

const { ApiRegistry } = AdminRegistry;

interface CreateVisitModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSuccess: () => void;
    initialClientId?: string;
    initialClientName?: string;
}

export const CreateVisitModal: React.FC<CreateVisitModalProps & { visit?: any }> = ({
    isOpen,
    onClose,
    onSuccess,
    initialClientId,
    initialClientName,
    visit
}) => {
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);
    const [clients, setClients] = useState<any[]>([]);
    const [services, setServices] = useState<any[]>([]);
    const [psws, setPsws] = useState<any[]>([]);

    const [formData, setFormData] = useState({
        clientId: initialClientId || '',
        serviceId: '',
        requestedStartAt: '',
        durationMinutes: 60,
        assignedPswId: '',
        clientNotes: '',
        assignmentType: 'open' as 'open' | 'direct'
    });

    useEffect(() => {
        if (isOpen) {
            fetchData();
            if (visit) {
                setFormData({
                    clientId: visit.client?.id || visit.clientId || '',
                    serviceId: visit.serviceId || '',
                    requestedStartAt: visit.requestedStartAt ? new Date(visit.requestedStartAt).toISOString().slice(0, 16) : '',
                    durationMinutes: visit.durationMinutes || 60,
                    assignedPswId: visit.assignedPswId || '',
                    clientNotes: visit.clientNotes || '',
                    assignmentType: visit.assignedPswId ? 'direct' : 'open'
                });
            } else if (initialClientId) {
                setFormData(prev => ({ ...prev, clientId: initialClientId, assignmentType: 'open' }));
            } else {
                setFormData({
                    clientId: '',
                    serviceId: '',
                    requestedStartAt: '',
                    durationMinutes: 60,
                    assignedPswId: '',
                    clientNotes: '',
                    assignmentType: 'open'
                });
            }
        }
    }, [isOpen, initialClientId, visit]);

    const fetchData = async () => {
        try {
            const [clientsRes, servicesRes, usersRes] = await Promise.all([
                apiClient.get(ApiRegistry.STAFF.CUSTOMERS),
                apiClient.get(ApiRegistry.ADMIN.SERVICES),
                apiClient.get(ApiRegistry.ADMIN.USERS)
            ]);

            if (clientsRes.ok) setClients(await clientsRes.json());
            if (servicesRes.ok) setServices(await servicesRes.json());
            if (usersRes.ok) {
                const userData = await usersRes.json();
                setPsws(userData.filter((u: any) => u.roles.includes('psw')));
            }
        } catch (error) {
            console.error('Failed to fetch modal data', error);
        }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);

        const payload = {
            clientId: formData.clientId,
            serviceId: formData.serviceId,
            requestedStartAt: new Date(formData.requestedStartAt).toISOString(),
            durationMinutes: Number(formData.durationMinutes),
            assignedPswId: formData.assignmentType === 'direct' ? formData.assignedPswId : undefined,
            clientNotes: formData.clientNotes
        };

        try {
            let response;
            if (visit) {
                response = await apiClient.patch(ApiRegistry.ADMIN.VISITS_UPDATE(visit.id), payload);
            } else {
                response = await apiClient.post('/v1/admin/visits', payload);
            }

            if (response.ok) {
                showToast(visit ? 'Shift updated successfully!' : 'Shift created successfully!', 'success');
                onSuccess();
                onClose();
            } else {
                const err = await response.json();
                showToast(err.error || (visit ? 'Failed to update shift' : 'Failed to create shift'), 'error');
            }
        } catch (error) {
            showToast(visit ? 'Error updating shift' : 'Error creating shift', 'error');
        } finally {
            setLoading(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} data-cy="modal-create-visit">
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '550px', width: '90%', maxHeight: '90vh', overflowY: 'auto' }}>
                <h3 style={{ marginTop: 0, fontSize: '1.25rem', fontWeight: 'bold' }}>{visit ? 'Edit Shift Request' : 'Create New Shift Request'}</h3>

                <form onSubmit={handleSubmit} style={{ marginTop: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>

                    <ClientServiceFields
                        clientId={formData.clientId}
                        serviceId={formData.serviceId}
                        clients={clients}
                        services={services}
                        onClientChange={(e) => setFormData(prev => ({ ...prev, clientId: e.target.value }))}
                        onServiceChange={(e) => setFormData(prev => ({ ...prev, serviceId: e.target.value }))}
                        fixedClientName={visit ? (clients.find(c => c.id === formData.clientId)?.fullName || 'Loading...') : (initialClientId ? initialClientName : undefined)}
                        disabled={loading}
                    />

                    <DateTimeFields
                        requestedStartAt={formData.requestedStartAt}
                        durationMinutes={formData.durationMinutes}
                        onStartChange={(e) => setFormData(prev => ({ ...prev, requestedStartAt: e.target.value }))}
                        onDurationChange={(e) => setFormData(prev => ({ ...prev, durationMinutes: Number(e.target.value) }))}
                        disabled={loading}
                    />

                    <AssignmentFields
                        assignmentType={formData.assignmentType}
                        assignedPswId={formData.assignedPswId}
                        psws={psws}
                        onTypeChange={(type) => setFormData(prev => ({ ...prev, assignmentType: type }))}
                        onPswChange={(e) => setFormData(prev => ({ ...prev, assignedPswId: e.target.value }))}
                        disabled={loading}
                    />

                    {/* Notes */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Instruction/Notes</label>
                        <textarea
                            data-cy="inp-notes"
                            value={formData.clientNotes}
                            onChange={(e) => setFormData(prev => ({ ...prev, clientNotes: e.target.value }))}
                            disabled={loading}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px', resize: 'vertical' }}
                            placeholder="Optional visit instructions..."
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                        <button
                            type="button"
                            onClick={onClose}
                            disabled={loading}
                            style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', backgroundColor: 'transparent', cursor: 'pointer' }}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            disabled={loading}
                            data-cy="btn-submit-visit"
                            style={{ flex: 2, padding: '0.75rem', borderRadius: '0.5rem', border: 'none', backgroundColor: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer', opacity: loading ? 0.7 : 1 }}
                        >
                            {loading ? 'Processing...' : (visit ? 'Save Changes' : 'Create Shift')}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};
