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
}

interface ScheduleListProps {
    visits: Visit[];
    getStatusColor: (status: string) => string;
    onEdit: (visit: Visit) => void;
    onAssign: (visit: Visit) => void;
}

export const ScheduleList: React.FC<ScheduleListProps> = ({ visits, getStatusColor, onEdit, onAssign }) => {
    return (
        <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                    <tr>
                        <th style={{ padding: '1rem' }}>Date & Time</th>
                        <th style={{ padding: '1rem' }}>Client</th>
                        <th style={{ padding: '1rem' }}>Caregiver</th>
                        <th style={{ padding: '1rem' }}>Status</th>
                        <th style={{ padding: '1rem' }}>Quick Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {visits.map((visit) => (
                        <tr
                            key={visit.id}
                            onClick={() => onAssign(visit)}
                            style={{ cursor: 'pointer', borderBottom: '1px solid #f3f4f6', transition: 'background-color 0.2s' }}
                            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                        >
                            <td style={{ padding: '1rem' }}>
                                {new Date(visit.requestedStartAt).toLocaleDateString()} <br />
                                <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                                    {format(new Date(visit.requestedStartAt), 'h:mm a')}
                                </span>
                            </td>
                            <td style={{ padding: '1rem', fontWeight: 500 }}>{visit.client?.fullName}</td>
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
                            <td style={{ padding: '1rem' }} onClick={(e) => e.stopPropagation()}>
                                <div style={{ display: 'flex', gap: '0.75rem', opacity: 0.8 }}>
                                    <button
                                        onClick={() => onEdit(visit)}
                                        style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                    >
                                        Edit
                                    </button>
                                    {!visit.psw && (
                                        <button
                                            onClick={() => onAssign(visit)}
                                            style={{ color: '#0369a1', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: 600 }}
                                        >
                                            Assign
                                        </button>
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
