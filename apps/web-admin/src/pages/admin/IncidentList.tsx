import React, { useEffect, useState } from 'react';

export default function IncidentList() {
    const [incidents, setIncidents] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetch('/v1/admin/incidents', {
            headers: { 'Authorization': `Bearer ${localStorage.getItem('token')}` }
        })
            .then(res => res.json())
            .then(data => {
                setIncidents(data);
                setLoading(false);
            });
    }, []);

    const handleResolve = (id: string) => {
        const notes = prompt('Enter resolution notes:');
        if (!notes) return;

        fetch(`/v1/admin/incidents/${id}`, {
            method: 'PATCH',
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ status: 'resolved', resolutionNotes: notes })
        })
            .then(() => {
                setIncidents(incidents.map((inc: any) => inc.id === id ? { ...inc, status: 'resolved', resolutionNotes: notes } : inc));
            });
    };

    if (loading) return <div>Loading incidents...</div>;

    return (
        <div>
            <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Reported Incidents</h1>
            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }} data-cy="tbl-incidents">
                    <thead style={{ backgroundColor: '#f9fafb' }}>
                        <tr>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Type</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Reporter</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Status</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Date</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {incidents.map((incident: any) => (
                            <tr key={incident.id} data-cy={`incident-row-${incident.id}`}>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="incident-type">{incident.type}</td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="incident-reporter">{incident.reporter?.email}</td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                    <span data-cy="incident-status" style={{
                                        padding: '0.25rem 0.5rem',
                                        borderRadius: '9999px',
                                        fontSize: '0.75rem',
                                        backgroundColor: incident.status === 'open' ? '#fee2e2' : '#d1fae5',
                                        color: incident.status === 'open' ? '#991b1b' : '#065f46'
                                    }}>
                                        {incident.status}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{new Date(incident.createdAt).toLocaleDateString()}</td>
                                <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                    {incident.status === 'open' && (
                                        <button
                                            data-cy="btn-resolve-incident"
                                            onClick={() => handleResolve(incident.id)}
                                            style={{ color: '#4db6ac', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                        >
                                            Resolve
                                        </button>
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
