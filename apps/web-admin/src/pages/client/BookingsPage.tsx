import React, { useState, useEffect } from 'react';

const API_URL = import.meta.env.VITE_API_URL;

interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    durationMinutes: number;
    status: string;
    psw?: { fullName: string };
}

export default function BookingsPage() {
    const [bookings, setBookings] = useState<Booking[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchBookings = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/client/bookings`, {
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

    useEffect(() => {
        fetchBookings();
    }, []);

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
        <div style={{ padding: '1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>My Care Bookings</h2>
                <p style={{ color: '#6b7280' }}>Track all your current and past care requests.</p>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
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
                                    <tr key={booking.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
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
        </div>
    );
}
