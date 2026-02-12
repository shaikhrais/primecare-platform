import React, { useState, useEffect } from 'react';
import { ApiRegistry } from 'prime-care-shared';
import { useNotification } from '../../context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function EarningsPage() {
    const { showToast } = useNotification();
    const [visits, setVisits] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [requesting, setRequesting] = useState(false);
    const hourlyRate = 25; // Default for simulation

    useEffect(() => {
        const fetchVisits = async () => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                const data = await response.json();
                setVisits(data.filter((v: any) => v.status === 'completed'));
            } catch (error) {
                console.error('Failed to fetch visits');
                showToast('Failed to load earnings data', 'error');
            } finally {
                setLoading(false);
            }
        };
        fetchVisits();
    }, []);

    const calculateEarnings = (duration: number) => {
        return (duration / 60) * hourlyRate;
    };

    const totalEarnings = visits.reduce((acc, v) => acc + calculateEarnings(v.durationMinutes || 60), 0);

    const handlePayout = async () => {
        if (totalEarnings === 0) {
            showToast('No earnings available to payout.', 'info');
            return;
        }
        if (!confirm('Request payout for verified earnings?')) return;

        setRequesting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.PSW.PAYOUT_REQUEST}`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                showToast(data.message || 'Payout requested successfully!', 'success');
            } else {
                showToast('Failed to request payout.', 'error');
            }
        } catch (error) {
            console.error('Payout Request Error', error);
            showToast('Error processing payout request.', 'error');
        } finally {
            setRequesting(false);
        }
    };

    return (
        <div style={{ maxWidth: '900px', margin: '0 auto', padding: '1rem' }} data-cy="psw-earnings-page">
            <div style={{ marginBottom: '2rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">My Earnings</h2>
                    <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Track your revenue from completed care shifts.</p>
                </div>
                <div style={{ backgroundColor: '#ecfdf5', padding: '1.5rem', borderRadius: '1rem', textAlign: 'right', border: '1px solid #c2ffd9' }}>
                    <span style={{ fontSize: '0.875rem', color: '#065f46', textTransform: 'uppercase', fontWeight: 'bold' }}>Total Withdrawable</span>
                    <div data-cy="txt-total-earnings" style={{ fontSize: '2rem', fontWeight: '900', color: '#004d40' }}>${totalEarnings.toFixed(2)}</div>
                </div>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Date</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Service</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Duration</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Earnings</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center' }}>Loading shift data...</td></tr>
                        ) : visits.length > 0 ? (
                            visits.map((v) => (
                                <tr key={v.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy="earnings-row">
                                    <td style={{ padding: '1rem' }}>{new Date(v.requestedStartAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1rem' }}>{v.service.name}</td>
                                    <td style={{ padding: '1rem' }}>{v.durationMinutes || 60} mins</td>
                                    <td style={{ padding: '1rem', fontWeight: '600' }}>${calculateEarnings(v.durationMinutes || 60).toFixed(2)}</td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No completed shifts found yet.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>

            <div style={{ marginTop: '2rem', textAlign: 'center' }}>
                <button
                    data-cy="btn-request-payout"
                    onClick={handlePayout}
                    disabled={requesting || totalEarnings === 0}
                    style={{
                        padding: '0.75rem 2rem',
                        backgroundColor: requesting || totalEarnings === 0 ? '#9ca3af' : '#004d40',
                        color: 'white',
                        border: 'none',
                        borderRadius: '0.5rem',
                        fontWeight: '600',
                        cursor: requesting || totalEarnings === 0 ? 'not-allowed' : 'pointer'
                    }}>
                    {requesting ? 'Processing...' : 'Request Payout'}
                </button>
            </div>
        </div>
    );
}
