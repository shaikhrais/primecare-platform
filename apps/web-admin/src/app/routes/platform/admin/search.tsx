import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T1-SearchPage.tsx ---
// PAGE IDENTITY: T1 · Search Page

export function SearchPage() {
    return (
        <PageTemplate pageId="T1" title="🔍 Global Search" subtitle="Search across clients, PSWs, visits, documents, invoices & more"
            sectionData={PageSectionRegistry['T1']}
        />
    );
}
