// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F6 · Client Admission
// Registry ID:   page.admin.admission
// Type:          Form
// Owner:         admin
// Route:         /platform/admin/admission
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F6] Client Admission Form — powered by centralized FormRegistry.
 */
export default function ClientAdmissionForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.admission');
    if (!formEntry) return null;

    return (
        <div data-cy="page.container" role="main" aria-label="Client Admission" style={{ padding: '2rem' }} data-cy="form.client.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.USERS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
