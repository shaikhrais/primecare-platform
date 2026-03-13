// ================================================================
// PAGE IDENTITY: L20 · Waitlist Manager
// Type: List | Owner: coordinator
// ================================================================
import React, { useState, useEffect } from 'react';
import { ContentRegistry, ApiRegistry, ButtonRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';
import EmptyState from '@/shared/components/layout/EmptyState';
import { Search } from 'lucide-react';
import './WaitlistManager.css';

const { COORDINATOR_WAITLIST } = ContentRegistry;

export default function WaitlistManager() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [waitlist, setWaitlist] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchWaitlist = async () => {
            try {
                const data = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.WAITLIST_SYNC);
                if (data && Array.isArray(data)) {
                    setWaitlist(data);
                }
            } catch (error) {
                showToast(t('waitlist.fetchError', 'Failed to fetch waitlist'), 'error');
                console.error(error);
            } finally {
                setLoading(false);
            }
        };
        fetchWaitlist();
    }, []);

    const getPriorityClass = (priority: string) => {
        switch (priority?.toLowerCase()) {
            case 'high': return 'priority-high';
            case 'medium': return 'priority-med';
            case 'low': return 'priority-low';
            default: return '';
        }
    };

    const getAcuityColor = (acuity: string) => {
        switch (acuity?.toLowerCase()) {
            case 'complex': return '#ef4444';
            case 'standard': return '#f59e0b';
            case 'basic': return '#10b981';
            default: return '#cbd5e1';
        }
    };

    if (loading) return <div className="waitlist-manager-container">{t('waitlist.syncLedger', 'Synchronizing Demand Ledger...')}</div>;

    return (
        <div className="waitlist-manager-container">
            <header className="waitlist-header">
                <h1>{COORDINATOR_WAITLIST.TITLE}</h1>
                <p style={{ color: '#64748b' }}>{COORDINATOR_WAITLIST.SUBTITLE}</p>
            </header>

            <div className="waitlist-table-card">
                <table className="waitlist-table">
                    <thead>
                        <tr>
                            <th>{COORDINATOR_WAITLIST.COLUMNS.CLIENT}</th>
                            <th>{COORDINATOR_WAITLIST.COLUMNS.PRIORITY}</th>
                            <th>{COORDINATOR_WAITLIST.COLUMNS.ACUITY}</th>
                            <th>{COORDINATOR_WAITLIST.COLUMNS.ENTRY_DATE}</th>
                            <th>{t('waitlist.actions', 'Actions')}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {waitlist.length === 0 ? (
                            <tr>
                                <td colSpan={5} style={{ padding: '0' }}>
                                    <EmptyState
                                        title={t(ContentRegistry.COMMON?.NO_RESULTS || 'No Results')}
                                        description={t('waitlist.emptyDescription', 'No active waitlist entries found.')}
                                        icon={<Search size={24} />}
                                    />
                                </td>
                            </tr>
                        ) : (
                            waitlist.map(entry => (
                                <tr key={entry.id}>
                                    <td style={{ fontWeight: 700 }}>{entry.clientName}</td>
                                    <td>
                                        <span className={`priority-badge ${getPriorityClass(entry.priority)}`}>
                                            {entry.priority}
                                        </span>
                                    </td>
                                    <td>
                                        <span className="acuity-ring" style={{ background: getAcuityColor(entry.acuity) }}></span>
                                        {entry.acuity}
                                    </td>
                                    <td style={{ color: '#64748b' }}>{new Date(entry.entryDate).toLocaleDateString()}</td>
                                    <td>
                                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                                            <button data-cy="btn-waitlist-boost" className="btn-action">
                                                {t('waitlist.actions.boost', COORDINATOR_WAITLIST.ACTIONS.BOOST_PRIORITY)}
                                            </button>
                                            <button data-cy="btn-waitlist-assign" className="btn-action" style={{ background: '#0f172a', color: 'white', border: 'none' }}>
                                                {t('waitlist.actions.assign', COORDINATOR_WAITLIST.ACTIONS.ASSIGN_STAFF)}
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
