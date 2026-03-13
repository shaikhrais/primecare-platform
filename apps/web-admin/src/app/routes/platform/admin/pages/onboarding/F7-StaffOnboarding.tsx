// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F7 · Staff Onboarding
// Registry ID:   page.admin.onboarding
// Type:          Form
// Owner:         admin
// Route:         /platform/admin/onboarding
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F7] Staff Onboarding Form — powered by centralized FormRegistry.
 */
export default function PswOnboardingForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('admin.onboarding');
    if (!formEntry) return null;

    return (
        <div style={{ padding: '2rem' }} data-cy="form.psw.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.USERS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
