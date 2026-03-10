import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { TimesheetDetailModal } from '@/shared/components/modals/TimesheetDetailModal';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import EmptyState from '@/shared/components/layout/EmptyState';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export default function TimesheetList() {
    const navigate = useNavigate();
    const [timesheets, setTimesheets] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    const [selectedTimesheet, setSelectedTimesheet] = useState<any>(null);

    useEffect(() => {
        apiClient.get('/v1/admin/timesheets')
            .then(res => res.json())
            .then(data => {
                setTimesheets(data);
                setLoading(false);
            })
            .catch(() => setLoading(false));
    }, []);

    const handleApprove = (id: string, status: string, e: React.MouseEvent) => {
        e.stopPropagation(); // Prevent modal opening
        apiClient.patch(`/v1/admin/timesheets/${id}`, { status })
            .then(() => {
                setTimesheets(timesheets.map((ts: any) => ts.id === id ? { ...ts, status } : ts));
            });
    };

    if (loading) return <div>Loading timesheets...</div>;

    return (
        <div style={{ padding: '2rem' }} data-cy="timesheet-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0 }} data-cy="page.title">Timesheet Review</h2>
                <button
                    data-cy="btn.timesheet.adjust"
                    onClick={() => navigate(AdminRegistry.RouteRegistry.ADMIN.TIMESHEET_ADJUST)}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    Manual Adjustment
                </button>
            </div>
            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: '#f9fafb' }}>
                        <tr>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Service Provider</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Week</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Minutes</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Status</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {timesheets.length === 0 ? (
                            <tr>
                                <td colSpan={5} style={{ padding: '2rem' }}>
                                    <EmptyState
                                        title="No Timesheets"
                                        description="There are currently no timesheets pending review."
                                        icon="⏱️"
                                    />
                                </td>
                            </tr>
                        ) : (
                            timesheets.map((ts: any) => (
                                <tr
                                    key={ts.id}
                                    data-cy={`timesheet-row-${ts.id}`}
                                    onClick={() => setSelectedTimesheet(ts)}
                                    style={{ cursor: 'pointer', transition: 'background-color 0.2s' }}
                                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                                >
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="ts-service-provider">
                                        <Link
                                            to={`${RouteRegistry.ADMIN.USERS}?search=${ts.psw?.email}`}
                                            onClick={(e) => e.stopPropagation()}
                                            style={{ color: '#00875A', fontWeight: 600, textDecoration: 'none' }}
                                        >
                                            {ts.psw?.fullName}
                                        </Link>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{ts.weekId}</td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="ts-minutes">{ts.totalMinutes}</td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                        <span data-cy="ts-status" style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            backgroundColor: ts.status === 'submitted' ? '#fef3c7' : ts.status === 'approved' ? '#d1fae5' : '#f3f4f6',
                                            color: ts.status === 'submitted' ? '#92400e' : ts.status === 'approved' ? '#065f46' : '#374151'
                                        }}>
                                            {ts.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                        {ts.status === 'submitted' && (
                                            <div style={{ display: 'flex', gap: '0.5rem' }}>
                                                <button
                                                    data-cy="btn-approve-ts"
                                                    onClick={(e) => handleApprove(ts.id, 'approved', e)}
                                                    style={{ color: '#4db6ac', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                                >
                                                    Approve
                                                </button>
                                                <button
                                                    data-cy="btn-reject-ts"
                                                    onClick={(e) => handleApprove(ts.id, 'rejected', e)}
                                                    style={{ color: '#dc2626', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                                >
                                                    Reject
                                                </button>
                                            </div>
                                        )}
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>

            <TimesheetDetailModal
                isOpen={!!selectedTimesheet}
                onClose={() => setSelectedTimesheet(null)}
                timesheet={selectedTimesheet}
            />
        </div>
    );
}
