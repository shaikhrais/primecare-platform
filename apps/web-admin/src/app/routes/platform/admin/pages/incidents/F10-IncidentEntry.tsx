// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F10 · Create Incident
// Registry ID:   page.admin.incident-entry
// Type:          Form
// Owner:         admin
// Route:         /platform/admin/incidents/new
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F10] Incident Entry Form — powered by centralized FormRegistry.
 */
export default function IncidentEntryForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.incident-entry');
    if (!formEntry) return null;

    return (
        <div role="main" aria-label="Incident Entry" style={{ padding: '2rem' }} data-cy="form.incident.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.INCIDENTS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
