import React, { useState, useEffect } from 'react';
import { ApiRegistry } from 'prime-care-shared';
import { useNotification } from '../../context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    durationMinutes: number;
    status: string;
    psw?: { fullName: string };
}

interface Service {
    id: string;
    name: string;
    hourlyRate: number;
    description?: string;
}

export default function BookingsPage() {
    const { showToast } = useNotification();
    const [bookings, setBookings] = useState<Booking[]>([]);
    const [services, setServices] = useState<Service[]>([]);
    const [loading, setLoading] = useState(true);
    const [showModal, setShowModal] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    // Form State
    const [selectedService, setSelectedService] = useState('');
    const [activeDate, setActiveDate] = useState('');
    const [activeTime, setActiveTime] = useState('');
    const [duration, setDuration] = useState(60);
    const [notes, setNotes] = useState('');

    const fetchBookings = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setBookings(data);
            }
        } catch (error) {
            console.error('Failed to fetch bookings', error);
        } finally {
            setLoading(false);
        }
    };

    const fetchServices = async () => {
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.PUBLIC.SERVICES}`);
            if (response.ok) {
                const data = await response.json();
                setServices(data);
            }
        } catch (error) {
            console.error('Failed to fetch services', error);
        }
    };

    useEffect(() => {
        fetchBookings();
        fetchServices();
    }, []);

    const handleRequest = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const requestedStartAt = new Date(`${activeDate}T${activeTime}`).toISOString();

            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    serviceId: selectedService,
                    requestedStartAt,
                    durationMinutes: Number(duration),
                    notes
                })
            });

            if (response.ok) {
                setShowModal(false);
                setNotes('');
                setActiveDate('');
                setActiveTime('');
                setSelectedService('');
                showToast('Request submitted! We will assign a caregiver shortly.', 'success');
                fetchBookings(); // Refresh list
            } else {
                showToast('Failed to submit request.', 'error');
            }
        } catch (error) {
            console.error('Error submitting booking', error);
            showToast('An unexpected error occurred.', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    const getStatusStyle = (status: string) => {
        switch (status.toLowerCase()) {
            case 'scheduled': return { color: '#0369a1', bg: '#e0f2fe' };
            case 'requested': return { color: '#92400e', bg: '#fef3c7' };
            case 'completed': return { color: '#065f46', bg: '#ecfdf5' };
            case 'cancelled': return { color: '#991b1b', bg: '#fee2e2' };
            default: return { color: '#374151', bg: '#f3f4f6' };
        }
    };

    return (
        <div style={{ padding: '1rem' }} data-cy="page.container">
            <div style={{ marginBottom: '2rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div data-cy="page.header">
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">My Care Bookings</h2>
                    <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Track all your current and past care requests.</p>
                </div>
                <button
                    data-cy="btn-request-care"
                    onClick={() => setShowModal(true)}
                    style={{
                        backgroundColor: 'var(--pc-primary-dark)',
                        color: 'white',
                        padding: '0.75rem 1.5rem',
                        borderRadius: '0.5rem',
                        border: 'none',
                        cursor: 'pointer',
                        fontWeight: '600'
                    }}
                >
                    + Request Care
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl.bookings">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Service</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Date & Time</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Caregiver</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr>
                                <td colSpan={4} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>Loading your care history...</td>
                            </tr>
                        ) : bookings.length > 0 ? (
                            bookings.map((booking) => {
                                const style = getStatusStyle(booking.status);
                                return (
                                    <tr key={booking.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`row-booking-${booking.id}`}>
                                        <td style={{ padding: '1rem', fontWeight: '500' }}>{booking.service.name}</td>
                                        <td style={{ padding: '1rem', color: '#4b5563' }}>
                                            {new Date(booking.requestedStartAt).toLocaleString([], { dateStyle: 'medium', timeStyle: 'short' })}
                                        </td>
                                        <td style={{ padding: '1rem', color: '#4b5563' }}>
                                            {booking.psw?.fullName || <span style={{ color: '#9ca3af', fontStyle: 'italic' }}>Pending Assignment</span>}
                                        </td>
                                        <td style={{ padding: '1rem' }}>
                                            <span style={{
                                                padding: '0.25rem 0.625rem',
                                                borderRadius: '9999px',
                                                fontSize: '0.75rem',
                                                fontWeight: '600',
                                                backgroundColor: style.bg,
                                                color: style.color,
                                                textTransform: 'uppercase'
                                            }}>
                                                {booking.status}
                                            </span>
                                        </td>
                                    </tr>
                                );
                            })
                        ) : (
                            <tr>
                                <td colSpan={4} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>No bookings found.</td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>

            {/* Simple Modal */}
            {showModal && (
                <div style={{
                    position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
                    backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 50
                }}>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', width: '90%', maxWidth: '500px' }}>
                        <h3 style={{ marginTop: 0, fontSize: '1.25rem' }}>Request New Care Visit</h3>

                        <form onSubmit={handleRequest} style={{ display: 'flex', flexDirection: 'column', gap: '1rem', marginTop: '1rem' }} data-cy="form-booking">
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Service Type</label>
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
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '600', marginBottom: '0.5rem' }}>Notes for Caregiver</label>
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
                                    onClick={() => setShowModal(false)}
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
            )}
        </div>
    );
}
