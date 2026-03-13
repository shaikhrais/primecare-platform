import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * Timesheet Adjustment Form — powered by centralized FormRegistry.
 * Previously 116 lines of hardcoded form with raw fetch(), now a single DynamicFormRenderer call.
 */
export default function TimesheetAdjForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.timesheet-adjust');
    if (!formEntry) return null;

    return (
        <div style={{ padding: '2rem' }} data-cy="form.timesheet.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.TIMESHEETS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
