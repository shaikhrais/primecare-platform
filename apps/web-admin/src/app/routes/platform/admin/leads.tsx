import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// removed re-export: export { LeadsPage, LeadEntryForm, LeadConversion };


// --- Merged from F11-LeadEntry.tsx ---
// PAGE IDENTITY: F11 · Lead Entry



export function LeadEntryForm_OLD1() {
    return (
        <PageTemplate pageId="F11" title="➕ New Lead Entry" subtitle="Capture new lead information, service interest & contact details"
            sectionData={PageSectionRegistry['F11']}
        />
    );
}

// --- Merged from L3-LeadList.tsx ---
// PAGE IDENTITY: L3 · Lead List
const cols: TableColumn[] = [
    { key: 'name', label: 'Lead' }, { key: 'source', label: 'Source' },
    { key: 'service', label: 'Service' }, { key: 'stage', label: 'Stage' },
    { key: 'assigned', label: 'Assigned' }, { key: 'age', label: 'Age' },
];

export function LeadList() {
    return (
        <PageTemplate pageId="L3" title="🎯 Lead Pipeline" subtitle="Sales leads, conversion tracking & assignment management"
            sectionData={PageSectionRegistry['L3']}
        />
    );
}

// --- Merged from LeadEntry.tsx ---
export function LeadEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-LEF" 
            title="✨ Lead Entry Form" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LEF']}
        />
    );
}

// --- Merged from T66-LeadConversion.tsx ---
// PAGE IDENTITY: T66 · Lead Conversion



export function LeadConversion() {
    return (
        <PageTemplate pageId="T66" title="🔄 Lead Conversion" subtitle="Convert qualified leads to active clients with automated onboarding"
            sectionData={PageSectionRegistry['T66']}
        />
    );
}