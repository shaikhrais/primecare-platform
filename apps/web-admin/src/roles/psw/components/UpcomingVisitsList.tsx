import React from 'react';

interface Visit {
    id: string;
    clientName: string;
    time: string;
}

interface UpcomingVisitsListProps {
    visits: Visit[];
}

export const UpcomingVisitsList: React.FC<UpcomingVisitsListProps> = ({ visits }) => {
    return (
        <div data-cy="upcoming-visits-list">
            <h4 style={{ margin: '0 0 16px 0', fontSize: '0.9rem', fontWeight: 800, textTransform: 'uppercase', color: '#6B7280' }}>
                Upcoming Schedule
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {visits.length > 0 ? visits.map(visit => (
                    <div
                        key={visit.id}
                        style={{
                            padding: '12px 16px',
                            backgroundColor: '#F9FAFB',
                            border: '1px solid #E5E7EB',
                            borderRadius: '12px',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center'
                        }}
                    >
                        <span style={{ fontWeight: 700, fontSize: '0.9rem' }}>{visit.clientName}</span>
                        <span style={{ fontSize: '0.8rem', color: '#6B7280', fontWeight: 600 }}>🕒 {visit.time}</span>
                    </div>
                )) : (
                    <p style={{ color: '#9CA3AF', fontSize: '0.9rem' }}>No more visits for today.</p>
                )}
            </div>
        </div>
    );
};
