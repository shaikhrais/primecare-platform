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
        <div style={{ height: '80vh', padding: '1rem', backgroundColor: 'white' }}>
            <h2>Visit Schedule</h2>
            <Calendar
                localizer={localizer}
                events={events}
                startAccessor="start"
                endAccessor="end"
                style={{ height: '100%' }}
                onSelectEvent={handleSelectEvent}
            />
        </div>
    );
}
