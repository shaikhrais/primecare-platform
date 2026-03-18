import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L15-CustomerList.tsx
// removed broken export: export { default } from './L15-CustomerList';


// --- Merged from L15-CustomerList.tsx ---
// PAGE IDENTITY: L15 · Customer List
const cols: TableColumn[] = [
    { key: 'name', label: 'Client' }, { key: 'age', label: 'Age' },
    { key: 'service', label: 'Service' }, { key: 'visits', label: 'Frequency' },
    { key: 'status', label: 'Status' }, { key: 'since', label: 'Since' },
];

export function CustomerList() {
    return (
        <PageTemplate pageId="L15" title="👥 Client Directory" subtitle="All active clients, service details & care history"
            sectionData={PageSectionRegistry['L15']}
        />
    );
}