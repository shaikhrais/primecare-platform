// ================================================================
// PAGE IDENTITY: T60 — Open Offers
// Type: Tool | Owner: psw
// ================================================================
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry } from 'prime-care-shared';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { useQueryClient } from '@tanstack/react-query';
import { CardGridSkeleton } from '@/shared/components/ui/Skeleton';

const { ApiRegistry } = AdminRegistry;

export default function OpenOffers() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const queryClient = useQueryClient();

    // TanStack Query: auto-cached shift offers
    const { data: offers = [], isLoading: loading } = useRegistryQuery<any[]>('/v1/psw/schedule/offers', {
        queryKey: ['psw', 'offers'],
        staleTime: 15_000,
    });

    const handleAction = async (id: string, action: 'accept' | 'decline') => {
        try {
            const res = await apiClient.post(`/v1/psw/schedule/offers/${id}/${action}`);
            if (res.ok) {
                showToast(`Offer ${action}ed successfully`, 'success');
                if (action === 'accept') {
                    navigate(AdminRegistry.RouteRegistry.PSW.SCHEDULE);
                } else {
                    // Invalidate query to trigger refetch
                    queryClient.invalidateQueries({ queryKey: ['psw', 'offers'] });
                }
            } else {
                showToast(`Failed to ${action} offer`, 'error');
            }
        } catch (error) {
            showToast(`Error trying to ${action} offer`, 'error');
        }
    };

    if (loading) return <CardGridSkeleton cards={4} />;

    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <h2 data-cy="h2-psw.open-offers-0" style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Personalized Shift Offers</h2>

            {offers.length === 0 ? (
                <div style={{ padding: '3rem', textAlign: 'center', backgroundColor: '#f9fafb', borderRadius: '1rem' }}>
                    <p style={{ color: '#6b7280' }}>No pending offers at the moment. Keep an eye out!</p>
                </div>
            ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))', gap: '1.5rem' }}>
                    {offers.map(offer => (
                        <div key={offer.id} style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', border: '1px solid #e5e7eb' }}>
                            <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'center', marginBottom: '1rem' }}>
                                <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#ecfdf5', color: '#065f46', borderRadius: '9999px', fontSize: '0.75rem', fontWeight: 'bold' }}>OFFER</span>
                                {offer.isSurgeActive && (
                                    <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#FEF2F2', color: '#EF4444', borderRadius: '9999px', fontSize: '0.75rem', fontWeight: 'bold' }}>
                                        🔥 {offer.surgeMultiplier}x SURGE
                                    </span>
                                )}
                                <span style={{ marginLeft: 'auto', color: '#6b7280', fontSize: '0.75rem' }}>Expires soon</span>
                            </div>

                            <h3 data-cy="h3-psw.open-offers-0" style={{ margin: '0 0 0.5rem 0', fontSize: '1.125rem' }}>{offer.service?.name || 'Care Visit'}</h3>
                            <p style={{ margin: '0 0 1rem 0', color: '#4b5563', fontSize: '0.875rem' }}>
                                <strong>Date:</strong> {new Date(offer.requestedStartAt).toLocaleDateString()}<br />
                                <strong>Time:</strong> {new Date(offer.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })} ({offer.durationMinutes} mins)<br />
                                <strong>Client:</strong> {offer.client?.fullName}
                            </p>

                            <div style={{ display: 'flex', gap: '1rem', marginTop: '1.5rem' }}>
                                <button data-cy="btn-psw.open-offers-0"
                                    onClick={() => handleAction(offer.id, 'decline')}
                                    style={{ flex: 1, padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem', backgroundColor: 'transparent', cursor: 'pointer', fontSize: '0.875rem' }}
                                >
                                    Decline
                                </button>
                                <button data-cy="btn-psw.open-offers-1"
                                    onClick={() => handleAction(offer.id, 'accept')}
                                    style={{ flex: 2, padding: '0.75rem', border: 'none', borderRadius: '0.5rem', backgroundColor: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer', fontSize: '0.875rem' }}
                                >
                                    Accept Shift
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
