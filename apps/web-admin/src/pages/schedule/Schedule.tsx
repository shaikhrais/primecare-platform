import React, { useEffect, useState } from 'react';
import { Calendar, dateFnsLocalizer } from 'react-big-calendar';
import { format, parse, startOfWeek, getDay } from 'date-fns';
import { enUS } from 'date-fns/locale';
import 'react-big-calendar/lib/css/react-big-calendar.css';
// import { ApiRegistry } from 'prime-care-shared';

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

    useEffect(() => {
        fetchVisits();
    }, []);

    const fetchVisits = async () => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL}/v1/admin/visits`, {
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

    const getStatusColor = (status: string) => {
        switch (status) {
            case 'requested': return '#f57c00'; // Orange
            case 'scheduled': return '#1976d2'; // Blue
            case 'completed': return '#388e3c'; // Green
            default: return '#9e9e9e';
        }
    };

    const handleSelectEvent = (event: any) => {
        const visit = event.resource;
        alert(`Visit for ${visit.client.fullName}\nStatus: ${visit.status}\nAssigned: ${visit.psw?.fullName || 'Unassigned'}`);
        // TODO: Open modal for assignment
    };

    return (
        <div style={{ display: 'flex', flexDirection: 'column', height: '100%' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>Visit Schedule</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0', fontSize: '0.875rem' }}>Coordinate care visits and assign PSWs to client requests.</p>
                </div>
                <div style={{ display: 'flex', gap: '0.5rem' }}>
                    <button style={{ padding: '0.5rem 1rem', backgroundColor: 'white', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}>Filter</button>
                    <button style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}>New Booking</button>
                </div>
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
        </div>
    );
}
