import React from 'react';
import { Calendar, dateFnsLocalizer } from 'react-big-calendar';
import { format, parse, startOfWeek, getDay } from 'date-fns';
import { enUS } from 'date-fns/locale';
import 'react-big-calendar/lib/css/react-big-calendar.css';

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

interface ScheduleCalendarProps {
    events: any[];
    onSelectEvent: (event: any) => void;
}

export const ScheduleCalendar: React.FC<ScheduleCalendarProps> = ({ events, onSelectEvent }) => {
    return (
        <div style={{
            flex: 1,
            backgroundColor: 'white',
            borderRadius: '0.75rem',
            boxShadow: '0 1px 3px rgba(0,0,0,0.1)',
            padding: '1.5rem',
            minHeight: '600px'
        }} data-cy="calendar-container">
            <Calendar
                localizer={localizer}
                events={events}
                startAccessor="start"
                endAccessor="end"
                style={{ height: '100%', minHeight: '550px' }}
                onSelectEvent={onSelectEvent}
                views={['month', 'week', 'day']}
            />
        </div>
    );
};
