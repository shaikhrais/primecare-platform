import React from 'react';
import { format } from 'date-fns';

interface Visit {
    id: string;
    requestedStartAt: string;
    durationMinutes: number;
    client: { fullName: string };
    psw?: { fullName: string };
    assignedPswId?: string;
    status: string;
    isSurgeActive?: boolean;
    surgeMultiplier?: number;
}

interface ScheduleListProps {
    visits: Visit[];
    getStatusColor: (status: string) => string;
    onEdit: (visit: Visit) => void;
    onAssign: (visit: Visit) => void;
    onSurge?: (visit: Visit) => void;
}

export const ScheduleList: React.FC<ScheduleListProps> = ({ visits, getStatusColor, onEdit, onAssign, onSurge }) => {
    return (
        <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
            <table data-cy="table-admin.schedule-list" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                    <tr>
                        <th style={{ padding: '1rem' }}>Date & Time</th>
                        <th style={{ padding: '1rem' }}>Client</th>
                        <th style={{ padding: '1rem' }}>Service Provider</th>
                        <th style={{ padding: '1rem' }}>Status</th>
                        <th style={{ padding: '1rem' }}>Quick Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {visits.map((visit) => (
                        <tr
                            key={visit.id}
                            style={{ borderBottom: '1px solid #f3f4f6', transition: 'background-color 0.2s' }}
                            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                        >
                            <td style={{ padding: '1rem' }}>
                                {new Date(visit.requestedStartAt).toLocaleDateString()} <br />
                                <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                                    {format(new Date(visit.requestedStartAt), 'h:mm a')}
                                </span>
                            </td>
                            <td style={{ padding: '1rem', fontWeight: 500 }}>
                                {visit.client?.fullName}
                                {visit.isSurgeActive && (
                                    <span style={{ marginLeft: '8px', backgroundColor: '#FEF2F2', color: '#EF4444', padding: '2px 6px', borderRadius: '4px', fontSize: '10px', fontWeight: 'bold' }}>
                                        🔥 {visit.surgeMultiplier}x SURGE
                                    </span>
                                )}
                            </td>
                            <td style={{ padding: '1rem', color: visit.psw ? '#111827' : '#9ca3af' }}>
                                {visit.psw?.fullName || 'Unassigned'}
                            </td>
                            <td style={{ padding: '1rem' }}>
                                <span style={{
                                    padding: '0.25rem 0.625rem',
                                    borderRadius: '9999px',
                                    fontSize: '0.75rem',
                                    fontWeight: 600,
                                    backgroundColor: getStatusColor(visit.status),
                                    color: 'white'
                                }}>
                                    {visit.status.toUpperCase()}
                                </span>
                            </td>
                            <td style={{ padding: '1rem' }}>
                                <div style={{ display: 'flex', gap: '0.75rem', opacity: 0.8 }}>
                                    <button data-cy="btn-admin.schedule-list-0"
                                        onClick={() => onEdit(visit)}
                                        style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                    >
                                        Edit
                                    </button>
                                    {!visit.psw && (
                                        <>
                                            <button data-cy="btn-admin.schedule-list-1"
                                                onClick={() => onAssign(visit)}
                                                style={{ color: '#0369a1', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                            >
                                                Assign
                                            </button>
                                            {onSurge && (
                                                <button data-cy="btn-admin.schedule-list-2"
                                                    onClick={() => onSurge(visit)}
                                                    style={{ color: '#EF4444', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                                >
                                                    Boost
                                                </button>
                                            )}
                                        </>
                                    )}
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};
