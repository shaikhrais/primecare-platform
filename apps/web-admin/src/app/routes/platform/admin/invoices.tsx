import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// removed re-export: export { InvoiceEntry };


// --- Merged from F9-InvoiceEntry.tsx ---
// PAGE IDENTITY: F9 · Invoice Entry



export function InvoiceEntry() {
    return (
        <PageTemplate pageId="F9" title="🧾 Invoice Entry" subtitle="Create and submit client invoices, service line items & payment terms"
            sectionData={PageSectionRegistry['F9']}
        />
    );
}