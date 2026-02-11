import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function TimesheetList() {
    const navigate = useNavigate();
    const [timesheets, setTimesheets] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetch('/v1/admin/timesheets', {
            headers: { 'Authorization': `Bearer ${localStorage.getItem('token')}` }
        })
            .then(res => res.json())
            .then(data => {
                setTimesheets(data);
                setLoading(false);
            });
    }, []);

    const handleApprove = (id: string, status: string) => {
        fetch(`/v1/admin/timesheets/${id}`, {
            method: 'PATCH',
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ status })
        })
            .then(() => {
                setTimesheets(timesheets.map((ts: any) => ts.id === id ? { ...ts, status } : ts));
            });
    };

    if (loading) return <div>Loading timesheets...</div>;

    return (
        <div style={{ padding: '2rem' }} data-cy="timesheet-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0 }}>Timesheet Review</h2>
                <button
                    data-cy="btn.timesheet.adjust"
                    onClick={() => navigate('/timesheets/adjust')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    Manual Adjustment
                </button>
            </div>
            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: '#f9fafb' }}>
                        <tr>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Caregiver</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Week</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Minutes</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Status</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {timesheets.map((ts: any) => (
                            <tr key={ts.id} data-cy={`timesheet-row-${ts.id}`}>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="ts-caregiver">{ts.psw?.fullName}</td>
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
                                                onClick={() => handleApprove(ts.id, 'approved')}
                                                style={{ color: '#4db6ac', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                            >
                                                Approve
                                            </button>
                                            <button
                                                data-cy="btn-reject-ts"
                                                onClick={() => handleApprove(ts.id, 'rejected')}
                                                style={{ color: '#dc2626', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                            >
                                                Reject
                                            </button>
                                        </div>
                                    )}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
