import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * Client Feedback Form — powered by centralized FormRegistry.
 * Previously 194 lines of hardcoded form with raw fetch(), star-rating buttons,
 * and manual visit dropdown fetching. Now a single DynamicFormRenderer call.
 */
export default function FeedbackForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('client.feedback');
    if (!formEntry) return null;

    return (
        <div style={{ padding: '2rem' }} data-cy="feedback-form-page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.CLIENT.BOOKINGS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
