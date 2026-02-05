import React, { useEffect, useState } from 'react';

interface Booking {
    id: string;
    serviceName: string;
    date: string;
    status: 'requested' | 'scheduled' | 'in_progress' | 'completed';
    caregiver?: string;
}

export default function ClientDashboard() {
    const [bookings, setBookings] = useState<Booking[]>([]);

    useEffect(() => {
        // Mock data for client bookings
        setBookings([
            { id: '1', serviceName: 'Diabetic Foot Care', date: 'Feb 10, 2026 - 10:00 AM', status: 'scheduled', caregiver: 'Jane Cooper' },
            { id: '2', serviceName: 'Personal Care', date: 'Feb 12, 2026 - 2:00 PM', status: 'requested' },
        ]);
    }, []);

    const getStatusColor = (status: string) => {
        switch (status) {
            case 'scheduled': return { bg: '#e0f2fe', text: '#0369a1' };
            case 'requested': return { bg: '#fef3c7', text: '#92400e' };
            case 'completed': return { bg: '#ecfdf5', text: '#065f46' };
            default: return { bg: '#f3f4f6', text: '#374151' };
        }
    };

    return (
        <div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>My Care Hub</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }}>Welcome back to your family care portal.</p>
                </div>
                <button style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}>
                    Request New Care
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Upcoming Visits</h3>
                    {bookings.length > 0 ? (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                            {bookings.map(booking => {
                                const colors = getStatusColor(booking.status);
                                return (
                                    <div key={booking.id} style={{ padding: '1rem', border: '1px solid #f3f4f6', borderRadius: '0.5rem' }}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                                            <span style={{ fontWeight: '600' }}>{booking.serviceName}</span>
                                            <span style={{ fontSize: '0.75rem', padding: '0.25rem 0.5rem', borderRadius: '9999px', backgroundColor: colors.bg, color: colors.text }}>
                                                {booking.status.toUpperCase()}
                                            </span>
                                        </div>
                                        <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>📅 {booking.date}</div>
                                        {booking.caregiver && <div style={{ fontSize: '0.875rem', color: '#6b7280', marginTop: '0.25rem' }}>👤 Caregiver: {booking.caregiver}</div>}
                                    </div>
                                );
                            })}
                        </div>
                    ) : (
                        <p style={{ color: '#6b7280' }}>No upcoming visits scheduled.</p>
                    )}
                </div>

                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Quick Support</h3>
                    <p style={{ fontSize: '0.875rem', color: '#374151', marginBottom: '1.5rem' }}>Need to talk to a care coordinator or adjust your schedule?</p>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                        <button style={{ width: '100%', padding: '0.75rem', border: '1px solid #004d40', color: '#004d40', backgroundColor: 'transparent', borderRadius: '0.5rem', fontWeight: '600' }}>Message Support</button>
                        <button style={{ width: '100%', padding: '0.75rem', border: 'none', color: 'white', backgroundColor: '#004d40', borderRadius: '0.5rem', fontWeight: '600' }}>Call PrimeCare</button>
                    </div>
                </div>
            </div>
        </div>
    );
}
