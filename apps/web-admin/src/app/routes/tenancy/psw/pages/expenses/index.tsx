import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * Expense Claim Form — powered by centralized FormRegistry.
 * Previously 205 lines of hardcoded form with raw fetch() and camera viewport,
 * now a single DynamicFormRenderer call. File upload field handles receipt attachment.
 */
export default function ExpenseReportForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('psw.expenses');
    if (!formEntry) return null;

    return (
        <div style={{ padding: '2rem' }} data-cy="form.expense.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.EARNINGS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
