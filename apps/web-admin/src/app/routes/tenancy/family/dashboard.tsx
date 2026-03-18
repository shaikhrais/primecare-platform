// ================================================================
// Family Dashboard
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function FamilyDashboard() {
    return (
        <PageTemplate pageId="FAM" title="👨‍👩‍👧 Family Portal" subtitle="Stay connected with your loved one's care — updates, schedule & payments"
            sectionData={PageSectionRegistry['FAM']}
        />
    );
}
