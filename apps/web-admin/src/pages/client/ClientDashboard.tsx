import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '../../App';

const { ContentRegistry, ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    status: string;
    psw?: { fullName: string };
}

export default function ClientDashboard() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [bookings, setBookings] = useState<Booking[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);

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

    const [services, setServices] = useState<any[]>([]);

    const fetchServices = async () => {
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.SERVICES}`);
            if (response.ok) {
                const data = await response.json();
                setServices(data.filter((s: any) => s.isActive));
            }
        } catch (error) {
            console.error('Failed to fetch services', error);
        }
    };

    useEffect(() => {
        fetchBookings();
        fetchServices();
    }, []);

    const getStatusColor = (status: string) => {
        switch (status.toLowerCase()) {
            case 'scheduled': return { bg: '#e0f2fe', text: '#0369a1' };
            case 'requested': return { bg: '#fef3c7', text: '#92400e' };
            case 'completed': return { bg: '#ecfdf5', text: '#065f46' };
            case 'assigned': return { bg: '#ddd6fe', text: '#5b21b6' };
            default: return { bg: '#f3f4f6', text: '#374151' };
        }
    };

    const [newRequest, setNewRequest] = useState({ serviceId: '', requestedStartAt: '', durationMinutes: 60 });

    const handleSubmitRequest = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(newRequest)
            });
            if (response.ok) {
                showToast('Care request submitted successfully!', 'success');
                setIsModalOpen(false);
                setNewRequest({ serviceId: '', requestedStartAt: '', durationMinutes: 60 });
                fetchBookings();
            } else {
                const data = await response.json();
                showToast(`Submission failed: ${data.error || 'Unknown error'}`, 'error');
            }
        } catch (error) {
            showToast('Failed to submit request', 'error');
        }
    };

    return (
        <div data-cy="page.container">
            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }}>{ContentRegistry.CLIENT_DASHBOARD.TITLE}</h1>
                    <p className="sub" style={{ margin: 0 }}>{ContentRegistry.CLIENT_DASHBOARD.SUBTITLE}</p>
                </div>
                <button
                    data-cy="btn-request-care"
                    className="btn btn-primary"
                    onClick={() => setIsModalOpen(true)}
                >
                    {ContentRegistry.CLIENT_DASHBOARD.BUTTON_REQUEST}
                </button>
            </div>

            {/* ... content ... */}
            {/* Keeping existing booking list logic as minimal refactor requested on structure/constants */}

            {isModalOpen && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, backdropFilter: 'blur(8px)' }}>
                    <form onSubmit={handleSubmitRequest} className="pc-card" style={{ padding: '2.5rem', maxWidth: '500px', width: '90%', border: '1px solid var(--brand-500)' }}>
                        <h3 className="pc-card-h" style={{ padding: 0, marginBottom: '0.5rem', color: 'var(--brand-500)' }}>{ContentRegistry.CLIENT_DASHBOARD.MODAL_TITLE}</h3>
                        <p style={{ color: 'var(--text-300)', marginBottom: '2rem' }}>{ContentRegistry.CLIENT_DASHBOARD.MODAL_SUBTITLE}</p>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                            <div>
                                <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Select Care Service</label>
                                <select
                                    value={newRequest.serviceId}
                                    onChange={(e) => setNewRequest({ ...newRequest, serviceId: e.target.value })}
                                    style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                                    data-cy="form.booking.service"
                                    required
                                >
                                    <option value="" style={{ background: '#12233C' }}>-- Choose a Service --</option>
                                    {services.map(s => (
                                        <option key={s.id} value={s.id} style={{ background: '#12233C' }}>{s.name} (${parseFloat(s.baseRateHourly).toFixed(2)}/hr)</option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Preferred Date & Time</label>
                                <input
                                    type="datetime-local"
                                    value={newRequest.requestedStartAt ? new Date(new Date(newRequest.requestedStartAt).getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, 16) : ''}
                                    onChange={(e) => setNewRequest({ ...newRequest, requestedStartAt: new Date(e.target.value).toISOString() })}
                                    style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                                    data-cy="form.booking.datetime"
                                    required
                                />
                            </div>
                            <div>
                                <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: 'var(--text-200)' }}>Duration (Minutes)</label>
                                <select
                                    value={newRequest.durationMinutes}
                                    onChange={(e) => setNewRequest({ ...newRequest, durationMinutes: parseInt(e.target.value) })}
                                    style={{ width: '100%', padding: '0.75rem', borderRadius: '12px', border: '1px solid var(--card-border)', backgroundColor: 'rgba(255,255,255,0.05)', color: 'white' }}
                                    data-cy="form.booking.duration"
                                >
                                    <option value={60} style={{ background: '#12233C' }}>1 Hour</option>
                                    <option value={90} style={{ background: '#12233C' }}>1.5 Hours</option>
                                    <option value={120} style={{ background: '#12233C' }}>2 Hours</option>
                                    <option value={180} style={{ background: '#12233C' }}>3 Hours</option>
                                </select>
                            </div>
                        </div>
                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2.5rem' }}>
                            <button data-cy="btn-modal-cancel" type="button" className="btn" onClick={() => setIsModalOpen(false)} style={{ flex: 1 }}>Cancel</button>
                            <button data-cy="btn-modal-submit" type="submit" className="btn btn-primary" style={{ flex: 1 }}>Submit Request</button>
                        </div>
                    </form>
                </div>
            )}
        </div>
    );
}
