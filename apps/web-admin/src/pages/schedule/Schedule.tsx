import React, { useEffect, useState } from 'react';
import { Calendar, dateFnsLocalizer } from 'react-big-calendar';
import { format, parse, startOfWeek, getDay } from 'date-fns';
import { enUS } from 'date-fns/locale';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry } = AdminRegistry;

const locales = {
    'en-US': enUS,
};

const localizer = dateFnsLocalizer({
    format,
    parse,
    startOfWeek,
    getDay,
    locales,
});

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8787';

interface Visit {
    id: string;
    requestedStartAt: string;
    durationMinutes: number;
    client: { fullName: string };
    psw?: { fullName: string };
    status: string;
}

export default function Schedule() {
    const [events, setEvents] = useState<any[]>([]);
    const [visits, setVisits] = useState<Visit[]>([]);
    const [psws, setPsws] = useState<any[]>([]);
    const [selectedVisit, setSelectedVisit] = useState<Visit | null>(null);
    const [isAssignModalOpen, setIsAssignModalOpen] = useState(false);
    const [assignedPswId, setAssignedPswId] = useState('');

    useEffect(() => {
        fetchVisits();
        fetchPsws();
    }, []);

    const fetchVisits = async () => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS}`, {
                headers: { Authorization: `Bearer ${token}` }
            });
            const data = await res.json();

            if (Array.isArray(data)) {
                setVisits(data);
                const calendarEvents = data.map((visit: Visit) => {
                    const start = new Date(visit.requestedStartAt);
                    const end = new Date(start.getTime() + visit.durationMinutes * 60000);
                    return {
                        id: visit.id,
                        title: `${visit.client.fullName} (${visit.status})`,
                        start,
                        end,
                        resource: visit,
                        style: { backgroundColor: getStatusColor(visit.status) }
                    };
                });
                setEvents(calendarEvents);
            }
        } catch (err) {
            console.error(err);
        }
    };

    const fetchPsws = async () => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.USERS}`, {
                headers: { Authorization: `Bearer ${token}` }
            });
            const data = await res.json();
            // Filter only PSWs who are verified
            const filteredPsws = data.filter((u: any) => u.role === 'psw');
            setPsws(filteredPsws);
        } catch (err) {
            console.error(err);
        }
    };

    const handleAssign = async () => {
        if (!selectedVisit || !assignedPswId) return;

        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_ASSIGN}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    visitId: selectedVisit.id,
                    pswId: assignedPswId
                })
            });

            if (response.ok) {
                setIsAssignModalOpen(false);
                fetchVisits();
                alert(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_ASSIGN);
            }
        } catch (err) {
            alert(ContentRegistry.SCHEDULE.MESSAGES.ERROR_ASSIGN);
        }
    };

    const getStatusColor = (status: string) => {
        switch (status.toLowerCase()) {
            case 'requested': return '#f57c00'; // Orange
            case 'scheduled': return '#1976d2'; // Blue
            case 'completed': return '#388e3c'; // Green
            default: return '#9e9e9e';
        }
    };

    const handleSelectEvent = (event: any) => {
        const visit = event.resource;
        setSelectedVisit(visit);
        setAssignedPswId(visit.assignedPswId || '');
        setIsAssignModalOpen(true);
    };

    const handleDeleteVisit = async () => {
        if (!selectedVisit) return;
        if (!confirm(ContentRegistry.SCHEDULE.MODAL.CONFIRM_DELETE)) return;

        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}`, {
                method: 'DELETE',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                setIsAssignModalOpen(false);
                fetchVisits();
                alert(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_CANCEL);
            }
        } catch (err) {
            alert(ContentRegistry.SCHEDULE.MESSAGES.ERROR_DELETE);
        }
    };

    const handleStatusChange = async (newStatus: string) => {
        if (!selectedVisit) return;
        try {
            const token = localStorage.getItem('token');
            await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(selectedVisit.id)}`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ status: newStatus })
            });
            fetchVisits();
            setIsAssignModalOpen(false);
        } catch (err) {
            alert(ContentRegistry.SCHEDULE.MESSAGES.ERROR_UPDATE);
        }
    };

    return (
        <div style={{ display: 'flex', flexDirection: 'column', height: '100%' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>{ContentRegistry.SCHEDULE.TITLE}</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0', fontSize: '0.875rem' }}>{ContentRegistry.SCHEDULE.SUBTITLE}</p>
                </div>
                <button
                    onClick={() => alert('Opening New Request form...')}
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    {ContentRegistry.SCHEDULE.ACTIONS.CREATE}
                </button>
            </div>

            <div style={{
                flex: 1,
                backgroundColor: 'white',
                borderRadius: '0.75rem',
                boxShadow: '0 1px 3px rgba(0,0,0,0.1)',
                padding: '1.5rem',
                minHeight: '600px'
            }}>
                <Calendar
                    localizer={localizer}
                    events={events}
                    startAccessor="start"
                    endAccessor="end"
                    style={{ height: '100%', minHeight: '550px' }}
                    onSelectEvent={handleSelectEvent}
                    views={['month', 'week', 'day']}
                />
            </div>

            {isAssignModalOpen && selectedVisit && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
                    <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%' }}>
                        <h3 style={{ marginTop: 0 }}>{ContentRegistry.SCHEDULE.ACTIONS.ASSIGN}</h3>
                        <div style={{ margin: '1rem 0' }}>
                            <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Client:</strong> {selectedVisit.client.fullName}</p>
                            <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Visit:</strong> {new Date(selectedVisit.requestedStartAt).toLocaleString()}</p>
                            <p style={{ margin: '0.5rem 0', fontSize: '0.9rem' }}><strong>Status:</strong> {selectedVisit.status.toUpperCase()}</p>
                        </div>

                        <div style={{ marginTop: '1.5rem' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{ContentRegistry.SCHEDULE.MODAL.SELECT_PSW}</label>
                            <select
                                value={assignedPswId}
                                onChange={(e) => setAssignedPswId(e.target.value)}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            >
                                <option value="">{ContentRegistry.SCHEDULE.MODAL.CHOOSE_WORKER}</option>
                                {psws.map(psw => (
                                    <option key={psw.id} value={psw.PswProfile?.id}>
                                        {psw.PswProfile?.fullName} (Verified)
                                    </option>
                                ))}
                            </select>
                        </div>

                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                            <button onClick={handleDeleteVisit} style={{ padding: '0.75rem', backgroundColor: '#fef2f2', color: '#991b1b', border: '1px solid #fecaca', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}>{ContentRegistry.SCHEDULE.ACTIONS.CANCEL_VISIT}</button>
                            <div style={{ flex: 1 }} />
                            <button onClick={() => setIsAssignModalOpen(false)} style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}>{ContentRegistry.SCHEDULE.ACTIONS.CLOSE}</button>
                            <button
                                onClick={handleAssign}
                                disabled={!assignedPswId}
                                style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', opacity: assignedPswId ? 1 : 0.5, cursor: 'pointer' }}
                            >
                                {ContentRegistry.SCHEDULE.ACTIONS.CONFIRM_ASSIGN}
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
