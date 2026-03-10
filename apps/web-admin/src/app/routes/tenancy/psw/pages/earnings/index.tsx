import React, { useState, useEffect } from 'react';
import { ApiRegistry, AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useNavigate } from 'react-router-dom';
import { apiClient } from '@/shared/utils/apiClient';
import EmptyState from '@/shared/components/layout/EmptyState';
import './EarningsPage.css';

const CONTENT = ContentRegistry.PSW_PAYOUTS;
const API = AdminRegistry.ApiRegistry.PSW;

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
                const response = await apiClient.get(API.VISITS);
                if (response.ok) {
                    const data = await response.json();
                    setVisits(data.filter((v: any) => v.status === 'completed'));
                }
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
            const response = await apiClient.post(API.PAYOUT_REQUEST, {});
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
        <div className="earnings-page-container">
            <header className="earnings-top-header">
                <div className="earnings-title-group">
                    <h1>{CONTENT.TITLE}</h1>
                    <p>{CONTENT.SUBTITLE}</p>
                </div>

                <button
                    className="history-btn"
                    onClick={() => navigate(AdminRegistry.RouteRegistry.PSW.PAYOUTS)}
                    style={{
                        padding: '10px 20px',
                        backgroundColor: '#FFFFFF',
                        color: 'var(--brand-500, #0f172a)',
                        border: '1px solid #E5E7EB',
                        borderRadius: '8px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px',
                        boxShadow: '0 1px 2px 0 rgba(0, 0, 0, 0.05)'
                    }}
                >
                    <span>🧾</span> {CONTENT.HISTORY_TITLE}
                </button>
            </header>

            <div className="earnings-main-layout">
                <div className="shift-log-card">
                    <h3>Verified Shift Log</h3>
                    <table className="earnings-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Client</th>
                                <th>Duration</th>
                                <th style={{ textAlign: 'right' }}>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? (
                                <tr><td colSpan={4} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                            ) : visits.length > 0 ? visits.map((v) => (
                                <tr key={v.id}>
                                    <td>{new Date(v.requestedStartAt).toLocaleDateString()}</td>
                                    <td className="client-name">{v.client?.fullName || 'Registry Node'}</td>
                                    <td>{v.durationMinutes || 60}m</td>
                                    <td className="amount-cell">${calculateEarnings(v.durationMinutes || 60).toFixed(2)}</td>
                                </tr>
                            )) : (
                                <tr>
                                    <td colSpan={4} style={{ padding: 0, borderBottom: 'none' }}>
                                        <EmptyState
                                            title="No Verified Shifts"
                                            description="You have no completed shifts finalized for payout yet. Complete your assigned visits to build your balance."
                                            actionLabel="View Schedule"
                                            onAction={() => navigate(AdminRegistry.RouteRegistry.PSW.SCHEDULE)}
                                        />
                                    </td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>

                <div className="earnings-sidebar">
                    <div className="balance-card">
                        <span className="balance-label">Available Balance</span>
                        <div className="balance-amount">${totalEarnings.toFixed(2)}</div>
                        <button
                            className="payout-btn"
                            disabled={requesting || totalEarnings === 0}
                            onClick={handlePayout}
                            style={{
                                width: '100%',
                                padding: '14px',
                                backgroundColor: (requesting || totalEarnings === 0) ? '#9CA3AF' : 'var(--brand-500, #0f172a)',
                                color: '#FFFFFF',
                                border: 'none',
                                borderRadius: '8px',
                                fontWeight: '700',
                                cursor: (requesting || totalEarnings === 0) ? 'not-allowed' : 'pointer',
                                transition: 'all 0.2s',
                                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)'
                            }}
                        >
                            {requesting ? 'Processing...' : (AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-payout-sync')?.label || 'Sync to Bank')}
                        </button>
                    </div>

                    <div className="security-box">
                        <h4>Security Note</h4>
                        <p>
                            All shifts are verified by clinical managers before being released to balance. Manual adjustments may take 24-48 hours.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}

