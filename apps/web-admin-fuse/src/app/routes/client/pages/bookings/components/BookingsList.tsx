import React from 'react';

interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    durationMinutes: number;
    status: string;
    psw?: { fullName: string };
}

interface BookingsListProps {
    bookings: Booking[];
    loading: boolean;
    onCancel: (id: string) => void;
}

const getStatusStyle = (status: string) => {
    switch (status.toLowerCase()) {
        case 'scheduled': return { color: '#0369a1', bg: '#e0f2fe' };
        case 'requested': return { color: '#92400e', bg: '#fef3c7' };
        case 'completed': return { color: '#065f46', bg: '#ecfdf5' };
        case 'cancelled': return { color: '#991b1b', bg: '#fee2e2' };
        default: return { color: '#374151', bg: '#f3f4f6' };
    }
};

export const BookingsList: React.FC<BookingsListProps> = ({ bookings, loading, onCancel }) => {
    return (
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
                                            textTransform: 'uppercase',
                                            marginRight: '1rem'
                                        }}>
                                            {booking.status}
                                        </span>
                                        {['requested', 'scheduled'].includes(booking.status.toLowerCase()) && (
                                            <button
                                                onClick={() => onCancel(booking.id)}
                                                style={{
                                                    padding: '0.25rem 0.75rem',
                                                    fontSize: '0.75rem',
                                                    borderRadius: '4px',
                                                    border: '1px solid #fee2e2',
                                                    backgroundColor: '#fff',
                                                    color: '#991b1b',
                                                    cursor: 'pointer',
                                                    fontWeight: 600
                                                }}
                                                title="Cancel this booking"
                                            >
                                                Cancel
                                            </button>
                                        )}
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
    );
};
