// PAGE IDENTITY: L3 · Lead List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

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

export default function LeadList() {
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
