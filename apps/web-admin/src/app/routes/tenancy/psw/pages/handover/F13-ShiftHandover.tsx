// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F13 · Shift Handover
// Registry ID:   page.psw.handover
// Type:          Form
// Owner:         psw
// Route:         /tenancy/psw/handover
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';
import './HandoverPage.css';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F13] Shift Handover Form — powered by centralized FormRegistry.
 */
export default function HandoverPage() {
    const navigate = useNavigate();
    const formEntry = getFormById('psw.handover');
    if (!formEntry) return null;

    return (
        <div className="handover-page-container" data-cy="form.handover.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.PSW.DASHBOARD)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
