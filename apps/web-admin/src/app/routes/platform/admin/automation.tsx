import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from T7-AutoPilot.tsx ---
// ================================================================
// PAGE IDENTITY: T7 · AutoPilot Dashboard
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'name', label: 'Automation' }, { key: 'trigger', label: 'Trigger' },
    { key: 'runs', label: 'Total Runs' }, { key: 'lastRun', label: 'Last Run' },
    { key: 'status', label: 'Status' },
];

export function AutoPilotDashboard() {
    return (
        <PageTemplate
            pageId="T7"
            title="🤖 AutoPilot Dashboard"
            subtitle="Workflow automations, event triggers, scheduled tasks & notification rules"
            actionPageId="admin.autopilot"
            sectionData={PageSectionRegistry['T7']}
        />
    );
}
