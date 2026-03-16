// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F11 · Create Lead
// Registry ID:   page.admin.lead-entry
// Type:          Form
// Owner:         admin
// Route:         /platform/admin/leads/new
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F11] Lead Entry Form — powered by centralized FormRegistry.
 */
export default function LeadEntryForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.lead-entry');
    if (!formEntry) return null;

    return (
        <div role="main" aria-label="Lead Entry" style={{ padding: '2rem' }} data-cy="form.lead.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.LEADS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
