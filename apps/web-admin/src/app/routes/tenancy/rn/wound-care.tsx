// ================================================================
// Wound Care Dashboard
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function WoundCareDashboard() {
    return (
        <PageTemplate pageId="WC" title="🩹 Wound Care" subtitle="Track wound assessments, healing progress & treatment protocols"
            sectionData={PageSectionRegistry['WC']}
        />
    );
}


// --- Merged from D17-WoundCareDashboard.tsx ---
export function WoundCareDashboard_OLD() {
    return (
        <PageTemplate pageId="D17" title="Wound Care Dashboard" subtitle="Active wound assessments, healing progress and treatment protocols"
            sectionData={PageSectionRegistry['D17']}
        />
    );
}

// --- Merged from T32-WoundCareClient.tsx ---
export function WoundCareClient() {
    return (
        <PageTemplate pageId="T32" title="Wound Care Client" subtitle="Document wound assessments, measurements and treatment progress"
            sectionData={PageSectionRegistry['T32']}
        />
    );
}