import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * Lead Entry Form — powered by centralized FormRegistry.
 * Previously 97 lines with setTimeout mock submission and hardcoded source dropdown.
 * Now uses DynamicFormRenderer with real API POST to /v1/admin/leads.
 */
export default function LeadEntryForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.lead-entry');
    if (!formEntry) return null;

    return (
        <div style={{ padding: '2rem' }} data-cy="form.lead.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.LEADS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
