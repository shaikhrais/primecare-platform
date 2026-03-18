import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Barrel re-export — identity file: F14-ExpenseClaim.tsx
// removed broken export: export { default } from './F14-ExpenseClaim';


// --- Merged from F14-ExpenseClaim.tsx ---
export function ExpenseReportForm() {
    return (
        <PageTemplate pageId="F14" title="Expense Claim" subtitle="Submit expense claims with receipt upload and approval tracking"
            sectionData={PageSectionRegistry['F14']}
        />
    );
}