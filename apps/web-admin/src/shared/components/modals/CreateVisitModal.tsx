import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry, ContentRegistry } = AdminRegistry;

interface CreateVisitModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSuccess: () => void;
    initialClientId?: string;
    initialClientName?: string;
}

export const CreateVisitModal: React.FC<CreateVisitModalProps> = ({
    isOpen,
    onClose,
    onSuccess,
    initialClientId,
    initialClientName
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
            if (initialClientId) {
                setFormData(prev => ({ ...prev, clientId: initialClientId, assignmentType: 'open' }));
            }
        }
    }, [isOpen, initialClientId]);

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
            const response = await apiClient.post('/v1/admin/visits', payload);
            if (response.ok) {
                showToast('Shift created successfully!', 'success');
                onSuccess();
                onClose();
            } else {
                const err = await response.json();
                showToast(err.error || 'Failed to create shift', 'error');
            }
        } catch (error) {
            showToast('Error creating shift', 'error');
        } finally {
            setLoading(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} data-cy="modal-create-visit">
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '550px', width: '90%', maxHeight: '90vh', overflowY: 'auto' }}>
                <h3 style={{ marginTop: 0, fontSize: '1.25rem', fontWeight: 'bold' }}>Create New Shift Request</h3>

                <form onSubmit={handleSubmit} style={{ marginTop: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>

                    {/* Client Selection */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Client</label>
                        {initialClientId ? (
                            <div style={{ padding: '0.75rem', backgroundColor: '#f9fafb', borderRadius: '0.5rem', border: '1px solid #d1d5db', fontWeight: '600' }}>
                                {initialClientName || 'Selected Client'}
                            </div>
                        ) : (
                            <select
                                data-cy="inp-client-id"
                                required
                                value={formData.clientId}
                                onChange={(e) => setFormData({ ...prev => ({ ...prev, clientId: e.target.value }) })}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option value="">Select a client</option>
                                {clients.map(c => (
                                    <option key={c.id} value={c.id}>{c.fullName}</option>
                                ))}
                            </select>
                        )}
                    </div>

                    {/* Service Selection */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Service Type</label>
                        <select
                            data-cy="inp-service-id"
                            required
                            value={formData.serviceId}
                            onChange={(e) => setFormData(prev => ({ ...prev, serviceId: e.target.value }))}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">Select a service</option>
                            {services.map(s => (
                                <option key={s.id} value={s.id}>{s.name}</option>
                            ))}
                        </select>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        {/* Start Time */}
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Date & Time</label>
                            <input
                                data-cy="inp-start-at"
                                type="datetime-local"
                                required
                                value={formData.requestedStartAt}
                                onChange={(e) => setFormData(prev => ({ ...prev, requestedStartAt: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                        {/* Duration */}
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Duration (min)</label>
                            <input
                                data-cy="inp-duration"
                                type="number"
                                required
                                min="30"
                                step="15"
                                value={formData.durationMinutes}
                                onChange={(e) => setFormData(prev => ({ ...prev, durationMinutes: Number(e.target.value) }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    </div>

                    {/* Assignment Type */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Shift Type</label>
                        <div style={{ display: 'flex', gap: '1rem' }}>
                            <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer' }}>
                                <input type="radio" value="open" checked={formData.assignmentType === 'open'} onChange={() => setFormData(prev => ({ ...prev, assignmentType: 'open' }))} />
                                Open Shift (Any PSW)
                            </label>
                            <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer' }}>
                                <input type="radio" value="direct" checked={formData.assignmentType === 'direct'} onChange={() => setFormData(prev => ({ ...prev, assignmentType: 'direct' }))} />
                                Direct Assign
                            </label>
                        </div>
                    </div>

                    {/* PSW Selector (Conditional) */}
                    {formData.assignmentType === 'direct' && (
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Select PSW</label>
                            <select
                                data-cy="inp-psw-id"
                                required={formData.assignmentType === 'direct'}
                                value={formData.assignedPswId}
                                onChange={(e) => setFormData(prev => ({ ...prev, assignedPswId: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option value="">Select a caregiver</option>
                                {psws.map(psw => (
                                    <option key={psw.id} value={psw.pswProfile?.id || psw.id}>
                                        {psw.pswProfile?.fullName || psw.email}
                                    </option>
                                ))}
                            </select>
                        </div>
                    )}

                    {/* Notes */}
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Instruction/Notes</label>
                        <textarea
                            data-cy="inp-notes"
                            value={formData.clientNotes}
                            onChange={(e) => setFormData(prev => ({ ...prev, clientNotes: e.target.value }))}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px', resize: 'vertical' }}
                            placeholder="Optional visit instructions..."
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                        <button
                            type="button"
                            onClick={onClose}
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
                            {loading ? 'Processing...' : 'Create Shift'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};
