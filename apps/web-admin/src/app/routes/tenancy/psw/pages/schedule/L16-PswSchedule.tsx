import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import EmptyState from '@/shared/components/layout/EmptyState';
import './ShiftsPage.css';

const CONTENT = ContentRegistry.PSW_SCHEDULE;
const DASH_CONTENT = ContentRegistry.PSW_DASHBOARD;
const API = AdminRegistry.ApiRegistry.PSW;

export default function ShiftsPage() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [shifts, setShifts] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchShifts = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get(API.VISITS);
            if (response.ok) {
                const data = await response.json();
                setShifts(Array.isArray(data) ? data : []);
            } else {
                setShifts([]);
            }
        } catch (error) {
            console.error('Failed to fetch shifts', error);
            setShifts([]);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchShifts();
    }, []);

    const getStatusClass = (status: string) => {
        switch ((status || '').toLowerCase()) {
            case 'scheduled': return 'status-scheduled';
            case 'in_progress': return 'status-in-progress';
            case 'completed': return 'status-completed';
            default: return '';
        }
    };

    const COMMON = ContentRegistry.COMMON;

    return (
        <div className="shifts-page-container" data-cy="page.container">
            <header className="shifts-header">
                <div className="header-group">
                    <h1>{CONTENT.TITLE}</h1>
                    <p>{CONTENT.SUBTITLE}</p>
                </div>
            </header>

            <div className="shifts-stats-grid">
                <div className="stats-card">
                    <span className="stats-label">{DASH_CONTENT.STATS.WEEKLY_HOURS}</span>
                    <span className="stats-value">38.5{COMMON.UNITS.HOURS}</span>
                </div>
                <div className="stats-card" style={{ background: 'linear-gradient(135deg, #0f172a 0%, #1e293b 100%)', color: 'white' }}>
                    <span className="stats-label" style={{ color: 'rgba(255,255,255,0.6)' }}>{DASH_CONTENT.STATS.NEXT_VISIT}</span>
                    <span className="stats-value" style={{ color: 'white' }}>2h 15m</span>
                </div>
                <div className="stats-card">
                    <span className="stats-label">{DASH_CONTENT.STATS.PENDING_PAYOUT}</span>
                    <span className="stats-value">$1,240.00</span>
                </div>
            </div>

            <div className="schedule-container">
                <div className="schedule-title-bar">
                    <h3>{DASH_CONTENT.SECTION_SHIFTS}</h3>
                </div>

                {loading ? (
                    <div className="loading-state">
                        <div className="loading-spinner"></div>
                        <p>{CONTENT.MESSAGES.LOADING}</p>
                    </div>
                ) : shifts.length > 0 ? (
                    <table className="schedule-table">
                        <thead>
                            <tr>
                                <th>{CONTENT.TABLE.CLIENT}</th>
                                <th>{CONTENT.TABLE.LOCATION}</th>
                                <th>{CONTENT.TABLE.DATETIME}</th>
                                <th>{CONTENT.TABLE.SERVICE}</th>
                                <th>{CONTENT.TABLE.STATUS}</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {shifts.map((shift) => (
                                <tr
                                    key={shift.id}
                                    className="schedule-row"
                                    data-cy={`row-shift-${shift.id}`}
                                >
                                    <td>
                                        <span className="client-name">{shift.client?.fullName || COMMON.FALLBACKS.REGISTRY_NODE}</span>
                                    </td>
                                    <td>
                                        <span className="client-location">
                                            {shift.client?.addressLine1 || COMMON.FALLBACKS.NA}
                                        </span>
                                    </td>
                                    <td>
                                        <span className="visit-time">
                                            {shift.requestedStartAt ? new Date(shift.requestedStartAt).toLocaleString([], { dateStyle: 'medium', timeStyle: 'short' }) : COMMON.FALLBACKS.TBD}
                                        </span>
                                    </td>
                                    <td>{shift.service?.name || COMMON.FALLBACKS.CARE_SERVICE}</td>
                                    <td>
                                        <span className={`status-badge ${getStatusClass(shift.status)}`}>
                                            {shift.status}
                                        </span>
                                    </td>
                                    <td>
                                        <button
                                            className="btn-primary-pc"
                                            data-cy={`btn-view-shift-${shift.id}`}
                                            onClick={() => navigate(`${AdminRegistry.RouteRegistry.PSW.CHECK_IN.replace(':id', shift.id)}`)}
                                        >
                                            {t('psw.view_shift', { defaultValue: 'View Shift' })}
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                ) : (
                    <EmptyState
                        title="No Upcoming Shifts"
                        description="You currently have no scheduled visits. Please check the Open Shifts board for available opportunities."
                        actionLabel="Find Open Shifts"
                        onAction={() => navigate(AdminRegistry.RouteRegistry.PSW.DASHBOARD)}
                    />
                )}
            </div>
        </div>
    );
}

