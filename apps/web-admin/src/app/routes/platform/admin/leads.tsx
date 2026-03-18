import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';




// removed re-export: export { LeadsPage, LeadEntryForm, LeadConversion };


// --- Merged from F11-LeadEntry.tsx ---
// PAGE IDENTITY: F11 · Lead Entry



export function LeadEntryForm_OLD1() {
    return (
        <PageTemplate pageId="F11" title="➕ New Lead Entry" subtitle="Capture new lead information, service interest & contact details"
            sectionData={{
                'F11.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Contact Information', subtitle: 'Name, phone, email & preferred contact method' },
                    { icon: '🏥', title: 'Service Interest', subtitle: 'Requested service, urgency & availability' },
                    { icon: '📋', title: 'Source & Notes', subtitle: 'Referral source, initial notes & follow-up plan' },
                    { icon: '📊', title: 'Qualification', subtitle: 'Budget, timeline, decision maker & scoring' },
                ], columns: 2 } },
            }}
        />
    );
}

// --- Merged from L3-LeadList.tsx ---
// PAGE IDENTITY: L3 · Lead List




const leads = [
    { name: 'John Smith', source: 'Website', service: 'PSW Home Care', stage: '🟢 Qualified', assigned: 'Sarah Mgr', age: '3 days' },
    { name: 'Mary Johnson', source: 'Referral (Dr. Wong)', service: 'RN Wound Care', stage: '🟡 Contact Made', assigned: 'Sarah Mgr', age: '1 day' },
    { name: 'David Lee', source: 'Call-In', service: 'Respite Care', stage: '⚪ New', assigned: 'Unassigned', age: '< 1 hr' },
    { name: 'Patricia Davis', source: 'Website', service: 'OT Assessment', stage: '🔵 Proposal Sent', assigned: 'Mike Coord', age: '5 days' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Lead' }, { key: 'source', label: 'Source' },
    { key: 'service', label: 'Service' }, { key: 'stage', label: 'Stage' },
    { key: 'assigned', label: 'Assigned' }, { key: 'age', label: 'Age' },
];

export function LeadList() {
    return (
        <PageTemplate pageId="L3" title="🎯 Lead Pipeline" subtitle="Sales leads, conversion tracking & assignment management"
            sectionData={{
                'L3.pipeline': { kpiCards: [
                    { label: 'New', value: 1, color: '#6B7280' },
                    { label: 'Contact Made', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Qualified', value: 1, color: 'var(--pc-success)' },
                    { label: 'Proposal Sent', value: 1, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L3.table': { table: { columns: cols, rows: leads } },
            }}
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
            sectionData={{
                ['PGE-' + 'LEF.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LEF.empty']: { emptyState: { title: 'Lead Entry Form Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from T66-LeadConversion.tsx ---
// PAGE IDENTITY: T66 · Lead Conversion



export function LeadConversion() {
    return (
        <PageTemplate pageId="T66" title="🔄 Lead Conversion" subtitle="Convert qualified leads to active clients with automated onboarding"
            sectionData={{
                'T66.stats': { kpiCards: [
                    { label: 'Conversion Rate', value: '72%', color: 'var(--pc-success)' },
                    { label: 'Avg Days to Convert', value: 5.2, color: 'var(--pc-primary)' },
                    { label: 'Ready to Convert', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Converted MTD', value: 8, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T66.chart': { chart: { title: 'Monthly Conversions', type: 'bar', data: [
                    { label: 'Oct', value: 6 }, { label: 'Nov', value: 8 },
                    { label: 'Dec', value: 5 }, { label: 'Jan', value: 10 },
                    { label: 'Feb', value: 7 }, { label: 'Mar', value: 8 },
                ]}},
            }}
        />
    );
}