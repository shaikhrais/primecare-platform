import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface Shift {
    id: string;
    client: { fullName: string };
    serviceAddressLine1: string;
    requestedStartAt: string;
    status: string;
    service: { name: string };
}

interface ShiftListProps {
    shifts: Shift[];
    loading: boolean;
    isMobile: boolean;
    onCheckIn: (id: string) => void;
    onCheckOut: (id: string) => void;
}

export const ShiftList: React.FC<ShiftListProps> = ({ shifts, loading, isMobile, onCheckIn, onCheckOut }) => {
    return (
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
            <div data-cy="section.shifts" style={{ padding: '20px 24px', borderBottom: '1px solid #E5E7EB', fontWeight: 700, fontSize: '1.2rem' }}>
                {t(ContentRegistry.PSW_DASHBOARD.SECTION_SHIFTS)}
            </div>
            <div style={{ padding: isMobile ? '16px' : '24px' }}>
                {loading ? (
                    <p style={{ color: '#6B7280' }}>Loading your upcoming visits...</p>
                ) : shifts.length > 0 ? (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                        {shifts.map(shift => (
                            <div key={shift.id} data-cy={`shift-card-${shift.id}`} style={{
                                padding: '20px',
                                border: '1px solid #E5E7EB',
                                borderRadius: '12px',
                                backgroundColor: '#F9FAFB'
                            }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem', alignItems: 'flex-start' }}>
                                    <div>
                                        <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800, color: '#000000' }}>
                                            {shift.client.fullName}
                                        </h3>
                                        <div style={{ color: '#00875A', fontWeight: 600, fontSize: '0.85rem', marginTop: '4px' }}>
                                            🏥 {shift.service.name}
                                        </div>
                                    </div>
                                    <span data-cy="shift-status" style={{
                                        color: '#00875A',
                                        fontWeight: 800,
                                        fontSize: '0.65rem',
                                        textTransform: 'uppercase',
                                        letterSpacing: '0.5px',
                                        background: '#E6F4EF',
                                        padding: '4px 10px',
                                        borderRadius: '20px'
                                    }}>
                                        {shift.status}
                                    </span>
                                </div>

                                <div data-cy="shift-details" style={{ display: 'grid', gridTemplateColumns: isMobile ? '1fr' : '1fr 1fr', gap: '1rem', color: '#374151', fontSize: '0.9rem' }}>
                                    <div>
                                        <strong style={{ display: 'block', color: '#6B7280', fontSize: '0.7rem', textTransform: 'uppercase', marginBottom: '4px' }}>Time</strong>
                                        🕒 {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                    </div>
                                    <div>
                                        <strong style={{ display: 'block', color: '#6B7280', fontSize: '0.7rem', textTransform: 'uppercase', marginBottom: '4px' }}>Location</strong>
                                        📍 {shift.serviceAddressLine1}
                                    </div>
                                </div>

                                <div style={{ marginTop: '1.5rem', display: 'flex', flexDirection: isMobile ? 'column' : 'row', gap: '0.75rem' }}>
                                    {shift.status.toLowerCase() !== 'completed' && (
                                        <button
                                            data-cy={shift.status.toLowerCase() === 'in_progress' ? "btn-check-out" : "btn-check-in"}
                                            onClick={() => shift.status.toLowerCase() === 'in_progress' ? onCheckOut(shift.id) : onCheckIn(shift.id)}
                                            style={{
                                                flex: 1,
                                                padding: '12px',
                                                backgroundColor: shift.status.toLowerCase() === 'in_progress' ? '#EF4444' : '#00875A',
                                                color: 'white',
                                                border: 'none',
                                                borderRadius: '8px',
                                                fontWeight: '700',
                                                cursor: 'pointer'
                                            }}
                                        >
                                            {shift.status.toLowerCase() === 'in_progress' ? 'Finish Visit' : 'Check-In Now'}
                                        </button>
                                    )}
                                    <button data-cy="btn-view-files" style={{
                                        flex: 1,
                                        padding: '12px',
                                        backgroundColor: '#FFFFFF',
                                        color: '#000000',
                                        border: '1px solid #E5E7EB',
                                        borderRadius: '8px',
                                        fontWeight: '600',
                                        cursor: 'pointer'
                                    }}>View Files</button>
                                </div>
                            </div>
                        ))}
                    </div>
                ) : (
                    <p style={{ color: '#6B7280' }}>You have no shifts scheduled today.</p>
                )}
            </div>
        </div>
    );
};
