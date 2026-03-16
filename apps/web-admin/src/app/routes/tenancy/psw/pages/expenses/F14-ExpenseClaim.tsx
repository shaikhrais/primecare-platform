// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: F14 · Expense Claim
// Registry ID:   page.psw.expenses
// Type:          Form
// Owner:         psw
// Route:         /tenancy/psw/expenses
// ═══════════════════════════════════════════════════════════════
import React from 'react';
import { useNavigate } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms';

const { getFormById, RouteRegistry } = AdminRegistry;

/**
 * [F14] Expense Claim Form — powered by centralized FormRegistry.
 */
export default function ExpenseReportForm() {
    const navigate = useNavigate();
    const formEntry = getFormById('psw.expenses');
    if (!formEntry) return null;

    return (
        <div role="main" aria-label="Expense Claim" style={{ padding: '2rem' }} data-cy="form.expense.page">
            <DynamicFormRenderer
                formEntry={formEntry}
                onSuccess={() => navigate(RouteRegistry.ADMIN.EARNINGS)}
                onCancel={() => navigate(-1)}
            />
        </div>
    );
}
