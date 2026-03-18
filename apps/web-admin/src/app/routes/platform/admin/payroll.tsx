import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H7-PayrollHub.tsx ---
// ================================================================
// PAGE IDENTITY: H7 · Payroll Hub
// Type: Hub | Owner: admin | Registry: H7
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export function PayrollHub() {
    return (
        <PageTemplate
            pageId="H7"
            title="💵 Payroll Hub"
            subtitle="Payroll processing, deductions, tax withholding & direct deposit management"
            actionPageId="admin.payroll"
            sectionData={PageSectionRegistry['H7']}
        />
    );
}
