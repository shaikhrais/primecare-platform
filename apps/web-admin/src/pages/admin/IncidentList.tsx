import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function IncidentList() {
    const navigate = useNavigate();
    const [incidents, setIncidents] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedIncident, setSelectedIncident] = useState<string | null>(null);
    const [resolutionNotes, setResolutionNotes] = useState('');
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty && isModalOpen) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty, isModalOpen]);

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

    const handleResolve = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!selectedIncident || !resolutionNotes) return;
        setSubmitting(true);

        try {
            const response = await fetch(`/v1/admin/incidents/${selectedIncident}`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${localStorage.getItem('token')}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ status: 'resolved', resolutionNotes })
            });

            if (response.ok) {
                setIncidents(incidents.map((inc: any) => inc.id === selectedIncident ? { ...inc, status: 'resolved', resolutionNotes } : inc));
                setIsModalOpen(false);
                setIsDirty(false);
            }
        } catch (error) {
            console.error('Failed to resolve incident', error);
        } finally {
            setSubmitting(false);
        }
    };

    if (loading) return <div>Loading incidents...</div>;

    return (
        <div style={{ padding: '2rem' }} data-cy="incident-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0 }} data-cy="page.title">Incident Reports</h2>
                <button
                    data-cy="btn.incident.report"
                    onClick={() => navigate('/incidents/new')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#e11d48', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    Report Incident
                </button>
            </div>
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
                                            data-cy="btn.incident.resolve"
                                            onClick={() => {
                                                setSelectedIncident(incident.id);
                                                setResolutionNotes('');
                                                setIsModalOpen(true);
                                                setIsDirty(false);
                                            }}
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

            {isModalOpen && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
                    {showGuard && (
                        <div data-cy="guard.unsaved.dialog" style={{ position: 'absolute', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', zIndex: 1001, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '0.5rem' }}>
                            <div style={{ background: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '350px', textAlign: 'center' }}>
                                <h4 style={{ margin: '0 0 1rem 0' }}>Discard Changes?</h4>
                                <p style={{ fontSize: '0.9rem', color: '#6b7280', marginBottom: '1.5rem' }}>You have typed resolution notes. Are you sure you want to cancel?</p>
                                <div style={{ display: 'flex', gap: '1rem' }}>
                                    <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); setIsModalOpen(false); }} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Discard</button>
                                    <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                                </div>
                            </div>
                        </div>
                    )}
                    <form onSubmit={handleResolve} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%', position: 'relative' }} data-cy="modal.incident.resolve.container">
                        <h3 style={{ marginTop: 0 }}>Resolve Incident</h3>
                        <div style={{ marginTop: '1.5rem' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Resolution Notes</label>
                            <textarea
                                data-cy="modal.incident.resolve.notes"
                                value={resolutionNotes}
                                onChange={(e) => { setResolutionNotes(e.target.value); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '120px' }}
                                required
                                placeholder="Describe the steps taken to resolve this incident..."
                            />
                        </div>
                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                            <button
                                type="button"
                                data-cy="modal.incident.resolve.close"
                                onClick={() => isDirty ? setShowGuard(true) : setIsModalOpen(false)}
                                style={{ flex: 1, padding: '0.75rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}
                            >
                                Cancel
                            </button>
                            <button
                                type="submit"
                                data-cy="modal.incident.resolve.save"
                                disabled={submitting}
                                style={{ flex: 1, padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                            >
                                {submitting ? 'Resolving...' : 'Resolve Incident'}
                            </button>
                        </div>
                    </form>
                </div>
            )}
        </div>
    );
}
