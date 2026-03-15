// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F8 · Timesheet Adjustment
// Registry ID:   page.admin.timesheet-adjust
// Type:          Form
// Owner:         admin
// Route:         /platform/admin/timesheets/adjust
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F8] Timesheet Adjustment Form — powered by centralized FormRegistry.
 */
export default function TimesheetAdjForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.timesheet-adjust');
    if (!formEntry) return null;

    return (
        <div role="main" aria-label="Timesheet Adjustment" style={{ padding: '2rem' }} data-cy="form.timesheet.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.TIMESHEETS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
