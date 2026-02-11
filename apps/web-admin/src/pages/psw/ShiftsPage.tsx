import React, { useState, useEffect } from 'react';

const API_URL = import.meta.env.VITE_API_URL;

interface Shift {
    id: string;
    client: { fullName: string; addressLine1: string; city: string };
    service: { name: string };
    requestedStartAt: string;
    status: string;
}

export default function ShiftsPage() {
    const [shifts, setShifts] = useState<Shift[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchShifts = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/psw/visits`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setShifts(data);
            }
        } catch (error) {
            console.error('Failed to fetch shifts', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchShifts();
    }, []);

    const getStatusStyle = (status: string) => {
        switch (status.toLowerCase()) {
            case 'scheduled': return { color: '#0369a1', bg: '#e0f2fe' };
            case 'in_progress': return { color: '#065f46', bg: '#ecfdf5' };
            case 'completed': return { color: '#1e293b', bg: '#f1f5f9' };
            default: return { color: '#374151', bg: '#f3f4f6' };
        }
    };

    return (
        <div style={{ padding: '1rem' }} data-cy="page.container">
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">My Shift History</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.header">Review all your assigned and completed care visits.</p>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl-shift-history">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Client</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Location</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Date & Time</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Service</th>
                            <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr>
                                <td colSpan={5} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>Loading your shifts...</td>
                            </tr>
                        ) : shifts.length > 0 ? (
                            shifts.map((shift) => {
                                const style = getStatusStyle(shift.status);
                                return (
                                    <tr key={shift.id} data-cy={`shift-row-${shift.id}`} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                        <td style={{ padding: '1rem', fontWeight: '500' }} data-cy="shift-client">{shift.client.fullName}</td>
                                        <td style={{ padding: '1rem', color: '#4b5563', fontSize: '0.875rem' }}>
                                            {shift.client.addressLine1}, {shift.client.city}
                                        </td>
                                        <td style={{ padding: '1rem', color: '#4b5563' }} data-cy="shift-date">
                                            {new Date(shift.requestedStartAt).toLocaleString([], { dateStyle: 'medium', timeStyle: 'short' })}
                                        </td>
                                        <td style={{ padding: '1rem', color: '#4b5563' }} data-cy="shift-service">{shift.service.name}</td>
                                        <td style={{ padding: '1rem' }}>
                                            <span data-cy="shift-status" style={{
                                                padding: '0.25rem 0.625rem',
                                                borderRadius: '9999px',
                                                fontSize: '0.75rem',
                                                fontWeight: '600',
                                                backgroundColor: style.bg,
                                                color: style.color,
                                                textTransform: 'uppercase'
                                            }}>
                                                {shift.status}
                                            </span>
                                        </td>
                                    </tr>
                                );
                            })
                        ) : (
                            <tr>
                                <td colSpan={5} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>No shifts assigned.</td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
