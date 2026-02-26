import React from 'react';
import { SmartBreadcrumbs } from '@/shared/components/SmartBreadcrumbs';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface ScheduleHeaderProps {
    onCreateVisit: () => void;
}

export const ScheduleHeader: React.FC<ScheduleHeaderProps> = ({ onCreateVisit }) => {
    return (
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
            <div>
                <SmartBreadcrumbs />
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">{ContentRegistry.SCHEDULE.TITLE}</h2>
                <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0', fontSize: '0.875rem' }} data-cy="page.header">{ContentRegistry.SCHEDULE.SUBTITLE}</p>
            </div>
            <button
                data-cy="btn-create-visit"
                onClick={onCreateVisit}
                style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
            >
                {ContentRegistry.SCHEDULE.ACTIONS.CREATE}
            </button>
        </div>
    );
};
