import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import { InlineCreateService } from '@/shared/components/modals/components/InlineCreationForms';

import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface Service {
    id: string;
    name: string;
    baseRateHourly: string;
}

interface ServiceBookingModalProps {
    isOpen: boolean;
    onClose: () => void;
    services: Service[];
    onSuccess: () => void;
    showToast: (message: string, type: 'success' | 'error' | 'info' | 'warning') => void;
    onRefreshServices?: () => void;
}

export const ServiceBookingModal: React.FC<ServiceBookingModalProps> = ({ isOpen, onClose, services, onSuccess, showToast, onRefreshServices }) => {
    const { t } = useTranslation();
    const [isCreatingService, setIsCreatingService] = useState(false);
    const [newRequest, setNewRequest] = useState({
        serviceId: '',
        requestedStartAt: '',
        durationMinutes: 60,
        priority: 'normal',
        recurrence: 'none'
    });

    const handleSubmitRequest = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const payload = {
                ...newRequest,
                serviceType: services.find((s) => s.id === newRequest.serviceId)?.name || newRequest.serviceId,
                preferredDate: newRequest.requestedStartAt || new Date().toISOString(),
                preferredTime: 'morning',
                notes: `Priority: ${newRequest.priority}, Recurrence: ${newRequest.recurrence}`
            };

            const response = await apiClient.post(ApiRegistry.CLIENT.BOOKING_REQUEST_LIST, payload);

            if (response.ok) {
                showToast('Care request submitted successfully!', 'success');
                setNewRequest({ serviceId: '', requestedStartAt: '', durationMinutes: 60, priority: 'normal', recurrence: 'none' });
                onSuccess();
                onClose();
            } else {
                const data = await response.json();
                showToast(`Submission failed: ${data.error || 'Unknown error'}`, 'error');
            }
        } catch (error) {
            console.error('Submission error:', error);
            showToast('Failed to submit request', 'error');
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, backdropFilter: 'blur(8px)' }} data-cy="modal-service-booking">
            <form onSubmit={handleSubmitRequest} className="pc-card" style={{ padding: '2.5rem', maxWidth: '500px', width: '90%', border: '1px solid var(--brand-500)' }} data-cy="form-service-booking">
                <h3 className="pc-card-h" style={{ padding: 0, marginBottom: '0.5rem', color: 'var(--brand-500)' }}>{t(ContentRegistry.CLIENT_DASHBOARD.MODAL_TITLE)}</h3>
                <p style={{ color: 'var(--text-300)', marginBottom: '2rem' }}>{t(ContentRegistry.CLIENT_DASHBOARD.MODAL_SUBTITLE)}</p>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                    <div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                            <label style={{ fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Select Care Service</label>
                            {!isCreatingService && (
                                <button
                                    data-cy="btn-create-service-inline"
                                    type="button"
                                    onClick={() => setIsCreatingService(true)}
                                    style={{ fontSize: '0.75rem', color: '#2563eb', fontWeight: '600', background: 'none', border: 'none', cursor: 'pointer' }}
                                >
                                    + Create New
                                </button>
                            )}
                        </div>
                        {isCreatingService ? (
                            <InlineCreateService
                                onCancel={() => setIsCreatingService(false)}
                                onSuccess={(newId) => {
                                    setNewRequest({ ...newRequest, serviceId: newId });
                                    setIsCreatingService(false);
                                    onRefreshServices?.();
                                }}
                            />
                        ) : (
                            <select
                                value={newRequest.serviceId}
                                onChange={(e) => setNewRequest({ ...newRequest, serviceId: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                                data-cy="form.booking.service"
                                required
                            >
                                <option value="" style={{ background: '#12233C' }}>-- Choose a Service --</option>
                                {services.map(s => (
                                    <option key={s.id} value={s.id} style={{ background: '#12233C' }}>{s.name} (${parseFloat(s.baseRateHourly).toFixed(2)}/hr)</option>
                                ))}
                            </select>
                        )}
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Preferred Date & Time</label>
                        <input
                            type="datetime-local"
                            value={newRequest.requestedStartAt ? new Date(new Date(newRequest.requestedStartAt).getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, 16) : ''}
                            onChange={(e) => setNewRequest({ ...newRequest, requestedStartAt: new Date(e.target.value).toISOString() })}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                            data-cy="form.booking.datetime"
                            required
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Duration (Minutes)</label>
                        <select
                            value={newRequest.durationMinutes}
                            onChange={(e) => setNewRequest({ ...newRequest, durationMinutes: parseInt(e.target.value) })}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                            data-cy="form.booking.duration"
                        >
                            <option value={60} style={{ background: '#12233C' }}>1 Hour</option>
                            <option value={90} style={{ background: '#12233C' }}>1.5 Hours</option>
                            <option value={120} style={{ background: '#12233C' }}>2 Hours</option>
                            <option value={180} style={{ background: '#12233C' }}>3 Hours</option>
                        </select>
                    </div>

                    <div style={{ display: 'flex', gap: '1rem' }}>
                        <div style={{ flex: 1 }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Priority</label>
                            <select
                                data-cy="form.booking.priority"
                                value={newRequest.priority}
                                onChange={(e) => setNewRequest({ ...newRequest, priority: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                            >
                                <option value="normal" style={{ background: '#12233C' }}>Normal</option>
                                <option value="urgent" style={{ background: '#12233C' }}>Urgent</option>
                            </select>
                        </div>
                        <div style={{ flex: 1 }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Recurrence</label>
                            <select
                                value={newRequest.recurrence}
                                onChange={(e) => setNewRequest({ ...newRequest, recurrence: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                                data-cy="form.booking.recurrence"
                            >
                                <option value="none" style={{ background: '#12233C' }}>None</option>
                                <option value="daily" style={{ background: '#12233C' }}>Daily</option>
                                <option value="weekly" style={{ background: '#12233C' }}>Weekly</option>
                                <option value="monthly" style={{ background: '#12233C' }}>Monthly</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '1rem', marginTop: '2.5rem' }}>
                    <button data-cy="btn-modal-cancel" type="button" className="btn" onClick={onClose} style={{ flex: 1 }}>Cancel</button>
                    <button data-cy="btn-modal-submit" type="submit" className="btn btn-primary" style={{ flex: 1 }}>Submit Request</button>
                </div>
            </form>
        </div>
    );
};
