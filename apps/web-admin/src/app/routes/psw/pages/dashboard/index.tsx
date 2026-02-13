import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';

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
    const isMobile = useMediaQuery('(max-width: 1024px)');

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
        <div data-cy="page.container" style={{ padding: isMobile ? '0' : '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{
                display: 'flex',
                flexDirection: isMobile ? 'column' : 'row',
                justifyContent: 'space-between',
                alignItems: isMobile ? 'flex-start' : 'flex-end',
                gap: '1.5rem',
                marginBottom: '2.5rem'
            }}>
                <div>
                    <h1 data-cy="page.title" style={{ margin: '0', fontSize: isMobile ? '2rem' : '2.5rem', fontWeight: 800, color: '#000000', lineHeight: 1.1 }}>
                        {ContentRegistry.PSW_DASHBOARD.TITLE}
                    </h1>
                    <p data-cy="page.subtitle" style={{ margin: '12px 0 0 0', color: '#4B5563', fontSize: isMobile ? '1rem' : '1.1rem' }}>
                        {ContentRegistry.PSW_DASHBOARD.SUBTITLE}
                    </p>
                </div>
                <button
                    data-cy="btn-view-all-shifts"
                    onClick={() => navigate('/shifts')}
                    style={{
                        padding: '12px 24px',
                        backgroundColor: '#000000',
                        color: '#FFFFFF',
                        border: 'none',
                        borderRadius: '8px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        width: isMobile ? '100%' : 'auto'
                    }}
                >
                    {ContentRegistry.PSW_DASHBOARD.BUTTON_FULL_SCHEDULE}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: isMobile ? '1fr' : '1fr 350px', gap: '2rem' }}>
                <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
                    <div data-cy="section.shifts" style={{ padding: '20px 24px', borderBottom: '1px solid #E5E7EB', fontWeight: 700, fontSize: '1.2rem' }}>
                        {ContentRegistry.PSW_DASHBOARD.SECTION_SHIFTS}
                    </div>
                    <div style={{ padding: isMobile ? '16px' : '24px' }}>
                        {loading ? (
                            <p style={{ color: '#6B7280' }}>Loading your upcoming visits...</p>
                        ) : shifts.length > 0 ? (
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                                {shifts.map(shift => (
                                    <div key={shift.id} data-cy={`shift-card-${shift.id}`} style={{
                                        padding: '20px',
                                        border: '1px solid #E5E7EB',
                                        borderRadius: '12px',
                                        backgroundColor: '#F9FAFB'
                                    }}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem', alignItems: 'flex-start' }}>
                                            <div>
                                                <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800, color: '#000000' }}>
                                                    {shift.client.fullName}
                                                </h3>
                                                <div style={{ color: '#00875A', fontWeight: 600, fontSize: '0.85rem', marginTop: '4px' }}>
                                                    🏥 {shift.service.name}
                                                </div>
                                            </div>
                                            <span data-cy="shift-status" style={{
                                                color: '#00875A',
                                                fontWeight: 800,
                                                fontSize: '0.65rem',
                                                textTransform: 'uppercase',
                                                letterSpacing: '0.5px',
                                                background: '#E6F4EF',
                                                padding: '4px 10px',
                                                borderRadius: '20px'
                                            }}>
                                                {shift.status}
                                            </span>
                                        </div>

                                        <div data-cy="shift-details" style={{ display: 'grid', gridTemplateColumns: isMobile ? '1fr' : '1fr 1fr', gap: '1rem', color: '#374151', fontSize: '0.9rem' }}>
                                            <div>
                                                <strong style={{ display: 'block', color: '#6B7280', fontSize: '0.7rem', textTransform: 'uppercase', marginBottom: '4px' }}>Time</strong>
                                                🕒 {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                            </div>
                                            <div>
                                                <strong style={{ display: 'block', color: '#6B7280', fontSize: '0.7rem', textTransform: 'uppercase', marginBottom: '4px' }}>Location</strong>
                                                📍 {shift.serviceAddressLine1}
                                            </div>
                                        </div>

                                        <div style={{ marginTop: '1.5rem', display: 'flex', flexDirection: isMobile ? 'column' : 'row', gap: '0.75rem' }}>
                                            {shift.status.toLowerCase() !== 'completed' && (
                                                <button
                                                    data-cy={shift.status.toLowerCase() === 'in_progress' ? "btn-check-out" : "btn-check-in"}
                                                    onClick={() => shift.status.toLowerCase() === 'in_progress' ? handleCheckOut(shift.id) : handleCheckIn(shift.id)}
                                                    style={{
                                                        flex: 1,
                                                        padding: '12px',
                                                        backgroundColor: shift.status.toLowerCase() === 'in_progress' ? '#EF4444' : '#00875A',
                                                        color: 'white',
                                                        border: 'none',
                                                        borderRadius: '8px',
                                                        fontWeight: '700',
                                                        cursor: 'pointer'
                                                    }}
                                                >
                                                    {shift.status.toLowerCase() === 'in_progress' ? 'Finish Visit' : 'Check-In Now'}
                                                </button>
                                            )}
                                            <button data-cy="btn-view-files" style={{
                                                flex: 1,
                                                padding: '12px',
                                                backgroundColor: '#FFFFFF',
                                                color: '#000000',
                                                border: '1px solid #E5E7EB',
                                                borderRadius: '8px',
                                                fontWeight: '600',
                                                cursor: 'pointer'
                                            }}>View Files</button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        ) : (
                            <p style={{ color: '#6B7280' }}>You have no shifts scheduled today.</p>
                        )}
                    </div>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <div data-cy="section.notes" style={{ backgroundColor: '#000000', color: '#FFFFFF', padding: '24px', borderRadius: '16px' }}>
                        <h3 style={{ margin: '0 0 12px 0', fontSize: '1.1rem', fontWeight: 800 }}>Visit Protocol</h3>
                        <p style={{ fontSize: '0.9rem', lineHeight: 1.6, opacity: 0.9, margin: 0 }}>
                            Please ensure you have all necessary supplies for diabetic foot care visits and record your notes immediately after visit completion.
                        </p>
                    </div>

                    <div data-cy="section.compliance" style={{ backgroundColor: '#E6F4EF', border: '1px solid #00875A', padding: '24px', borderRadius: '16px' }}>
                        <h3 style={{ margin: '0 0 12px 0', color: '#00875A', fontSize: '1.1rem', fontWeight: 800 }}>Compliance</h3>
                        <p style={{ fontSize: '0.875rem', color: '#000000', fontWeight: 600, margin: 0 }}>
                            ✅ Your certifications are active.<br />
                            <span style={{ fontSize: '0.8rem', fontWeight: 400, opacity: 0.7 }}>Next renewal: June 2026.</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
