import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Barrel re-export — identity file: D1-AdminDashboard.tsx
// removed broken export: export { default } from './D1-AdminDashboard';


// --- Merged from D1-AdminDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D1 · Admin Dashboard (Main Landing)
// Type: Dashboard | Owner: admin | Registry: D1
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AdminDashboard() {
    return (
        <PageTemplate pageId="D1" title="🏠 Admin Dashboard" subtitle="Platform overview — operations, finance, compliance & AI insights"
            actionPageId="admin.dashboard"
            sectionData={PageSectionRegistry['D1']}
        />
    );
}

// --- Merged from D2-RegistrySummary.tsx ---
// PAGE IDENTITY: D2 · Registry Summary

export function RegistrySummary() {
    return (
        <PageTemplate pageId="D2" title="📊 Registry Summary" subtitle="Overview of all platform registries — pages, APIs, sections, roles & events"
            sectionData={PageSectionRegistry['D2']}
        />
    );
}