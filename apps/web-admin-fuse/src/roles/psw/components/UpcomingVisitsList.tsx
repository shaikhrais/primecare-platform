import React from 'react';

interface Visit {
    id: string;
    clientName: string;
    time: string;
}

interface UpcomingVisitsListProps {
    visits: Visit[];
    onItemClick?: (id: string) => void;
}

export const UpcomingVisitsList: React.FC<UpcomingVisitsListProps> = ({ visits, onItemClick }) => {
    return (
        <div data-cy="upcoming-visits-list">
            <h4 style={{ margin: '0 0 16px 0', fontSize: '0.9rem', fontWeight: 800, textTransform: 'uppercase', color: '#6B7280' }}>
                Upcoming Schedule
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {visits.length > 0 ? visits.map(visit => (
                    <div
                        key={visit.id}
                        onClick={() => onItemClick && onItemClick(visit.id)}
                        style={{
                            padding: '20px',
                            backgroundColor: '#FFFFFF',
                            border: '1px solid #E5E7EB',
                            borderRadius: '16px',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            transition: 'all 0.2s ease',
                            cursor: onItemClick ? 'pointer' : 'default'
                        }}
                    >
                        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '40px', height: '40px', backgroundColor: '#F3F4F6', borderRadius: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.2rem' }}>👤</div>
                            <div>
                                <div style={{ fontWeight: 800, fontSize: '0.95rem', color: '#111827' }}>{visit.clientName}</div>
                                <div style={{ fontSize: '0.75rem', color: '#6B7280', fontWeight: 500 }}>{visit.id}</div>
                            </div>
                        </div>
                        <span style={{ fontSize: '0.85rem', color: '#00875A', fontWeight: 800, backgroundColor: '#E6F4EF', padding: '6px 12px', borderRadius: '12px' }}>
                            🕒 {visit.time}
                        </span>
                    </div>
                )) : (
                    <div style={{ padding: '32px', textAlign: 'center', backgroundColor: '#F9FAFB', borderRadius: '16px', border: '1px dashed #E5E7EB' }}>
                        <p style={{ color: '#9CA3AF', fontSize: '0.9rem', margin: 0 }}>No more visits for today.</p>
                    </div>
                )}
            </div>
        </div>
    );
};
