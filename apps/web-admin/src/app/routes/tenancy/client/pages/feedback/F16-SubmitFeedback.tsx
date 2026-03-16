// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F16 · Submit Feedback
// Registry ID:   page.client.feedback
// Type:          Form
// Owner:         client
// Route:         /tenancy/client/feedback
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F16] Client Feedback Form — powered by centralized FormRegistry.
 */
export default function FeedbackForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('client.feedback');
    if (!formEntry) return null;

    return (
        <div style={{ padding: '2rem' }} data-cy="page.container" role="main" aria-label="Submit Feedback">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.CLIENT.BOOKINGS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
