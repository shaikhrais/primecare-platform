import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from ApiLatencyHeatmap.tsx ---
export function ApiLatencyHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-ALH" 
            title="✨ Api Latency Heatmap" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'ALH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ALH.empty']: { emptyState: { title: 'Api Latency Heatmap Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from BrowserMatrixTelemetry.tsx ---
export function BrowserMatrixTelemetry() {
    return (
        <PageTemplate 
            pageId="PGE-BMT" 
            title="✨ Browser Matrix Telemetry" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'BMT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'BMT.empty']: { emptyState: { title: 'Browser Matrix Telemetry Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from CoreWebVitalsTracker.tsx ---
export function CoreWebVitalsTracker() {
    return (
        <PageTemplate 
            pageId="PGE-CWV" 
            title="✨ Core Web Vitals Tracker" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'CWV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CWV.empty']: { emptyState: { title: 'Core Web Vitals Tracker Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
