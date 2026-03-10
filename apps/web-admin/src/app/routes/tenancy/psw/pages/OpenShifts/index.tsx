import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import EmptyState from '@/shared/components/layout/EmptyState';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface OpenShift {
    id: string;
    client: { city: string; postalCode?: string }; // Anonymized for open shifts
    service: { name: string };
    requestedStartAt: string;
    durationMinutes: number;
    status: string;
    serviceAddressLine1: string; // Maybe show partial or just general area?
}

export default function OpenShifts() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [shifts, setShifts] = useState<OpenShift[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchOpenShifts = async () => {
        setLoading(true);
        try {
            // Using a new endpoint convention, logic needs to be backend supported
            // For now, assuming GET /v1/psw/visits/open exists or similar
            // If not, we might need to mock or reuse an existing one with filters
            const response = await apiClient.get('/v1/psw/visits/open');

            if (response.ok) {
                const data = await response.json();
                setShifts(Array.isArray(data) ? data : []);
            } else {
                // Fallback strictly for demo if endpoint doesn't exist yet
                setShifts([]);
            }
        } catch (error) {
            console.error('Failed to fetch open shifts', error);
            showToast('Failed to load open shifts', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleAcceptShift = async (visitId: string) => {
        try {
            const response = await apiClient.post(`/v1/psw/visits/${visitId}/accept`, {});
            if (response.ok) {
                showToast('Shift accepted successfully!', 'success');
                fetchOpenShifts(); // Refresh list
                // Optionally navigate to schedule
                // navigate(AdminRegistry.RouteRegistry.PSW.SCHEDULE);
            } else {
                const err = await response.json();
                showToast(err.error || 'Failed to accept shift', 'error');
            }
        } catch (error) {
            showToast('Error accepting shift', 'error');
        }
    };

    useEffect(() => {
        fetchOpenShifts();
    }, []);

    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h1 style={{ fontSize: '2rem', fontWeight: 800, margin: 0 }}>Open Shifts</h1>
                <p style={{ color: '#6b7280', marginTop: '0.5rem' }}>Browse and accept available shifts in your area.</p>
            </div>

            {loading ? (
                <div style={{ display: 'flex', justifyContent: 'center', padding: '3rem' }}>
                    <p style={{ color: '#6b7280' }}>Loading available shifts...</p>
                </div>
            ) : shifts.length > 0 ? (
                <div style={{ display: 'grid', gap: '1.5rem', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))' }}>
                    {shifts.map(shift => (
                        <div key={shift.id} style={{
                            backgroundColor: '#FFFFFF',
                            padding: '1.5rem',
                            borderRadius: '12px',
                            border: '1px solid #E5E7EB',
                            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03)',
                            display: 'flex',
                            flexDirection: 'column'
                        }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
                                <span style={{
                                    backgroundColor: '#e0f2fe',
                                    color: '#0369a1',
                                    padding: '4px 12px',
                                    borderRadius: '999px',
                                    fontWeight: 600,
                                    fontSize: '0.75rem'
                                }}>
                                    {shift.service?.name || 'Service'}
                                </span>
                                <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                                    {shift.durationMinutes} min
                                </span>
                            </div>

                            <h3 style={{ margin: '0 0 0.5rem 0', fontSize: '1.1rem' }}>
                                {new Date(shift.requestedStartAt).toLocaleDateString(undefined, { weekday: 'short', month: 'short', day: 'numeric' })}
                            </h3>
                            <p style={{ margin: '0 0 1rem 0', fontSize: '1.25rem', fontWeight: 700 }}>
                                {new Date(shift.requestedStartAt).toLocaleTimeString(undefined, { hour: '2-digit', minute: '2-digit' })}
                            </p>

                            <div style={{ marginBottom: '1.5rem', color: '#4b5563', fontSize: '0.9rem' }}>
                                📍 {shift.client?.city || 'Unknown City'}
                            </div>

                            <div style={{ marginTop: 'auto', paddingTop: '1rem' }}>
                                <button
                                    onClick={() => handleAcceptShift(shift.id)}
                                    style={{
                                        width: '100%',
                                        padding: '12px',
                                        backgroundColor: 'var(--brand-500, #0f172a)',
                                        color: '#FFFFFF',
                                        border: 'none',
                                        borderRadius: '8px',
                                        fontWeight: 600,
                                        cursor: 'pointer',
                                        transition: 'opacity 0.2s',
                                        boxShadow: '0 1px 2px 0 rgba(0, 0, 0, 0.05)'
                                    }}
                                    onMouseOver={(e) => e.currentTarget.style.opacity = '0.9'}
                                    onMouseOut={(e) => e.currentTarget.style.opacity = '1'}
                                >
                                    Accept Shift
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            ) : (
                <EmptyState
                    title="No Open Shifts Available"
                    description="There are currently no unfilled shifts in your service area. Please check back later for new opportunities."
                    actionLabel="View My Schedule"
                    onAction={() => navigate(AdminRegistry.RouteRegistry.PSW.SCHEDULE)}
                />
            )}
        </div>
    );
}
