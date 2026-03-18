import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Barrel re-export — identity file: F7-StaffOnboarding.tsx
// removed broken export: export { default } from './F7-StaffOnboarding';


// --- Merged from F7-StaffOnboarding.tsx ---
// PAGE IDENTITY: F7 · Staff Onboarding



export function StaffOnboarding() {
    return (
        <PageTemplate pageId="F7" title="🎓 Staff Onboarding" subtitle="New hire onboarding workflow — credentials, training & compliance checklist"
            sectionData={PageSectionRegistry['F7']}
        />
    );
}