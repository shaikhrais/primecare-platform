import React, { useEffect, useState } from 'react';

interface Shift {
    id: string;
    clientName: string;
    address: string;
    time: string;
    status: 'scheduled' | 'in_progress' | 'completed';
    service: string;
}

export default function PswDashboard() {
    const [shifts, setShifts] = useState<Shift[]>([]);

    useEffect(() => {
        // Mock data for PSW shifts
        setShifts([
            { id: '1', clientName: 'Bob Wilson', address: '123 Maple St, Toronto', time: 'Today - 9:00 AM to 12:00 PM', status: 'scheduled', service: 'Personal Care' },
            { id: '2', clientName: 'Alice Thorne', address: '456 Oak Rd, Scarborough', time: 'Tomorrow - 1:00 PM to 3:00 PM', status: 'scheduled', service: 'Diabetic Foot Care' },
        ]);
    }, []);

    return (
        <div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>My Work Schedule</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }}>Stay updated on your upcoming assigned care visits.</p>
                </div>
                <div style={{ display: 'flex', gap: '0.75rem' }}>
                    <button style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600' }}>View Calendar</button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '1.5rem' }}>
                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1.5rem' }}>Today's Shifts</h3>
                    {shifts.filter(s => s.time.includes('Today')).length > 0 ? (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                            {shifts.filter(s => s.time.includes('Today')).map(shift => (
                                <div key={shift.id} style={{ padding: '1.25rem', border: '1px solid #e5e7eb', borderRadius: '0.75rem', backgroundColor: '#f9fafb' }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                                        <span style={{ fontWeight: '700', fontSize: '1.1rem', color: '#004d40' }}>{shift.clientName}</span>
                                        <span style={{ color: '#059669', fontWeight: '600', fontSize: '0.875rem' }}>{shift.status.toUpperCase()}</span>
                                    </div>
                                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', color: '#4b5563' }}>
                                        <div style={{ fontSize: '0.9rem' }}>🕒 {shift.time}</div>
                                        <div style={{ fontSize: '0.9rem' }}>📍 {shift.address}</div>
                                        <div style={{ fontSize: '0.9rem' }}>🏥 Service: {shift.service}</div>
                                    </div>
                                    <div style={{ marginTop: '1.25rem', display: 'flex', gap: '1rem' }}>
                                        <button style={{ flex: 1, padding: '0.625rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', fontWeight: '600' }}>Check-In</button>
                                        <button style={{ flex: 1, padding: '0.625rem', backgroundColor: 'white', border: '1px solid #d1d5db', color: '#374151', borderRadius: '0.375rem', fontWeight: '600' }}>View Files</button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p style={{ color: '#6b7280' }}>You have no shifts scheduled for today.</p>
                    )}
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                        <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Shift Notes & Requirements</h3>
                        <p style={{ fontSize: '0.875rem', color: '#6b7280' }}>Please ensure you have all necessary supplies for diabetic foot care visits and record your notes immediately after visit completion.</p>
                    </div>
                    <div style={{ backgroundColor: '#ecfdf5', padding: '1.5rem', borderRadius: '0.75rem', border: '1px solid #059669' }}>
                        <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '0.5rem', color: '#065f46' }}>Compliance Status</h3>
                        <p style={{ fontSize: '0.875rem', color: '#065f46' }}>✅ Your certifications are up to date. Next renewal: June 2026.</p>
                    </div>
                </div>
            </div>
        </div>
    );
}
