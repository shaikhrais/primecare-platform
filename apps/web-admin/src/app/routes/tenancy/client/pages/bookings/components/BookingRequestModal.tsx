import React, { useState } from 'react';
import { InlineCreateService } from '@/shared/components/modals/components/InlineCreationForms';

interface Service {
    id: string;
    name: string;
    hourlyRate: number;
    description?: string;
}

interface BookingRequestModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSubmit: (data: any) => Promise<void>;
    services: Service[];
    submitting: boolean;
    onRefreshServices?: () => void;
}

export const BookingRequestModal: React.FC<BookingRequestModalProps> = ({ isOpen, onClose, onSubmit, services, submitting, onRefreshServices }) => {
    const [selectedService, setSelectedService] = useState('');
    const [activeDate, setActiveDate] = useState('');
    const [activeTime, setActiveTime] = useState('');
    const [duration, setDuration] = useState(60);
    const [notes, setNotes] = useState('');
    const [isCreatingService, setIsCreatingService] = useState(false);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        await onSubmit({
            selectedService,
            activeDate,
            activeTime,
            duration,
            notes
        });

        if (!isOpen) {
            setNotes('');
            setActiveDate('');
            setActiveTime('');
            setSelectedService('');
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{
            position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
            backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 50
        }} data-cy="modal-booking-request">
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', width: '90%', maxWidth: '500px' }}>
                <h3 data-cy="h3-client.booking-request-modal-0" style={{ marginTop: 0, fontSize: '1.25rem' }}>Request New Care Visit</h3>

                <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem', marginTop: '1rem' }} data-cy="form-booking">
                    <div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                            <label style={{ fontSize: '0.875rem', fontWeight: '600' }}>Service Type</label>
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
                                    setSelectedService(newId);
                                    setIsCreatingService(false);
                                    onRefreshServices?.();
                                }}
                            />
                        ) : (
                            <select
                                value={selectedService}
                                onChange={e => setSelectedService(e.target.value)}
                                required
                                style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                                data-cy="sel-service"
                            >
                                <option value="">-- Select Service --</option>
                                {services.map(s => (
                                    <option key={s.id} value={s.id}>{s.name} (${s.hourlyRate}/hr)</option>
                                ))}
                            </select>
                        )}
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Date</label>
                            <input
                                data-cy="inp-date"
                                type="date"
                                required
                                value={activeDate}
                                onChange={e => setActiveDate(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Time</label>
                            <input
                                data-cy="inp-time"
                                type="time"
                                required
                                value={activeTime}
                                onChange={e => setActiveTime(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Duration (Minutes)</label>
                        <select
                            data-cy="sel-duration"
                            value={duration}
                            onChange={e => setDuration(Number(e.target.value))}
                            style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                        >
                            <option value={60}>1 Hour</option>
                            <option value={90}>1.5 Hours</option>
                            <option value={120}>2 Hours</option>
                            <option value={180}>3 Hours</option>
                            <option value={240}>4 Hours</option>
                        </select>
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Notes for Service Provider</label>
                        <textarea
                            data-cy="inp-notes"
                            rows={3}
                            value={notes}
                            onChange={e => setNotes(e.target.value)}
                            placeholder="Enter any special instructions..."
                            style={{ width: '100%', padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem', justifyContent: 'flex-end' }}>
                        <button
                            data-cy="btn-cancel-request"
                            type="button"
                            onClick={onClose}
                            style={{ padding: '0.5rem 1rem', border: '1px solid #d1d5db', background: 'white', borderRadius: '0.375rem', cursor: 'pointer' }}
                        >
                            Cancel
                        </button>
                        <button
                            data-cy="btn.requestBooking"
                            type="submit"
                            disabled={submitting}
                            style={{ padding: '0.5rem 1rem', background: 'var(--pc-primary-dark)', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', opacity: submitting ? 0.7 : 1 }}
                        >
                            {submitting ? 'Submitting...' : 'Submit Request'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};
