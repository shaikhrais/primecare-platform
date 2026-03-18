import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D9-BranchPL.tsx ---
export function BranchPL() {
    return (
        <PageTemplate pageId="D9" title="Branch P&L" subtitle="Branch-level profit and loss analysis with margin tracking"
            sectionData={PageSectionRegistry['D9']}
        />
    );
}

// --- Merged from T24-PayrollVerification.tsx ---
export function PayrollVerification() {
    return (
        <PageTemplate pageId="T24" title="Payroll Verification" subtitle="Verify timesheets, approve hours and process payroll"
            sectionData={PageSectionRegistry['T24']}
        />
    );
}
