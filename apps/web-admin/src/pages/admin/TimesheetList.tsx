import React, { useEffect, useState } from 'react';

export default function TimesheetList() {
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
        <div>
            <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Timesheet Review</h1>
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
                            <tr key={ts.id}>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{ts.psw?.fullName}</td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{ts.weekId}</td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{ts.totalMinutes}</td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                    <span style={{
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
                                                onClick={() => handleApprove(ts.id, 'approved')}
                                                style={{ color: '#4db6ac', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                            >
                                                Approve
                                            </button>
                                            <button
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
