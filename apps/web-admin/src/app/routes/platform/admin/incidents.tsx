import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// removed re-export: export { IncidentList, IncidentEntry };


// --- Merged from F10-IncidentEntry.tsx ---
// PAGE IDENTITY: F10 · Incident Entry



export function IncidentEntry() {
    return (
        <PageTemplate pageId="F10" title="🚨 Incident Report" subtitle="Submit workplace incidents, near-misses & safety concerns"
            sectionData={PageSectionRegistry['F10']}
        />
    );
}

// --- Merged from IncidentEntry.tsx ---
export function IncidentEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-IEF" 
            title="✨ Incident Entry Form" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IEF']}
        />
    );
}

// --- Merged from IncidentList.tsx ---
export function IncidentList_OLD1() {
    return (
        <PageTemplate 
            pageId="PGE-IL" 
            title="✨ Incident List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IL']}
        />
    );
}

// --- Merged from L2-IncidentList.tsx ---
// PAGE IDENTITY: L2 · Incident List
const cols: TableColumn[] = [
    { key: 'id', label: 'ID' }, { key: 'date', label: 'Date' },
    { key: 'type', label: 'Type' }, { key: 'client', label: 'Client' },
    { key: 'severity', label: 'Severity' }, { key: 'status', label: 'Status' },
];

export function IncidentList() {
    return (
        <PageTemplate pageId="L2" title="🚨 Incident List" subtitle="Track workplace incidents, near-misses, investigations & resolutions"
            sectionData={PageSectionRegistry['L2']}
        />
    );
}