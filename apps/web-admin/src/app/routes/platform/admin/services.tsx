import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L5-Services.tsx
// removed broken export: export { default } from './L5-Services';


// --- Merged from L5-Services.tsx ---
// PAGE IDENTITY: L5 · Services
const cols: TableColumn[] = [
    { key: 'code', label: 'Code' }, { key: 'name', label: 'Service' },
    { key: 'rate', label: 'Rate' }, { key: 'clients', label: 'Clients' },
    { key: 'status', label: 'Status' },
];

export function Services() {
    return (
        <PageTemplate pageId="L5" title="🏥 Service Catalog" subtitle="All service types, billing rates, capacity & eligibility requirements"
            sectionData={PageSectionRegistry['L5']}
        />
    );
}