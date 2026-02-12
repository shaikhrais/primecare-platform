import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '../../context/NotificationContext';

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
        <div data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 data-cy="page.title" style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }}>{ContentRegistry.PSW_DASHBOARD.TITLE}</h1>
                    <p data-cy="page.subtitle" className="sub" style={{ margin: 0 }}>{ContentRegistry.PSW_DASHBOARD.SUBTITLE}</p>
                </div>
                <div style={{ display: 'flex', gap: '0.75rem' }}>
                    <button
                        data-cy="btn-view-all-shifts"
                        className="btn btn-primary"
                        onClick={() => navigate('/shifts')}
                    >
                        {ContentRegistry.PSW_DASHBOARD.BUTTON_FULL_SCHEDULE}
                    </button>
                </div>
            </div>

            <div className="grid">
                <div className="pc-card strip">
                    <div data-cy="section.shifts" className="pc-card-h">{ContentRegistry.PSW_DASHBOARD.SECTION_SHIFTS}</div>
                    <div className="pc-card-b">
                        {loading ? (
                            <p style={{ color: 'var(--text-300)' }}>Loading your upcoming visits...</p>
                        ) : shifts.length > 0 ? (
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem', marginTop: '1rem' }}>
                                {shifts.map(shift => (
                                    <div key={shift.id} data-cy={`shift-card-${shift.id}`} style={{ padding: '1.5rem', border: '1px solid var(--card-border)', borderRadius: '14px', backgroundColor: 'rgba(255,255,255,0.03)' }}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                                            <span data-cy="shift-client-name" style={{ fontWeight: '900', fontSize: '1.1rem', color: 'var(--brand-500)', letterSpacing: '.2px' }}>{shift.client.fullName}</span>
                                            <span data-cy="shift-status" style={{ color: 'var(--success-600)', fontWeight: '900', fontSize: '0.7rem', textTransform: 'uppercase', letterSpacing: '1px', background: 'rgba(24, 160, 127, 0.1)', padding: '4px 10px', borderRadius: '8px' }}>{shift.status}</span>
                                        </div>
                                        <div data-cy="shift-details" style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', color: 'var(--text-200)' }}>
                                            <div data-cy="shift-time" style={{ fontSize: '0.9rem' }}>🕒 {new Date(shift.requestedStartAt).toLocaleString()}</div>
                                            <div data-cy="shift-address" style={{ fontSize: '0.9rem' }}>📍 {shift.serviceAddressLine1}</div>
                                            <div style={{ fontSize: '0.9rem' }}>🏥 Service: {shift.service.name}</div>
                                        </div>
                                        <div style={{ marginTop: '1.5rem', display: 'flex', gap: '1rem' }}>
                                            {shift.status.toLowerCase() !== 'completed' && (
                                                <button
                                                    data-cy={shift.status.toLowerCase() === 'in_progress' ? "btn-check-out" : "btn-check-in"}
                                                    onClick={() => shift.status.toLowerCase() === 'in_progress' ? handleCheckOut(shift.id) : handleCheckIn(shift.id)}
                                                    className={`btn ${shift.status.toLowerCase() === 'in_progress' ? 'btn-danger' : 'btn-primary'}`}
                                                    style={{ flex: 1 }}
                                                >
                                                    {shift.status.toLowerCase() === 'in_progress' ? 'Check-Out' : 'Check-In'}
                                                </button>
                                            )}
                                            <button data-cy="btn-view-files" className="btn" style={{ flex: 1 }}>View Files</button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        ) : (
                            <p style={{ color: 'var(--text-300)' }}>You have no shifts scheduled at this time.</p>
                        )}
                    </div>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <div data-cy="section.notes" className="pc-card">
                        <div className="pc-card-h">Shift Notes & Requirements</div>
                        <div className="pc-card-b">
                            <p style={{ fontSize: '0.875rem', margin: 0 }}>Please ensure you have all necessary supplies for diabetic foot care visits and record your notes immediately after visit completion.</p>
                        </div>
                    </div>
                    <div data-cy="section.compliance" className="pc-card" style={{ border: '1px solid var(--success-600)', background: 'rgba(24, 160, 127, 0.05)' }}>
                        <div className="pc-card-h" style={{ color: 'var(--success-600)' }}>Compliance Status</div>
                        <div className="pc-card-b">
                            <p style={{ fontSize: '0.875rem', color: 'var(--text-100)', margin: 0 }}>✅ Your certifications are up to date. Next renewal: June 2026.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
