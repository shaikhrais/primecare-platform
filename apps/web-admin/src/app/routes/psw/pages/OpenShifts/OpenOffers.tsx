import React, { useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;

export default function OpenOffers() {
    const { showToast } = useNotification();
    const [offers, setOffers] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchOffers = async () => {
        setLoading(true);
        try {
            const res = await apiClient.get('/v1/psw/schedule/offers');
            if (res.ok) {
                setOffers(await res.json());
            }
        } catch (error) {
            console.error('Failed to fetch offers', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchOffers();
    }, []);

    const handleAction = async (id: string, action: 'accept' | 'decline') => {
        try {
            const res = await apiClient.post(`/v1/psw/schedule/offers/${id}/${action}`);
            if (res.ok) {
                showToast(`Offer ${action}ed successfully`, 'success');
                fetchOffers();
            } else {
                showToast(`Failed to ${action} offer`, 'error');
            }
        } catch (error) {
            showToast(`Error trying to ${action} offer`, 'error');
        }
    };

    if (loading) return <div style={{ padding: '2rem' }}>Loading offers...</div>;

    return (
        <div style={{ padding: '2rem' }}>
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Personalized Shift Offers</h2>

            {offers.length === 0 ? (
                <div style={{ padding: '3rem', textAlign: 'center', backgroundColor: '#f9fafb', borderRadius: '1rem' }}>
                    <p style={{ color: '#6b7280' }}>No pending offers at the moment. Keep an eye out!</p>
                </div>
            ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))', gap: '1.5rem' }}>
                    {offers.map(offer => (
                        <div key={offer.id} style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', border: '1px solid #e5e7eb' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
                                <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#ecfdf5', color: '#065f46', borderRadius: '9999px', fontSize: '0.75rem', fontWeight: 'bold' }}>OFFER</span>
                                <span style={{ color: '#6b7280', fontSize: '0.75rem' }}>Expires soon</span>
                            </div>

                            <h3 style={{ margin: '0 0 0.5rem 0', fontSize: '1.125rem' }}>{offer.visit.service?.name || 'Care Visit'}</h3>
                            <p style={{ margin: '0 0 1rem 0', color: '#4b5563', fontSize: '0.875rem' }}>
                                <strong>Date:</strong> {new Date(offer.visit.requestedStartAt).toLocaleDateString()}<br />
                                <strong>Time:</strong> {new Date(offer.visit.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })} ({offer.visit.durationMinutes} mins)<br />
                                <strong>Client:</strong> {offer.visit.client?.fullName}
                            </p>

                            <div style={{ display: 'flex', gap: '1rem', marginTop: '1.5rem' }}>
                                <button
                                    onClick={() => handleAction(offer.id, 'decline')}
                                    style={{ flex: 1, padding: '0.75rem', border: '1px solid #d1d5db', borderRadius: '0.5rem', backgroundColor: 'transparent', cursor: 'pointer', fontSize: '0.875rem' }}
                                >
                                    Decline
                                </button>
                                <button
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
