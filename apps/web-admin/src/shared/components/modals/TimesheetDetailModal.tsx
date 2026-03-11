import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';

const { RouteRegistry } = AdminRegistry;

interface TimesheetDetailModalProps {
    isOpen: boolean;
    onClose: () => void;
    timesheet: any;
}

export const TimesheetDetailModal: React.FC<TimesheetDetailModalProps> = ({ isOpen, onClose, timesheet }) => {
    if (!isOpen || !timesheet) return null;

    return (
        <div style={{
            position: 'fixed',
            inset: 0,
            backgroundColor: 'rgba(0,0,0,0.5)',
            display: 'flex',
            justifyContent: 'flex-end',
            zIndex: 1000
        }} onClick={onClose}>
            <div style={{
                width: '100%',
                maxWidth: '500px',
                backgroundColor: 'white',
                height: '100%',
                overflowY: 'auto',
                padding: '2rem',
                boxShadow: '-4px 0 20px rgba(0,0,0,0.1)'
            }} onClick={e => e.stopPropagation()}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'start', marginBottom: '2rem' }}>
                    <div>
                        <h2 style={{ margin: 0, fontSize: '1.5rem', color: '#111827' }}>Timesheet Details</h2>
                        <p style={{ margin: '0.5rem 0 0 0', color: '#6b7280' }}>Week: {timesheet.weekId}</p>
                    </div>
                    <button onClick={onClose} style={{ background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#9ca3af' }}>×</button>
                </div>

                <div style={{ marginBottom: '2rem', padding: '1rem', backgroundColor: '#f9fafb', borderRadius: '0.75rem' }}>
                    <div style={{ fontSize: '0.875rem', color: '#6b7280', marginBottom: '0.5rem' }}>Service Provider</div>
                    <div style={{ fontSize: '1.125rem', fontWeight: 600, color: '#111827' }}>
                        <Link to={`${RouteRegistry.ADMIN.USERS}?search=${timesheet.psw?.email}`} style={{ color: '#00875A', textDecoration: 'none' }}>
                            {timesheet.psw?.fullName} →
                        </Link>
                    </div>
                </div>

                <h3 style={{ fontSize: '1rem', fontWeight: 600, color: '#111827', marginBottom: '1rem' }}>Shift Breakdown</h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>

                    {timesheet.items && timesheet.items.length > 0 ? timesheet.items.map((item: any) => (
                        <div key={item.id} style={{ padding: '1rem', border: '1px solid #e5e7eb', borderRadius: '0.5rem' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                                <span style={{ fontWeight: 600 }}>{new Date(item.visit?.requestedStartAt || item.createdAt).toLocaleDateString()}</span>
                                <span style={{ color: '#6b7280' }}>{(item.minutes / 60).toFixed(1)} hrs</span>
                            </div>
                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                                Client ID: <Link to={`${RouteRegistry.ADMIN.USERS}?role=client`} style={{ color: '#00875A' }}>{item.visit?.clientId || 'Unknown'}</Link>
                            </div>
                        </div>
                    )) : (
                        <div style={{ textAlign: 'center', padding: '2rem', color: '#9ca3af', border: '1px dashed #e5e7eb', borderRadius: '0.5rem' }}>
                            Detailed shift data not currently available on this record.
                        </div>
                    )}
                </div>

                <div style={{ marginTop: '2rem', paddingTop: '1rem', borderTop: '1px solid #e5e7eb', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>Total Hours</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: 700, color: '#111827' }}>{(timesheet.totalMinutes / 60).toFixed(1)} hrs</div>
                </div>
            </div>
        </div>
    );
};
