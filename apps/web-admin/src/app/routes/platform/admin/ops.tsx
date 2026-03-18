import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D7-OperationsCenter.tsx ---
// ================================================================
// PAGE IDENTITY: D7 · Operations Center  
// Type: Dashboard | Owner: admin | Registry: D7
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const opsModules = [
    { icon: '📋', title: 'Shift Overview', subtitle: 'Active shifts, coverage gaps, overtime tracking' },
    { icon: '🚗', title: 'Fleet & Logistics', subtitle: 'Vehicle tracking, route optimization, mileage' },
    { icon: '📊', title: 'Capacity Planning', subtitle: 'Demand forecasting, staffing models, utilization' },
    { icon: '⚡', title: 'Incident Command', subtitle: 'Active incidents, escalation chains, resolution SLAs' },
    { icon: '🔄', title: 'Workflow Automation', subtitle: 'Triggered actions, approval chains, notifications' },
    { icon: '📈', title: 'Performance Metrics', subtitle: 'KPIs, SLA adherence, quality scores' },
];

export function OperationsCenter() {
    return (
        <PageTemplate
            pageId="D7"
            title="⚙️ Operations Center"
            subtitle="Real-time operational command — shifts, logistics, incidents & capacity"
            actionPageId="admin.operations"
            isLive
            sectionData={{
                'D7.stats': { kpiCards: [
                    { label: 'Active Shifts', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Coverage', value: '96%', color: 'var(--pc-success)' },
                    { label: 'Open Incidents', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Utilization', value: '87%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'OT Hours Today', value: 8, color: '#F59E0B' },
                ]},
                'D7.modules': { cardGrid: { items: opsModules, columns: 3 } },
                'D7.trend': { chart: { title: 'Daily Visit Volume (This Week)', type: 'bar', data: [
                    { label: 'Mon', value: 145 }, { label: 'Tue', value: 162 },
                    { label: 'Wed', value: 138 }, { label: 'Thu', value: 155 },
                    { label: 'Fri', value: 170 }, { label: 'Sat', value: 45 },
                    { label: 'Sun', value: 32 },
                ]}},
            }}
        />
    );
}

// --- Merged from T67-SupplyDemand.tsx ---
// PAGE IDENTITY: T67 · Supply & Demand

export function SupplyDemand() {
    return (
        <PageTemplate pageId="T67" title="📊 Supply & Demand Analytics" subtitle="Staff capacity vs client demand — coverage gaps, forecasting & optimization"
            sectionData={{
                'T67.stats': { kpiCards: [
                    { label: 'Supply (PSWs)', value: 82, color: 'var(--pc-primary)' },
                    { label: 'Demand (Hrs/wk)', value: 3200, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Utilization', value: '87%', color: 'var(--pc-success)' },
                    { label: 'Coverage Gaps', value: 4, color: 'var(--pc-warning)' },
                ]},
                'T67.supply': { chart: { title: 'Supply vs Demand (Weekly)', type: 'bar', data: [
                    { label: 'Mon', value: 162, color: '#3B82F6' }, { label: 'Tue', value: 158, color: '#3B82F6' },
                    { label: 'Wed', value: 148, color: '#F59E0B' }, { label: 'Thu', value: 155, color: '#3B82F6' },
                    { label: 'Fri', value: 170, color: '#3B82F6' }, { label: 'Sat', value: 45, color: '#EF4444' },
                    { label: 'Sun', value: 32, color: '#EF4444' },
                ]}},
                'T67.forecast': { chart: { title: 'Demand Forecast (Next 4 Weeks)', type: 'bar', data: [
                    { label: 'Wk 12', value: 3200 }, { label: 'Wk 13', value: 3350 },
                    { label: 'Wk 14', value: 3100 }, { label: 'Wk 15', value: 3400 },
                ]}},
            }}
        />
    );
}
