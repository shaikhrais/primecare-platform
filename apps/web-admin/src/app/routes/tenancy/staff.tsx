const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;

import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import AppLayout from "@/shared/components/layout/AppLayout";
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import RequireRole from "@/shared/rbac/RequireRole";
import { AdminRegistry } from "prime-care-shared";
import React, { lazy } from "react";
import { Route } from "react-router";

// --- Extracted from dashboard.tsx ---
// Re-export from identity file: D19-StaffDashboard.tsx
// removed broken export: export { default } from './D19-StaffDashboard';


// --- Merged from D19-StaffDashboard.tsx ---
export function StaffDashboard() {
    return (
        <PageTemplate pageId="D19"  
            sectionData={PageSectionRegistry['D19']}
        />
    );
}

// --- Extracted from messages.tsx ---
// --- Merged from T44-MessageCenter.tsx ---
export function MessageCenter() {
    return (
        <PageTemplate pageId="T44"  
            sectionData={PageSectionRegistry['T44']}
        />
    );
}

// --- Extracted from operations.tsx ---
// --- Merged from T45-IncidentPortal.tsx ---
export function IncidentPortal() {
    return (
        <PageTemplate pageId="T45"  
            sectionData={PageSectionRegistry['T45']}
        />
    );
}

// --- Merged from T46-ComplianceMonitor.tsx ---
export function ComplianceMonitor() {
    return (
        <PageTemplate pageId="T46"  
            sectionData={PageSectionRegistry['T46']}
        />
    );
}

// --- Extracted from StaffRoutes.tsx ---
// Staff Pages
// --- Extracted from tasks.tsx ---
// --- Merged from T43-TaskGrid.tsx ---
export function TaskGrid() {
    return (
        <PageTemplate pageId="T43"  
            sectionData={PageSectionRegistry['T43']}
        />
    );
}
