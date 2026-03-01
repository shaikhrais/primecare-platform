import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

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
}

export const ServiceBookingModal: React.FC<ServiceBookingModalProps> = ({ isOpen, onClose, services, onSuccess, showToast }) => {
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
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    ...newRequest,
                    recurrenceRule: newRequest.recurrence !== 'none' ? { pattern: newRequest.recurrence } : undefined
                })
            });
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
            showToast('Failed to submit request', 'error');
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, backdropFilter: 'blur(8px)' }}>
            <form onSubmit={handleSubmitRequest} className="pc-card" style={{ padding: '2.5rem', maxWidth: '500px', width: '90%', border: '1px solid var(--brand-500)' }}>
                <h3 className="pc-card-h" style={{ padding: 0, marginBottom: '0.5rem', color: 'var(--brand-500)' }}>{t(ContentRegistry.CLIENT_DASHBOARD.MODAL_TITLE)}</h3>
                <p style={{ color: 'var(--text-300)', marginBottom: '2rem' }}>{t(ContentRegistry.CLIENT_DASHBOARD.MODAL_SUBTITLE)}</p>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Select Care Service</label>
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
