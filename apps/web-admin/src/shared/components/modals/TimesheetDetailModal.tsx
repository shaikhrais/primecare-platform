import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { Link } from 'react-router';

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
            backgroundColor: 'var(--pc-bg-overlay)',
            display: 'flex',
            justifyContent: 'flex-end',
            zIndex: 1000
        }} onClick={onClose}>
            <div style={{
                width: '100%',
                maxWidth: '500px',
                backgroundColor: 'var(--pc-surface-card)',
                height: '100%',
                overflowY: 'auto',
                padding: '2rem',
                boxShadow: 'var(--pc-shadow-xl)',
                color: 'var(--pc-text-primary)'
            }} onClick={e => e.stopPropagation()}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'start', marginBottom: '2rem' }}>
                    <div>
                        <h2 data-cy="h2-shared.timesheet-detail-modal-0" style={{ margin: 0, fontSize: '1.5rem', color: 'var(--pc-text-primary)' }}>Timesheet Details</h2>
                        <p style={{ margin: '0.5rem 0 0 0', color: 'var(--pc-text-secondary)' }}>Week: {timesheet.weekId}</p>
                    </div>
                    <button data-cy="btn-shared.timesheet-detail-modal-0" onClick={onClose} style={{ background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: 'var(--pc-text-tertiary)' }}>×</button>
                </div>

                <div style={{ marginBottom: '2rem', padding: '1rem', backgroundColor: 'var(--pc-bg-secondary)', borderRadius: 'var(--pc-radius-lg)' }}>
                    <div style={{ fontSize: '0.875rem', color: 'var(--pc-text-secondary)', marginBottom: '0.5rem' }}>Service Provider</div>
                    <div style={{ fontSize: '1.125rem', fontWeight: 600, color: 'var(--pc-text-primary)' }}>
                        <Link to={`${RouteRegistry.ADMIN.USERS}?search=${timesheet.psw?.email}`} style={{ color: 'var(--pc-primary)', textDecoration: 'none' }}>
                            {timesheet.psw?.fullName} →
                        </Link>
                    </div>
                </div>

                <h3 data-cy="h3-shared.timesheet-detail-modal-0" style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--pc-text-primary)', marginBottom: '1rem' }}>Shift Breakdown</h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>

                    {timesheet.items && timesheet.items.length > 0 ? timesheet.items.map((item: any) => (
                        <div key={item.id} style={{ padding: '1rem', border: '1px solid var(--pc-border-primary)', borderRadius: 'var(--pc-radius-md)' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                                <span style={{ fontWeight: 600 }}>{new Date(item.visit?.requestedStartAt || item.createdAt).toLocaleDateString()}</span>
                                <span style={{ color: 'var(--pc-text-secondary)' }}>{(item.minutes / 60).toFixed(1)} hrs</span>
                            </div>
                            <div style={{ fontSize: '0.875rem', color: 'var(--pc-text-secondary)' }}>
                                Client ID: <Link to={`${RouteRegistry.ADMIN.USERS}?role=client`} style={{ color: 'var(--pc-primary)' }}>{item.visit?.clientId || 'Unknown'}</Link>
                            </div>
                        </div>
                    )) : (
                        <div style={{ textAlign: 'center', padding: '2rem', color: 'var(--pc-text-tertiary)', border: '1px dashed var(--pc-border-primary)', borderRadius: 'var(--pc-radius-md)' }}>
                            Detailed shift data not currently available on this record.
                        </div>
                    )}
                </div>

                <div style={{ marginTop: '2rem', paddingTop: '1rem', borderTop: '1px solid var(--pc-border-primary)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div style={{ fontSize: '0.875rem', color: 'var(--pc-text-secondary)' }}>Total Hours</div>
                    <div style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--pc-text-primary)' }}>{(timesheet.totalMinutes / 60).toFixed(1)} hrs</div>
                </div>
            </div>
        </div>
    );
};
