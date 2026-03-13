// ================================================================
// PAGE IDENTITY: R4 � Payout History
// Type: Report | Owner: psw
// ================================================================
import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useNavigate } from 'react-router-dom';

const API_URL = import.meta.env.VITE_API_URL;

export default function PayoutHistory() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [payouts, setPayouts] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchPayouts = async () => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}/v1/psw/payouts/history`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                const data = await response.json();
                setPayouts(Array.isArray(data) ? data : []);
            } catch (error) {
                showToast('Failed to load payout history', 'error');
            } finally {
                setLoading(false);
            }
        };
        fetchPayouts();
    }, []);

    const getStatusColor = (status: string) => {
        switch (status.toLowerCase()) {
            case 'paid': return { bg: '#e8f5e9', text: '#2e7d32' };
            case 'pending': return { bg: '#fff3e0', text: '#ef6c00' };
            case 'failed': return { bg: '#ffebee', text: '#c62828' };
            default: return { bg: '#eceff1', text: '#455a64' };
        }
    };

    return (
        <div data-cy="page.container" style={{ maxWidth: '1000px', margin: '2rem auto', padding: '0 1rem' }}>
            <div style={{
                background: 'rgba(255, 255, 255, 0.8)',
                backdropFilter: 'blur(12px)',
                borderRadius: '32px',
                padding: '3rem',
                border: '1px solid rgba(255, 255, 255, 0.4)',
                boxShadow: '0 20px 50px rgba(0, 0, 0, 0.05)'
            }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '3rem' }}>
                    <div>
                        <h1 data-cy="page.title" style={{
                            fontSize: '2.5rem',
                            fontWeight: 900,
                            color: '#1a237e',
                            marginBottom: '0.5rem',
                            letterSpacing: '-1px'
                        }}>
                            Earnings & Payouts
                        </h1>
                        <p style={{ color: '#546e7a', fontSize: '1.1rem' }}>
                            Transparency into your processed income.
                        </p>
                    </div>
                    <button data-cy="btn-psw.payout-history-0"
                        onClick={() => navigate(-1)}
                        style={{ padding: '0.75rem 1.5rem', borderRadius: '12px', border: '1px solid #e0e0e0', background: 'white', cursor: 'pointer', fontWeight: 600 }}
                    >
                        Back
                    </button>
                </div>

                <div style={{ overflowX: 'auto' }}>
                    <table data-cy="table-psw.payout-history" style={{ width: '100%', borderCollapse: 'separate', borderSpacing: '0 1rem' }}>
                        <thead>
                            <tr style={{ color: '#90a4ae', textTransform: 'uppercase', fontSize: '0.8rem', letterSpacing: '1px' }}>
                                <th style={{ padding: '0 1rem', textAlign: 'left' }}>Reference</th>
                                <th style={{ padding: '0 1rem', textAlign: 'left' }}>Date</th>
                                <th style={{ padding: '0 1rem', textAlign: 'left' }}>Amount</th>
                                <th style={{ padding: '0 1rem', textAlign: 'left' }}>Status</th>
                                <th style={{ padding: '0 1rem', textAlign: 'left' }}>Processed</th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? (
                                <tr><td colSpan={5} style={{ textAlign: 'center', padding: '4rem', color: '#b0bec5' }}>Authenticating Ledger...</td></tr>
                            ) : payouts.length > 0 ? (
                                payouts.map(p => {
                                    const colors = getStatusColor(p.status);
                                    return (
                                        <tr key={p.id} style={{ background: 'white', boxShadow: '0 2px 8px rgba(0,0,0,0.02)', borderRadius: '16px' }}>
                                            <td style={{ padding: '1.5rem 1rem', borderRadius: '16px 0 0 16px', fontWeight: 600, color: '#37474f' }}>#PY-{p.id.slice(0, 8)}</td>
                                            <td style={{ padding: '1.5rem 1rem', color: '#546e7a' }}>{new Date(p.createdAt).toLocaleDateString()}</td>
                                            <td style={{ padding: '1.5rem 1rem', fontSize: '1.2rem', fontWeight: 800, color: '#1a237e' }}>${parseFloat(p.amount).toFixed(2)}</td>
                                            <td style={{ padding: '1.5rem 1rem' }}>
                                                <span style={{
                                                    padding: '0.5rem 1rem',
                                                    borderRadius: '8px',
                                                    background: colors.bg,
                                                    color: colors.text,
                                                    fontSize: '0.85rem',
                                                    fontWeight: 700,
                                                    textTransform: 'uppercase'
                                                }}>
                                                    {p.status}
                                                </span>
                                            </td>
                                            <td style={{ padding: '1.5rem 1rem', borderRadius: '0 16px 16px 0', color: '#78909c' }}>
                                                {p.processedAt ? new Date(p.processedAt).toLocaleDateString() : '—'}
                                            </td>
                                        </tr>
                                    );
                                })
                            ) : (
                                <tr>
                                    <td colSpan={5} style={{ textAlign: 'center', padding: '6rem' }}>
                                        <div style={{ opacity: 0.3, marginBottom: '1rem' }}>
                                            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5">
                                                <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" />
                                                <path d="M12 6V12L16 14" />
                                            </svg>
                                        </div>
                                        <p style={{ color: '#90a4ae', fontWeight: 500 }}>No payout history found.</p>
                                    </td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
