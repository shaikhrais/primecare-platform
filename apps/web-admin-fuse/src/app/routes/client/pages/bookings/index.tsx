import React, { useState, useEffect } from 'react';
import { ApiRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';

// Components
import { BookingsList } from './components/BookingsList';
import { BookingRequestModal } from './components/BookingRequestModal';

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

    const handleRequest = async (data: any) => {
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const requestedStartAt = new Date(`${data.activeDate}T${data.activeTime}`).toISOString();

            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    serviceId: data.selectedService,
                    requestedStartAt,
                    durationMinutes: Number(data.duration),
                    notes: data.notes
                })
            });

            if (response.ok) {
                setShowModal(false);
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

    const handleCancel = async (bookingId: string) => {
        if (!window.confirm('Are you sure you want to cancel this booking?')) return;

        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/client/bookings/${bookingId}/cancel`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}` }
            });

            if (response.ok) {
                showToast('Booking cancelled successfully', 'success');
                fetchBookings();
            } else {
                showToast('Failed to cancel booking', 'error');
            }
        } catch (error) {
            console.error('Error cancelling booking', error);
            showToast('Error cancelling booking', 'error');
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

            <BookingsList
                bookings={bookings}
                loading={loading}
                onCancel={handleCancel}
            />

            <BookingRequestModal
                isOpen={showModal}
                onClose={() => setShowModal(false)}
                onSubmit={handleRequest}
                services={services}
                submitting={submitting}
            />
        </div>
    );
}
