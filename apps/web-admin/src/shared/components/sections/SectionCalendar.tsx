import React, { useState } from 'react';

export interface CalendarEvent {
    id: string;
    title: string;
    date: string;       // ISO date string or 'YYYY-MM-DD'
    time?: string;
    icon?: string;
    color?: string;
    status?: 'confirmed' | 'pending' | 'cancelled';
}

interface SectionCalendarProps {
    events: CalendarEvent[];
    title?: string;
    initialMonth?: number;  // 0-11
    initialYear?: number;
}

const DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const MONTHS = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];

const statusDot: Record<string, string> = {
    confirmed: '#10B981', pending: '#F59E0B', cancelled: '#EF4444',
};

/** Registry-driven calendar section — month view with event dots */
export function SectionCalendar({ events, title, initialMonth, initialYear }: SectionCalendarProps) {
    const now = new Date();
    const [month, setMonth] = useState(initialMonth ?? now.getMonth());
    const [year, setYear] = useState(initialYear ?? now.getFullYear());

    const firstDay = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    const today = now.getDate();
    const isCurrentMonth = month === now.getMonth() && year === now.getFullYear();

    // Group events by day
    const eventsByDay: Record<number, CalendarEvent[]> = {};
    events.forEach(e => {
        const d = new Date(e.date);
        if (d.getMonth() === month && d.getFullYear() === year) {
            const day = d.getDate();
            if (!eventsByDay[day]) eventsByDay[day] = [];
            eventsByDay[day].push(e);
        }
    });

    const prev = () => { if (month === 0) { setMonth(11); setYear(y => y - 1); } else setMonth(m => m - 1); };
    const next = () => { if (month === 11) { setMonth(0); setYear(y => y + 1); } else setMonth(m => m + 1); };

    const cells: React.ReactNode[] = [];
    // Empty cells before first day
    for (let i = 0; i < firstDay; i++) cells.push(<div key={`e${i}`} />);
    // Day cells
    for (let d = 1; d <= daysInMonth; d++) {
        const dayEvents = eventsByDay[d] || [];
        const isToday = isCurrentMonth && d === today;
        cells.push(
            <div key={d} title={dayEvents.map(e => `${e.icon || '•'} ${e.title}${e.time ? ` @ ${e.time}` : ''}`).join('\n')} style={{
                padding: '6px 4px', borderRadius: '8px', textAlign: 'center', cursor: dayEvents.length ? 'pointer' : 'default',
                background: isToday ? 'var(--pc-primary, #3B82F6)' : dayEvents.length ? 'rgba(59,130,246,0.06)' : 'transparent',
                color: isToday ? 'white' : 'var(--pc-text-primary)',
                border: isToday ? 'none' : dayEvents.length ? '1px solid rgba(59,130,246,0.15)' : '1px solid transparent',
                transition: 'all 0.15s', position: 'relative', minHeight: '44px',
            }}>
                <div style={{ fontWeight: isToday || dayEvents.length ? 700 : 400, fontSize: '0.8rem' }}>{d}</div>
                {dayEvents.length > 0 && (
                    <div style={{ display: 'flex', gap: '3px', justifyContent: 'center', marginTop: '4px', flexWrap: 'wrap' }}>
                        {dayEvents.slice(0, 3).map((e, i) => (
                            <span key={i} style={{
                                width: '6px', height: '6px', borderRadius: '50%',
                                background: statusDot[e.status || 'confirmed'] || e.color || '#3B82F6',
                            }} />
                        ))}
                        {dayEvents.length > 3 && <span style={{ fontSize: '0.55rem', color: 'var(--pc-text-tertiary)' }}>+{dayEvents.length - 3}</span>}
                    </div>
                )}
            </div>
        );
    }

    // Upcoming events list
    const upcoming = events
        .filter(e => new Date(e.date) >= now)
        .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
        .slice(0, 5);

    return (
        <div style={{ marginBottom: '24px' }}>
            {title && <div style={{ fontWeight: 700, marginBottom: '12px', color: 'var(--pc-text-primary)' }}>{title}</div>}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 280px', gap: '20px' }}>
                {/* Calendar grid */}
                <div style={{ background: 'var(--pc-bg-primary, white)', borderRadius: '14px', padding: '20px', border: '1px solid var(--pc-border-primary, #e5e7eb)' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                        <button onClick={prev} style={{ background: 'none', border: '1px solid var(--pc-border-primary, #e5e7eb)', borderRadius: '8px', padding: '6px 12px', cursor: 'pointer', fontSize: '0.8rem' }}>◀</button>
                        <span style={{ fontWeight: 800, fontSize: '1rem' }}>{MONTHS[month]} {year}</span>
                        <button onClick={next} style={{ background: 'none', border: '1px solid var(--pc-border-primary, #e5e7eb)', borderRadius: '8px', padding: '6px 12px', cursor: 'pointer', fontSize: '0.8rem' }}>▶</button>
                    </div>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: '4px' }}>
                        {DAYS.map(d => <div key={d} style={{ textAlign: 'center', fontSize: '0.65rem', fontWeight: 700, color: 'var(--pc-text-tertiary)', padding: '4px 0', textTransform: 'uppercase' }}>{d}</div>)}
                        {cells}
                    </div>
                </div>

                {/* Upcoming sidebar */}
                <div style={{ background: 'var(--pc-bg-primary, white)', borderRadius: '14px', padding: '20px', border: '1px solid var(--pc-border-primary, #e5e7eb)' }}>
                    <div style={{ fontWeight: 700, fontSize: '0.85rem', marginBottom: '12px', color: 'var(--pc-text-secondary)' }}>📅 Upcoming</div>
                    {upcoming.length === 0 && <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-tertiary)' }}>No upcoming events</div>}
                    {upcoming.map(e => {
                        const d = new Date(e.date);
                        return (
                            <div key={e.id} style={{
                                display: 'flex', gap: '10px', padding: '10px 0',
                                borderBottom: '1px solid var(--pc-border-primary, #f1f5f9)',
                            }}>
                                <div style={{
                                    width: '40px', height: '40px', borderRadius: '10px',
                                    background: 'var(--pc-bg-secondary, #f1f5f9)',
                                    display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
                                    flexShrink: 0,
                                }}>
                                    <span style={{ fontSize: '0.55rem', fontWeight: 700, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase' }}>{MONTHS[d.getMonth()].slice(0, 3)}</span>
                                    <span style={{ fontSize: '0.9rem', fontWeight: 800 }}>{d.getDate()}</span>
                                </div>
                                <div style={{ flex: 1, minWidth: 0 }}>
                                    <div style={{ fontWeight: 600, fontSize: '0.8rem', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                        {e.icon || '•'} {e.title}
                                    </div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>
                                        {e.time || `${d.toLocaleDateString()}`}
                                        {e.status && <span style={{ marginLeft: '6px', color: statusDot[e.status] }}>● {e.status}</span>}
                                    </div>
                                </div>
                            </div>
                        );
                    })}
                </div>
            </div>
        </div>
    );
}
