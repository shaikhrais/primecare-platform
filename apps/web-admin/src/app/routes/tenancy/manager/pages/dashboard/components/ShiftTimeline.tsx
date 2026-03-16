import React from 'react';
import { useNavigate } from 'react-router';

interface ShiftDisplay {
    id: string;
    requestedStartAt: string;
    client: { fullName: string };
    psw?: { fullName: string };
    service: { name: string };
}

interface ShiftTimelineProps {
    shifts: ShiftDisplay[];
}

export const ShiftTimeline: React.FC<ShiftTimelineProps> = ({ shifts }) => {
    const navigate = useNavigate();

    return (
        <>
            <h2 data-cy="section.timeline" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Today's Timeline</h2>
            <div className="pc-card">
                <div className="pc-card-b" style={{ padding: '0 24px' }}>
                    {shifts.length === 0 ? (
                        <p data-cy="timeline-empty-message" style={{ color: 'var(--text-300)', textAlign: 'center', padding: '40px' }}>No shifts scheduled for today.</p>
                    ) : (
                        shifts.map((shift) => (
                            <div key={shift.id} data-cy="timeline-item" style={{ display: 'flex', gap: '20px', padding: '20px 0', borderBottom: '1px solid var(--card-border)', alignItems: 'center' }}>
                                <div style={{ fontWeight: 900, width: '90px', textAlign: 'right', color: 'var(--brand-500)', fontSize: '0.9rem' }}>
                                    {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                </div>
                                <div style={{ flex: 1 }}>
                                    <div data-cy="timeline-client-name" style={{ fontWeight: 900, color: 'var(--text-100)', fontSize: '1.05rem' }}>{shift.client?.fullName || 'Untitled Client'}</div>
                                    <div data-cy="timeline-details" style={{ fontSize: '0.85rem', color: 'var(--text-300)', marginTop: '2px' }}>{shift.service?.name || 'General Service'} • {shift.psw ? shift.psw.fullName : <span style={{ color: 'var(--brand-500)' }}>Unassigned</span>}</div>
                                </div>
                                <button data-cy={`btn-view-shift-${shift.id}`} className="btn" style={{ padding: '8px 16px', fontSize: '13px' }} onClick={() => navigate(`/visits/${shift.id}`)}>View Details</button>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </>
    );
};
