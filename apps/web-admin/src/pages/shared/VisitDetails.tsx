import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';

const API_URL = import.meta.env.VITE_API_URL;

export default function VisitDetails() {
    const { id } = useParams();
    const [visit, setVisit] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const role = user.role;

    useEffect(() => {
        const fetchVisit = async () => {
            try {
                const token = localStorage.getItem('token');
                let endpoint = '/v1/admin/visits';
                if (role === 'client') endpoint = '/v1/client/bookings';
                if (role === 'psw') endpoint = '/v1/psw/visits';

                const res = await fetch(`${API_URL}${endpoint}`, {
                    headers: { Authorization: `Bearer ${token}` }
                });
                const data = await res.json();
                const found = data.find((v: any) => v.id === id);
                setVisit(found);
            } catch (err) {
                console.error(err);
            } finally {
                setLoading(false);
            }
        };
        fetchVisit();
    }, [id, role]);

    if (loading) return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading visit details...</div>;
    if (!visit) return <div style={{ padding: '2rem', textAlign: 'center' }}>Visit not found.</div>;

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '1rem' }} data-cy="visit-details-page">
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Visit Profile</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Tracking ID: <span data-cy="visit-id">{visit.id}</span></p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Client Information</h3>
                    <p><strong>Name:</strong> {visit.client.fullName}</p>
                    <p><strong>Address:</strong> {visit.client.addressLine1}</p>
                </div>

                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Caregiver Information</h3>
                    {visit.psw ? (
                        <>
                            <p><strong>Name:</strong> {visit.psw.fullName}</p>
                            <span style={{ fontSize: '0.875rem', color: '#059669', backgroundColor: '#ecfdf5', padding: '0.25rem 0.5rem', borderRadius: '0.25rem' }}>Verified Worker</span>
                        </>
                    ) : (
                        <p style={{ color: '#dc2626' }}>Not yet assigned.</p>
                    )}
                </div>

                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', gridColumn: 'span 2' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Operational Details</h3>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '1rem' }}>
                        <div>
                            <span style={{ display: 'block', fontSize: '0.75rem', color: '#6b7280', textTransform: 'uppercase' }}>Status</span>
                            <span style={{ fontWeight: '600' }} data-cy="visit-status">{visit.status.toUpperCase()}</span>
                        </div>
                        <div>
                            <span style={{ display: 'block', fontSize: '0.75rem', color: '#6b7280', textTransform: 'uppercase' }}>Service</span>
                            <span style={{ fontWeight: '600' }}>{visit.service.name}</span>
                        </div>
                        <div>
                            <span style={{ display: 'block', fontSize: '0.75rem', color: '#6b7280', textTransform: 'uppercase' }}>Scheduled At</span>
                            <span style={{ fontWeight: '600' }}>{new Date(visit.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                        </div>
                    </div>
                </div>

                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', gridColumn: 'span 2' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>Logs & Notes</h3>
                    <div style={{ borderLeft: '2px solid #e5e7eb', paddingLeft: '1.5rem', marginLeft: '0.5rem' }}>
                        <div style={{ marginBottom: '1rem' }}>
                            <span style={{ fontSize: '0.75rem', color: '#6b7280' }}>Request Logged</span>
                            <p style={{ margin: 0 }}>System: New care request received from client.</p>
                        </div>
                        {visit.status === 'scheduled' && (
                            <div style={{ marginBottom: '1rem' }}>
                                <span style={{ fontSize: '0.75rem', color: '#6b7280' }}>Assignment Logic</span>
                                <p style={{ margin: 0 }}>Admin: Assigned to {visit.psw?.fullName}.</p>
                            </div>
                        )}
                        <p style={{ fontSize: '0.875rem', color: '#9ca3af', fontStyle: 'italic' }}>GPS check-in logs will appear here once visit begins.</p>
                    </div>
                </div>
            </div>
        </div>
    );
}
