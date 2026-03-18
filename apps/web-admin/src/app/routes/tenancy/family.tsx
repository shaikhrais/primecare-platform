import { PageSectionRegistry } from "@/shared/PageSectionRegistry";
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import React from "react";

// --- Extracted from dashboard.tsx ---
export function FamilyDashboard() {
    return (
        <PageTemplate pageId="FAM" title="Family Dashboard" subtitle="Manage family care plans"
            sectionData={PageSectionRegistry['FAM']}
        />
    );
}
