import React, { useState, useEffect } from 'react';
import { ApiRegistry, AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useNavigate } from 'react-router-dom';

const API_URL = import.meta.env.VITE_API_URL;
const CONTENT = ContentRegistry.PSW_PAYOUTS;

export default function EarningsPage() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [visits, setVisits] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [requesting, setRequesting] = useState(false);
    const hourlyRate = 25;

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
                showToast('Failed to load earnings data', 'error');
            } finally {
                setLoading(false);
            }
        };
        fetchVisits();
    }, []);

    const calculateEarnings = (duration: number) => (duration / 60) * hourlyRate;
    const totalEarnings = visits.reduce((acc, v) => acc + calculateEarnings(v.durationMinutes || 60), 0);

    const handlePayout = async () => {
        if (totalEarnings === 0) {
            showToast('No earnings available to payout.', 'info');
            return;
        }
        setRequesting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.PSW.PAYOUT_REQUEST}`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                showToast(CONTENT.SUCCESS_REQUEST, 'success');
            } else {
                showToast(CONTENT.ERROR_REQUEST, 'error');
            }
        } catch (error) {
            showToast('Error processing payout request.', 'error');
        } finally {
            setRequesting(false);
        }
    };

    return (
        <div style={{ maxWidth: '1000px', margin: '2rem auto', padding: '0 1.5rem' }}>
            <div style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'end',
                marginBottom: '4rem'
            }}>
                <div>
                    <h1 style={{ fontSize: '3rem', fontWeight: 900, color: '#1a237e', marginBottom: '0.5rem' }}>{CONTENT.TITLE}</h1>
                    <p style={{ color: '#546e7a', fontSize: '1.1rem' }}>{CONTENT.SUBTITLE}</p>
                </div>

                <div style={{ textAlign: 'right' }}>
                    <button
                        onClick={() => navigate(AdminRegistry.RouteRegistry.PSW.PAYOUTS)}
                        style={{
                            padding: '0.75rem 1.5rem',
                            borderRadius: '12px',
                            border: '1px solid #1a237e',
                            background: 'white',
                            color: '#1a237e',
                            fontWeight: 700,
                            cursor: 'pointer',
                            display: 'flex',
                            alignItems: 'center',
                            gap: '0.5rem'
                        }}
                    >
                        <span>🧾</span> {CONTENT.HISTORY_TITLE}
                    </button>
                </div>
            </div>

            <div style={{
                display: 'grid',
                gridTemplateColumns: '2fr 1fr',
                gap: '2.5rem'
            }}>
                <div style={{
                    background: 'white',
                    borderRadius: '24px',
                    padding: '2rem',
                    boxShadow: '0 4px 20px rgba(0,0,0,0.05)'
                }}>
                    <h3 style={{ marginBottom: '2rem', fontSize: '1.25rem', fontWeight: 700 }}>Verified Shift Log</h3>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ borderBottom: '2px solid #f3f4f6', color: '#90a4ae', textAlign: 'left' }}>
                                <th style={{ padding: '1rem 0' }}>Date</th>
                                <th style={{ padding: '1rem 0' }}>Client</th>
                                <th style={{ padding: '1rem 0' }}>Duration</th>
                                <th style={{ padding: '1rem 0', textAlign: 'right' }}>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? (
                                <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                            ) : visits.map((v) => (
                                <tr key={v.id} style={{ borderBottom: '1px solid #f9fafb' }}>
                                    <td style={{ padding: '1.25rem 0' }}>{new Date(v.requestedStartAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1.25rem 0', fontWeight: 600 }}>{v.client.fullName}</td>
                                    <td style={{ padding: '1.25rem 0' }}>{v.durationMinutes || 60}m</td>
                                    <td style={{ padding: '1.25rem 0', textAlign: 'right', fontWeight: 700, color: '#2e7d32' }}>${calculateEarnings(v.durationMinutes || 60).toFixed(2)}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '2.5rem' }}>
                    <div style={{
                        background: 'linear-gradient(135deg, #1a237e 0%, #311b92 100%)',
                        color: 'white',
                        padding: '2.5rem',
                        borderRadius: '24px',
                        boxShadow: '0 15px 35px rgba(26, 35, 126, 0.2)'
                    }}>
                        <span style={{ fontSize: '0.9rem', opacity: 0.8, textTransform: 'uppercase', fontWeight: 600, letterSpacing: '1px' }}>Available Balance</span>
                        <div style={{ fontSize: '3rem', fontWeight: 900, margin: '0.5rem 0' }}>${totalEarnings.toFixed(2)}</div>
                        <button
                            disabled={requesting || totalEarnings === 0}
                            onClick={handlePayout}
                            style={{
                                width: '100%',
                                marginTop: '1.5rem',
                                padding: '1.25rem',
                                borderRadius: '16px',
                                border: 'none',
                                background: 'white',
                                color: '#1a237e',
                                fontWeight: 800,
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                        >
                            {requesting ? 'Processing...' : 'Sync to Bank'}
                        </button>
                    </div>

                    <div style={{ padding: '2rem', borderRadius: '24px', border: '2px dashed #cfd8dc' }}>
                        <h4 style={{ margin: '0 0 1rem 0', color: '#546e7a' }}>Security Note</h4>
                        <p style={{ margin: 0, fontSize: '0.85rem', color: '#78909c', lineHeight: '1.6' }}>
                            All shifts are verified by clinical managers before being released to balance. Manual adjustments may take 24-48 hours.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
