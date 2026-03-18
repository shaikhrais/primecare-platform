import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from ApiLatencyHeatmap.tsx ---
export function ApiLatencyHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-ALH" 
            title="✨ Api Latency Heatmap" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-ALH']}
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
            sectionData={PageSectionRegistry['PGE-BMT']}
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
            sectionData={PageSectionRegistry['PGE-CWV']}
        />
    );
}
