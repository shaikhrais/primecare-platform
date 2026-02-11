import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '../../App';

const { ContentRegistry, ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Shift {
    id: string;
    client: { fullName: string };
    serviceAddressLine1: string;
    requestedStartAt: string;
    status: string;
    service: { name: string };
}

export default function PswDashboard() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [shifts, setShifts] = useState<Shift[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchShifts = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setShifts(data);
            }
        } catch (error) {
            console.error('Failed to fetch shifts', error);
            showToast('Failed to load shifts', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleCheckIn = async (id: string) => {
        if (!navigator.geolocation) {
            showToast('Geolocation is not supported by your browser', 'error');
            return;
        }

        navigator.geolocation.getCurrentPosition(async (position) => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_IN(id)}`, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                        accuracy: position.coords.accuracy
                    })
                });
                if (response.ok) {
                    fetchShifts();
                    showToast('Check-in successful!', 'success');
                } else {
                    const data = await response.json();
                    showToast(`Check-in failed: ${data.error || 'Unknown error'}`, 'error');
                }
            } catch (error) {
                showToast('Check-in failed', 'error');
            }
        }, (error) => {
            showToast(`Could not get location: ${error.message}`, 'error');
        });
    };

    const handleCheckOut = async (id: string) => {
        if (!navigator.geolocation) {
            showToast('Geolocation is not supported by your browser', 'error');
            return;
        }

        navigator.geolocation.getCurrentPosition(async (position) => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_OUT(id)}`, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                        accuracy: position.coords.accuracy
                    })
                });
                if (response.ok) {
                    fetchShifts();
                    showToast('Check-out successful! Visit completed.', 'success');
                } else {
                    const data = await response.json();
                    showToast(`Check-out failed: ${data.error || 'Unknown error'}`, 'error');
                }
            } catch (error) {
                showToast('Check-out failed', 'error');
            }
        }, (error) => {
            showToast(`Could not get location: ${error.message}`, 'error');
        });
    };

    useEffect(() => {
        fetchShifts();
    }, []);

    return (
        <div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>{ContentRegistry.PSW_DASHBOARD.TITLE}</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }}>{ContentRegistry.PSW_DASHBOARD.SUBTITLE}</p>
                </div>
                <div style={{ display: 'flex', gap: '0.75rem' }}>
                    <button
                        data-cy="btn-view-all-shifts"
                        onClick={() => navigate('/shifts')}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                    >
                        {ContentRegistry.PSW_DASHBOARD.BUTTON_FULL_SCHEDULE}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '1.5rem' }}>
                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1.5rem' }}>{ContentRegistry.PSW_DASHBOARD.SECTION_SHIFTS}</h3>
                    {loading ? (
                        <p style={{ color: '#6b7280' }}>Loading your upcoming visits...</p>
                    ) : shifts.length > 0 ? (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                            {shifts.map(shift => (
                                <div key={shift.id} data-cy={`shift-card-${shift.id}`} style={{ padding: '12.5rem', border: '1px solid #e5e7eb', borderRadius: '0.75rem', backgroundColor: '#f9fafb' }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                                        <span data-cy="shift-client-name" style={{ fontWeight: '700', fontSize: '1.1rem', color: '#004d40' }}>{shift.client.fullName}</span>
                                        <span data-cy="shift-status" style={{ color: '#059669', fontWeight: '600', fontSize: '0.875rem', textTransform: 'uppercase' }}>{shift.status}</span>
                                    </div>
                                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', color: '#4b5563' }}>
                                        <div data-cy="shift-time" style={{ fontSize: '0.9rem' }}>🕒 {new Date(shift.requestedStartAt).toLocaleString()}</div>
                                        <div data-cy="shift-address" style={{ fontSize: '0.9rem' }}>📍 {shift.serviceAddressLine1}</div>
                                        <div style={{ fontSize: '0.9rem' }}>🏥 Service: {shift.service.name}</div>
                                    </div>
                                    <div style={{ marginTop: '1.25rem', display: 'flex', gap: '1rem' }}>
                                        {shift.status.toLowerCase() !== 'completed' && (
                                            shift.status.toLowerCase() === 'in_progress' ? (
                                                <button
                                                    data-cy="btn-check-out"
                                                    onClick={() => handleCheckOut(shift.id)}
                                                    style={{ flex: 1, padding: '0.625rem', backgroundColor: '#dc2626', color: 'white', border: 'none', borderRadius: '0.375rem', fontWeight: '600' }}
                                                >
                                                    Check-Out
                                                </button>
                                            ) : (
                                                <button
                                                    data-cy="btn-check-in"
                                                    onClick={() => handleCheckIn(shift.id)}
                                                    style={{ flex: 1, padding: '0.625rem', backgroundColor: 'var(--pc-primary-dark)', color: 'white', border: 'none', borderRadius: '0.375rem', fontWeight: '600' }}
                                                >
                                                    Check-In
                                                </button>
                                            )
                                        )}
                                        <button data-cy="btn-view-files" style={{ flex: 1, padding: '0.625rem', backgroundColor: 'white', border: '1px solid #d1d5db', color: '#374151', borderRadius: '0.375rem', fontWeight: '600' }}>View Files</button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p style={{ color: '#6b7280' }}>You have no shifts scheduled at this time.</p>
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
