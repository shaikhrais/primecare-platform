import React, { useState, useEffect } from 'react';
import { ContentRegistry, ApiRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './WaitlistManager.css';

const { COORDINATOR_WAITLIST } = ContentRegistry;

export default function WaitlistManager() {
    const [waitlist, setWaitlist] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchWaitlist = async () => {
            try {
                const data = await apiClient.get(ApiRegistry.COORDINATOR.WAITLIST_SYNC);
                if (data && Array.isArray(data)) {
                    setWaitlist(data);
                } else {
                    // Fallback mock data
                    setWaitlist([
                        { id: '1', clientName: 'Sarah Jenkins', priority: 'High', acuity: 'Complex', entryDate: '2026-03-01' },
                        { id: '2', clientName: 'Robert Wilson', priority: 'Medium', acuity: 'Standard', entryDate: '2026-03-02' },
                        { id: '3', clientName: 'Emma Thompson', priority: 'Low', acuity: 'Basic', entryDate: '2026-03-03' },
                    ]);
                }
            } catch (error) {
                console.error('Failed to fetch waitlist:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchWaitlist();
    }, []);

    const getPriorityClass = (priority: string) => {
        switch (priority.toLowerCase()) {
            case 'high': return 'priority-high';
            case 'medium': return 'priority-med';
            case 'low': return 'priority-low';
            default: return '';
        }
    };

    const getAcuityColor = (acuity: string) => {
        switch (acuity.toLowerCase()) {
            case 'complex': return '#ef4444';
            case 'standard': return '#f59e0b';
            case 'basic': return '#10b981';
            default: return '#cbd5e1';
        }
    };

    if (loading) return <div className="waitlist-manager-container">Synchronizing Demand Ledger...</div>;

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
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {waitlist.map(entry => (
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
                                        <button className="btn-action">{COORDINATOR_WAITLIST.ACTIONS.BOOST_PRIORITY}</button>
                                        <button className="btn-action" style={{ background: '#0f172a', color: 'white', border: 'none' }}>{COORDINATOR_WAITLIST.ACTIONS.ASSIGN_STAFF}</button>
                                    </div>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
