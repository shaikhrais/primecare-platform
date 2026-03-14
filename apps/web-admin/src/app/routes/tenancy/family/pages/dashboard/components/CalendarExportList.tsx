import React from 'react';
import { Calendar as CalendarIcon, Download } from 'lucide-react';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

interface ShiftItem {
    id: string;
    title: string;
    description: string;
    startsAt: Date;
    endsAt: Date;
    location: string;
}

export const CalendarExportList: React.FC = () => {
    // TanStack Query: auto-cached family schedule
    const { data: rawShifts = [], isLoading: loading } = useRegistryQuery<any[]>('/v1/client/family/schedule/upcoming', {
        queryKey: ['family', 'schedule', 'upcoming'],
        staleTime: 60_000,
    });

    // Parse date strings from API into Date objects
    const shifts: ShiftItem[] = rawShifts.map((d: any) => ({
        ...d,
        startsAt: new Date(d.startsAt),
        endsAt: new Date(d.endsAt)
    }));

    // Generates a proper iCalendar (.ics) string format client-side
    const generateIcsBlob = (shift: ShiftItem) => {
        // Formatting function for exact iCal timestamp structure: YYYYMMDDTHHMMSSZ
        const pad = (n: number) => n < 10 ? `0${n}` : `${n}`;
        const formatTz = (date: Date) => {
            return date.getUTCFullYear() +
                pad(date.getUTCMonth() + 1) +
                pad(date.getUTCDate()) + "T" +
                pad(date.getUTCHours()) +
                pad(date.getUTCMinutes()) +
                pad(date.getUTCSeconds()) + "Z";
        };

        const icsBody = [
            "BEGIN:VCALENDAR",
            "VERSION:2.0",
            "PRODID:-//PrimeCare Inc//Care Portal//EN",
            "CALSCALE:GREGORIAN",
            "BEGIN:VEVENT",
            `DTSTAMP:${formatTz(new Date())}`,
            `UID:${shift.id}@primecare.health`,
            `DTSTART:${formatTz(shift.startsAt)}`,
            `DTEND:${formatTz(shift.endsAt)}`,
            `SUMMARY:${shift.title}`,
            `DESCRIPTION:${shift.description}`,
            `LOCATION:${shift.location}`,
            "END:VEVENT",
            "END:VCALENDAR"
        ].join("\r\n");

        return encodeURI(`data:text/calendar;charset=utf8,${icsBody}`);
    };

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E2E8F0', padding: '32px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
                <CalendarIcon color="#8B5CF6" size={28} />
                <h2 data-cy="h2-calendar-export-list-0" style={{ fontSize: '1.5rem', fontWeight: 900, color: '#0F172A', margin: 0 }}>Sync Care Schedule</h2>
            </div>
            <p style={{ color: '#64748B', marginBottom: '24px', lineHeight: '1.5' }}>
                Download events directly to your personal Apple, Google, or Outlook calendar to stay up to date on when staff will be at the house.
            </p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {loading ? <div style={{ color: '#64748B', padding: '16px' }}>Syncing schedule...</div> : shifts.length === 0 ? <div style={{ color: '#64748B', padding: '16px' }}>No upcoming visits scheduled.</div> : shifts.map(shift => (
                    <div key={shift.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '12px', border: '1px solid #E2E8F0' }}>
                        <div>
                            <div style={{ fontWeight: 800, color: '#0F172A', marginBottom: '4px' }}>{shift.title}</div>
                            <div style={{ fontSize: '0.85rem', color: '#64748B' }}>
                                {shift.startsAt.toLocaleDateString()} • {shift.startsAt.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})} - {shift.endsAt.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}
                            </div>
                        </div>
                        
                        {/* The pure client-side .ics export intent trigger */}
                        <a 
                            href={generateIcsBlob(shift)} 
                            download={`primecare-shift-${shift.id}.ics`}
                            style={{ 
                                display: 'flex', alignItems: 'center', gap: '8px', 
                                backgroundColor: '#E0E7FF', color: '#4F46E5', 
                                textDecoration: 'none', padding: '10px 16px', borderRadius: '8px', 
                                fontWeight: 800, fontSize: '0.9rem',
                                transition: 'background-color 0.2s',
                            }}
                            onMouseEnter={e => e.currentTarget.style.backgroundColor = '#C7D2FE'}
                            onMouseLeave={e => e.currentTarget.style.backgroundColor = '#E0E7FF'}
                        >
                            <Download size={16} /> ADD TO CALENDAR
                        </a>
                    </div>
                ))}
            </div>
        </section>
    );
};
